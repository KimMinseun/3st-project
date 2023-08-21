<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>회원 정보 수정</title>
  </head>
  <body>
    <h1>회원 정보 수정</h1>
    <form action="/member/checkPassword" method="post">
      <label for="b_userID">UserID:</label>
      <input
        type="text"
        id="b_userID"
        name="b_userID"
        value="${sessionScope.user.b_userId}"
        readonly
      /><br />
      <!-- 비밀번호 확인 -->
      <label for="password">비밀번호 확인:</label>
      <input type="password" id="password" name="password" required /><br />

      <input type="submit" value="비밀번호 확인" />
    </form>
    <form action="/member/update" method="post">
      <label for="b_nickname">닉네임:</label>
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

      <label for="b_userAdd">주소:</label>
      <input
        type="text"
        id="b_userAdd"
        name="b_userAdd"
        value="${sessionScope.user.b_userAdd}"
        required
      /><br />

      <label for="gender">Gender:</label>
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

      <input type="submit" value="회원정보 수정" />
    </form>
  </body>
</html>
