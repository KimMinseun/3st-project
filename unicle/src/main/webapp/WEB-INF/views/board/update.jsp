<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="/resource/css/notice.css" />
    <style>
      body {
        font-family: Arial, sans-serif;
      }

      .container {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ccc;
      }

      .form-group {
        margin-bottom: 20px;
      }

      .form-group label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
      }

      .form-group input[type="text"],
      .form-group textarea {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 4px;
      }

      .form-group textarea {
        resize: vertical;
        height: 150px;
      }

      .form-group input[type="submit"],
      [type="reset"] {
        background-color: #4caf50;
        color: #fff;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        border-radius: 4px;
      }

      .form-group input[type="submit"],
      [type="reset"]:hover {
        background-color: #45a049;
      }

      iframe {
        display: none;
      }
      /* 출발지와 목적지 입력 필드 스타일 수정 */
      .location-inputs {
        display: flex;
        gap: 10px; /* 입력 필드 사이의 간격 조절 */
      }

      /* 입력 필드 스타일 수정 */
      .location-inputs input[type="text"] {
        flex: 1; /* 입력 필드를 같은 너비로 설정 */
      }
    </style>
    <script>
      function getvalue() {
        var sName = document.getElementById("sName").value;
        var eName = document.getElementById("eName").value;
        // Change the base URL to your desired URL
        var baseUrl =
          "https://map.kakao.com/?map_type=TYPE_MAP&target=bike&sName=";
        var urll = baseUrl + sName + "&eName=" + eName;

        // Show the iframe
        var frame = document.querySelector("iframe");
        frame.setAttribute("src", urll);
        frame.style.display = "block";

        document.getElementById("upload").value = urll;
      }

      function hideIframe() {
        // Hide the iframe on loading
        var frame = document.querySelector("iframe");
        frame.style.display = "none";
      }
    </script>
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a2e23a409ec3bcbfc463fc649f92efb9&libraries=services"
    ></script>
  </head>
  <body onload="hideIframe()">
    <div class="container">
      <h2>커뮤니티 수정</h2>
      <form action="/board/update" method="post">
        <input type="hidden" name="num" value="${num}" />
        <input type="hidden" id="upload" name="upload" />
        <div class="form-group">
          <label for="subject">제목:</label>
          <input
            type="text"
            id="subject"
            name="subject"
            value="${subject}"
            required
          />
        </div>
        <div class="form-group">
          <label for="content">내용:</label>
          <textarea id="content" name="content" required>${content}</textarea>
          <div class="location-inputs">
            <label for="sName">출발지:</label>
            <input type="text" name="sName" id="sName" value="${sName}" />

            <label for="eName">목적지:</label>
            <input type="text" name="eName" id="eName" value="${eName}" />
          </div>
          <input type="button" value="go!" onclick="getvalue()" />

          <iframe src="" height="600px" width="800px"></iframe>
        </div>
        <div class="form-group">
          <input type="submit" value="수정" />
          <input type="reset" value="취소" />
        </div>
      </form>
    </div>
  </body>
</html>
