<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
    />
    <style>
      body {
        font-family: Arial, sans-serif;
        background-color: #fafafa;
        margin: 0;
        padding: 0;
      }

      .container {
        max-width: 1300px;
        margin: 0 auto;
      }

      h1 {
        text-align: center;
        margin: 30px 0;
        color: #333;
      }

      .post {
        border: 1px solid #ccc;
        margin: 20px 0;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
      }

      .post-image {
        width: 100%;
        height: 300px;
        object-fit: cover;
        border-radius: 5px 5px 0 0;
      }

      .post-content {
        padding: 10px;
        height: 600px;
      }

      .post-info {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
      }

      .post-author {
       
        font-weight: bold;
        margin-right: 10px;
      }

      .post-date {
        
        color: #666;
      }

       .post-media {
    width: 70%; /* 예시 비율 조정 */
    float: left;
    padding-left: 20px; /* 여백 조절 */
    box-sizing: border-box; /* 패딩까지 요소 크기에 포함시키기 */
     border-radius: 5px 5px 0 0;
    }

.post-con {
    width: 30%; /* 나머지 부분 */
    float: right;
    box-sizing: border-box;
}


      .post-caption {
        font-size: 16px;
        margin-bottom: 15px;
        color: #333;
      }

      .post-interaction {
        display: flex;
        align-items: center;
        color: #666;
        font-size: 14px;
      }

      .post-interaction i {
        margin-right: 5px;
      }

      .post-buttons {
        display: flex;
        justify-content: space-between;
        margin-top: 15px;
      }

      .btn {
        padding: 8px 15px;
        border-radius: 5px;
        text-decoration: none;
        color: #fff;
        font-size: 14px;
        cursor: pointer;
      }

      .btn-primary {
        background-color: #3498db;
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

      .btn-list {
        background-color: #4caf50;
      }

      .btn-list:hover {
        background-color: #45a049;
      }

      
      .btn-main {
        background-color: #e57373;
      }

      .btn-main:hover {
        background-color: #c62828;
      }

      /* Media queries for responsive design */
      @media screen and (max-width: 576px) {
        .post-image {
          height: 200px;
        }

        .post-caption {
          font-size: 14px;
        }

        .post-interaction {
          font-size: 12px;
        }

        .post-interaction i {
          font-size: 14px;
        }

        .btn {
          font-size: 12px;
        }
      }
      .post-buttons {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 15px;
      }

     
    /* post-buttons 영역 수정 */
    .post-buttons-container {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        margin-top: 10px; 
    }

      .post-buttons {
        display: flex;
        align-items: center;
      }

      .btn {
        /* Updated btn styles... */
        /* padding: 8px 15px; */
        border-radius: 5px;
         justify-content: flex-end;
        text-decoration: none;
        text-align: center;
        color: #fff;
        font-size: 14px;
        cursor: pointer;
        margin-left: 10px;
        min-width: 80px;
        position: static;
        max-width: 40px; 
      }
/* Pagination Styles */
.pagination {
  display: flex;
  justify-content: center;
  margin-top: 20px;
  margin-bottom: 20px;
}

.page-item {
  list-style-type: none;
  margin: 0 5px;
}

.page-link {
  display: block;
  padding: 8px 12px;
  background-color: #f5f5f5;
  border: 1px solid #ddd;
  border-radius: 4px;
  color: #333;
  text-decoration: none;
  transition: background-color 0.3s, color 0.3s, border-color 0.3s;
}

.page-link:hover {
  background-color: #ddd;
}

.page-item.active .page-link {
  background-color: #007bff;
  border-color: #007bff;
  color: #fff;
}

.page-item.disabled .page-link {
  opacity: 0.5;
  pointer-events: none;
}

.pagination .page-link:focus {
  box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

/* Remove list-style from ul */
.pagination ul {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
}

.pagination li {
  margin: 0;
  padding: 0;
}

/* Pagination Container Styles */
.pagination-container {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 20px;
  margin-bottom: 20px;
}

.pagination-container .page-item {
  margin: 0 5px;
}

</style>
<script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a2e23a409ec3bcbfc463fc649f92efb9&libraries=services"
    ></script>
  </head>
  <body>
    <div class="container">
      <h1 class="text-center my-4">RIDNG Diary</h1>
      <div class="row">
        <div class="col-md-8 mx-auto">
          <a href="/board/write" class="btn btn-primary">글쓰기</a>
          <a href="/member/main" class="btn btn-main">Home</a>
          <a href="/board/list?writer=${sessionScope.user.b_userId}" class="btn btn-primary ">작성자 게시물 보기</a>
          <c:choose>
    <c:when test="${param.writer == sessionScope.user.b_userId}">
        <a href="/board/list" class="btn btn-list">목록으로</a>
    </c:when>
    <c:when test="${param.writer != null}">
        오류
    </c:when>
</c:choose>

           <div id="postList">
          <c:if test="${not empty boardList}">
            <c:forEach items="${boardList}" var="post">
              <div class="post" data-writer="${post.writer}">
                <div class="post-content">
                  <br class="post-info">
                    <span class="post-author">${post.writer}</span>
                    <span class="post-date">${post.reg_date}</span>
                    <span class="post-title">${post.subject}</span></br>
                    <span class="post-image">
                     <iframe id="myIframe" src="${post.upload}"  height="550px" width="800px"></iframe></span>
                    <span class="post-con">${post.content}</span>
                  </div>
              </div>
              <div class="post-buttons-container">
                <div class="post-buttons">
                    <c:if test="${sessionScope.user.b_userId == post.writer}">
                    <a
                      href="/board/update/${post.num}"
                      class="btn btn-update"
                      >수정</a
                    >  
                  
                  <a
                      href="/board/delete/${post.num}"
                      class="btn btn-danger"
                      >삭제</a
                    >
                  </c:if>
                </div>
              </div>
            </c:forEach>
          </c:if>
          <c:if test="${empty boardList}">
            <div class="text-center">게시물이 없습니다.</div>
          </c:if>
        </div>
        </div>
        </div>

   <div class="pagination-container">
  <!--  이전 출력 시작 -->
  <c:if test="${pv.startPage > 1}">
    <span class="page-item">
      <a class="page-link" href="/board/list?currentPage=${pv.startPage - pv.blockPage}${isMyBoard?'&writer='+=sessionScope.user.b_userId:''}">Prev</a>
    </span>
  </c:if>
  <!--  이전 출력 끝 -->

  <!-- 페이지 출력 시작 -->
  <c:forEach var="i" begin="${pv.startPage}" end="${pv.endPage}">
    <span class="page-item">
      <c:choose>
        <c:when test="${i == pv.currentPage}">
          <a class="page-link page-item active" href="/board/list?currentPage=${i}${isMyBoard?'&writer='+=sessionScope.user.b_userId:''}">${i}</a>
        </c:when>
        <c:otherwise>
          <a class="page-link" href="/board/list?currentPage=${i}${isMyBoard?'&writer='+=sessionScope.user.b_userId:''}">${i}</a>
        </c:otherwise>
      </c:choose>
    </span>
  </c:forEach>
  <!-- 페이지 출력 끝 -->

  <!-- 다음 출력 시작 -->
  <c:if test="${pv.endPage < pv.totalPage}">
    <span class="page-item">
      <a class="page-link" href="/board/list?currentPage=${pv.startPage + pv.blockPage}${isMyBoard?'&writer='+=sessionScope.user.b_userId:''}">Next</a>
    </span>
  </c:if>
  <!-- 다음 출력 끝 -->
</div>


      
    </div>    
  </body>
</html>
