# 12a

## How to use the system

| Endpoint                   | Request Body  | Response body |  
| -------------              | ------------- | ------------- |
| POST /buy10000litersofmilk | {"token": "xyz"} | None       |
| POST /ping                 | {"token": "xyz"} | None       |
| POST /register             | {"event": **EventType**, "url": "http://mydomain.com/webhooks/milkman", "token": "xyz"}     | {"event": **EventType**, "url": "http://mydomain.com/webhooks/milkman"} |
| POST /unregister           | {"event": **EventType**, "token": "xyz" } | "Webhook for event **EventType** unregistered." |
| GET /newtoken             | None             | {"token": "xyz"} |

| EventType     | 
| ------------- | 
| payment_processed | 
| order_processed | 
| order_shipped | 
| receipt_delivered |