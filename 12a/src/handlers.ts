import { Response } from 'express';
import { Events } from './events';

export function handleRegister(eventName: string, url: string, res: Response) {
    const event = eventName in Events;

    if (event === null) {
        res.status(400).send(`Invalid event name: ${eventName}`);
    }

    try {
        registerHook(event, url);
        res.status(201).send(JSON.stringify({ event: event.valueOf, url: url }));
    } catch (error) {
        //res.status(400).send(`A hook is already registered for event ${event.valueOf}`)
        res.status(400).send(error);
    }
}
function handleUnregister(eventName: string, res: Response) {
    const event = eventName in Events;

    if (event === null) {
        res.status(400).send(`Invalid event name: ${eventName}`);
    }

    try {
        unregisterHook(event);
        res.status(200).send(`Webhook for event ${event.valueOf} unregistered.`);
    } catch (error) {
        //res.status(400).send(`The token does not match the token used to register the hook!`)
        res.status(400).send(error);
    }
}
