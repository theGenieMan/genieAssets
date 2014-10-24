<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        <cfargument name="geniePastePath" required="true" type="String">
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>      
        <cfset variables.geniePastePath=arguments.geniePastePath>   
        
        <cfset variables.hearingsDAO=CreateObject("component","genieObj.processDecisions.hearingsDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD)>
                                                                                                 
        <cfset variables.offencesDAO=CreateObject("component","genieObj.processDecisions.offencesDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD)>
           
        <cfreturn this />  
    </cffunction>   
    
	<cffunction name="read" output="false" access="public" returntype="processDecision">
		<cfargument name="obj" required="true">
		<cfset var qRead="">
		<cfset var qReadMinDates="">     
        <cfset var qCustDetails="">   

		<cfquery name="qRead" datasource="#variables.warehousedsn#">
			select 	PD_REF, CASE_ORG, CASE_SERIAL, CASE_YEAR, DECISION, NOMINAL_REF, 
					CUSTODY_REF, DATE_FORMALISED, DEFENDANT, DOB, SEX, 
					DATE_CREATED, ARREST_SUMMONS_NO
			from BROWSER_OWNER.PD_SEARCH
			where PD_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getPD_REF()#" />
		</cfquery>

		<cfscript>
			obj.setPD_REF(qRead.PD_REF);
			obj.setCASE_ORG(qRead.CASE_ORG);
			obj.setCASE_SERIAL(qRead.CASE_SERIAL);
			obj.setCASE_YEAR(qRead.CASE_YEAR);
			obj.setDECISION(qRead.DECISION);
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setCUSTODY_REF(qRead.CUSTODY_REF);
			obj.setCUSTODY_TYPE();			
			obj.setDATE_FORMALISED(qRead.DATE_FORMALISED);
			obj.setDEFENDANT(qRead.DEFENDANT);
			obj.setDOB(qRead.DOB);
			obj.setSEX(qRead.SEX);
			obj.setDATE_CREATED(qRead.DATE_CREATED);
			obj.setARREST_SUMMONS_NO(qRead.ARREST_SUMMONS_NO);
			obj.setPdHearings(variables.hearingsDAO.readPdHearings(qRead.PD_REF));
		</cfscript>
        
        <!--- sort out the min dates for the case if there is a valid case no --->
        <cfif Len(obj.getCASE_ORG()) GT 0 AND Len(obj.getCASE_SERIAL()) GT 0 AND Len(obj.getCASE_YEAR()) GT 0>

	       	<cfquery name="qReadMinDates" datasource="#variables.warehousedsn#">
                SELECT TO_CHAR(MIN(DATE_CREATED),'DD') AS REC_DAY,
				       TO_CHAR(MIN(DATE_CREATED),'MM') AS REC_MON,
				       TO_CHAR(MIN(DATE_CREATED),'YYYY') AS REC_YEAR
				FROM  browser_owner.PD_SEARCH
				WHERE CASE_ORG=<cfqueryparam value="#obj.getCASE_ORG()#" cfsqltype="cf_sql_varchar">
				AND CASE_SERIAL=<cfqueryparam value="#obj.getCASE_SERIAL()#" cfsqltype="cf_sql_varchar">
				AND CASE_YEAR=<cfqueryparam value="#obj.getCASE_YEAR()#" cfsqltype="cf_sql_varchar">
			</cfquery>

            <cfset obj.setMIN_DAY(qReadMinDates.REC_DAY)>
            <cfset obj.setMIN_MONTH(qReadMinDates.REC_MON)>
            <cfset obj.SetMIN_YEAR(qReadMinDates.REC_YEAR)>                        
        
        </cfif>
        
        <!--- if the custody ref exists --->
        <cfif Len(obj.getCUSTODY_REF()) GT 0>
        
	       	<cfquery name="qReadCustDetails" datasource="#variables.warehousedsn#">
                SELECT TO_CHAR(CREATION_DATE,'DD') AS REC_DAY,
				       TO_CHAR(CREATION_DATE,'MM') AS REC_MON,
				       TO_CHAR(CREATION_DATE,'YYYY') AS REC_YEAR
				FROM  browser_owner.CUSTODY_SEARCH
				WHERE CUSTODY_REF=<cfqueryparam value="#obj.getCUSTODY_REF()#" cfsqltype="cf_sql_varchar">
			</cfquery>        
            
            <cfset obj.setCUSTODY_LINK(qReadCustDetails.REC_YEAR&"\"&qReadCustDetails.REC_MON&"\"&qReadCustDetails.REC_DAY&"\"&Replace(obj.getCUSTODY_REF(),"/","_","ALL")&".xml")>
        
        </cfif>
        
        <cfreturn obj>
        
	</cffunction>    
    
    <cffunction name="doWestMerciaProcessDecisionSearch" output="false" access="public" returntype="query">
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
	                <cfif Len(searchItem) GT 0>
	                AND #PreserveSingleQuotes(searchKey)#
	                 <cfif Find("%",searchItem) OR Find("_",searchItem)>
	                  LIKE
	                 <cfelse>
	                  =
	                 </cfif>
	                 <cfqueryparam value="#searchItem#" cfsqltype="cf_sql_varchar">
	                </cfif>
	             </cfloop> 
		  </cfquery> 
                
       <cfreturn qSearchResults>      
     
    </cffunction>  
    
    <cffunction name="getCaseDatesCreated" output="false" access="public" returntype="query">
      <cfargument name="case_Urn" type="string" required="true" hint="structure of search terms for address query">
      
      <cfset var qCaseDates="">

		  <cfquery name="qCaseDates" datasource="#variables.WarehouseDSN#">
		    SELECT TO_CHAR(DATE_CREATED,'DD') AS REC_DAY, TO_CHAR(DATE_CREATED,'MM') AS REC_MON, 
                   TO_CHAR(DATE_CREATED,'YYYY') AS REC_YEAR
        	FROM   browser_owner.PD_SEARCH pd
		    WHERE  CASE_ORG='#ListGetAt(arguments.CASE_URN,1,"/")#'
		    AND    CASE_SERIAL='#ListGetAt(arguments.CASE_URN,2,"/")#'
		    AND    CASE_YEAR='#ListGetAt(arguments.CASE_URN,3,"/")#'
		  </cfquery>
               
       <cfreturn qCaseDates>      
     
    </cffunction>      

	<cffunction name="getNominalProcessDecisions" output="false" access="public" returntype="array">
		<cfargument name="nominalRef" required="true">
		<cfset var qPdecs="">
        <cfset var pdecs=ArrayNew(1)>
        <cfset var pdec="">

		<cfquery name="qPdecs" datasource="#variables.warehouseDSN#">
			select 	PD_REF
			from    BROWSER_OWNER.PD_SEARCH
			where   NOMINAL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nominalRef#" />
            order by DATE_CREATED desc
		</cfquery>
        
        <cfif qPdecs.RecordCount GT 0>
         <cfloop query="qPdecs">
          <cfset pdec=CreateObject("component","genieObj.processDecisions.processDecision")>
          <cfset pdec.setPD_REF(PD_REF)>
          <cfset pdec=read(pdec)>
          <cfset ArrayAppend(pdecs,pdec)>
         </cfloop>
        </cfif>

        <cfreturn pdecs>
		
	</cffunction> 


</cfcomponent>