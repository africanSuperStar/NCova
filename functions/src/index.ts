import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const fcm = admin.messaging();

export const subscribeStatusBNOTopic = functions.firestore
	.document('statusBNO/{countryId}')
	.onUpdate(async snapshot => {
		const country = snapshot.after.data;

		const payload: admin.messaging.MessagingPayload = {
			notification: {
				title: 'COVID-19 Updates',
				body: `Information on ${country?.name} has been updated.`,
				icon: 'https://storage.googleapis.com/ncova-2020.appspot.com/57.png',
				click_action: 'FLUTTER_NOTIFICATION_CLICK' // required only for onResume or onLaunch callbacks
			}
		};

		return fcm.sendToTopic('statusBNO', payload);
	});

