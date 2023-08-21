<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="/resource/css/main.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Add the Kakao Map API script -->
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a2e23a409ec3bcbfc463fc649f92efb9&libraries=services"
    ></script>
    <style>
      .bike,
      .jongju {
        display: block;
        background: #50627f;
        color: #fff;
        text-align: center;
        height: 24px;
        line-height: 22px;
        border-radius: 4px;
        padding: 0px 10px;
      }

      .bike:hover,
      .jongju :hover {
        background: #6a80a3;
      }
    </style>
  </head>
  <body onload="init()">
    <div class="menu-container">
      <div class="menu">
        <a href="/notice/list">Notice</a>
        <a href="/board/list">Community</a>
        <c:choose>
          <c:when test="${not empty sessionScope.user}">
            <a href="/member/update">
              <c:out value="${sessionScope.user.b_userId}" />
              <i class="fa-solid fa-user"></i>
            </a>
            <a href="/member/logout">로그아웃</a>
          </c:when>
          <c:otherwise>
            <a href="/member/login">로그인</a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
    <div class="map_wrap">
      <div id="map" style="width: 100%; height: 100%; position: relative">
        <ul id="category">
          <li id="BK9" data-order="0">
            <span class="category_bg bank"></span>
            은행
          </li>
          <li id="MT1" data-order="1">
            <span class="category_bg mart"></span>
            마트
          </li>
          <li id="PM9" data-order="2">
            <span class="category_bg pharmacy"></span>
            약국
          </li>
          <li id="AD5" data-order="3">
            <span class="category_bg sleep"></span>
            숙박
          </li>
          <li id="CE7" data-order="4">
            <span class="category_bg cafe"></span>
            카페
          </li>
          <li id="CS2" data-order="5">
            <span class="category_bg store"></span>
            편의점
          </li>
        </ul>
      </div>

      <div id="menu_wrap" class="bg_white">
        <div class="option">
          <div>
            <!-- HTML 코드 -->
            <form id="searchForm">
              키워드 :
              <input
                type="text"
                value=""
                id="keyword"
                size="15"
                autocomplete="off"
              />
              <button type="submit" onclick="searchPlaces(); return false;">
                검색하기
              </button>
            </form>
          </div>
        </div>
        <hr />
        <ul id="placesList"></ul>
        <div id="pagination"></div>
      </div>
      <button
        type="button"
        class="btn btn-lg btn-primary btn-map"
        onClick="getCurrentPosBtn()"
      >
        <i class="fa-solid fa-person-biking fa-2x"></i>
      </button>
    </div>

    <p class="btn-group-vertical" style="margin-top: 3px">
      <input type="checkbox" id="chkTerrain" onclick="setOverlayMapTypeId()" />
      <label for="chkTerrain">지형정보 보기</label>
      <input type="checkbox" id="chkTraffic" onclick="setOverlayMapTypeId()" />
      <label for="chkTraffic"> 교통정보 보기</label>
      <input type="checkbox" id="chkBicycle" onclick="setOverlayMapTypeId()" />
      <label for="chkBicycle">자전거도로 정보 보기</label>
      <label id="result" style="display: inline-block"></label>
    </p>
    <button onclick="showMarkers()" class="btn-default">자전거 종주</button>
    <button onclick="show1Markers()" class="btn-default">따릉이 위치</button>

    <!-- 버튼 추가 -->

    <script>
      function init() {
        // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
        // ps.keywordSearch("", placesSearchCB);
      }

      // // 초기 지도와 마커를 생성하는 함수 호출은 버튼 클릭 이전에 이루어짐
      // // 따라서 초기에도 마커를 표시하고 싶다면 페이지 로드 시 호출해야 함
      // $(document).ready(function () {
      //   showMarkers(); // 초기 지도와 마커 생성
      // });

      // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
      var placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 }),
        contentNode = document.createElement("div"), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
        markers = [], // 마커를 담을 배열입니다
        currCategory = ""; // 현재 선택된 카테고리를 가지고 있을 변수입니다

      var mapContainer = document.getElementById("map"), // 지도를 표시할 div
        mapOption = {
          center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
          level: 5, // 지도의 확대 레벨
        };

      // 지도를 생성합니다
      var map = new kakao.maps.Map(mapContainer, mapOption);

      // 장소 검색 객체를 생성합니다
      //var ps = new kakao.maps.services.Places(map);

      kakao.maps.event.addListener(map, "click", function (mouseEvent) {
        // 클릭한 위도, 경도 정보를 가져옵니다
        var latlng = mouseEvent.latLng;

        var message = "위도 : " + latlng.getLat() + " , ";
        message += "경도 : " + latlng.getLng() + " ";

        var resultDiv = document.getElementById("result");
        resultDiv.innerHTML = message;
      });

      console.log("result");

      // 지도에 idle 이벤트를 등록합니다
      //kakao.maps.event.addListener(map, 'idle', searchCategoryPlaces);

      // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다
      contentNode.className = "placeinfo_wrap";

      // 장소 검색 객체를 생성합니다
      var ps = new kakao.maps.services.Places();

      // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
      var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

      // 키워드로 장소를 검색합니다
      searchPlaces();

      // 키워드 검색을 요청하는 함수입니다
      function searchPlaces() {
        var keyword = document.getElementById("keyword").value;

        if (!keyword.replace(/^\s+|\s+$/g, "")) {
          alert("키워드를 입력해주세요!");
          return false;
        }
        console.log(keyword);
        // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
        ps.keywordSearch(keyword, placesSearchCB);
      }

      // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
      function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
          // 정상적으로 검색이 완료됐으면
          // 검색 목록과 마커를 표출합니다
          displayPlaces(data);

          // 페이지 번호를 표출합니다
          displayPagination(pagination);
        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
          alert("검색 결과가 존재하지 않습니다.");
          return;
        } else if (status === kakao.maps.services.Status.ERROR) {
          alert("검색 결과 중 오류가 발생했습니다.");
          return;
        }
      }

      // 검색 결과 목록과 마커를 표출하는 함수입니다
      function displayPlaces(places) {
        var listEl = document.getElementById("placesList"),
          menuEl = document.getElementById("menu_wrap"),
          fragment = document.createDocumentFragment(),
          bounds = new kakao.maps.LatLngBounds(),
          listStr = "";

        // 검색 결과 목록에 추가된 항목들을 제거합니다
        removeAllChildNods(listEl);

        // 지도에 표시되고 있는 마커를 제거합니다
        removeMarker();

        for (var i = 0; i < places.length; i++) {
          // 마커를 생성하고 지도에 표시합니다
          var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i),
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

          // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
          // LatLngBounds 객체에 좌표를 추가합니다
          bounds.extend(placePosition);

          // 마커와 검색결과 항목에 mouseover 했을때
          // 해당 장소에 인포윈도우에 장소명을 표시합니다
          // mouseout 했을 때는 인포윈도우를 닫습니다
          // 검색결과 항목과 마커를 생성하는 함수에서 마커의 이벤트 등록 부분을 수정합니다
          (function (marker, title, position) {
            kakao.maps.event.addListener(marker, "mouseover", function () {
              displayInfowindow(marker, title, position);
            });

            kakao.maps.event.addListener(marker, "mouseout", function () {
              infowindow.close();
            });

            itemEl.onmouseover = function () {
              displayInfowindow(marker, title, position);
            };

            itemEl.onmouseout = function () {
              infowindow.close();
            };

            itemEl.onclick = function () {
              // 마커를 클릭하면 해당 위치로 지도 이동
              map.panTo(position);
              // 해당 마커를 지도에서 삭제
              marker.setMap(null);
            };
          })(marker, places[i].place_name, placePosition);

          fragment.appendChild(itemEl);
        }

        // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
        listEl.appendChild(fragment);
        menuEl.scrollTop = 0;

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
      }

      // 검색결과 항목을 Element로 반환하는 함수입니다
      function getListItem(index, places) {
        var el = document.createElement("li"),
          itemStr =
            '<span class="markerbg marker_' +
            (index + 1) +
            '"></span>' +
            '<div class="info">' +
            "   <h5>" +
            places.place_name +
            "</h5>";

        if (places.road_address_name) {
          itemStr +=
            "    <span>" +
            places.road_address_name +
            "</span>" +
            '   <span class="jibun gray">' +
            places.address_name +
            "</span>";
        } else {
          itemStr += "    <span>" + places.address_name + "</span>";
        }

        itemStr += '  <span class="tel">' + places.phone + "</span>" + "</div>";

        el.innerHTML = itemStr;
        el.className = "item";

        return el;
      }

      // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
      function addMarker(position, idx, title) {
        var imageSrc =
            "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
          imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
          imgOptions = {
            spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin: new kakao.maps.Point(0, idx * 46 + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37), // 마커 좌표에 일치시킬 이미지 내에서의 좌표
          },
          markerImage = new kakao.maps.MarkerImage(
            imageSrc,
            imageSize,
            imgOptions
          ),
          marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage,
          });

        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker); // 배열에 생성된 마커를 추가합니다

        return marker;
      }

      // 지도 위에 표시되고 있는 마커를 모두 제거합니다
      function removeMarker() {
        for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(null);
        }
        markers = [];
      }

      // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
      function displayPagination(pagination) {
        var paginationEl = document.getElementById("pagination"),
          fragment = document.createDocumentFragment(),
          i;

        // 기존에 추가된 페이지번호를 삭제합니다
        while (paginationEl.hasChildNodes()) {
          paginationEl.removeChild(paginationEl.lastChild);
        }

        for (i = 1; i <= pagination.last; i++) {
          var el = document.createElement("a");
          el.href = "#";
          el.innerHTML = i;

          if (i === pagination.current) {
            el.className = "on";
          } else {
            el.onclick = (function (i) {
              return function () {
                pagination.gotoPage(i);
              };
            })(i);
          }

          fragment.appendChild(el);
        }
        paginationEl.appendChild(fragment);
      }

      // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
      // 인포윈도우에 장소명을 표시합니다
      function displayInfowindow(marker, title) {
        var content = '<div style="padding:5px;z-index:1;">' + title + "</div>";

        infowindow.setContent(content);
        infowindow.open(map, marker);
      }

      // 검색결과 목록의 자식 Element를 제거하는 함수입니다
      function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
          el.removeChild(el.lastChild);
        }
      }

      // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
      // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다
      addEventHandle(contentNode, "mousedown", kakao.maps.event.preventMap);
      addEventHandle(contentNode, "touchstart", kakao.maps.event.preventMap);

      // 커스텀 오버레이 컨텐츠를 설정합니다
      placeOverlay.setContent(contentNode);

      // 각 카테고리에 클릭 이벤트를 등록합니다
      addCategoryClickEvent();

      // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
      function addEventHandle(target, type, callback) {
        if (target.addEventListener) {
          target.addEventListener(type, callback);
        } else {
          target.attachEvent("on" + type, callback);
        }
      }

      // 카테고리 검색을 요청하는 함수입니다
      function searchCategoryPlaces() {
        if (!currCategory) {
          return;
        }

        // 커스텀 오버레이를 숨깁니다
        placeOverlay.setMap(null);

        // 지도에 표시되고 있는 마커를 제거합니다
        removeMarker();

        ps.categorySearch(currCategory, placesCategorySearchCB, {
          useMapBounds: true,
        });
      }

      // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
      function placesCategorySearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
          // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
          displayCategoryPlaces(data);
        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
          // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요
        } else if (status === kakao.maps.services.Status.ERROR) {
          // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
        }
      }

      // 지도에 마커를 표출하는 함수입니다
      function displayCategoryPlaces(places) {
        // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
        // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
        var order = document
          .getElementById(currCategory)
          .getAttribute("data-order");

        for (var i = 0; i < places.length; i++) {
          // 마커를 생성하고 지도에 표시합니다
          var marker = addCategoryMarker(
            new kakao.maps.LatLng(places[i].y, places[i].x),
            order
          );

          // 마커와 검색결과 항목을 클릭 했을 때
          // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
          (function (marker, place) {
            kakao.maps.event.addListener(marker, "click", function () {
              displayCategoryPlaceInfo(place);
            });
          })(marker, places[i]);
        }
      }

      // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
      function addCategoryMarker(position, order) {
        var imageSrc = "https://i.postimg.cc/j5pyjtGT/places-category.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
          imageSize = new kakao.maps.Size(27, 28), // 마커 이미지의 크기
          imgOptions = {
            spriteSize: new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
            spriteOrigin: new kakao.maps.Point(46, order * 36), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(11, 28), // 마커 좌표에 일치시킬 이미지 내에서의 좌표
          },
          markerImage = new kakao.maps.MarkerImage(
            imageSrc,
            imageSize,
            imgOptions
          ),
          marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage,
          });

        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker); // 배열에 생성된 마커를 추가합니다

        return marker;
      }

      // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
      function displayCategoryPlaceInfo(place) {
        var content =
          '<div class="placeinfo">' +
          '   <a class="title" href="' +
          place.place_url +
          '" target="_blank" title="' +
          place.place_name +
          '">' +
          place.place_name +
          "</a>";

        if (place.road_address_name) {
          content +=
            '    <span title="' +
            place.road_address_name +
            '">' +
            place.road_address_name +
            "</span>" +
            '  <span class="jibun" title="' +
            place.address_name +
            '">(지번 : ' +
            place.address_name +
            ")</span>";
        } else {
          content +=
            '    <span title="' +
            place.address_name +
            '">' +
            place.address_name +
            "</span>";
        }

        content +=
          '    <span class="tel">' +
          place.phone +
          "</span>" +
          "</div>" +
          '<div class="after"></div>';

        contentNode.innerHTML = content;
        placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
        placeOverlay.setMap(map);
      }

      // 각 카테고리에 클릭 이벤트를 등록합니다
      function addCategoryClickEvent() {
        var category = document.getElementById("category"),
          children = category.children;

        for (var i = 0; i < children.length; i++) {
          children[i].onclick = onClickCategory;
        }
      }

      // 카테고리를 클릭했을 때 호출되는 함수입니다
      function onClickCategory() {
        var id = this.id,
          className = this.className;

        placeOverlay.setMap(null);

        if (className === "on") {
          currCategory = "";
          changeCategoryClass();
          removeMarker();
        } else {
          currCategory = id;
          changeCategoryClass(this);
          searchCategoryPlaces();
        }
      }

      // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
      function changeCategoryClass(el) {
        var category = document.getElementById("category"),
          children = category.children,
          i;

        for (i = 0; i < children.length; i++) {
          children[i].className = "";
        }

        if (el) {
          el.className = "on";
        }
      }

      function showMarkers() {
        $.ajax({
          type: "GET",
          url: "/jongju",
          dataType: "json",
          success: function (data) {
            removeMarker(); // 검색 결과 목록에 추가된 항목들을 제거합니다

            var level = map.getLevel();
            map.setLevel(9);

            for (var i = 0; i < data.length; i++) {
              var markerPosition = new kakao.maps.LatLng(
                data[i].latitude,
                data[i].longitude
              );
              var marker = new kakao.maps.Marker({
                position: markerPosition,
                map: map,
                title: data[i].jongjuname,
              });

              var jongjuname = data[i].jongjuname;
              var indexOfDot = jongjuname.indexOf("."); // "."의 위치를 찾습니다.

              var content =
                '<div class="info-window">' +
                '<div class="info-name" style="width: 200px; text-align:center">' +
                '<span class="jongju" style="font-size:14px ;font-weight: bold;">' +
                jongjuname +
                "</span> 인증센터" +
                "</div>" +
                "</div>";

              // 마커에 표시할 인포윈도우를 생성합니다.
              var infowindow = new kakao.maps.InfoWindow({
                content: content,
              });

              // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다.
              kakao.maps.event.addListener(
                marker,
                "mouseover",
                makeOverListener(map, marker, infowindow)
              );
              kakao.maps.event.addListener(
                marker,
                "mouseout",
                makeOutListener(infowindow)
              );

              markers.push(marker); // 배열에 생성된 마커를 추가합니다.
            }
          },
          error: function (xhr, status, error) {
            console.error(error);
          },
        });
      }

      function show1Markers() {
        $.ajax({
          type: "GET",
          url: "/bike",
          dataType: "json",
          success: function (data) {
            removeMarker(); // 검색 결과 목록에 추가된 항목들을 제거합니다.
            console.log(data);
            var level = map.getLevel();
            map.setLevel(7);

            for (var i = 0; i < data.row.length; i++) {
              var markerPosition = new kakao.maps.LatLng(
                data.row[i].stationLatitude,
                data.row[i].stationLongitude
              );
              var marker = new kakao.maps.Marker({
                position: markerPosition,
                map: map,
                title: data.row[i].stationName,
              });

              var stationName = data.row[i].stationName;
              var indexOfDot = stationName.indexOf("."); // "."의 위치를 찾습니다.

              // "." 다음의 문자열(역 이름)만 추출하여 출력합니다.
              var stationNameWithoutNumber = stationName.substring(
                indexOfDot + 2
              );

              var content =
                '<div class="info-window">' +
                '<div class="info-name" style="width: 200px; text-align:center">' +
                '<span class="bike" style="font-size:14px ;font-weight: bold;">' +
                stationNameWithoutNumber +
                "</span> 정류소" +
                "</div>" +
                '<div class="info-bike" style="text-align:center;">' +
                '<span class="bike" style="color: red; font-size:13px ; font-weight: bold;">' +
                data.row[i].parkingBikeTotCnt +
                "</span> 사용가능</div>" +
                "</div>";

              // 마커에 표시할 인포윈도우를 생성합니다.
              var infowindow = new kakao.maps.InfoWindow({
                content: content,
              });

              // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다.
              kakao.maps.event.addListener(
                marker,
                "mouseover",
                makeOverListener(map, marker, infowindow)
              );
              kakao.maps.event.addListener(
                marker,
                "mouseout",
                makeOutListener(infowindow)
              );

              markers.push(marker); // 배열에 생성된 마커를 추가합니다.
            }
          },
          error: function (xhr, status, error) {
            console.error(error);
          },
        });
      }

      var infoTitle = document.querySelectorAll(".jongju");
      infoTitle.forEach(function (e) {
        var w = e.offsetWidth + 10;
        var ml = w / 2;
        e.parentElement.style.top = "82px";
        e.parentElement.style.left = "50%";
        e.parentElement.style.marginLeft = -ml + "px";
        e.parentElement.style.width = w + "px";
        e.parentElement.previousSibling.style.display = "none";
        e.parentElement.parentElement.style.border = "0px";
        e.parentElement.parentElement.style.background = "unset";
      });

      var infoTitle1 = document.querySelectorAll(".bike");
      infoTitle1.forEach(function (e) {
        var w = e.offsetWidth + 10;
        var ml = w / 2;
        e.parentElement.style.top = "82px";
        e.parentElement.style.left = "50%";
        e.parentElement.style.marginLeft = -ml + "px";
        e.parentElement.style.width = w + "px";
        e.parentElement.previousSibling.style.display = "none";
        e.parentElement.parentElement.style.border = "0px";
        e.parentElement.parentElement.style.background = "unset";
      });

      // 인포윈도우를 표시하는 클로저를 만드는 함수입니다.
      function makeOverListener(map, marker, infowindow) {
        return function () {
          infowindow.open(map, marker);
        };
      }

      // 인포윈도우를 닫는 클로저를 만드는 함수입니다.
      function makeOutListener(infowindow) {
        return function () {
          infowindow.close();
        };
      }

      var mapTypes = {
        terrain: kakao.maps.MapTypeId.TERRAIN,
        traffic: kakao.maps.MapTypeId.TRAFFIC,
        bicycle: kakao.maps.MapTypeId.BICYCLE,
      };

      // 체크 박스를 선택하면 호출되는 함수입니다
      function setOverlayMapTypeId() {
        var chkTerrain = document.getElementById("chkTerrain"),
          chkTraffic = document.getElementById("chkTraffic"),
          chkBicycle = document.getElementById("chkBicycle"),
          chkUseDistrict = document.getElementById("chkUseDistrict");

        // 지도 타입을 제거합니다
        for (var type in mapTypes) {
          map.removeOverlayMapTypeId(mapTypes[type]);
        }

        // 지적편집도정보 체크박스가 체크되어있으면 지도에 지적편집도정보 지도타입을 추가합니다

        // 지형정보 체크박스가 체크되어있으면 지도에 지형정보 지도타입을 추가합니다
        if (chkTerrain.checked) {
          map.addOverlayMapTypeId(mapTypes.terrain);
        }

        // 교통정보 체크박스가 체크되어있으면 지도에 교통정보 지도타입을 추가합니다
        if (chkTraffic.checked) {
          map.addOverlayMapTypeId(mapTypes.traffic);
        }

        // 자전거도로정보 체크박스가 체크되어있으면 지도에 자전거도로정보 지도타입을 추가합니다
        if (chkBicycle.checked) {
          map.addOverlayMapTypeId(mapTypes.bicycle);
        }
      }

      var currentMarker; // 전역 변수로 현재 마커를 저장하기 위한 변수

      function locationLoadSuccess(pos) {
        // 현재 위치 받아오기
        var currentPos = new kakao.maps.LatLng(
          pos.coords.latitude,
          pos.coords.longitude
        );

        // 지도 이동(기존 위치와 가깝다면 부드럽게 이동)
        map.panTo(currentPos);

        // 기존에 마커가 있다면 삭제
        if (currentMarker) {
          currentMarker.setMap(null);
          currentMarker = null; // 변수 초기화
        } else {
          // 마커 생성
          currentMarker = new kakao.maps.Marker({
            position: currentPos,
            map: map,
          });
        }
      }

      function locationLoadError(error) {
        var errorMessage;
        switch (error.code) {
          case error.PERMISSION_DENIED:
            errorMessage = "사용자가 위치 정보 제공에 동의하지 않았습니다.";
            break;
          case error.POSITION_UNAVAILABLE:
            errorMessage = "위치 정보를 사용할 수 없습니다.";
            break;
          case error.TIMEOUT:
            errorMessage = "위치 정보를 가져오는데 시간이 초과되었습니다.";
            break;
          case error.UNKNOWN_ERROR:
            errorMessage = "알 수 없는 오류가 발생했습니다.";
            break;
        }
        alert(errorMessage);
      }

      function getCurrentPosBtn() {
        if (navigator.geolocation) {
          var options = {
            enableHighAccuracy: true, // 더 정확한 위치 요청
            timeout: 5000, // 최대 응답 시간 (밀리초)
            maximumAge: 0, // 캐시된 위치 정보 사용하지 않음
          };

          navigator.geolocation.getCurrentPosition(
            locationLoadSuccess,
            locationLoadError,
            options
          );
        } else {
          alert("브라우저가 위치 정보를 지원하지 않습니다.");
        }
      }
    </script>
    <footer style="height: 180px; margin-top: 20px">
      <jsp:include page="/WEB-INF/views/footer.jsp" />
    </footer>
  </body>
</html>
