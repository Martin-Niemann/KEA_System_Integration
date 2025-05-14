import { Database } from 'sqlite3';
import { Events } from './events';

export let db: Database

function initDb() {
    db = new Database("db.sqlite", (error) => {
        console.log(`Could not open or create database: ${error}`)
    });

    db.run("CREATE TABLE IF NOT EXISTS hooks (event INTEGER, url TEXT, token TEXT)");
}

function saveHook(event: Events, url: string, token: string) {
    db.serialize(() => {
        db.get("SELECT event FROM hooks WHERE token = (?)", token, (err, row) => {
            if (row !== undefined) {
                throw new Error("A hook is already registered with that token!")
            }
        });

        const stmt = db.prepare("INSERT INTO hooks VALUES (?, ?, ?)");
        stmt.run(event, url, token, (error: any) => {
            if (error !== null) {
                throw new Error(`An error occured saving the hook: ${error}`)
            }
        });
        stmt.finalize();
    });
}

function removeHook(event: Events, url: string, token: string) {
    db.serialize(() => {
        db.get("SELECT event FROM hooks WHERE event = (?) AND url = (?) AND token = (?)", token, (err, row) => {
            if (row === undefined) {
                throw new Error("A hook is already registered with that token!")
            }
        });

        const stmt = db.prepare("INSERT INTO hooks VALUES (?, ?, ?)");
        stmt.run(event, url, token, (error: any) => {
            if (error !== null) {
                throw new Error(`An error occured saving the hook: ${error}`)
            }
        });
        stmt.finalize();
    });
}

db.serialize(() => {
    db.run("CREATE TABLE lorem (info TEXT)");

    const stmt = db.prepare("INSERT INTO lorem VALUES (?)");
    for (let i = 0; i < 10; i++) {
        stmt.run("Ipsum " + i);
    }
    stmt.finalize();

    db.each("SELECT rowid AS id, info FROM lorem", (err, row) => {
        console.log(row.id + ": " + row.info);
    });
});

db.close();