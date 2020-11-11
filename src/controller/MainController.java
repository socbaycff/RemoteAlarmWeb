package controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.DocumentReference;
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

import model.Alarm;
/*
 * Pham vi chi tuong tac voi thuoc tinh hour minute title started
 * */
@Controller
public class MainController {
	String token = "dCo4K1UUVUI:APA91bFo96cq0IqmIldJAYwuyCrCE8rhjcVMxco7QzEDh9Akhk3OdO0I10HlDpDQL06vNFNME7NvZc44_DaCbJmNZy3O3L0HRakhv7VC8LwWM4qFEhcMKSAx67xprCigLbwpgGPWCyRR";
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
		if (!isInit) { // lk db firebase
			init();
		}
		
		// demo
		//FirestoreClient.getFirestore().collection("alarms").document("1101434745").update("started", true);
		
		return "index";
	}
	
	@RequestMapping("new")
	public String newAlarm(@RequestParam("time") String strTime,@RequestParam("title") String title) throws FirebaseMessagingException {
		System.out.println("Da vao trong new mapping new");
		int id = new Random().nextInt(Integer.MAX_VALUE);
		// gui tin hieu den mobile new moi
		
		Message mess = Message.builder().putData("alarmId", String.valueOf(id)).putData("type", "insert").putData("hour", strTime.substring(0, 2)).putData("minute", strTime.substring(3, 5)).setToken(token)
				.putData("title", title).build();
		FirebaseMessaging.getInstance().send(mess);
		// add vao trong firestore
		
		Alarm alarm = new Alarm(id, Integer.parseInt(strTime.substring(0, 2)), Integer.parseInt(strTime.substring(3, 5)), title, System.currentTimeMillis(), true);
		FirestoreClient.getFirestore().collection("alarms").document(String.valueOf(id)).set(alarm);
		return "redirect:/index.htm";
	}
	@RequestMapping("cancel/{alarmId}")
	public String cancelAlarm(@PathVariable("alarmId") String id) throws FirebaseMessagingException {
		System.out.println("Da vao trong new mapping cancel");
		// gui message den mobile cancel
		Message mess = Message.builder().putData("type", "cancel").putData("alarmId", id).setToken(token).build();
		FirebaseMessaging.getInstance().send(mess);
		//update firestore started = false
		FirestoreClient.getFirestore().collection("alarms").document(id).delete();
		return "redirect:/index.htm";
	}
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateAlarm(@RequestParam("time") String strTime, @RequestParam("title") String title, @RequestParam(value = "aid", defaultValue = "id") String id) throws FirebaseMessagingException {
		System.out.println("Da vao trong new mapping update");
		System.out.println(id);
		// gui delete + new moi den mobile
		Message mess = Message.builder().putData("type", "update").putData("alarmId", id).putData("hour",strTime.substring(0, 2)).putData("minute", strTime.substring(3, 5)).setToken(token)
				.putData("title", title).build();
		FirebaseMessaging.getInstance().send(mess);
		// update gia tri firestore
		DocumentReference reference = FirestoreClient.getFirestore().collection("alarms").document(id);
		Map<String,Object> map = new HashMap<>();
		map.put("hour",Integer.parseInt(strTime.substring(0, 2)));
		map.put("minute",Integer.parseInt(strTime.substring(3, 5)));
		map.put("title", title);
		map.put("started", true);
		reference.update(map);
		return "redirect:/index.htm";
	}
	
	
}
