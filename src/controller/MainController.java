package controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.EventListener;
import com.google.cloud.firestore.FirestoreException;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.storage.StorageOptions;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.internal.FirebaseCustomAuthToken;
import com.google.firebase.cloud.FirestoreClient;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;

@Controller
public class MainController {
	public static boolean isInit = false;
	public static void init() throws IOException {
		isInit = true;
		FileInputStream serviceAccount = new FileInputStream("C:\\Users\\Khang\\Desktop\\credential.json");

		@SuppressWarnings("deprecation")
		FirebaseOptions options = new FirebaseOptions.Builder()
				.setCredentials(GoogleCredentials.fromStream(serviceAccount))
				.setDatabaseUrl("https://remotealarmclock-2f98a.firebaseio.com").build();

		FirebaseApp.initializeApp(options);
	}
	
	@RequestMapping("index")
	public String index() throws FirebaseMessagingException, IOException {

//		String token = "dsy2Bd_3IPg:APA91bFr6OJmJ7m_DM4WIK6V70E-zgZhxTvI85c6kL4hOt3zFsVhwOqd4ZvfnPbmzwtS-rlKY8sTgTz3hsb8TSu3nWTfpGcyXXgaldFl7bl8siCF7DasL2DqrbTyhZaJ4HaTfrcDVkaA";
//		Message mess = Message.builder().putData("hour", "9").putData("minute", "9").setToken(token)
//				.putData("title", "Noi dung").build();
		if (!isInit) {
			init();
		}
//		FirebaseMessaging.getInstance().send(mess);
		FirestoreClient.getFirestore().collection("alarms").addSnapshotListener(new EventListener<QuerySnapshot>() {
			
			@Override
			public void onEvent(QuerySnapshot value, FirestoreException error) {
				List<QueryDocumentSnapshot> documents = value.getDocuments();
				for (QueryDocumentSnapshot doc : documents) {
					String string = String.valueOf(doc.get("alarmId"));
					System.out.println(string);
				}
				
			}
		});
		return "index";
	}
	
	
}
