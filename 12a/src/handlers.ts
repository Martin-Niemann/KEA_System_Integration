import { Response, Request } from 'express';
import { Events } from './events.js';
import { getHooksRow, removeHook, saveHook } from './db.js';
import { randomUUID } from 'crypto';
import { GetHooksRowOperation, HandleCallHooksOperation } from './enums.js';
import { $enum } from "ts-enum-util";
import axios from 'axios';
import util from 'node:util';
import { UserError } from './error_types.js';

export function handleNewToken(res: Response) {
    const token = randomUUID()
    res.status(200).send({ "token": token })

    // TODO: Save token in a table of approved tokens
}

export function handleRegister(req: Request, res: Response) {
    const payload = req.body

    if ("event" in payload && "url" in payload && "token" in payload) {
        const event: Events = payload.event as Events;

        // TODO: Check if the token supplied is in the table of approved tokens

        if (event === null) {
            res.status(400).send(`Invalid event name: ${payload.event}`);
            return
        }

        if (payload.url === "" || payload.url === undefined) {
            res.status(400).send(`Invalid url: ${payload.url}`);
            return
        }

        if (payload.token === "" || payload.url === undefined) {
            res.status(400).send(`Invalid token: ${payload.token}`);
            return
        }

        try {
            getHooksRow(event, payload.token, GetHooksRowOperation.CheckIfRegistered);
            saveHook(event, payload.url, payload.token)
            res.status(201).send(JSON.stringify({ event: event.valueOf, url: payload.url }));
        } catch (error: any) {
            res.status(error.status_code ? error.status_code : 500).send(error.code + " " + error.message);
        }
    } else {
        res.status(400).send(`Invalid JSON: missing fields or typo`);
    }
}

export function handleUnregister(req: Request, res: Response) {
    const payload = req.body

    if ("event" in payload && "token" in payload) {
        const event: Events = payload.event as Events;

        if (event === null) {
            res.status(400).send(`Invalid event name: ${payload.event}`);
            return
        }

        if (payload.token === "" || payload.url === undefined) {
            res.status(400).send(`Invalid token: ${payload.token}`);
            return
        }

        try {
            removeHook(event, payload.token);
            res.status(200).send(`Webhook for event ${event.valueOf} unregistered.`);
        } catch (error: any) {
            res.status(error.status_code ? error.status_code : 500).send(error.code + " " + error.message);
        }
    } else {
        res.status(400).send(`Invalid JSON: missing fields or typo`);
    }
}

export async function handleCallHooks(req: Request, res: Response, operation: HandleCallHooksOperation) {
    const payload = req.body

    if (payload.token === null || payload.token === undefined || payload.token === "") {
        res.status(401).send()
    } else {
        const hooks: Array<any> = []

        $enum(Events).map(event => {
            try {
                const hook = getHooksRow(event, payload.token, GetHooksRowOperation.GetHookEventURL)

                if (hook !== undefined || hook !== null)
                    hooks.push(hook)
            } catch (error: any) {
                if (error instanceof UserError) {
                } else {
                    res.status(error.status_code ? error.status_code : 500).send(error.code + " " + error.message);
                }
            }
        })

        if (hooks.length === 0) {
            res.status(400).send(`Found no hooks registered with token: ${payload.token}`)
        } else {
            if (operation === HandleCallHooksOperation.Ping) {
                res.status(200).send()

                Promise.all(
                    hooks.map((hook) => {
                        axios.post(hook.url, { "event": hook.event, "token": hook.token }).then(_res => { })
                    })
                )
            }
            if (operation === HandleCallHooksOperation.Flow) {
                res.status(200).send()

                let delay: number = 5000
                for (let hook of hooks) {
                    util.promisify(setTimeout)(delay).then(async () => {
                        await axios.post(hook.url, { "event": hook.event, "token": hook.token }).then(_res => { })
                    })
                    delay = delay + delay
                }
            }
        }
    }
}