package com.example.unicle.map.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor   //파라미터가 없는 생성자 
@AllArgsConstructor 

@Getter     //getter 메소드
@Setter  
public class JongjuDTO {
	
	  private int jongjuid;
	  private String jongjuname;
	  private String jongjusec;          
	  private String jongjuAddress; 
	  private double Latitude;
	  private double Longitude;

}
