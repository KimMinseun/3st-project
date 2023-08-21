<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Result</title>
</head>
<body>
    <%-- 로그인 실패 시에만 알람창 띄우기 --%>
    <c:if test="${param.error eq 'true'}">
        <script>
            alert("로그인에 실패하였습니다. 다시 로그인해주세요.");
        </script>
    </c:if>

    <%-- index 페이지로 자동 리다이렉트 (로그인 성공 시) --%>
    <script>
        window.location.replace("/member/main");
    </script>
</body>
</html>
