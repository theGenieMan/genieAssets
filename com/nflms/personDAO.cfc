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

	<cffunction name="read" output="false" access="public" returntype="genieObj.nfmls.person">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">

		<cfquery name="qRead" datasource="wmercia">
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
    
    <cffunction name="doWestMerciaFirearmsSearch" output="false" access="public" returntype="query">
		<cfargument name="searchTerms" required="true">
      
        <cfset var qResults="">
		<cfset var forename1Order="">
		<cfset var isYearDOBPart=false>
		<cfset var year1Text="">
		<cfset var year2Text="">		
		<cfset var qNamex="">
		<cfset var namexSurnames1="">
		<cfset var namexSurnames2="">		
		<cfset var namexForenames1="">
		<cfset var namexForenames2="">		
		
		<cfif (Len(arguments.searchTerms.P_SURNAME_1) IS 0 OR (arguments.searchTerms.P_SURNAME_1 IS "%" OR arguments.searchTerms.P_SURNAME_1 IS "_")) AND Len(arguments.searchTerms.P_SURNAME_2) GT 0>
		  <cfset arguments.searchTerms.P_SURNAME_1=arguments.searchTerms.P_SURNAME_2>
		  <cfset arguments.searchTerms.P_SURNAME_2="">
		</cfif>
		
		<cfif Len(arguments.searchTerms.P_SURNAME_1) GT 0>
		  <cfquery name="qNamex" datasource="#variables.warehouseDSN#">
			SELECT replace(UPPER(match_name),chr(39),chr(39)||chr(39)) as the_name
	        from namex_owner.namex_surname 
	        WHERE surname = LOWER('#arguments.searchTerms.P_SURNAME_1#') 
	        UNION  
	        SELECT replace(UPPER('#arguments.searchTerms.P_SURNAME_1#'),chr(39),chr(39)||chr(39)) as the_name
	        FROM dual		  
		  </cfquery>
		  <cfset namexSurnames1=QuotedValueList(qNamex.the_name,",")>
		</cfif>
		
		<cfif Len(arguments.searchTerms.P_SURNAME_2) GT 0>
		  <cfquery name="qNamex" datasource="#variables.warehouseDSN#">
			SELECT replace(UPPER(match_name),chr(39),chr(39)||chr(39)) as the_name
	        from namex_owner.namex_surname 
	        WHERE surname = LOWER('#arguments.searchTerms.P_SURNAME_2#') 
	        UNION  
	        SELECT replace(UPPER('#arguments.searchTerms.P_SURNAME_2#'),chr(39),chr(39)||chr(39)) as the_name
	        FROM dual		  
		  </cfquery>
		  <cfset namexSurnames2=QuotedValueList(qNamex.the_name,",")>
		</cfif>		
		
		<cfif (Len(arguments.searchTerms.P_FORENAME_1) IS 0 OR (arguments.searchTerms.P_FORENAME_1 IS "%" OR arguments.searchTerms.P_FORENAME_1 IS "_")) AND Len(arguments.searchTerms.P_FORENAME_2) GT 0>
		  <cfset arguments.searchTerms.P_FORENAME_1=arguments.searchTerms.P_FORENAME_2>
		  <cfset arguments.searchTerms.P_FORENAME_2="">
		</cfif>				
		
		<cfif Len(arguments.searchTerms.P_FORENAME_1) GT 0>
		  <cfquery name="qNamex" datasource="#variables.warehouseDSN#">
			SELECT replace(UPPER(match_name),chr(39),chr(39)||chr(39)) as the_name
	        from namex_owner.namex_forename 
	        WHERE forename = LOWER('#arguments.searchTerms.P_FORENAME_1#') 
	        UNION  
	        SELECT replace(UPPER('#arguments.searchTerms.P_FORENAME_1#'),chr(39),chr(39)||chr(39)) as the_name
	        FROM dual		  
		  </cfquery>
		  <cfset namexForenames1=QuotedValueList(qNamex.the_name,",")>
		</cfif>			
		
		<cfif Len(arguments.searchTerms.P_FORENAME_2) GT 0>
		  <cfquery name="qNamex" datasource="#variables.warehouseDSN#">
			SELECT replace(UPPER(match_name),chr(39),chr(39)||chr(39)) as the_name
	        from namex_owner.namex_forename 
	        WHERE forename = LOWER('#arguments.searchTerms.P_FORENAME_2#') 
	        UNION  
	        SELECT replace(UPPER('#arguments.searchTerms.P_FORENAME_2#'),chr(39),chr(39)||chr(39)) as the_name
	        FROM dual		  
		  </cfquery>
		  <cfset namexForenames2=QuotedValueList(qNamex.the_name,",")>
		</cfif>			
		
		<cftry>
    	<cfquery name="qResults" datasource="#variables.warehouseDSN#" result="qMyRes">
		 		 SELECT p.*
			 FROM   browser_owner.NFLMS_PERSON p
			 WHERE  (1=1)
			 <cfif Len(arguments.searchTerms.P_PNC) GT 0>
				<cfif Len(ListGetAt(arguments.searchTerms.P_PNC,1,"/")) IS 4>
 			     <cfset arguments.searchTerms.P_PNC=Right(arguments.searchTerms.P_PNC,Len(arguments.searchTerms.P_PNC)-2)>
			    </cfif>			 
			   AND PNCID='#arguments.searchTerms.P_PNC#'
			 <cfelse>
		  	  <cfif arguments.searchTerms.P_FUZZY IS "Y">
				 <cfif Len(arguments.searchTerms.P_SURNAME_1) GT 0>
				     AND (
				              SURNAME1   LIKE '#arguments.searchTerms.P_SURNAME_1#'	 
						  OR  SURNAME2   LIKE '#arguments.searchTerms.P_SURNAME_1#'
						  OR  FORENAME1  LIKE '#arguments.searchTerms.P_SURNAME_1#'
						  OR  FORENAME2  LIKE '#arguments.searchTerms.P_SURNAME_1#'
						  OR  FORENAME3  LIKE '#arguments.searchTerms.P_SURNAME_1#'
						  OR  FORENAME4  LIKE '#arguments.searchTerms.P_SURNAME_1#'	  
				          )
				 </cfif>
				
				 <cfif Len(arguments.searchTerms.P_SURNAME_2) GT 0>
				     AND (
				              SURNAME1   LIKE '#arguments.searchTerms.P_SURNAME_2#'	 
						  OR  SURNAME2   LIKE '#arguments.searchTerms.P_SURNAME_2#'
						  OR  FORENAME1  LIKE '#arguments.searchTerms.P_SURNAME_2#'
						  OR  FORENAME2  LIKE '#arguments.searchTerms.P_SURNAME_2#'
						  OR  FORENAME3  LIKE '#arguments.searchTerms.P_SURNAME_2#'
						  OR  FORENAME4  LIKE '#arguments.searchTerms.P_SURNAME_2#'	  
				          )
				 </cfif>
				
				 <cfif Len(arguments.searchTerms.P_FORENAME_1) GT 0>
				     AND (
				              SURNAME1   LIKE '#arguments.searchTerms.P_FORENAME_1#'	 
						  OR  SURNAME2   LIKE '#arguments.searchTerms.P_FORENAME_1#'
						  OR  FORENAME1  LIKE '#arguments.searchTerms.P_FORENAME_1#'
						  OR  FORENAME2  LIKE '#arguments.searchTerms.P_FORENAME_1#'
						  OR  FORENAME3  LIKE '#arguments.searchTerms.P_FORENAME_1#'
						  OR  FORENAME4  LIKE '#arguments.searchTerms.P_FORENAME_1#'	  
				          )
				 </cfif>
				
				 <cfif Len(arguments.searchTerms.P_FORENAME_2) GT 0>
				     AND (
				              SURNAME1   LIKE '#arguments.searchTerms.P_FORENAME_2#'	 
						  OR  SURNAME2   LIKE '#arguments.searchTerms.P_FORENAME_2#'
						  OR  FORENAME1  LIKE '#arguments.searchTerms.P_FORENAME_2#'
						  OR  FORENAME2  LIKE '#arguments.searchTerms.P_FORENAME_2#'
						  OR  FORENAME3  LIKE '#arguments.searchTerms.P_FORENAME_2#'
						  OR  FORENAME4  LIKE '#arguments.searchTerms.P_FORENAME_2#'	  
				          )
				 </cfif>
				
				<cfelse>
				
				 <cfif Len(arguments.searchTerms.P_SURNAME_1) GT 0>
				     AND (
				              SURNAME1 IN (#PreserveSingleQuotes(namexSurnames1)#)					  
				          OR  SURNAME2 IN (#PreserveSingleQuotes(namexSurnames1)#)					  				  
				     )
				 </cfif>
				
				 <cfif Len(arguments.searchTerms.P_SURNAME_2) GT 0>
				     AND (
				              SURNAME1 IN (#PreserveSingleQuotes(namexSurnames2)#)					  
						  OR  SURNAME2 IN (#PreserveSingleQuotes(namexSurnames2)#)					  				  
				         )
				 </cfif>
				
				 <cfif Len(arguments.searchTerms.P_FORENAME_1) GT 0>
				     AND (
				              FORENAME1	IN (#PreserveSingleQuotes(namexForenames1)#)					  				  
					 	  OR  FORENAME2 IN (#PreserveSingleQuotes(namexForenames1)#)	
						  OR  FORENAME3 IN (#PreserveSingleQuotes(namexForenames1)#)					  				  
						  OR  FORENAME4 IN (#PreserveSingleQuotes(namexForenames1)#)					  					  
					         )
				 </cfif>
				
				 <cfif Len(arguments.searchTerms.P_FORENAME_2) GT 0>
				     AND (
				              FORENAME1	IN (#PreserveSingleQuotes(namexForenames2)#)					  				  
					 	  OR  FORENAME2 IN (#PreserveSingleQuotes(namexForenames2)#)	
						  OR  FORENAME3 IN (#PreserveSingleQuotes(namexForenames2)#)					  				  
						  OR  FORENAME4 IN (#PreserveSingleQuotes(namexForenames2)#)					  					  
					         )
				 </cfif>
				
				</cfif>  	          	                   
              </cfif>
	          <cfif Len(arguments.searchTerms.P_DOB) GT 0>
			      <cfif Len(arguments.searchTerms.P_EXACT) IS 0>
					  AND DOB BETWEEN add_months(TO_DATE('#arguments.searchTerms.P_DOB#','DD/MM/YYYY'),-60) AND add_months(TO_DATE('#arguments.searchTerms.P_DOB#','DD/MM/YYYY'),60)	             
				  <cfelse>
				      AND DOB = TO_DATE('#arguments.searchTerms.P_DOB#','DD/MM/YYYY')
				  </cfif>
			  <cfelse>
			     <cfif Len(arguments.searchTerms.P_DOB_PART) GT 0>
			      <cfif Len(arguments.searchTerms.P_EXACT) IS 0>
					  <cfif Left(arguments.searchTerms.P_DOB_PART,1) IS "%" AND Right(arguments.searchTerms.P_DOB_PART,1) IS NOT '%'>
						 <cfset yearDOBPart=Right(arguments.searchTerms.P_DOB_PART,Len(arguments.searchTerms.P_DOB_PART)-1)>
						 
						 <cfif isNumeric(yearDOBPart) AND (Len(yearDOBPart) IS 2 OR Len(yearDOBPart) IS 4)>
						     <cfset isYearDOBPart=true>
							 <cfif Len(yearDOBPart) IS 2>
								 <cfset yearDOBPart="19"&yearDOBPart>
							 </cfif>
							 <cfset year1Text="01/01/"&yearDOBPart-5>
							 <cfset year2Text="31/12/"&yearDOBPart+5>					 
						 </cfif>
					  </cfif>				  
					  <cfif not isYearDOBPart>
					  AND TO_CHAR(DOB,'DD/MON/YYYY') LIKE '#arguments.searchTerms.P_DOB_PART#'
					  <cfelse>
					  AND DOB BETWEEN TO_DATE('#year1Text#','DD/MM/YYYY') AND TO_DATE('#year2Text#','DD/MM/YYYY')
					  </cfif>
				  <cfelse>
     				  AND TO_CHAR(DOB,'DD/MON/YYYY') LIKE '#arguments.searchTerms.P_DOB_PART#'				  
				  </cfif>
				 </cfif>
			  </cfif>			
			  ORDER BY 
			  decode(SURNAME1, '#arguments.searchTerms.P_SURNAME_1#', 0, 1),
			  decode(FORENAME1, '#arguments.searchTerms.P_FORENAME_1#', 0, 1),
			  SURNAME1, FORENAME1, DOB			    			  		  
		</cfquery>
		 <cfcatch type="database">
		 	 <cfoutput>
		 	 <cfmail to="nick.blackham@westmercia.pnn.police.uk" from="genie@westmercia.pnn.police.uk" subject="firearms error" type="html">
			  Firearms error<br><br>
			  #cfcatch.message#<br>
			  #cfcatch.detail#<br>
			  #cfcatch.sql#<br>
			  #cfcatch.queryError#<br>
			  <br><br>
			  Arguments Search Terms:
				<cfloop collection="#searchTerms#" item="sTerm">			 
			     #sTerm# = #searchTerms[sTerm]#<Br>			
			    </cfloop>			     	  
			 </cfmail>
			 </cfoutput>
		 </cfcatch> 			
		</cftry>			
        <cfreturn qResults>
    
    </cffunction>

    <cffunction name="isLicenceHolder" output="false" access="public" returntype="any" hint="returns nflms person based on PNCID">
		<cfargument name="pncId" type="string" required="true"> 
		
		<cfset var qHasLic="">
		
		<cfif Len(arguments.pncId) GT 0>
			<cfif Len(ListGetAt(arguments.pncId,1,"/")) IS 4>
			 <cfset arguments.pncId=Right(arguments.pncId,Len(arguments.pncId)-2)>
			</cfif>
			
	    	<cfquery name="qHasLic" datasource="#variables.warehouseDSN#">
		     SELECT *
		     FROM   browser_owner.NFLMS_PERSON np
		     WHERE  PNCID=<cfqueryparam value="#arguments.pncId#">
		    </cfquery>
		</cfif>
	    
	    <cfreturn qHasLic>
		
	</cffunction>

    <cffunction name="doWestMerciaFirearmsTelephoneSearch" output="false" access="public" returntype="query">
      <cfargument name="telephoneNumber" required="true" type="string" hint="telephone number to search on">
      
      <cfset var qSearch="">
      
      <cfquery name="qSearch" datasource="#variables.warehouseDSN#">
        SELECT p.*
        FROM   browser_owner.NFLMS_PERSON p, browser_owner.NFLMS_ADDRESS a
        WHERE  p.PERSON_URN=a.PERSON_URN
        AND    (
                  REPLACE(p.MOBILE_TEL,' ','')
                  <cfif Find("%",arguments.telephoneNumber) OR Find("_",arguments.telephoneNumber)>
                  LIKE
                  <cfelse>
                  =
                  </cfif>
                  <cfqueryparam value="#arguments.telephoneNumber#" cfsqltype="cf_sql_varchar">
                  OR
                  REPLACE(REPLACE(REPLACE(a.TEL_NO,' ',''),'(',''),')','')
                  <cfif Find("%",arguments.telephoneNumber) OR Find("_",arguments.telephoneNumber)>
                  LIKE
                  <cfelse>
                  =
                  </cfif>
                  <cfqueryparam value="#arguments.telephoneNumber#" cfsqltype="cf_sql_varchar">                  
                )
      </cfquery>
      
      <cfreturn qSearch>
    
    </cffunction>

    <cffunction name="doSerialCertifSearch" output="false" access="public" returntype="query">
      <cfargument name="serialNo" required="true" type="string" hint="serial no to search on">
	  <cfargument name="certifNo" required="true" type="string" hint="certif no to search on">
      
      <cfset var qSearch="">
      
      <cfquery name="qSearch" datasource="#variables.warehouseDSN#">
		 SELECT p.*, w.*, c.*
		 FROM   browser_owner.NFLMS_PERSON p, browser_owner.NFLMS_CERTIFICATE c, browser_owner.NFLMS_WEAPON w
		 WHERE p.PERSON_URN=c.PERSON_URN
		 AND     c.CERT_NO=w.CERT_NO
	  	  <cfif Len(serialNo) GT 0>
		   AND  w.SERIAL_NO
		  <cfif Find("%",serialNo) OR Find("_",serialNo)>
		    LIKE 
			 <cfelse>
			 = 
			 </cfif>
		  '#serialNo#' 
		  </cfif> 	 
	  	  <cfif Len(certifNo) GT 0>
		   AND  c.CERT_NO
		  <cfif Find("%",certifNo) OR Find("_",certifNo)>
		    LIKE 
			 <cfelse>
			 = 
			 </cfif>
		  '#certifNo#' 
		  </cfif> 	 	
		  ORDER BY SURNAME, FORENAMES, DOB
      </cfquery>
      
      <cfreturn qSearch>
    
    </cffunction>

</cfcomponent>