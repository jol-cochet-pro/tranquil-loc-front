/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import { MailjetService } from './services/mailjet.service';
import { defineSecret } from 'firebase-functions/params';
import { onCall } from "firebase-functions/https";
import z from 'zod';

// Start writing functions
// https://firebase.google.com/docs/functions/typescript;

const API_KEY = defineSecret("MJ_APIKEY_PUBLIC");
const API_SECRET = defineSecret("MJ_APIKEY_PRIVATE");

const sendMailBodySchema = z.object({
    email: z.string().email()
})

type SendMailBody = z.infer<typeof sendMailBodySchema>;

export const send = onCall({ secrets: [API_KEY, API_SECRET] }, async (request) => {
    const service = new MailjetService(API_KEY.value(), API_SECRET.value());
    const body: SendMailBody = sendMailBodySchema.parse(request.data);
    service.send(body.email, "share_folder");
    return "OK"
});

