<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>공지사항 글쓰기 폼</title>
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

     .form-group input[type="reset"] {
    background-color: #f44336;
    color: #fff;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.3s ease-in-out; /* 추가된 부분: hover 효과를 부드럽게 만들기 위한 transition 속성 */
}


  .form-group input[type="submit"] {
        background-color: #4caf50;
        color: #fff;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        border-radius: 4px;
        transition: background-color 0.3s ease-in-out;
    }

    .form-group input[type="submit"]:hover {
        background-color: #45a049;
    }

    .form-group input[type="reset"]:hover {
        background-color: #d32f2f;
    }  
    
    .btn {
        display: inline-block;
        background-color: #3498db;
        color: #fff;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        border-radius: 4px;
        text-decoration: none;
        transition: background-color 0.3s ease-in-out;
    }

    .btn-primary {
        background-color: #3498db;
    }

    .btn-primary:hover {
        background-color: #2980b9;
    }

    .btn:hover {
        background-color: #2980b9;
    }

      </style>
  </head>
  <body>
    <div class="container">
      <h2>공지사항 글쓰기</h2>
      <form action="/notice/submit" method="post">
        <div class="form-group">
          <label for="subject">제목:</label>
          <input type="text" id="subject" name="subject" required />
        </div>
        <div class="form-group">
          <label for="content">내용:</label>
          <textarea id="${content}" name="content" required> </textarea>
        </div>
        <div class="form-group">
          <input type="submit" value="글쓰기" />
          <input type="reset" value="다시쓰기 " />
           <a href="/notice/list" class="btn list-btn">목록으로 </a>
        </div>
      </form>
    </div>
  </body>
</html>
