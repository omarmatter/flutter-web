importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyCAA0KmD5JUmbTXC1nBCOCzQh0OTkHY6k4",
    authDomain: "trustproject-72236.firebaseapp.com",
    databaseURL: "DATABASE_URL",
    projectId: "trustproject-72236",
    storageBucket: "trustproject-72236.appspot.com",
    messagingSenderId: "1043456810875",
    appId: "1:1043456810875:web:23c7c139be9ba3da2fa7de",
    measurementId: "G-NTMD0XQRZ3"
});
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});