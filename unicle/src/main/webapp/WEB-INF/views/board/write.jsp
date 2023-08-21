<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>게시판 글쓰기 폼</title>
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
      <h2>Riding 기록 남기기</h2>
      <form action="/board/submit" method="post">
        <input type="hidden" id="upload" name="upload" />
        <div class="form-group">
          <label for="subject">제 목:</label>
          <input type="text" id="subject" name="subject" required />
        </div>

        <div class="form-group">
          <label for="content">라이딩 후기:</label>
          <textarea id="${content}" name="content" required> </textarea>
          <div class="location-inputs">
            <label for="sName">출 발 지:</label>
            <input type="text" name="sName" id="sName" />

            <label for="eName">목 적 지:</label>
            <input type="text" name="eName" id="eName" />
          </div>
          <input type="button" value="경로남기기!" onclick="getvalue()" />

          <iframe src="" height="600px" width="800px"></iframe>

          <iframe id="myIframe" src="https://www.example.com"></iframe>
          <!-- <button onclick="captureIframe()">Capture IFrame</button> -->
        </div>
        <div class="form-group">
          <input type="submit" value="글쓰기" />
          <input type="reset" value="다시쓰기" />
          <a href="/board/list" class="btn list-btn">목록으로 </a>
        </div>
      </form>
    </div>
  </body>
</html>
