<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>회원 정보 수정</title>
  </head>
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
         input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        button {
            display: inline-block;
            align-items: center;
            width: 150px;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
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
      
       .gender-container label {
        margin-right: 15px;
      }

      /* 추가한 스타일 */
button[type="button"][onclick="checkPasswordAndSubmit()"] {
  background-color: #e74c3c;
}

button[type="button"][onclick="checkPasswordAndSubmit()"]:hover {
  background-color: #c0392b;
}
    </style>
     <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  </head>
<body>
<h1>회원 정보 수정</h1>
<c:if test="${not empty sessionScope.user}">
<form action="/member/checkPassword" method="post" id="updateForm">

    <input type="text"value="${sessionScope.user.b_userId}" readonly/><br />
    <label for="b_userPass">비밀번호 확인:</label>
    <input type="password" id="b_userPass" name="b_userPass" required />
    <button type="button" onclick="checkPassword()">비밀번호 확인</button>
        
</form>
<form action="/member/update" method="post">
    <label for="b_nickname">닉네임:</label>
    <input type="hidden" id="b_userId" name="b_userId" value="${sessionScope.user.b_userId}" />
    <input
            type="text"
            id="b_nickname"
            name="b_nickname"
            value="${sessionScope.user.b_nickname}"
            required
    /><br />

    <label for="b_userPhone">전화번호:</label>
    <input
            type="text"
            id="b_userPhone"
            name="b_userPhone"
            value="${sessionScope.user.b_userPhone}"
            required
    /><br />
    <label for="memberemail">이메일:</label>
      <input type="email" id="memberemail" name="memberemail" value="${sessionScope.user.memberemail}"required />
      <div class="address-container">

    <label for="b_userAdd">주소:</label>
    <input
            type="text"
            id="b_userAdd"
            name="b_userAdd"
            value="${sessionScope.user.b_userAdd}"
            required
            onclick="showAddressPopup()"
    /><button type="button" onclick="openAddressSearch()">주소 검색</button>
<div class="gender-container"></div>
    <label for="b_userGender">Gender:</label>
    <!-- Hidden input to store the original gender value -->
    <input
            type="hidden"
            name="originalGender"
            value="${sessionScope.user.b_userGender}"
    />

    <input type="radio" id="male" name="b_userGender" value="M"
           ${sessionScope.user.b_userGender eq 'M' ? 'checked' : ''} required>
    <label for="male">Male</label>

    <input type="radio" id="female" name="b_userGender" value="F"
           ${sessionScope.user.b_userGender eq 'F' ? 'checked' : ''} required>
    <label for="female">Female</label>
</div>
    <button type="submit" id="updateButton" disabled >회원정보 수정</button>
</form>
<form action="/member/delete" method="post" id="deleteForm">
    <button type="button" onclick="checkPasswordAndSubmit()">회원 탈퇴</button>
</form>
</c:if>


<script>
function checkPassword() {
    // 비밀번호 입력값 가져오기
    var password = document.getElementById('b_userPass').value;
    // AJAX를 사용하여 서버로 비밀번호 전송
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/member/checkPassword', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                if (response.passwordMatch) {
                    // 비밀번호가 일치하는 경우
                    alert('비밀번호가 일치합니다.');
                    document.getElementById('updateButton').removeAttribute('disabled');
                } else {
                    // 비밀번호가 일치하지 않는 경우
                    alert('비밀번호가 틀렸습니다');
                    document.getElementById('updateButton').setAttribute('disabled', 'true');
                }
            } else {
                alert('오류가 발생하였습니다');
            }
        }
    };
    // 서버로 보낼 데이터 설정
    var formData = 'b_userPass=' + encodeURIComponent(password);
    xhr.send(formData);
}

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

 function checkPasswordAndSubmit() {
        var password = document.getElementById('b_userPass').value;
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/member/checkPassword', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var response = JSON.parse(xhr.responseText);
                    if (response.passwordMatch) {
                        // 비밀번호가 일치하는 경우
                        alert('비밀번호가 일치합니다.');
                        // 회원정보 수정 버튼 활성화
                        document.getElementById('updateButton').removeAttribute('disabled');
                        // 회원 탈퇴 폼 제출
                        document.getElementById('deleteForm').submit();
                    } else {
                         // 비밀번호가 일치하지 않는 경우
                        alert('비밀번호가 일치하지 않습니다. 비밀번호를 확인해주세요.');
                        // 회원정보 수정 버튼 비활성화
                        document.getElementById('updateButton').setAttribute('disabled', 'true');
                    }
                } else {
                    alert('오류가 발생하였습니다');
                }
            }
        };
    // 서버로 보낼 데이터 설정
    var formData = 'b_userPass=' + encodeURIComponent(password);
    xhr.send(formData);
}

  </script>
  </body>
</html>



        