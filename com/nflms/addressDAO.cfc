<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">               
        <cfargument name="nflmsImageDir" required="true" type="String">                
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>
        <cfset variables.nflmsImageDir=arguments.nflmsImageDir>
           
        <cfreturn this />  
    </cffunction> 

	<cffunction name="read" output="false" access="public" returntype="genieObj.nfmls.address">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	PERSON_URN, FORENAMES, SURNAME, ORG_NAME, DOB, PNCID, 
					HEIGHT, MOBILE_TEL
			from BROWSER_OWNER.NFLMS_PERSON
			where PERSON_URN = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.id#" />
		</cfquery>

		<cfscript>
			obj = createObject("component", "genieObj.nfmls.person").init();
			obj.setPERSON_URN(qRead.PERSON_URN);
			obj.setFORENAMES(qRead.FORENAMES);
			obj.setSURNAME(qRead.SURNAME);
			obj.setORG_NAME(qRead.ORG_NAME);
			obj.setDOB(qRead.DOB);
			obj.setPNCID(qRead.PNCID);
			obj.setHEIGHT(qRead.HEIGHT);
			obj.setMOBILE_TEL(qRead.MOBILE_TEL);
			return obj;
		</cfscript>
	</cffunction>
    
    <cffunction name="doWestMerciaFirearmsAddressSearch" output="false" access="public" returntype="struct">
		<cfargument name="searchTerms" required="true">
        <cfargument name="searchType" required="false" default="firearmsEnquiry">
      
        <cfset var qResults="">
        <cfset var qPeople="">
        <cfset var resultStruct=StructNew()>
        <cfset var noandstreet="">
		<cfset var buildingName="">		
		<cfset var street="">
        <cfset var district="">		
        <cfset var town="">
        <cfset var county="">		
        <cfset var postcode="">              
        <cfset var lisPersonURNV7="">  
        
        <cfif arguments.searchType IS "addressEnquiry">
          <cfset noandstreet="%"&searchTerms.BUILDING_NAME&"%"&searchTerms.PART_ID&"%"&searchTerms.BUILDING_NUMBER&"%"&searchTerms.STREET_1&"%">
		  <cfset buildingName=searchTerms.BUILDING_NAME>		
		  <cfset street=searchTerms.STREET_1>
		  <cfif Left(street,1) IS NOT "%">
			  <cfset street='%'&street>
		  </cfif>
          <cfset town=searchTerms.TOWN>
		  <cfset district=searchTerms.LOCALITY>
		  <cfset county=searchTerms.COUNTY>		  
          <cfset postcode=Replace(searchTerms.POST_CODE,' ','','ALL')>
        </cfif>
      
    	 <cfquery name="qResults" datasource="#variables.warehouseDSN#">
			 SELECT * FROM (
					 SELECT     DECODE(LINE_1,'','',LINE_1||', ')||
								DECODE(LINE_2,'','',LINE_2||', ')||
								DECODE(LINE_3,'','',LINE_3||', ')||
								DECODE(LINE_4,'','',LINE_4||', ')||
								DECODE(LINE_5,'','',LINE_5||', ')||
								DECODE(POSTCODE,'','',POSTCODE) Address,
								a.*
					 FROM   browser_owner.NFLMS_ADDRESS a, browser_owner.NFLMS_PERSON p
					 WHERE  (1=1)
					 AND  a.PERSON_URN=p.PERSON_URN(+)
					 AND (
				  	  <cfif Len(noandstreet) GT 0>
					     (   UPPER(LINE_1)  LIKE '#noandstreet#' 
					         OR UPPER(LINE_2)  LIKE '#noandstreet#' )
					  </cfif> 
				  	  <cfif Len(buildingName) GT 0>
					   OR  (   UPPER(LINE_1)  LIKE '#buildingName#' 
					         OR UPPER(LINE_2)  LIKE '#buildingName#' )
					  </cfif> 					  
					     )
				  	  <cfif Len(street) GT 0>
					   AND ((UPPER(LINE_1)
					  <cfif Find("%",street) OR Find("_",street)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#street#' 
				      )
					   OR
					    (UPPER(LINE_2)
					  <cfif Find("%",street) OR Find("_",street)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#street#' 
				      ) OR (UPPER(LINE_3)
					  <cfif Find("%",street) OR Find("_",street)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#street#' 
				      ) OR (UPPER(LINE_4)
					  <cfif Find("%",street) OR Find("_",street)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#street#' 
					  ) 
                      )
					  </cfif>					  
				  	  <cfif Len(town) GT 0>
					   AND ( (UPPER(LINE_2)
					  <cfif Find("%",town) OR Find("_",town)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#town#' 
				      ) OR (UPPER(LINE_3)
					  <cfif Find("%",town) OR Find("_",town)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#town#' 
				      ) OR (UPPER(LINE_4)
					  <cfif Find("%",town) OR Find("_",town)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#town#' 
					  ) 
                      )
					  </cfif>
				  	  <cfif Len(district) GT 0>
					   AND ( (UPPER(LINE_2)
					  <cfif Find("%",district) OR Find("_",district)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#district#' 
				      ) OR (UPPER(LINE_3)
					  <cfif Find("%",district) OR Find("_",district)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#district#' 
				      ) OR (UPPER(LINE_4)
					  <cfif Find("%",district) OR Find("_",district)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#district#' 
					  ) 
                      )
					  </cfif>	
				  	  <cfif Len(county) GT 0>
					   AND ( (UPPER(LINE_2)
					  <cfif Find("%",county) OR Find("_",county)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#county#' 
				      ) OR (UPPER(LINE_3)
					  <cfif Find("%",county) OR Find("_",county)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#county#' 
				      ) OR (UPPER(LINE_4)
					  <cfif Find("%",county) OR Find("_",county)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#county#' 
					  ) OR (UPPER(LINE_5)
					  <cfif Find("%",county) OR Find("_",county)>
					    LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#county#' 					  
					  ) 
                      )
					  </cfif>					  				  
				      <cfif Len(postcode) GT 0>
					  AND  REPLACE(POSTCODE,' ','')
					  <cfif Find("%",postcode) OR Find("_",postcode)>
						 LIKE 
						 <cfelse>
						 = 
						 </cfif>
					  '#postcode#' 
					  </cfif>   
					  ORDER BY LINE_1, POSTCODE
					)
	        WHERE ROWNUM < 202
	     </cfquery>
                        
     <cfset returnStruct.qAddress=qResults>                        
	                    
	 <cfloop query="qResults" startrow="1" endrow="200">
	  <cfset lisPersonURNV7=ListAppend(lisPersonURNV7,"'"&PERSON_URN&"'",",")>	  
	 </cfloop>
	 
	 <cfif qResults.RecordCount GT 0>
	 
	     <cfquery name="qPeople" datasource="#variables.WarehouseDSN#">
		   SELECT p.*
		   FROM   browser_owner.NFLMS_PERSON p		 
		   WHERE  PERSON_URN IN (#PreserveSingleQuotes(lisPersonURNV7)#)
		  </cfquery>
	  
          <cfset returnStruct.qPeople=qPeople>
            
	  </cfif>                        
                                                   
      <cfreturn returnStruct>
    
    </cffunction>

</cfcomponent>