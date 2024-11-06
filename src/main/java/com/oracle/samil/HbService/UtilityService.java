package com.oracle.samil.HbService;

import java.util.List;

import com.oracle.samil.Amodel.Utility;

public interface UtilityService {

	List<Utility>     getUtilityData();
	Utility     	  UilityPlus(Utility utility);
	boolean 		  existsByYyyymmAndDetail(int utilityYyyymm, int utilityDetail);



}
