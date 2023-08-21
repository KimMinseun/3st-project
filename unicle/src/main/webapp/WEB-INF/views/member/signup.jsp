<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Signup Page</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        line-height: 1.6;
        margin: 20px;
      }

      h1 {
        text-align: center;
      }

      form {
        max-width: 400px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
      }

      label {
        display: block;
        margin-bottom: 5px;
      }

      input[type="text"],
      input[type="password"],
      input[type="email"],
      input[type="radio"] {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 16px;
      }

      input[type="radio"] {
        width: auto;
        margin-right: 10px;
      }

      .gender-container {
        display: flex;
        align-items: center;
        /* Added to align items to the right */
        margin-bottom: 10px;
      }

      div.button-container {
        display: flex;
        justify-content: center; /* Added to center the buttons */
      }

      button {
        display: inline-block;
        align-items: center;
        width: 100px;
        padding: 10px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        margin-left: 5px;
      }

      button:hover {
        background-color: #0056b3;
      }

      button:focus {
        outline: none;
      }

      button:active {
        background-color: #003780;
      }

      .address-container {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        margin-bottom: 10px;
      }

      .address-container input {
        flex: 1;
      }

      .address-container button {
        margin-left: 10px;
        padding: 10px;
      }

      .address-container label {
        margin-bottom: 10px;
      }
        button[type="reset"] {
    background-color: #e74c3c;
  }

  button[type="reset"]:hover {
    background-color: #c0392b;
  }
    </style>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  </head>
  <body>
    <h1>회 원 가 입</h1>

    <form id="signup-form" action="/member/signup" method="post">
      <label for="b_userId">ID:</label>
      <input type="text" id="b_userId" name="b_userId" required />
      <label for="b_userPass">비밀번호:</label>
      <input type="password" id="b_userPass" name="b_userPass" required />
      <label for="b_nickname">닉네임:</label>
      <input type="text" id="b_nickname" name="b_nickname" required />
      <label for="b_userPhone">연락처:</label>
      <input type="text" id="b_userPhone" name="b_userPhone" required />
      <label for="memberemail">이메일:</label>
      <input type="email" id="memberemail" name="memberemail" required />
      <div class="address-container">
        <label for="b_userAdd">주소: </label>
        <input
          type="text"
          id="b_userAdd"
          name="b_userAdd"
          required
          
        />
        <button type="button" onclick="openAddressSearch()">주소 검색</button>
      </div>
      <div class="gender-container">
        <label>Gender:</label>
        <input type="radio" id="male" name="b_userGender" value="M" required />
        <label for="male">남성</label>
        <input
          type="radio"
          id="female"
          name="b_userGender"
          value="F"
          required
        />
        <label for="female">여성</label>
      </div>
      <div class="button-container">
        <button type="submit">가입하기</button>
        <button type="reset">초기화</button>
      </div>
    </form>

    <script>
      <!-- onclick="showAddressPopup()" -->
      function openAddressSearch() {
        new daum.Postcode({
          oncomplete: function (data) {
            // 검색 결과가 있을 때 코드 작성
            document.getElementById("b_userAdd").value = data.address;
          },
        }).open();
      }

      function showAddressPopup() {
        new daum.Postcode({
          oncomplete: function (data) {
            // 검색 결과가 있을 때 코드 작성
            document.getElementById("b_userAdd").value = data.address;
          },
        }).open();
      }
    </script>
  </body>
</html>
