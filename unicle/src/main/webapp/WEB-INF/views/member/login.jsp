<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login Page</title>
    <style>
  body {
  font-family: Arial, sans-serif;
  background-color: #f2f2f2;
  margin: 0;
  padding: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

.login-container {
  background-color: #fff;
  border-radius: 10px;
  padding: 20px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  width: 300px;
}

h1 {
  text-align: center;
  margin-bottom: 20px;
}

form {
  display: flex;
  flex-direction: column;
  align-items: center;
}

label {
  font-weight: bold;
  margin-bottom: 5px;
}

input {
  width: 100%;
  padding: 10px;
  margin-bottom: 15px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

button {
  background-color: #007bff;
  color: #fff;
  border: none;
  padding: 12px 27px;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease-in-out;
}

button:hover {
  background-color: #0056b3;
}

a {
  display: inline-block;
  background-color: #007bff;
  color: #fff;
  border: none;
  padding: 10px 15px;
  border-radius: 5px;
  cursor: pointer;
  text-decoration: none;
  transition: background-color 0.3s ease-in-out;
}

a:hover {
  background-color: #0056b3;
}

p {
  text-align: center;
  margin-top: 20px;
}

#kakao-login-btn {
  display: block;
  margin-top: 20px;
  text-align: center;
}

#token-result {
  text-align: center;
  margin-top: 20px;
}

.login-btn,
.signup-btn {
  background-color: #007bff;
  color: #fff;
  border: none;
  padding: 10px 15px;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease-in-out;
  text-decoration: none;
    margin-right: 5px;
}

.login-btn:hover {
  background-color: #0056b3;
}
  .signup-btn:hover {
    background-color: #e74c3c; /* 호버 시 배경색 변경 */
  }

  .button-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
    </style>
  </head>
  <body>
    <div class="login-container">
      <h1>Login Page</h1>
      <form id="login-form" action="/member/loginProcess" method="post">
        <label for="b_userId">UserID:</label>
        <input type="text" id="b_userId" name="b_userId" required />
        <label for="b_userPass">Password:</label>
        <input type="password" id="b_userPass" name="b_userPass" required />
      <div class="button-container">
        <button class="login-btn" type="submit">LogIn</button>
        <a class="signup-btn"
          href="/member/signup"
      style=" padding: 7px 14px;
          " >SignUp</a
        >
      </div>
      </form>
       </div>
   

       <!-- style="
            background-color: #e74c3c;
            color: #fff;
            border: none;
            padding: 7px 14px;
            border-radius: 5px;
            cursor: pointer; -->
     

      <!-- <p><a th:href="@{|${kakaoUrl}|}">카카오로그인</a></p>

      <a id="kakao-login-btn" href="javascript:loginWithKakao()">
        <img
          src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
          width="222"
          alt="카카오 로그인 버튼"
        />
      </a>
      <p id="token-result"></p>
   

    <script
      src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js"
      integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh"
      crossorigin="anonymous"
    ></script> -->
    <script>
      // Kakao.init("c089c8172def97eb00c07217cae17495"); // 사용하려는 앱의 JavaScript 키 입력
    </script>

    <script>
      // function loginWithKakao() {
      //   Kakao.Auth.authorize({
      //     redirectUri: "https://developers.kakao.com/tool/demo/oauth",
      //   });
      // }

      // // 아래는 데모를 위한 UI 코드입니다.
      // displayToken();
      // function displayToken() {
      //   var token = getCookie("authorize-access-token");

      //   if (token) {
      //     Kakao.Auth.setAccessToken(token);
      //     Kakao.Auth.getStatusInfo()
      //       .then(function (res) {
      //         if (res.status === "connected") {
      //           document.getElementById("token-result").innerText =
      //             "login success, token: " + Kakao.Auth.getAccessToken();
      //         }
      //       })
      //       .catch(function (err) {
      //         Kakao.Auth.setAccessToken(null);
      //       });
      //   }
      // }

      // function getCookie(name) {
      //   var parts = document.cookie.split(name + "=");
      //   if (parts.length === 2) {
      //     return parts[1].split(";")[0];
      //   }
      // }
    </script>
  </body>
</html>
