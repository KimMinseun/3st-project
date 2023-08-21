<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
      /* static/css/board.css */

      /* Center the heading */
      .text-center {
        text-align: center;
      }

      /* Add some margin to the heading */
      .my-4 {
        margin-top: 2rem;
        margin-bottom: 2rem;
      }

      /* Style the post title */
      .post-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 10px;
      }

      /* Style the post meta information */
      .post-meta {
        font-size: 14px;
        color: #777;
        margin-bottom: 20px;
      }

      /* Style the post content */
      .post-content {
        font-size: 16px;
        line-height: 1.6;
      }

      /* Add some padding to the post details container */
      .post-details {
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #fff;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        margin: 20px;
      }

      .btn {
        padding: 8px 15px;
        border-radius: 5px;
        text-decoration: none;
        color: #fff;
        font-size: 14px;
        cursor: pointer;
      }

      .buttons .btn-danger:hover {
        background-color: #45a049;
      }

      .btn-primary {
        background-color: #3498db;
        margin-left: 20px;
      }

      .btn-primary:hover {
        background-color: #2980b9;
      }

      .btn-danger {
        background-color: #e74c3c;
      }

      .btn-danger:hover {
        background-color: #c0392b;
      }

      .btn-update {
        background-color: #4caf50;
      }

      .btn-update:hover {
        background-color: #45a049;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1 class="text-center my-4">공 지 사 항 view</h1>
      <div class="row">
        <div class="col-md-8 mx-auto">
          <div class="post-details">
            <h2 class="post-title">${boardDTO.subject}</h2>
            <div class="post-meta">
              작성자: ${boardDTO.writer} | 작성일: ${boardDTO.reg_date}
            </div>
            <div class="post-content">${boardDTO.content}</div>
          </div>

          <!-- Buttons section -->
          <div class="buttons">
            <a href="/notice/list" class="btn btn-primary" id="button"
              >목록으로</a
            >
            <c:if test="${sessionScope.user.b_admin == 'Y'}">
            <a
              href="/notice/delete/${boardDTO.num}"
              class="btn btn-danger"
              id="button"
              >삭제</a
            >
            <a
              href="/notice/update/${boardDTO.num}"
              class="btn btn-update"
              id="button"
              >수정</a
            >
            </c:if>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>

<!-- <body>
    <div class="container">
      <h1 class="text-center my-4">게시판페이지</h1>
      <div class="row">
        <div class="col-md-8 mx-auto">
          <table class="table table-striped">
            <thead>
              <tr>
                <th>#</th>
                <th>제목</th>
                <th>내용</th>
                <th>작성일</th>
              </tr>
            </thead>
            <tbody>
              <c:if test="${not empty boardDTO}">
                <tr>
                  <td>${boardDTO.num}</td>
                  <td>
                    <a href="/board/view/${post.num}">${boardDTO.subject}</a>
                  </td>
                  <td>${boardDTO.memberDTO.b_nickname}</td>
                  <td>${boardDTO.reg_date}</td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </body>
</html> -->
