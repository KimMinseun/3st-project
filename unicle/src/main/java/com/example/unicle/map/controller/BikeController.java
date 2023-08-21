package com.example.unicle.map.controller;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@CrossOrigin("*")
@RestController
public class BikeController {

    // 따릉이 전체list 호출 a2e23a409ec3bcbfc463fc649f92efb9
    @RequestMapping("/bike")
    public String getBikeList() {
        int pageSize = 1000; // 한 페이지당 가져올 데이터 개수
        JSONArray combinedData = new JSONArray();

        for (int i = 1; i <= 3; i++) {
            int pageNumber = (i - 1) * pageSize + 1;
            String apiUrl = "http://openapi.seoul.go.kr:8088/466a674b42646e7239364743537945/json/bikeList/" + pageNumber
                    + "/" + (pageNumber + pageSize - 1);

            RestTemplate restTemplate = new RestTemplate();
            String response = restTemplate.getForObject(apiUrl, String.class);

            // API 응답 데이터를 파싱하여 필요한 정보를 추출하고 데이터를 합침
            JSONArray dataArray = parseApiResponse(response);
            combinedData = combineArrays(combinedData, dataArray);
        }

        // 필요한 정보를 담은 JSON 객체 생성
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("list_total_count", combinedData.length());
        jsonObject.put("row", combinedData);

        return jsonObject.toString();
    }

    private JSONArray parseApiResponse(String response) {
        JSONObject apiResponse = new JSONObject(response);
        JSONObject jsonBikeList = apiResponse.getJSONObject("rentBikeStatus");
        return jsonBikeList.getJSONArray("row");
    }

    private JSONArray combineArrays(JSONArray array1, JSONArray array2) {
        for (int i = 0; i < array2.length(); i++) {
            array1.put(array2.getJSONObject(i));
        }
        return array1;
    }

    @RequestMapping("/store")
    public String getStoreList() {
        int numOfRows = 1000; // 한 페이지당 가져올 데이터 개수
        JSONArray combinedData = new JSONArray();

        for (int i = 1; i <= 3; i++) {
            int pageNo = (i - 1) * numOfRows + 1;

            String apiUrl = "http://www.safemap.go.kr/openApiService/data/getConvenienceStoreData.do?serviceKey=D1MI9V3S-D1MI-D1MI-D1MI-D1MI9V3SJ6"
                    + "&pageNo=" + pageNo + "&numOfRows=" + numOfRows + "&type=json";

            RestTemplate restTemplate = new RestTemplate();
            String response = restTemplate.getForObject(apiUrl, String.class);

            JSONArray dataArray = parseApiResponse(response);
            combinedData = combineArrays(combinedData, dataArray);
        }

        // 필요한 정보를 담은 JSON 객체 생성
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("items", combinedData.length());
        jsonObject.put("item", combinedData);

        return jsonObject.toString();
    }
}
