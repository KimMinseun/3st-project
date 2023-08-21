<%@ page language="java" contentType="text/html; charset=UTF-8"%> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>날씨 정보</title>
    <!-- axios 라이브러리 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <!-- Weather Underground Icons CSS 파일 추가 -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css"
    />
    <style>
      /* Styles for h1 */
      h1 {
        text-align: center;
        margin-top: 10px;
        font-size: 20px; /* Increase font size for emphasis */
        color: #555; /* Slightly darker gray color */
      }

      /* Styles for the table */
      table {
        border-collapse: collapse;
        width: 100%;
      }

      th,
      td {
        /* Maintain existing styles and set white border */
        text-align: center;
        border-bottom: 1px solid white;
        font-weight: bolder;
        color: #333;
        line-height: 45px;
      }
      td > img {
        vertical-align: middle;
        margin-top: -3px;
      }

      /* Remove right border for last column */
      td:last-child {
        border-right: none;
      }

      /* Add top border for the first row */
      td:first-child {
        border-top: 1px solid white;
      }

      /* Add left border for the first column */
      td:first-child {
        border-left: 1px solid rgb(242, 238, 238);
      }

      /* Styles for the scrollable container */
      .scrollable-container {
        max-height: 390px; /* Increase the maximum scrollable height */
        overflow-y: auto;
        background-color: rgb(245, 245, 245);
      }
    </style>
  </head>
  <body>
    <!-- 날씨 정보를 출력할 테이블 -->
    <div class="scrollable-container">
      <table id="weather-table">
        <thead>
          <tr>
            <th>날짜</th>
            <th>시간대</th>
            <th>하늘상태</th>
            <th>강수확률</th>
            <th>1시간 기온</th>
          </tr>
        </thead>
        <tbody></tbody>
      </table>
    </div>

    <script>
      // 페이지 로딩 시, 날씨 정보를 가져와서 테이블로 출력하는 함수 호출
      fetchWeatherInfo();

      // PTY 값을 기반으로 강수 상태 아이콘을 반환하는 함수
      function getPtyWeatherIcon(ptyValue) {
        switch (ptyValue) {
          case "0":
            return '<img width="24" height="24" src="https://img.icons8.com/fluency/48/sun.png" alt="sun" />';
          case "1":
            return '<img width="24" height="24" src="https://img.icons8.com/color/48/heavy-rain.png" alt="heavy-rain" />';
          case "2":
            return '<img width="24" height="24" src="https://img.icons8.com/fluency/48/sleet.png" alt="sleet" />';
          case "3":
            return '<img width="24" height="24" src="https://img.icons8.com/office/48/snow-storm.png" alt="snow-storm" />';
          case "4":
            return '<img width="24" height="24" src="https://img.icons8.com/emoji/48/sun-behind-rain-cloud.png" alt="sun-behind-rain-cloud" />';
          default:
            return "";
        }
      }

      // 날씨 정보를 가져와서 테이블로 출력하는 함수
      function fetchWeatherInfo() {
        // 서버로 날씨 정보를 요청 (axios 라이브러리 사용)
        axios
          .get("/weather")
          .then(function (response) {
            var weatherInfo = response.data;

            // 날씨 정보를 출력할 테이블의 tbody 요소를 선택
            var tableBody = document.querySelector("#weather-table tbody");

            // 동일한 시간대의 데이터를 그룹화하는 객체 생성
            var groupedData = {};

            // 가져온 날씨 정보를 그룹화
            weatherInfo.forEach(function (item) {
              var fcstDate = item.fcstDate;
              var fcstTime = item.fcstTime;
              var category = item.category;
              var fcstValue = item.fcstValue;

              var key = fcstDate + fcstTime; // 시간대를 기준으로 그룹화하기 위한 키 생성

              // 동일한 시간대의 데이터가 없으면 새로운 객체 생성
              if (!groupedData[key]) {
                groupedData[key] = {
                  fcstDate: fcstDate,
                  fcstTime: fcstTime,
                  PTY: "",
                  POP: "",
                  TMP: "",
                };
              }

              // PTY, POP, TMP 값에 따라 데이터를 할당
              if (category === "PTY") {
                groupedData[key].PTY = fcstValue;
              } else if (category === "POP") {
                groupedData[key].POP = fcstValue;
              } else if (category === "TMP") {
                groupedData[key].TMP = fcstValue;
              }
            });

            // 날씨 정보를 테이블에 추가
            for (var key in groupedData) {
              var row = document.createElement("tr"); // 행(tr) 생성
              var data = groupedData[key];

              // 날짜와 시간대 정보 출력
              var fcstDateCell = document.createElement("td");
              fcstDateCell.textContent = data.fcstDate;
              row.appendChild(fcstDateCell);

              var fcstTimeCell = document.createElement("td");
              fcstTimeCell.textContent = data.fcstTime;
              row.appendChild(fcstTimeCell);

              // PTY 값을 기반으로 강수 상태 아이콘 출력
              var ptyCell = document.createElement("td");
              ptyCell.innerHTML = getPtyWeatherIcon(data.PTY);
              row.appendChild(ptyCell);

              var popCell = document.createElement("td");
              popCell.textContent = data.POP || "-";
              row.appendChild(popCell);

              var tmpCell = document.createElement("td");
              tmpCell.textContent = data.TMP || "-";
              row.appendChild(tmpCell);

              // 테이블의 tbody에 행을 추가
              tableBody.appendChild(row);
            }
          })
          .catch(function (error) {
            console.error("날씨 정보를 가져오는데 실패했습니다.");
          });
      }
    </script>
  </body>
</html>
