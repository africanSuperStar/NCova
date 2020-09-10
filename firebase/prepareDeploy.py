import firebase_admin
from firebase_admin import credentials
from firebase_admin import storage
import glob
import os

cred = credentials.Certificate(os.environ['GOOGLE_APPLICATION_CREDENTIALS'])
firebase_admin.initialize_app(cred, {
    'storageBucket': 'ncova-2020.appspot.com'
})

bucket = storage.bucket()

## upload new manifest and ipa ##
#get latest archive folder
folders = glob.glob('archives/*')
latest_folder = max(folders, key=os.path.getctime)

#upload ipa
print('uploading unCOVID.ipa...')
ipa_blob = bucket.blob('AdHoc/prod.ipa')
ipa_blob.upload_from_filename(
    latest_folder + '/prod.ipa',
    content_type='application/octet-stream')

#upload manifest
print('uploading manifest.plist...')
manifest_blob = bucket.blob('AdHoc/manifest.plist')
manifest_blob.upload_from_filename(
    latest_folder + '/manifest.plist',
    content_type='text/xml')

#this will make the public path equal the gs path
#this way, the same links can be used every time
ipa_blob.make_public()
manifest_blob.make_public()
