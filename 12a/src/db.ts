import Database from 'better-sqlite3';
import process from 'node:process';
import { Events } from './events.js';
import { SystemError, UserError } from './error_types.js';
import { GetHooksRowOperation } from './enums.js';

let db: Database.Database

function initDb() {
    db = new Database("db.sqlite")
    db.pragma('journal_mode = WAL');

    process.on('exit', () => {
        db.close()
    });

    db.prepare("CREATE TABLE IF NOT EXISTS hooks (event INTEGER, url TEXT, token TEXT)").run();
}

function getHooksRow(event: Events, token: string, operation: GetHooksRowOperation) {
    const stmt = db.prepare("SELECT * FROM hooks WHERE event = :event AND token = :token")

    try {
        const row = stmt.get({ event: event.valueOf(), token: token })

        if (row !== undefined) {
            if (operation === GetHooksRowOperation.CheckIfRegistered) {
                throw new UserError(`A hook is already registered for event ${event.valueOf()}`)
            }
            if (operation === GetHooksRowOperation.GetHookEventURL) {
                return row
            }
        } else {
            if (operation === GetHooksRowOperation.GetHookEventURL) {
                throw new UserError(`A hook for the following event and token combination could not be found: ${"event: " + event.valueOf() + " token: " + token}`)
            }
        }
    } catch (error: any) {
        if (error instanceof UserError) {
            throw new UserError(error.message)
        } else {
            throw new SystemError(`An error occured getting the hook: ${error.message}`)
        }
    }
}

function saveHook(event: Events, url: string, token: string) {

    const stmt = db.prepare("INSERT INTO hooks VALUES (?, ?, ?)");
    try {
        const info = stmt.run(event.valueOf(), url, token)
        if (info.changes === 0) {
            throw new UserError(`Could not save a hook with the following data: ${"event: " + event.valueOf() + " url: " + url + " token: " + token}`)
        }
    } catch (error: any) {
        if (error instanceof UserError) {
            throw new UserError(error.message)
        } else {
            throw new SystemError(`An error occured saving the hook: ${error.message}`)
        }
    }
}

function removeHook(event: Events, token: string) {
    const stmt = db.prepare("DELETE FROM hooks WHERE event = ':event' AND token = ':token'");

    try {
        const info = stmt.run({ event: event.valueOf(), token: token })
        if (info.changes === 0) {
            throw new UserError(`Cannot unregister event ${event.valueOf()} for token: ${token}`)
        }
    } catch (error) {
        if (error instanceof UserError) {
            throw new UserError(error.message)
        } else {
            throw new SystemError(`An error occured removing the hook: ${error}`)
        }
    }
}

export { initDb, getHooksRow, saveHook, removeHook }