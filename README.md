# flutter caching test

This app is used to test the following features:
- Google Sing In at startup;
- ```Simple Provider Test``` - basic testing of ChangeNotifier class; 
- ```Future Firestore``` - Fetching data from Firestore. Fetched data is cached into SQLite database;
- ```Stream Firestore``` - Streaming data from Firestore. Just showing how you can add, update and delete Firestore data in real time;
- ```Clean DB``` - removes all tables from SQLite database and creates them again;
- ```Old Json Caching Example``` - fetching data from REST API and caching into SQLite;

- Firebase notifications are also enabled. FCM token is shown in debug console at startup. Copy the token and go to "Cloud messaging" in Firebase console to test it out.

- Provider is listening on Firestore collection changes; Changes can be seen on the Home Page and on "Simple provider test" page;

