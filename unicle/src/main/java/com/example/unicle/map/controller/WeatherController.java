package com.example.unicle.map.controller;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.xml.sax.InputSource; 
import org.w3c.dom.Document; 

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.TimeZone;

@RestController
public class WeatherController {
   

   //날씨 호출 코드
    @RequestMapping("/weather")
    public String getWeatherList() {
        String serviceKey = "YF5NT9aXhtTNKURlG0pChRmvqgG9m5CzMf8ZFY21b1p7ggLa3msyJXw+mq/EXwMojtP4JgrQ/nGU9OY6luSW5w==";
      
        Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("Asia/Seoul"));
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH00");
        String baseDate = dateFormat.format(cal.getTime());
        String baseTime = timeFormat.format(cal.getTime());

        // List of possible baseTime values
        String[] possibleBaseTimes = {"0200", "0500", "0800", "1100", "1400", "1700", "2000", "2300"};
        
        // Find the nearest baseTime from the list
        int currentHour = cal.get(Calendar.HOUR_OF_DAY);
        int nearestIndex = 0;
        int minTimeDiff = Integer.MAX_VALUE;
        for (int i = 0; i < possibleBaseTimes.length; i++) {
            int timeDiff = Math.abs(currentHour - Integer.parseInt(possibleBaseTimes[i].substring(0, 2)));
            if (timeDiff < minTimeDiff) {
                minTimeDiff = timeDiff;
                nearestIndex = i;
            }
        }
        
        baseTime = possibleBaseTimes[nearestIndex];
        
        System.out.println(baseDate);
        System.out.println(baseTime);
        
        
        
        int nx = 55;
        int ny = 127;
        
        int numOfRows = 1000;

        String apiUrl = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"
                + "?serviceKey=" + encode(serviceKey)
                + "&pageNo=1&numOfRows=" + numOfRows + "&dataType=XML"
                + "&base_date=" + encode(baseDate)
                + "&base_time=" + encode(baseTime)
                + "&nx=" + nx + "&ny=" + ny;

        try {
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            br.close();

            String response = sb.toString();
            System.out.println(response);

            JSONArray dataArray = parseApiResponse(response);

            if (dataArray.isEmpty()) {
                // 데이터를 가져오지 못한 경우 이전 시간대의 데이터를 가져올 수 있도록 baseTime을 조정
                int prevIndex = (nearestIndex - 1 + possibleBaseTimes.length) % possibleBaseTimes.length;
                baseTime = possibleBaseTimes[prevIndex];

                apiUrl = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"
                        + "?serviceKey=" + encode(serviceKey)
                        + "&pageNo=1&numOfRows=" + numOfRows + "&dataType=XML"
                        + "&base_date=" + encode(baseDate)
                        + "&base_time=" + encode(baseTime)
                        + "&nx=" + nx + "&ny=" + ny;

                // 데이터 불러오기 시도
                url = new URL(apiUrl);
                conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");

                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                sb = new StringBuilder();
                while ((line = br.readLine()) != null) {
                    sb.append(line);
                }
                br.close();

                response = sb.toString();
                System.out.println(response);

                dataArray = parseApiResponse(response);
            }          
            
            System.out.println(dataArray);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("items", dataArray.length());
            jsonObject.put("item", dataArray);
            
            System.out.println(jsonObject);

            return dataArray.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }

    // Method to encode URL components
    private String encode(String value) {
        try {
            return URLEncoder.encode(value, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return value;
    }

    // Method to parse API response and extract data
    private JSONArray parseApiResponse(String response) {
        JSONArray dataArray = new JSONArray();
        try {
            // XML 파싱을 위해 DocumentBuilder를 사용합니다.
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            InputSource is = new InputSource(new StringReader(response));
            Document doc = builder.parse(is);

            // XML에서 "item" 요소들을 NodeList로 가져옵니다.
            NodeList itemNodes = doc.getElementsByTagName("item");

            // 각 "item" 요소들을 순회하며 필요한 데이터를 JSONArray에 추가합니다.
            for (int i = 0; i < itemNodes.getLength(); i++) {
                Element itemElement = (Element) itemNodes.item(i);
                String baseDate = itemElement.getElementsByTagName("baseDate").item(0).getTextContent();
                String baseTime = itemElement.getElementsByTagName("baseTime").item(0).getTextContent();
                String category = itemElement.getElementsByTagName("category").item(0).getTextContent();
                String fcstDate = itemElement.getElementsByTagName("fcstDate").item(0).getTextContent();
                String fcstTime = itemElement.getElementsByTagName("fcstTime").item(0).getTextContent();
                String fcstValue = itemElement.getElementsByTagName("fcstValue").item(0).getTextContent();
                String nx = itemElement.getElementsByTagName("nx").item(0).getTextContent();
                String ny = itemElement.getElementsByTagName("ny").item(0).getTextContent();

                // 필요한 데이터를 JSONObject로 생성하고, JSONArray에 추가합니다.
                JSONObject itemObject = new JSONObject();
                itemObject.put("baseDate", baseDate);
                itemObject.put("baseTime", baseTime);
                itemObject.put("category", category);
                itemObject.put("fcstDate", fcstDate);
                itemObject.put("fcstTime", fcstTime);
                itemObject.put("fcstValue", fcstValue);
                itemObject.put("nx", nx);
                itemObject.put("ny", ny);

                dataArray.put(itemObject);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dataArray;
    }
}
