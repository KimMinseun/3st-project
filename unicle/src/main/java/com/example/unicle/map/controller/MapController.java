package com.example.unicle.map.controller;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class MapController {

    @GetMapping("/information")
    public String getInformationList() {
        int pageSize = 1000; // 한 페이지당 가져올 데이터 개수
        JSONArray combinedData = new JSONArray();

        for (int i = 1; i <= 3; i++) {
            int pageNumber = (i - 1) * pageSize + 1;
            String apiUrl = "http://openapi.seoul.go.kr:8088/724861594d646e723530446a745577/xml/tvBicycleEtc" + pageNumber
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
        JSONObject jsonInformationList = apiResponse.getJSONObject("tvBicycleEtc");
        return jsonInformationList.getJSONArray("row");
    }

    private JSONArray combineArrays(JSONArray array1, JSONArray array2) {
        if (array1 == null) {
            array1 = new JSONArray();
        }
        if (array2 != null) {
            for (int i = 0; i < array2.length(); i++) {
                array1.put(array2.getJSONObject(i));
            }
        }
        return array1;
    }
}
