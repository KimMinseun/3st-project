<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
      /* 이미지를 감싸는 링크 스타일 설정 */
      .link-wrapper {
        display: block;
        width: 150px; /* 원하는 버튼 가로 크기로 설정 */
        height: 50px; /* 원하는 버튼 세로 크기로 설정 */
        position: absolute;
        top: 40%;
        left: 50%;
        transform: translate(-50%, -50%);
        cursor: pointer;
        background-color: rgba(255, 255, 255, 0.3);
        border-radius: 10px;
        text-align: center;
        line-height: 50px;

        text-decoration: none; /* 버튼 텍스트에 밑줄 제거 */
        color: rgb(216, 185, 185); /* 버튼 텍스트 색상 */
      }

      /* 바탕화면 이미지 설정 */
      .background-image {
        background-image: url("https://veloshop.co.kr/web/upload/NNEditor/20210326/99e5184776fd077c29f83d99c5db5698.gif");
        background-size: cover;
        background-repeat: no-repeat;
        margin: 0;
        padding: 0;
        position: relative;
        width: 100vw;
        height: 100vh;
      }
    </style>
  </head>
  <body>
    <div class="background-image">
      <a href="/member/main" class="link-wrapper">GO to UNICLE</a>
    </div>
  </body>
</html>
