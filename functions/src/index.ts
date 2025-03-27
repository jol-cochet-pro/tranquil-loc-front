/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import Mailjet from "node-mailjet";
import { defineSecret } from 'firebase-functions/params';
import { onCall } from "firebase-functions/https";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript;

const API_KEY = defineSecret("MJ_APIKEY_PUBLIC");
const API_SECRET = defineSecret("MJ_APIKEY_PRIVATE");

export const send = onCall({ secrets: [API_KEY, API_SECRET] }, async (request) => {
    const mailjet: Mailjet = new Mailjet({
        apiKey: API_KEY.value(),
        apiSecret: API_SECRET.value()
    });
    const mail = await mailjet
        .post('send', { version: 'v3.1' })
        .request({
            Messages: [
                {
                    From: {
                        Email: "contact@easyloc.fr",
                        Name: "Mailjet Pilot"
                    },
                    To: [
                        {
                            Email: "jolan@yopmail.com",
                            Name: "passenger 1"
                        }
                    ],
                    Subject: "Your email flight plan!",
                    TextPart: "Dear passenger 1, welcome to Mailjet! May the delivery force be with you!",
                    HTMLPart: "<h3>Dear passenger 1, welcome to <a href=\"https://www.mailjet.com/\">Mailjet</a>!</h3><br />May the delivery force be with you!"
                }
            ]
        });

    return mail.response
});

