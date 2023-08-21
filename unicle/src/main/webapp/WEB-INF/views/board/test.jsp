<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Title</title>
    <style>
      /* Hide the iframe initially */
      iframe {
        display: none;
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
      }

      function hideIframe() {
        // Hide the iframe on loading
        var frame = document.querySelector("iframe");
        frame.style.display = "none";
      }
    </script>
  </head>
  <body onload="hideIframe()">
    <!--폼을 만드는 html구문-->
    <form>
      <input type="text" name="sName" id="sName" />
      <input type="text" name="eName" id="eName" />
      <input type="button" value="go!" onclick="getvalue()" />
    </form>

    <iframe src="" height="600px" width="800px"></iframe>
  </body>
</html>
