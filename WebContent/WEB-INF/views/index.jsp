<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>

<title>Alarm App</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/style.css" />
<link rel="stylesheet" href="assets/css/form.css" />
<link rel="stylesheet" href="assets/css/slide.css" />
<link rel="stylesheet" href="assets/css/columns.css" />
<base href="${pageContext.servletContext.contextPath}/">
</head>
<style>
.datebox-active {
	background-color: #008000;
}

.modal {
	display: none;
	/* Hidden by default */
	position: fixed;
	/* Stay in place */
	z-index: 1;
	/* Sit on top */
	padding-top: 100px;
	/* Location of the box */
	left: 0;
	top: 0;
	width: 100%;
	/* Full width */
	height: 100%;
	/* Full height */
	overflow: auto;
	/* Enable scroll if needed */
	background-color: rgb(0, 0, 0);
	/* Fallback color */
	background-color: rgba(0, 0, 0, 0.8);
	/* Black w/ opacity */
}

/* Modal Content */
.modal-content {
	margin: auto;
	width: 50%;
}
</style>
<body>

	<div class="header">
		<a href="index.htm" class="logo"><img src="images/logo.png"
			width="66.25" height="20"></a>
		<!-- Dẫn về Home-->
		<div class="header-center">
			<a class="active" href="index.htm">Home</a>
			<!-- Dẫn về Home-->
			<a href="AboutUs.html">About Us</a>
			<!-- Dẫn về Page About-->
			<a href="Lost.html">Lost?</a>
			<!-- Dẫn đến Page hướng dẫn (Video hoặc Hình ảnh nếu thích)-->
		</div>

		<div class="header-right">
			<a href="SignIn.html">Login</a>
			<!-- Dẫn đến Page Login-->
		</div>
	</div>
	<br>
	<br>
	<!-- Banner -->
	<div class="slideshow-container">
		<div class="mySlides fade">
			<img src="images/LDK.png" style="width: 100%">
		</div>

		<div class="mySlides fade">
			<img src="images/NHL.png" style="width: 100%">
		</div>

		<div class="mySlides fade">
			<img src="images/TKM.png" style="width: 100%">
		</div>

		<div class="mySlides fade">
			<img src="images/PPN.png" style="width: 100%">
		</div>
	</div>
	<br>

	<!-- Banner -->

	<!-- Main -->
	<div id="main">
		<div class="inner">

			<!--Nút bấm tạo báo thức mới-->
			<div class="centerbtn">
				<Button class="btn info" style="font-size: 20px;"
					onclick="openAlarmForm()">Create New</Button>
			</div>

			<br> <br>
			<hr>
			<br>

			<!-- Thùng hàng chứa báo thức foreach ra -->
			<div class="thumbnails">
				<div class="box">
					<br>
					<!-- Color: Green = đã đặt báo thức  -->
					<i id="alarmColor1" onclick="changeColor(id)" class="fa fa-clock-o"
						style="font-size: 8rem; color: #808080;" aria-hidden="true"></i>
					<div class="inner">
						<h3>Hiển thị giờ báo thức ở đây</h3>
						<p>Thêm title</p>
						<p>
							<span class="datebox-active"
								style="font-weight: bold; font-size: 12px; line-height: 30px; width: 30px; border: 2px white solid; display: inline-block; text-align: center; border-radius: 4px;">Mon</span>
							<span
								style="font-weight: bold; font-size: 12px; line-height: 30px; width: 30px; border: 2px white solid; display: inline-block; text-align: center; border-radius: 4px;">Tue</span>
							<span class="datebox-active"
								style="font-weight: bold; font-size: 12px; line-height: 30px; width: 30px; border: 2px white solid; display: inline-block; text-align: center; border-radius: 4px;">Wed</span>
							<span
								style="font-weight: bold; font-size: 12px; line-height: 30px; width: 30px; border: 2px white solid; display: inline-block; text-align: center; border-radius: 4px;">Thu</span>
							<span
								style="font-weight: bold; font-size: 12px; line-height: 30px; width: 30px; border: 2px white solid; display: inline-block; text-align: center; border-radius: 4px;">Fri</span>
							<span
								style="font-weight: bold; font-size: 12px; line-height: 30px; width: 30px; border: 2px white solid; display: inline-block; text-align: center; border-radius: 4px;">Sat</span>
							<span
								style="font-weight: bold; font-size: 12px; line-height: 30px; width: 30px; border: 2px white solid; display: inline-block; text-align: center; border-radius: 4px;">Sun</span>
						</p>
						<p>Nút tích Repeat</p>
						<button class="btn success" style="font-size: 20px"
							onclick="openAlarmForm()">Set Time</button>
						<div style="line-height: 50%;">
							<br>
						</div>
						<button class="btn danger" style="font-size: 20px"
							onclick="openAlarmForm()">Remove</button>
					</div>
				</div>


			</div>
		</div>
	</div>

	<!-- Popup cái set bao thức -->
	<div class="modal" id="alarmId">
		<div class="form-popup modal-content">
			<form action="new.htm">
				<div>
					<label style="font-size: 25px;">Chọn giờ:</label> <input
						name="time" style="font-size: 25px;" type="time" required>
				</div>

				<br>

				<div>
					<label style="font-size: 25px;">Nhập Tiêu Đề:</label> <br> <input
						type="text" name="title" placeholder="Title">
				</div>

				<br> <label>Chọn ngày báo thức</label> <br>

				<div>
					<label">Mon <input type="checkbox" checked="checked">
					</label> <label>- Tues <input type="checkbox" checked="checked">
					</label> <label>- Wed <input type="checkbox" checked="checked">
					</label> <label>- Thus <input type="checkbox" checked="checked">
					</label> <label>- Fri <input type="checkbox" checked="checked">
					</label> <label>- Sat <input type="checkbox" checked="checked">
					</label> <label>- Sun <input type="checkbox" checked="checked">
					</label>
				</div>

				<br>

				<div>
					<label>Repeat <input type="radio" name="radio">
					</label>
				</div>
				<br> <br>
				<button class="btn success">Set</button>

			</form>
			<button class="btn danger" onclick="closeAlarmForm()">Cancel</button>
		</div>
	</div>

	<!-- Popup cái update bao thức -->
	<div class="modal" id="update">
		<div class="form-popup modal-content">
			<form action="update.htm" method="post">

				<div>
					<label style="font-size: 25px;">ID:</label> <br> <input id ="alarmMid"
						type="text" name="aid">
				</div>
				<br>
				<div>
					<label style="font-size: 25px;">Chọn giờ:</label> <input
						name="time" style="font-size: 25px;" type="time" required>
				</div>

				<br>

				<div>
					<label style="font-size: 25px;">Nhập Tiêu Đề:</label> <br> <input
						type="text" name="title" placeholder="Title">
				</div>

				<br> <label>Chọn ngày báo thức</label> <br>

				<div>
					<label">Mon <input type="checkbox" checked="checked">
					</label> <label>- Tues <input type="checkbox" checked="checked">
					</label> <label>- Wed <input type="checkbox" checked="checked">
					</label> <label>- Thus <input type="checkbox" checked="checked">
					</label> <label>- Fri <input type="checkbox" checked="checked">
					</label> <label>- Sat <input type="checkbox" checked="checked">
					</label> <label>- Sun <input type="checkbox" checked="checked">
					</label>
				</div>

				<br>


				<div>
					<label>Repeat <input type="radio" name="radio">
					</label>
				</div>
				<br> <br>
				<button class="btn success" type="submit">Set</button>

			</form>
			<button class="btn danger" onclick="closeUpdateForm()">Cancel</button>
		</div>
	</div>

	<hr>

	<div class="Footer">
		<div class="inner">
			<div class="row">
				<div class="column">
					<h2>Download Our App</h2>
					<img src="images/AppleStore.svg" alt="" width="170" height="56">
					<br> <br> <img src="images/GooglePlay.png" alt=""
						width="167" height="50">
				</div>
				<div class="column">
					<h2>Resources</h2>
					<p>About Us</p>
					<p>Are you lost?</p>
				</div>
				<div class="column">
					<h2>Legals</h2>
					<p>Terms of Use</p>
					<p>Privacy Policy</p>
					<p>Security</p>
				</div>
				<div class="column">
					<h2>Contact Us</h2>
					<p>Phone: 113</p>
					<p>Email: learncodeweb123@gmail.com</p>
				</div>
				<hr>
				Student From PTITHCM <br> <br> <br>
			</div>

		</div>
	</div>
	<!-- Footer -->


	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.scrolly.min.js"></script>
	<script src="assets/js/jquery.poptrox.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>

	<!-- The core Firebase JS SDK is always required and must be listed first -->
	<script src="https://www.gstatic.com/firebasejs/7.24.0/firebase-app.js"></script>

	<!-- TODO: Add SDKs for Firebase products that you want to use
		 https://firebase.google.com/docs/web/setup#available-libraries -->
	<script
		src="https://www.gstatic.com/firebasejs/7.24.0/firebase-firestore.js"></script>


	<script>
		// Your web app's Firebase configuration
		var firebaseConfig = {
			apiKey : "AIzaSyBucL9Q85YASVNA8-M4UMBvZK2tYV14zWo",
			authDomain : "remotealarmclock-2f98a.firebaseapp.com",
			databaseURL : "https://remotealarmclock-2f98a.firebaseio.com",
			projectId : "remotealarmclock-2f98a",
			storageBucket : "remotealarmclock-2f98a.appspot.com",
			messagingSenderId : "570922046860",
			appId : "1:570922046860:web:3b1fa8f98bb8935adcf2a9"
		};
		// Initialize Firebase
		firebase.initializeApp(firebaseConfig);
	</script>
	<script src="assets/js/firebaseUtil.js"></script>
	<script>
		/////////////////Banner//////////////////
		var slideIndex = 0;
		showSlides();

		function showSlides() {
			var i;
			var slides = document.getElementsByClassName("mySlides");
			for (i = 0; i < slides.length; i++) {
				slides[i].style.display = "none";
			}
			slideIndex++;
			if (slideIndex > slides.length) {
				slideIndex = 1
			}
			slides[slideIndex - 1].style.display = "block";
			setTimeout(showSlides, 8000); // fade ảnh sau 10s
		}

		////////////////Form để Set time/////////////
		function openAlarmForm(id) {
			document.getElementById("alarmId").style.display = "block";

		}

		function closeAlarmForm() {
			document.getElementById("alarmId").style.display = "none";
		}

		function openUpdateForm(id) {
			document.getElementById("update").style.display = "block";
			document.getElementById("alarmMid").value = id;

		}

		function closeUpdateForm() {
			document.getElementById("update").style.display = "none";

		}
	</script>
</html>