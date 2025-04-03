import Mailjet from "node-mailjet"
import { MAILJET_TEMPLATES } from "../constants/mailjet-templates";

export class MailjetService {
    mailjet: Mailjet;

    public constructor(apiKey: string, apiSecret: string) {
        this.mailjet = new Mailjet({
            apiKey: apiKey,
            apiSecret: apiSecret,
        });
    }

    public async send(emailTo: string, template: string) {
        const templateID: number | undefined = MAILJET_TEMPLATES.get(template);
        if (!templateID)
            return;
        return this.mailjet
            .post('send', { version: 'v3.1' })
            .request({
                Messages: [
                    {
                        From: {
                            Email: "jolan.cochet.pro@gmail.com",
                            Name: "contact@tranquil-loc.fr"
                        },
                        To: [
                            {
                                Email: emailTo,
                            }
                        ],
                        TemplateID: templateID,
                        TemplateLanguage: true,
                    }
                ]
            })
    }
}