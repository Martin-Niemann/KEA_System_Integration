import axios from 'axios';

const baseurl = "https://cad6-83-92-88-92.ngrok-free.app/"

axios.post(baseurl + "unregister",
    {
        "url": "http://91.101.69.70:13464/webhooks/kristian",
        "event_type": "order_received"
    })
    .then(_res => { })

axios.post(baseurl + "unregister",
    {
        "url": "http://91.101.69.70:13464/webhooks/kristian",
        "event_type": "order_shipped"
    })
    .then(_res => { })

axios.post(baseurl + "register",
    {
        "url": "http://91.101.69.70:13464/webhooks/kristian",
        "event_type": "order_processed"
    })
    .then(_res => { })