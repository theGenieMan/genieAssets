<<<<<<< .mine
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

	<cffunction name="read" output="false" access="public" returntype="GE_WARNINGS">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN2#">
		select 	RISK_REF, NOMINAL_REF, DATE_MARKED, WSC_CODE, WSC_DESC, WS_NOTE, END_DATE, FS_CODE				
		from BROWSER_OWNER.GE_WARNINGS
		where RISK_REF = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#arguments.id#" />
	</cfquery>

	<cfscript>
		obj = createObject("component", "GE_WARNINGS").init();
		obj.setRISK_REF(qRead.RISK_REF);
		obj.setNOMINAL_REF(qRead.NOMINAL_REF);
		obj.setDATE_MARKED(qRead.DATE_MARKED);
		obj.setWSC_CODE(qRead.WSC_CODE);
		obj.setWSC_DESC(qRead.WSC_DESC);
		obj.setWS_NOTE(qRead.WS_NOTE);
		obj.setEND_DATE(qRead.END_DATE);
		obj.setFS_CODE(qRead.FS_CODE);				
		return obj;
	</cfscript>
</cffunction>
   
   <cffunction name="getNominalSearchWarnings" output="false" access="public" returntype="array" hint="returns an array of html formatted nominal warnings based on a query of nominals being passed in">
     <cfargument name="qNoms" required="true" type="query" hint="query containing a list of nominals with NOMINAL_REF column">
     
     <cfset var arrWarnings=ArrayNew(1)>
     <cfset var lisNominals="">
     <cfset var qWarnings="">
	 <cfset var warnStart="">
	 <cfset var warnEnd="">
	 <cfset var iRef="">
	 <cfset var thisNomRef="">
     <cfset var warnPos=""> 
	 <cfset var sNomWarnText="">
     
     <!--- create a list of nominal refs 
     <cfloop query="arguments.qNoms">
       <cfset lisNominals=ListAppend(lisNominals,NOMINAL_REF,",")>
     </cfloop>--->
     
     <cfset lisNominals=ValueList(arguments.qNoms.NOMINAL_REF)>
     
     <cfset warnStart=getTickCount()>
     <!--- query for all warnings on nominals in list --->
     <cfquery name="qWarnings" datasource="#variables.warehouseDSN#">
	 SELECT w.NOMINAL_REF, '<b>'||w.WSC_DESC||'</b>-'||TO_CHAR(w.DATE_MARKED,'DD/MM/YYYY') AS WARNING_TEXT, DATE_MARKED, END_DATE
	 FROM browser_owner.GE_WARNINGS w
	 WHERE NOMINAL_REF IN (<cfqueryparam value="#lisNominals#" cfsqltype="cf_sql_varchar" list="true">)	 
     AND   (END_DATE IS NULL OR (TRUNC(END_DATE) >= TRUNC(SYSDATE)))
     UNION
     SELECT ns.NOMINAL_REF, '<b>CURRENT MISSING PERSON</b>' AS WARNING_TEXT, TRUNC(SYSDATE) AS DATE_MARKED, TRUNC(SYSDATE) AS END_DATE     
     FROM browser_owner.nominal_search ns
     WHERE NOMINAL_REF IN (<cfqueryparam value="#lisNominals#" cfsqltype="cf_sql_varchar" list="true">)	 
     AND COMP_STATUS IN ('M','I')
	 ORDER BY 1,3 DESC      
     </cfquery>
     <cfset warnEnd=getTickCount()>
	 <cflog file="geniePersonWebService" type="information" text="Nom List = #lisNominals# ms" />
     <cflog file="geniePersonWebService" type="information" text="Warning DAO Query = #warnENd-warnStart# ms" />
	 
	 <cfset warnStart=getTickCount()> 
     <!--- loop round all nominals and get their warnings. if they have none then set their position in the array
           to a blank. If they do have warnings then concatenate their array entry with <br> to give a full
           html warning list 
     <cfset iNom=1>      
     <cfloop query="arguments.qNoms">
         
           <cfquery name="qNomWarning" dbtype="query">
        SELECT * 
        FROM   qWarnings
        WHERE  NOMINAL_REF=<cfqueryparam value="#NOMINAL_REF#" cfsqltype="cf_sql_varchar">
           </cfquery>
           
           <cfif qNomWarning.RecordCount GT 0>
             <!--- nominal has no warnings 
             <cfset arrWarnings[iNom]="">
           <cfelse>--->
             <!--- nominal has warnings --->
             <cfset iWarning=1>
             <cfloop query="qNomWarning">
              <cfif iWarning IS 1>
                  <cfset arrWarnings[iNom]=qNomWarning.WARNING_TEXT> 
              <cfelse>
                  <cfset arrWarnings[iNom]=arrWarnings[iNom]&"<br>"&qNomWarning.WARNING_TEXT>
              </cfif>
              <cfset iWarning=iWarning+1>
             </cfloop>
           </cfif>
           
           <cfset iNom=iNom+1>
           
     </cfloop>--->
     
      <cfset iRef=1>
	  <cfloop list="#lisNominals#" index="xxx" delimiters=",">
	 	 <cfset arrWarnings[iRef]="">
		 <cfset iRef++>
	  </cfloop>
	  <cfset thisNomRef="">
	  <cfset i=1>
	  <cfloop query="qWarnings">	  	  	  	 
	     <cfif thisNomRef IS NOT NOMINAL_REF>	 	 
			 <cfif thisNomRef IS NOT "">					 	  	 
				 <cfset warnPos=ListFind(lisNominals,thisNomRef,",")>
				 <cfset arrWarnings[warnPos]=sNomWarnText>				  
			 </cfif>
			 <cfset sNomWarnText=WARNING_TEXT>
			 <cfset thisNomRef=NOMINAL_REF>			  
		 <cfelse>
		 	 <cfset sNomWarnText &= "<br>" & WARNING_TEXT>			  	 
		 </cfif>
		<cfset i++>
	  </cfloop>	
	  
	  <cfset warnPos=ListFind(lisNominals,thisNomRef,",")>
	  <cfif warnPos GT 0>
	  <cfset arrWarnings[warnPos]=sNomWarnText>
	  </cfif>
     
     <cfset warnEnd=getTickCount()>
	  <cflog file="geniePersonWebService" type="information" text="Warning DAO Process List = #warnENd-warnStart# ms" />
          
     <cfreturn arrWarnings>
     
   </cffunction>
   
   <cffunction name="getNominalWarnings" output="false" access="public" returntype="array" hint="returns an array of nominal warnings">
     <cfargument name="nominalRef" required="true" type="string" hint="nominal ref to get warnings for">
     <cfargument name="includeExpired" required="no" type="string" default="N" hint="pass in Y to get all warnings default N">
     
     <cfset var qWarnings="">
	 <cfset var qOffRec="">
     <cfset var warnings=arrayNew(1)>
     <cfset var thisWarning="">
     
     <!--- create a list of nominal refs --->
     
     <!--- query for all warnings on nominals in list --->
     <cfquery name="qWarnings" datasource="#variables.warehouseDSN#">
	 SELECT w.NOMINAL_REF, w.WSC_DESC, TO_CHAR(w.DATE_MARKED,'DD/MM/YYYY') AS WARNING_DATE, WSC_CODE, 
	        DATE_MARKED, WS_NOTE, RISK_REF, TO_CHAR(END_DATE,'DD/MM/YYYY') AS END_DATE,
	        SUB_TYPE
	 FROM browser_owner.GE_WARNINGS w
	 WHERE NOMINAL_REF =<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">	
     <cfif arguments.includeExpired IS "N"> 
     AND   (END_DATE IS NULL OR (END_DATE > SYSDATE))
     </cfif>
	 ORDER BY DATE_MARKED DESC      
     </cfquery>


     <cfloop query="qWarnings">
       <cfset thisWarning=CreateObject("component","genieObj.nominal.warnings").init()>
       <cfset thisWarning.setRISK_REF(RISK_REF)>       
       <cfset thisWarning.setNOMINAL_REF(NOMINAL_REF)>
       <cfset thisWarning.setWSC_DESC(WSC_DESC)>
       <cfset thisWarning.setWSC_CODE(WSC_CODE)>
       <cfset thisWarning.setWS_NOTE(WS_NOTE)>
       <cfset thisWarning.setDATE_MARKED(WARNING_DATE)>
       <cfset thisWarning.setEND_DATE(END_DATE)>
	   <cfset thisWarning.setSUB_TYPE(SUB_TYPE)>       
       <cfset ArrayAppend(warnings,thisWarning)>                            
     </cfloop>
	
	 <!--- check if it is the official record of a nominal, ie, police officer or staff --->
	 <cfquery name="qOffRec" datasource="#variables.warehouseDSN#">
	  select 'Y'
      from browser_owner.nominal_details nd
      where nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
      and sub_type='O'
	 </cfquery>
	 
	 <cfif qOffRec.recordCount GT 0>
       <cfset thisWarning=CreateObject("component","genieObj.nominal.warnings").init()>
       <cfset thisWarning.setNOMINAL_REF(arguments.nominalRef)>
       <cfset thisWarning.setWSC_DESC('OFFICIAL RECORD')>
       <cfset ArrayAppend(warnings,thisWarning)>      	 
	 </cfif>
                
     <cfreturn warnings>
     
   </cffunction>    
   
   <cffunction name="getNominalIsPYO" output="false" access="public" returntype="boolean" hint="returns true or false is a nominal is a PYO or not">
     <cfargument name="nominalRef" required="true" type="string" hint="nominal ref to get warnings for">
     
     <cfset var qWarnings="">
     <cfset var pyo=false>
     
     <!--- create a list of nominal refs --->
     
     <!--- query for all warnings on nominals in list --->
     <cfquery name="qWarnings" datasource="#variables.warehouseDSN#">
	 SELECT 'Y'
	 FROM browser_owner.GE_WARNINGS w
	 WHERE NOMINAL_REF =<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">	 
     AND  WSC_CODE IN ('PY','DY')
     AND NOT EXISTS (SELECT 'Y' 
                     FROM browser_owner.ge_warnings w2
                     WHERE NOMINAL_REF =<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
                     AND  WSC_CODE=<cfqueryparam value="XY" cfsqltype="cf_sql_varchar"> )
     </cfquery>
     
     <cfif qWarnings.recordCount GT 0>
      <cfset pyo=true>
     </cfif>
                
     <cfreturn pyo>
     
   </cffunction>     

   <cffunction name="getNominalIsPPO" output="false" access="public" returntype="boolean" hint="returns true or false is a nominal is a PPO or not">
     <cfargument name="nominalRef" required="true" type="string" hint="nominal ref to get warnings for">
     
     <cfset var qWarnings="">
     <cfset var ppo=false>
     
     <!--- create a list of nominal refs --->
     
     <!--- query for all warnings on nominals in list --->
     <cfquery name="qWarnings" datasource="#variables.warehouseDSN#">
     SELECT 'Y'
     FROM browser_owner.GE_WARNINGS w
     WHERE NOMINAL_REF =<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">    
     AND  WSC_CODE IN ('PP')     
     AND  (DATE_MARKED <= TRUNC(SYSDATE) AND (END_DATE >= TRUNC(SYSDATE) OR END_DATE IS NULL))	 	 
     </cfquery>
     
     <cfif qWarnings.recordCount GT 0>
      <cfset ppo=true>
     </cfif>
                
     <cfreturn ppo>
     
   </cffunction> 

   <cffunction name="getNominalIsIOM" output="false" access="public" returntype="boolean" hint="returns true or false is a nominal is a IOM or not">
     <cfargument name="nominalRef" required="true" type="string" hint="nominal ref to get warnings for">
     
     <cfset var qWarnings="">
     <cfset var iom=false>
     
     <!--- create a list of nominal refs --->
     
     <!--- query for all warnings on nominals in list --->
     <cfquery name="qWarnings" datasource="#variables.warehouseDSN#">
     SELECT 'Y'
     FROM browser_owner.GE_WARNINGS w
     WHERE NOMINAL_REF =<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">    
     AND  WSC_CODE IN ('IO')     
     AND  (DATE_MARKED <= TRUNC(SYSDATE) AND (END_DATE >= TRUNC(SYSDATE) OR END_DATE IS NULL))	 	 
     </cfquery>
     
     <cfif qWarnings.recordCount GT 0>
      <cfset iom=true>
     </cfif>
                
     <cfreturn iom>
     
   </cffunction> 

   <cffunction name="getWarningLevel" output="false" access="public" returntype="string" hint="returns sub type for a given nominal and warning marker">
     <cfargument name="nominalRef" required="true" type="string" hint="nominal ref to get warnings for">
	 <cfargument name="wsc_code" required="true" type="string" hint="warning marker to get level for"> 
     
     <cfset var qWarningLevel="">
     <cfset var warningLevel="">
     
     <!--- query for all warnings on nominals in list --->
     <cfquery name="qWarningLevel" datasource="#variables.warehouseDSN#">
     SELECT SUB_TYPE
     FROM browser_owner.GE_WARNINGS w
     WHERE NOMINAL_REF =<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">    
     AND  WSC_CODE = <cfqueryparam value="#arguments.wsc_code#" cfsqltype="cf_sql_varchar">     
     AND  (DATE_MARKED <= TRUNC(SYSDATE) AND (END_DATE >= TRUNC(SYSDATE) OR END_DATE IS NULL))	 	 
     </cfquery>
     
     <cfif qWarningLevel.recordCount GT 0>
      <cfset warningLevel=qWarningLevel.SUB_TYPE>
     </cfif>
                
     <cfreturn warningLevel>
     
   </cffunction> 


   <cffunction name="getNominalsForMarker" output="false" access="public" returntype="query" hint="returns a query of nominals for a given warning marker and area">
     <cfargument name="warningMarker" required="true" type="string" hint="warning marker to get nominals for">
     <cfargument name="area" required="false" type="string" hint="area to get nominals for" default="">
     <cfargument name="currentOnly" required="false" type="string" hint="return nominal only if warning marker is current" default="N">
	 <cfargument name="subTypeOrder" required="false" type="string" hint="order on the warning subtype" default="N">
	 <cfargument name="filterType" required="false" type="string" hint="filter type options DATE_MARKED or SURNAME" default="">
	 <cfargument name="filter" required="false" type="string" hint="filter data DATE_MARKED number of days and SURNAME 1st Letter of" default="N">
	 <cfargument name="incLPA" required="false" type="string" hint="include LPA/SNT in the results" default="N">
	 <cfargument name="lpaFilter" required="false" type="string" hint="filter results on LPA" default="">  		
     
     <cfset var qNominals="">
     
     <cfquery name="qNominals" datasource="#variables.warehouseDSN#" result="theQuery">
	  SELECT gw.NOMINAL_REF, FS_CODE, SUB_TYPE <cfif arguments.incLPA IS "Y">, LPA</cfif>
	  FROM   browser_owner.GE_WARNINGS gw
	  <cfif Len(arguments.filterType) GT 0>
	  	 <cfif arguments.filterType IS "SURNAME">
		  , browser_owner.NOMINAL_SEARCH ns
		 </cfif>
	  </cfif>	 
	  <cfif Len(arguments.lpaFilter) GT 0>
	  	, browser_owner.ge_add_nominals gn, browser_owner.ge_addresses ga
	  </cfif>
	  WHERE  WSC_CODE <cfif ListLen(arguments.warningMarker,',') GT 1>
	                    IN (<cfqueryparam value="#arguments.warningMarker#" cfsqltype="cf_sql_varchar" list="true">)
	                  <cfelse>
	                    = <cfqueryparam value="#arguments.warningMarker#" cfsqltype="cf_sql_varchar">
	                  </cfif>
	  <cfif Len(arguments.lpaFilter) GT 0>
		AND gn.NOMINAL_REF=gw.NOMINAL_REF
		AND (gn.POST_CODE=ga.POST_CODE AND GN.PREMISE_KEY=ga.PREMISE_KEY)
		AND GN.LATEST_FLAG='Y'
		AND GA.LPA IN (<cfqueryparam value="#arguments.lpaFilter#" cfsqltype="cf_sql_varchar" list="true">)	  	
	  </cfif>
      <cfif Len(arguments.area) GT 0>
	   <cfif arguments.area IS NOT "H">	   	 
	   	 <cfif Left(arguments.area,2) IS "22"  OR Left(arguments.area,2) IS "23">     	   
		   AND FS_CODE=<cfqueryparam value="#arguments.area#" cfsqltype="cf_sql_varchar">
		 <cfelse>   
	   	   <cfset iDivCount=1>
		   	AND (
			      <cfloop list="#arguments.area#" index="div" delimiters=",">
				  	 <cfif iDivCount GT 1>
					 OR
					 </cfif>
	                   SUBSTR(FS_CODE,3,1) = <cfqueryparam value="#div#" cfsqltype="cf_sql_varchar">				 
					 <cfset iDivCount++> 
				  </cfloop>
				  <cfif Left(arguments.area,2) IS "S" OR Left(arguments.area,2) IS "N" OR arguments.area IS "N,S">
				  	  OR FS_CODE = '23XB'
				  </cfif>
		    )	 
		 </cfif>   
	   </cfif>   
	  </cfif>   
	  <cfif arguments.currentOnly IS 'Y'>
	   AND ((TRUNC(END_DATE) >= TRUNC(SYSDATE)) OR END_DATE IS NULL)
	  </cfif>
	  <cfif Len(arguments.filterType) GT 0>
	  	 <cfif arguments.filterType IS "DATE_MARKED" AND isNumeric(arguments.filter)>
		 AND DATE_MARKED > SYSDATE-#arguments.filter#
		 </cfif>		 	  
	  	 <cfif arguments.filterType IS "SURNAME">
		 AND gw.NOMINAL_REF=ns.NOMINAL_REF
		 <cfif Len(arguments.filter) GT 0>
		 AND SUBSTR(ns.SURNAME_1,0,1) = <cfqueryparam value="#arguments.filter#" cfsqltype="cf_sql_varchar">
		 </cfif>
		 </cfif>
	  </cfif>
	  <cfif arguments.filterType IS "SURNAME">
	  ORDER BY SURNAME_1, SURNAME_2, FORENAME_1, FORENAME_2, FS_CODE, DATE_MARKED
	  <cfelse>
      ORDER BY #iif(arguments.subTypeOrder IS "Y",de(' SUB_TYPE,'),de(''))# FS_CODE, DATE_MARKED DESC
	  </cfif>
	 </cfquery>
	  
     <cfreturn qNominals>
     
   </cffunction>

   <cffunction name="getCountForMarker" output="false" access="public" returntype="boolean" hint="returns a count of IOM nominals">
     <cfargument name="warningMarker" required="true" type="string" hint="warning marker to get nominals for">
     <cfargument name="area" required="false" type="string" hint="area to get nominals for" default="">
     <cfargument name="currentOnly" required="false" type="string" hint="return nominal only if warning marker is current" default="N">	
	 <cfargument name="lpaFilter" required="false" type="string" hint="filter results on LPA" default="">	
     
     <cfset var qWarnings="">
     
     <!--- create a list of nominal refs --->
     
     <!--- query for all warnings on nominals in list --->
     <cfquery name="qWarnings" datasource="#variables.warehouseDSN#" result="rWarn">
	 SELECT COUNT(DISTINCT w.NOMINAL_REF) AS NO_IOM
	 FROM browser_owner.GE_WARNINGS w
	 <cfif Len(arguments.lpaFilter) GT 0>
	  	, browser_owner.ge_add_nominals gn, browser_owner.ge_addresses ga
	  </cfif>
	 WHERE WSC_CODE IN (<cfqueryparam value="#arguments.warningMarker#" cfsqltype="cf_sql_varchar" list="true">)
	  <cfif Len(arguments.lpaFilter) GT 0>
		AND gn.NOMINAL_REF=w.NOMINAL_REF
		AND (gn.POST_CODE=ga.POST_CODE AND GN.PREMISE_KEY=ga.PREMISE_KEY)
		AND GN.LATEST_FLAG='Y'
		AND GA.LPA IN (<cfqueryparam value="#arguments.lpaFilter#" cfsqltype="cf_sql_varchar" list="true">)	  	
	  </cfif>	 
	  <cfif arguments.currentOnly IS 'Y'>
	   AND ((TRUNC(END_DATE) >= TRUNC(SYSDATE)) OR END_DATE IS NULL)
	  </cfif>
	 <cfif Len(arguments.area) GT 0>
	   <cfif arguments.area IS NOT "H">
	   	 <cfset iDivCount=1>
	   	  AND (
		      <cfloop list="#arguments.area#" index="div" delimiters=",">
			  	 <cfif iDivCount GT 1>
				 OR
				 </cfif>
                   SUBSTR(FS_CODE,3,1) = <cfqueryparam value="#div#" cfsqltype="cf_sql_varchar">				 
				 <cfset iDivCount++> 
			  </cfloop>
			  <cfif Left(arguments.area,2) IS "S" OR Left(arguments.area,2) IS "N" OR arguments.area IS "N,S">
			  	  OR FS_CODE = '23XB'
			  </cfif>
		    )	
	   </cfif>
	 </cfif>
     </cfquery>
                    
     <cfreturn qWarnings.NO_IOM>
     
   </cffunction>  

   <cffunction name="doWarningMarkerSearch" output="false" access="public" returntype="query" hint="returns a query of nominals for a given warning marker and area">
     <cfargument name="warningMarkers" required="true" type="string" hint="warning marker(s) to get nominals for">     
     <cfargument name="currentOnly" required="false" type="string" hint="return nominal only if warning marker is current" default="N">
	 <cfargument name="howToUseMarker" required="false" type="string" hint="does nominal need to have ALL or ANY of the markers" default="ANY">
	 <cfargument name="dateFrom" required="false" type="string" hint="date warning marker put on start date" default="">
	 <cfargument name="dateTo" required="false" type="string" hint="date warning marker put on end" default="">
	 <cfargument name="ageFrom" required="false" type="string" hint="date warning marker put on end" default="">
	 <cfargument name="ageTo" required="false" type="string" hint="date warning marker put on end" default="">
	 <cfargument name="sex" required="false" type="string" hint="sex of nominal" default="">
	 <cfargument name="postTown" required="false" type="string" hint="current town of person address" default=""> 
	 <cfargument name="subTypeOrder" required="false" type="string" hint="order on the nominal list" default="ALPHABETICAL"> 		
     
     <cfset var qNominals="">
	 <cfset var sMarker="">
	 <cfset var iMarker=1>
     
     <!--- do the search query, only returns distinct nominal refs as we get the full
	       nominal info elsewhere, max of 200 rows returned --->
     <cfquery name="qNominals" datasource="#variables.warehouseDSN#">
	 SELECT * FROM
		      (		 
				 SELECT ns1.NOMINAL_REF, ns1.FORENAME_1, ns1.SURNAME_1,  ns1.SURNAME_2
			     FROM   browser_owner.NOMINAL_SEARCH ns1 	 
			     WHERE  ns1.NOMINAL_REF IN (							     	 	 
								    <cfif arguments.howToUseMarker IS "ALL">	 	 
								 	  <cfloop list="#arguments.warningMarkers#" index="sMarker" delimiters=",">
										 <cfif iMarker GT 1>
										 INTERSECT	 
										 </cfif>		   	   
									     SELECT DISTINCT ge.NOMINAL_REF
									     FROM   browser_owner.GE_WARNINGS ge, browser_owner.NOMINAL_SEARCH ns, browser_owner.NOMINAL_DETAILS nd
									     WHERE  WSC_CODE = <cfqueryparam value="#sMarker#" cfsqltype="cf_sql_varchar">
									     <cfif arguments.currentOnly IS 'Y'>
									      AND ((TRUNC(END_DATE) >= TRUNC(SYSDATE)) OR END_DATE IS NULL)
									     </cfif>
									     AND ge.NOMINAL_REF=ns.NOMINAL_REF
										 AND ns.NOMINAL_REF=nd.NOMINAL_REF
										 <cfif Len(arguments.sex) GT 0>
										  AND ns.SEX=<Cfqueryparam value="#arguments.sex#" cfsqltype="cf_sql_varchar">
										 </cfif>
										 <cfif Len(arguments.dateFrom) GT 0 AND Len(arguments.dateTo) IS 0>
										  AND ge.DATE_MARKED = TO_DATE(<cfqueryparam value="#arguments.dateFrom#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')
										 </cfif>
										 <cfif Len(arguments.dateFrom) GT 0 AND Len(arguments.dateTo) GT 0>
										  AND ge.DATE_MARKED BETWEEN TO_DATE(<cfqueryparam value="#arguments.dateFrom#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')
										                         AND TO_DATE(<cfqueryparam value="#arguments.dateTo#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')	 
										 </cfif>
										 <cfif Len(arguments.ageFrom) GT 0 AND Len(arguments.ageTo) IS 0>
										  AND trunc(months_between(sysdate,ns.DATE_OF_BIRTH)/12) = <cfqueryparam value="#arguments.ageFrom#" cfsqltype="cf_sql_numeric">	 
										 </cfif>
										 <cfif Len(arguments.ageFrom) GT 0 AND Len(arguments.ageTo) GT 0>
										  AND trunc(months_between(sysdate,ns.DATE_OF_BIRTH)/12) BETWEEN <cfqueryparam value="#arguments.ageFrom#" cfsqltype="cf_sql_numeric">
										                                                             AND <cfqueryparam value="#arguments.ageTo#" cfsqltype="cf_sql_numeric">	 
										 </cfif>	
										 <cfif Len(arguments.postTown) GT 0>
										  AND nd.POST_TOWN=<Cfqueryparam value="#UCase(arguments.postTown)#" cfsqltype="cf_sql_varchar">	 
										 </cfif>									 
										 <cfset iMarker++>			  
									  </cfloop>	 	
									<cfelseif arguments.howToUseMarker IS "ANY">
										 SELECT DISTINCT ge.NOMINAL_REF
									     FROM   browser_owner.GE_WARNINGS ge, browser_owner.NOMINAL_SEARCH ns, browser_owner.NOMINAL_DETAILS nd
									     WHERE  WSC_CODE IN (<cfqueryparam value="#arguments.warningMarkers#" cfsqltype="cf_sql_varchar" list="true" >)
									     <cfif arguments.currentOnly IS 'Y'>
									      AND ((TRUNC(END_DATE) >= TRUNC(SYSDATE)) OR END_DATE IS NULL)
									     </cfif>		
									 	 <cfif Len(arguments.sex) GT 0>
										  AND ns.SEX=<Cfqueryparam value="#arguments.sex#" cfsqltype="cf_sql_varchar">
										 </cfif>
										 <cfif Len(arguments.dateFrom) GT 0 AND Len(arguments.dateTo) GT 0>
										  AND ge.DATE_MARKED BETWEEN TO_DATE(<cfqueryparam value="#arguments.dateFrom#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')
										                         AND TO_DATE(<cfqueryparam value="#arguments.dateTo#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')	 
										 </cfif>										 
										 <cfif Len(arguments.ageFrom) GT 0 AND Len(arguments.ageTo) GT 0>
										  AND trunc(months_between(sysdate,ns.DATE_OF_BIRTH)/12) BETWEEN <cfqueryparam value="#arguments.ageFrom#" cfsqltype="cf_sql_numeric">
										                                                             AND <cfqueryparam value="#arguments.ageTo#" cfsqltype="cf_sql_numeric">	 
										 </cfif>
										 <cfif Len(arguments.postTown) GT 0>
										  AND nd.POST_TOWN=<Cfqueryparam value="#UCase(arguments.postTown)#" cfsqltype="cf_sql_varchar">	 
										 </cfif>
										 AND ge.NOMINAL_REF=ns.NOMINAL_REF	
										 AND ns.NOMINAL_REF=nd.NOMINAL_REF								     							 
								    </cfif>	  								 
							  )
				ORDER BY 3,4,1		
 			   )
	 WHERE ROWNUM < 201							  					  	 
	 </cfquery>
                
     <cfreturn qNominals>
     
   </cffunction>

</cfcomponent>