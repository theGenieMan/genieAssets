<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
      
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>          
           
        <cfreturn this />  
    </cffunction> 
    
    <cffunction name="doWestMerciaPropertyVehicleSearch" output="false" access="public" returntype="query">
      <cfargument name="searchTerms" type="struct" required="true" hint="structure of search terms for address query">
      
      <cfset var qSearchResults="">
      <cfset var searchItem="">
      <cfset var searchKey="">
      
		  <cfquery name="qSearchResults" datasource="#variables.WarehouseDSN#">
		    select PD.VRM, pd.OFF_ORG_CODE||'/'||pd.OFF_SERIAL_NO||'/'||DECODE(LENGTH(pd.OFF_YEAR),1, '0' || pd.OFF_YEAR, pd.OFF_YEAR) AS CRIME_NO,
		           pd.CRIME_REF, TO_CHAR(pd.OFF_CREATED_DATE,'YYYY') AS REC_YEAR,
		 		   TO_CHAR(pd.OFF_CREATED_DATE,'MM') AS REC_MON, TO_CHAR(pd.OFF_CREATED_DATE,'DD') AS REC_DAY,
			       USAGE AS VEH_USAGE, TO_CHAR(DATE_USED,'DD/MM/YYYY') AS DATE_USED, MANUFACTURER, MODEL,
			       CRIME_FIRST_DATE,CRIME_LAST_DATE
			from   browser_owner.ge_property pd, browser_owner.ge_property_usage pu
			where pd.property_ref=pu.property_Ref(+)
                 <cfloop collection="#arguments.searchTerms#" item="searchKey">
	                <cfset searchItem=StructFind(arguments.searchTerms,PreserveSingleQuotes(searchKey))>
                    <!--- VRM can be an Array of VRMS to search, if we can an array then loop through it to get the
                          different VRMS in the query --->
                    <cfif PreserveSingleQuotes(searchKey) IS "VRM" and isArray(searchItem)>
                    AND ( 
					 <cfset iVrm=1>
					 <cfloop from="1" to="#ArrayLen(searchItem)#" index="iVrm">
					  <cfif iVrm IS 1>
						 VRM
						<cfelse>
						 OR VRM 
						</cfif>
						 <cfif Find("%",searchItem[iVrm]) OR Find("_",searchItem[iVrm])>LIKE<cfelse>=</cfif>
						 '#searchItem[iVrm]#'
					 </cfloop>
					 	)
                    <cfelse>                                                                                                         
		                <cfif Len(searchItem) GT 0>
		                 <cfif searchKey IS 'VRM' OR searchKey IS 'MODEL' OR searchKey IS 'MANUFACTURER'>
			                AND #PreserveSingleQuotes(searchKey)#
			                 <cfif Find("%",searchItem) OR Find("_",searchItem)>
			                  LIKE
			                 <cfelse>
			                  =
			                 </cfif>
			                 <cfqueryparam value="#searchItem#" cfsqltype="cf_sql_varchar">
		                 </cfif>
		                </cfif>
                    </cfif>
	             </cfloop> 
		  </cfquery> 
                
       <cfreturn qSearchResults>      
     
    </cffunction>    

	<cffunction name="doPropertyEnquiry" output="false" access="public" returntype="query" hint="function the performs property enquiry search">
      <cfargument name="searchTerms" type="struct" required="true" hint="structure of search terms for property query">
      
      <cfset var qSearchResults="">
      <cfset var searchItem="">
      <cfset var searchKey="">
        
		  <cfquery name="qSearchResults" datasource="#variables.WarehouseDSN#">		  	  
			 SELECT * FROM (
			  SELECT gps.CATEGORY, GPS.SUB_CATEGORY,gps.SUB_TYPE,gps.MODEl,gps.MANUFACTURER,
			         gps.VRM,gps.NOTES,gpu.USAGE,gpu.DATE_USED,gpu.QUANTITY,gpu.UNIT,
					 gps.CARD_NUMBER, gps.CHEQUE_NUMBERS, GPS.IDENTIFIABLE, GPS.CARD_EXPIRY, 
					 gps.OFF_ORG_CODE || '/' || gps.OFF_SERIAL_NO ||'/' || DECODE(LENGTH(gps.OFF_YEAR),1, '0' || gps.OFF_YEAR, gps.OFF_YEAR) Crime_Number,
			         gps.CRIME_REF, TO_CHAR(gps.OFF_CREATED_DATE,'YYYY') AS REC_YEAR,
					 TO_CHAR(gps.OFF_CREATED_DATE,'MM') AS REC_MON, TO_CHAR(gps.OFF_CREATED_DATE,'DD') AS REC_DAY,
					 gps.MAN_SERIAL_NUMBER, gps.FRAME_NUMBER, gps.CHASSIS_NUMBER, gps.ENGINE_NUMBER, gps.OTHER_MARKS,
					 gps.DOCUMENT_NUMBER, gps.BANK_SORT_CODE, gps.DOCUMENT_NAME, gpu.PROP_VALUE
			  FROM   browser_owner.GE_PROPERTY gps,
			         browser_owner.GE_PROPERTY_USAGE gpu
			  WHERE  (1=1)
			  AND    gps.PROPERTY_REF=gpu.PROPERTY_REF(+)
				<cfif Len(searchTerms.unique_id) GT 0>
				    AND (
					     gps.FRAME_NUMBER
							<cfif Find("%",searchTerms.unique_id) OR Find("_",searchTerms.unique_id)>
							LIKE 
							<cfelse>
							= 
							</cfif>
							'#searchTerms.unique_id#'	    
					    OR
					     gps.CHASSIS_NUMBER
							<cfif Find("%",searchTerms.unique_id) OR Find("_",searchTerms.unique_id)>
							LIKE 
							<cfelse>
							= 
							</cfif>
							'#searchTerms.unique_id#'	    
					    OR
					     gps.ENGINE_NUMBER
							<cfif Find("%",searchTerms.unique_id) OR Find("_",searchTerms.unique_id)>
							LIKE 
							<cfelse>
							= 
							</cfif>
							'#searchTerms.unique_id#'	    
					    OR
					     gps.MAN_SERIAL_NUMBER
							<cfif Find("%",searchTerms.unique_id) OR Find("_",searchTerms.unique_id)>
							LIKE 
							<cfelse>
							= 
							</cfif>
							'#searchTerms.unique_id#'	    			 	
					    OR
					     gps.DOCUMENT_NUMBER
							<cfif Find("%",searchTerms.unique_id) OR Find("_",searchTerms.unique_id)>
							LIKE 
							<cfelse>
							= 
							</cfif>
							'#searchTerms.unique_id#'	  		
					    OR
					     gps.DOCUMENT_NAME
							<cfif Find("%",searchTerms.unique_id) OR Find("_",searchTerms.unique_id)>
							LIKE 
							<cfelse>
							= 
							</cfif>
							'#searchTerms.unique_id#'									
					    OR
					     gps.CHEQUE_NUMBERS
							<cfif Find("%",searchTerms.unique_id) OR Find("_",searchTerms.unique_id)>
							LIKE 
							<cfelse>
							= 
							</cfif>
							'#searchTerms.unique_id#'	   					
					    )
				  </cfif>	
				<cfif Len(searchTerms.NOTES) GT 0>
				AND UPPER(gps.NOTES) LIKE <cfqueryparam value="#searchTerms.NOTES#" cfsqltype="cf_sql_varchar">	
				</cfif>  			
				<cfif Len(searchTerms.DATE_FROM1) GT 0 and Len(searchTerms.DATE_FROM2) IS 0>
                 	AND gps.CRIME_FIRST_DATE BETWEEN TO_DATE('#searchTerms.DATE_FROM1# 00:00:00','DD/MM/YYYY HH24:MI:SS')
											 AND     TO_DATE('#searchTerms.DATE_FROM1# 23:59:59','DD/MM/YYYY HH24:MI:SS')
                <cfelseif  Len(searchTerms.DATE_FROM1) GT 0 and Len(searchTerms.DATE_FROM2) GT 0>
                 AND ((gps.CRIME_FIRST_DATE <= TO_DATE('#searchTerms.DATE_FROM2#','DD/MM/YYYY') AND
		 			 gps.CRIME_LAST_DATE >= TO_DATE('#searchTerms.DATE_FROM1#','DD/MM/YYYY'))
				 OR (gps.CRIME_FIRST_DATE BETWEEN TO_DATE('#searchTerms.DATE_FROM1#','DD/MM/YYYY') AND TO_DATE('#searchTerms.DATE_FROM2#','DD/MM/YYYY')))
                </cfif>
                <cfloop collection="#arguments.searchTerms#" item="searchKey">
	                <cfset searchItem=StructFind(arguments.searchTerms,PreserveSingleQuotes(searchKey))>
					<cfif ListFindNoCase('UNIQUE_ID,DATE_FROM1,DATE_FROM2,NOTES',searchKey) IS 0>
		                <cfif Len(searchItem) GT 0>
		                AND #iif(searchKey IS "Usage", DE('gpu.'),de('gps.'))##PreserveSingleQuotes(searchKey)#
		                 <cfif Find("%",searchItem) OR Find("_",searchItem)>
		                  LIKE
		                 <cfelse>
		                  =
		                 </cfif>
		                 <cfqueryparam value="#searchItem#" cfsqltype="cf_sql_varchar">
		                </cfif>
					</cfif>
	             </cfloop> 
				ORDER BY gps.CRIME_REF DESC
			)
			WHERE ROWNUM < 202				  
		  </cfquery> 
                
       <cfreturn qSearchResults>      
     
    </cffunction>      

</cfcomponent>