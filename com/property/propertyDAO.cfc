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

</cfcomponent>