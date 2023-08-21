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
h2 {
	font-weight: border;
}

.hr1 {
	border: 0;
	height: 2px;
	background: #d3d3d3;
}

.grey {
	color: #727272;
}

#strong {
	font-weight: 900;
}

table {
	width: 100%;
	border-top: 1px solid #d3d3d3;
	border-collapse: collapse;
}

th {
	background-color: #d3d3d3;
	border-top: 3px solid #727272;
}

th,
td {
	border-bottom: 1px solid #d3d3d3;
	padding: 10px;
	text-align: center
}

td :hover{
  background-color: #727272;
}

 .greylist,
  .gradient {
    width: 80px;
    height: 30px;
    font-weight: 900;
    color: white;
    text-align: center;
    border: solid 2px white;
    border-radius: 5px;
  }

  .greylist {
    background: grey;
  }

  .gradient {
    background: linear-gradient(to bottom, rgb(128, 128, 128), black);
  }

  /* Apply greylist style when gradient button is hovered */
  .gradient:hover {
    background: grey;
  }

.left {
	text-align: left;
}

.right {
	float: right;
}


a {
	color: black;
	text-decoration-line: none;
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

.text-center {
  text-align: center;
  margin-top: 4rem; /* 조정 가능한 마진 값 */
  margin-bottom: 4rem; /* 조정 가능한 마진 값 */
}



 body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  background-color: #f5f5f5;
  color: #333;
}

.container {

  width: 100%;
  max-width: 1400px;
  margin: 0 auto;
  padding: 20px;
} 



  </style>
  
  </head>
  <body>
    <div class="container">
      <h1 class="text-center my-4">공 지 게 시 판</h1>
      <div class="row">
        <br class="col-md-8 mx-auto">
          <table class="table table-striped">
            <thead>
              <tr>
                <th>게시번호</th>
                <th>공 지 사 항</th>
                <th>작성자</th>
                <th>작성일</th>
              </tr>
            </thead>
            <tbody>
              <c:if test="${not empty noticeList}">
                <c:forEach items="${noticeList}" var="post">
                  <tr>
                    <td>${post.rnum}</td>
                    <td>
                      <a href="/notice/view?num=${post.num}">${post.subject}</a>
                    </td>
                     <td>${post.writer}</td>
                    <!--<td>${post.memberDTO.b_userID}</td>-->
                    <td>${post.reg_date}</td>
                  </tr>
                </c:forEach>
              </c:if>
              <c:if test="${empty noticeList}">
                <tr>
                  <td colspan="4" class="text-center">게시물이 없습니다.</td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </br>

	<div class="pagination-container">
  <!--  이전 출력 시작 -->
  <c:if test="${pv.startPage > 1}">
    <span class="page-item">
      <a class="page-link" href="/notice/list?currentPage=${pv.startPage - pv.blockPage}">Prev</a>
    </span>
  </c:if>
  <!--  이전 출력 끝 -->

  <!-- 페이지 출력 시작 -->
  <c:forEach var="i" begin="${pv.startPage}" end="${pv.endPage}">
    <span class="page-item">
      <c:choose>
        <c:when test="${i == pv.currentPage}">
          <a class="page-link page-item active" href="/notice/list?currentPage=${i}">${i}</a>
        </c:when>
        <c:otherwise>
          <a class="page-link" href="/notice/list?currentPage=${i}">${i}</a>
        </c:otherwise>
      </c:choose>
    </span>
  </c:forEach>
  <!-- 페이지 출력 끝 -->

  <!-- 다음 출력 시작 -->
  <c:if test="${pv.endPage < pv.totalPage}">
    <span class="page-item">
      <a class="page-link" href="/notice/list?currentPage=${pv.startPage + pv.blockPage}">Next</a>
    </span>
  </c:if>
  <!-- 다음 출력 끝 -->
</div>

<div>
  <input type="button" value="HOME" class="gradient" onclick="window.location.href='/member/main'" />
  <span class="right">  
    <c:if test="${sessionScope.user.b_admin == 'Y'}">
                <input type="button" value="글쓰기" class="gradient" onclick="WritePage()" cursor="pointer">        
    </c:if>
      </span>
</div>
           
    
        </div>
      </div>

   

    <script> 
     function WritePage() {
      window.location.href = "write";
     }
    
   </script>
  </body>
</html>




