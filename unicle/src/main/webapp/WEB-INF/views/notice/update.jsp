<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>공지사항 수정</title>
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

      /* Input and Textarea Styles */
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

      /* Button and Link Styles */
      .form-group input[type="submit"],
      .form-group input[type="reset"],
      .form-group a.btn {
        background-color: #4caf50;
        color: #fff;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        border-radius: 4px;
        text-decoration: none;
        display: inline-block;
        transition: background-color 0.3s;
      }

      .form-group input[type="submit"]:hover,
      .form-group input[type="reset"]:hover,
      .form-group a.btn:hover {
        background-color: #45a049;
      }

      /* Different Color for Reset Button */
      .form-group input[type="reset"] {
        background-color: #f44336;
      }

      .form-group input[type="reset"]:hover {
        background-color: #d32f2f;
      }

      /* Different Color for Link Button */
      .form-group a.btn {
        background-color: #2196f3;
      }

      .form-group a.btn:hover {
        background-color: #1976d2;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h2>공지사항 글 수정</h2>
      <form action="/notice/update" method="post">
        <input type="hidden" id="num" name="num" value="${num}" />
        <input
          type="hidden"
          id="boardType"
          name="boardType"
          value="${boardType}"
        />
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
        </div>

        <div class="form-group">
          <input type="submit" value="수정" />
          <input type="reset" value="초기화" />
          <a href="/notice/list" class="btn btn-danger">목록</a>
        </div>
      </form>
    </div>
  </body>
</html>
