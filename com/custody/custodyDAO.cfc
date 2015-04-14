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
        
        <cfset variables.custodyDeparturesDAO=CreateObject("component","genieObj.custody.custodyDeparturesDAO").init(warehouseDSN=variables.warehouseDSN,
					                                                                                                 warehouseDSN2=variables.warehouseDSN2,
					                                                                                                 warehouseUID=variables.warehouseUID,
					                                                                                                 warehousePWD=variables.warehousePWD)>
                                                                                                 
        <cfset variables.custodyReasonsDAO=CreateObject("component","genieObj.custody.custodyReasonDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD)>                
           
        <cfreturn this />  
    </cffunction> 

	<cffunction name="read" output="false" access="public" returntype="custody">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	cs.CUSTODY_REF, STATION, NOMINAL_REF, NAME, SEX, DOB, 
					ETHNIC_APP, ARREST_TIME, AO_FORCE, AO_BADGE, AO_STATION, 
					OIC_FORCE, OIC_BADGE, OIC_STATION, ORIG_CUSTODY, DEPARTURE_TIME, 
					BAIL_ANSWERED, CREATION_DATE, CUSTODY_TYPE, ARREST_SUMMONS_NO,
                    AO_NAME, OIC_NAME, RIGHTS, CHARGED, BAIL_CANC_REASON, 
					NEXT_REVIEW_DATE, REVIEW_RANK, DETAIN_UNTIL, STATUS, CELL, 
					PLACE_OF_ARREST,CUSTODY_TYPE
			from BROWSER_OWNER.CUSTODY_SEARCH cs, BROWSER_OWNER.CUSTODY_DETAIL cd
			where cs.CUSTODY_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getCUSTODY_REF()#" />
            and cs.CUSTODY_REF=cd.CUSTODY_REF
		</cfquery>

		<cfscript>
			obj.setCUSTODY_REF(qRead.CUSTODY_REF);
			obj.setCUSTODY_TYPE(qRead.CUSTODY_TYPE);			
			obj.setSTATION(qRead.STATION);
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setNAME(qRead.NAME);
			obj.setSEX(qRead.SEX);
			obj.setDOB(qRead.DOB);
			obj.setETHNIC_APP(qRead.ETHNIC_APP);
			obj.setARREST_TIME(qRead.ARREST_TIME);
			obj.setAO_FORCE(qRead.AO_FORCE);
			obj.setAO_BADGE(qRead.AO_BADGE);
			obj.setAO_STATION(qRead.AO_STATION);
			obj.setOIC_FORCE(qRead.OIC_FORCE);
			obj.setOIC_BADGE(qRead.OIC_BADGE);
			obj.setOIC_STATION(qRead.OIC_STATION);
			obj.setORIG_CUSTODY(qRead.ORIG_CUSTODY);
			obj.setDEPARTURE_TIME(qRead.DEPARTURE_TIME);
			obj.setBAIL_ANSWERED(qRead.BAIL_ANSWERED);
			obj.setCREATION_DATE(qRead.CREATION_DATE);
			obj.setCUSTODY_TYPE(qRead.CUSTODY_TYPE);
			obj.setARREST_SUMMONS_NO(qRead.ARREST_SUMMONS_NO);
			obj.setAO_NAME(qRead.AO_NAME);
			obj.setOIC_NAME(qRead.OIC_NAME);
			obj.setRIGHTS(qRead.RIGHTS);
			obj.setCHARGED(qRead.CHARGED);
			obj.setBAIL_CANC_REASON(qRead.BAIL_CANC_REASON);
			obj.setNEXT_REVIEW_DATE(qRead.NEXT_REVIEW_DATE);
			obj.setREVIEW_RANK(qRead.REVIEW_RANK);
			obj.setDETAIN_UNTIL(qRead.DETAIN_UNTIL);
			obj.setSTATUS(qRead.STATUS);
			obj.setCELL(qRead.CELL);
			obj.setPLACE_OF_ARREST(qRead.PLACE_OF_ARREST);		
			obj.setCustodyReasons(variables.custodyReasonsDAO.readCustodyReasons(id=obj.getCUSTODY_REF()));	
			obj.setCustodyDepartures(variables.custodyDeparturesDAO.readCustodyDepartures(id=obj.getCUSTODY_REF()));				
			return obj;
		</cfscript>
	</cffunction>
	
	<cffunction name="readInCustody" output="false" access="public" returntype="custody">
		<cfargument name="nominalRef" required="true">
		<cfset var qInCust="">
        <cfset var currentCustody=CreateObject("component","genieObj.custody.custody")>

		<cfquery name="qInCust" datasource="#variables.warehouseDSN#">
			select cs.custody_ref, station, arrest_time, STATUS
			from  browser_owner.CUSTODY_SEARCH cs, browser_owner.CUSTODY_DETAIL cd
			where  cs.nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
			AND    cs.custody_ref=cd.custody_ref
			AND    status IN ('C','I')
			AND    departure_time is null
			order by arrest_time desc
		</cfquery>
        
        <cfif qInCust.RecordCount GT 0>
            
          <cfset currentCustody.setCUSTODY_REF(qInCust.CUSTODY_REF)>
          <cfset currentCustody=read(currentCustody)>
        </cfif>

        <cfreturn currentCustody>
		
	</cffunction>	

	<cffunction name="getNominalCustodies" output="false" access="public" returntype="array">
		<cfargument name="nominalRef" required="true">
		<cfset var qCusts="">
        <cfset var custs=ArrayNew(1)>
        <cfset var cust="">

		<cfquery name="qCusts" datasource="#variables.warehouseDSN#">
			select 	CUSTODY_REF
			from    BROWSER_OWNER.CUSTODY_SEARCH
			where   NOMINAL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nominalRef#" />
            order by CREATION_DATE desc
		</cfquery>
        
        <cfif qCusts.RecordCount GT 0>
         <cfloop query="qCusts">
          <cfset cust=CreateObject("component","genieObj.custody.custody")>
          <cfset cust.setCUSTODY_REF(CUSTODY_REF)>
          <cfset cust=read(cust)>
          <cfset ArrayAppend(custs,cust)>
         </cfloop>
        </cfif>

        <cfreturn custs>
		
	</cffunction> 

	<cffunction name="doCustodyWhiteboard" output="false" access="public" returntype="array">
		<cfargument name="custodySuite" required="true">
		<cfset var qCusts="">
        <cfset var custs=ArrayNew(1)>
        <cfset var cust="">
		<cfset var cSuite="">
		<cfset var iCust=1>
		
		<cfset custodySuite=Trim(ReplaceList(custodySuite,'ALLWP,ALLWMP,ALLCUST','23%,22%,%'))>

		<cfquery name="qCusts" datasource="#variables.warehouseDSN#">
		SELECT cs.CUSTODY_REF
		FROM   browser_owner.CUSTODY_SEARCH cs, browser_owner.CUSTODY_DETAIL cd
		WHERE  cd.custody_ref=cs.custody_ref
		AND    cs.sensetive = 'N'
		<!---
		<cfif Len(custodySuite) GT 0>		
			 <cfif Len(custodySuite) IS 2>
			  	  AND   SUBSTR(STATION,0,2) = <cfqueryparam value="#custodySuite#" cfsqltype="cf_sql_varchar" />	 
			 <cfelse> 
				  AND   STATION	 
				  <cfif Find("%",custodySuite) OR Find("_",custodySuite)>
		    	    LIKE 
				  <cfelse>
				    = 
				  </cfif>
			      <cfqueryparam value="#custodySuite#" cfsqltype="cf_sql_varchar">
			 </cfif> 
	    </cfif> 
	    --->
	    AND (
	    <cfloop list="#custodySuite#" index="cSuite" delimiters=",">
		 <cfif iCust GT 1>
		  OR
		 </cfif>
		 STATION LIKE <cfqueryparam value="#cSuite#" cfsqltype="cf_sql_varchar">
		 <cfset iCust++>	
		</cfloop>
		)
		AND    status IN ('C','I')
		AND    departure_time is null
		order by custody_ref
		</cfquery>
        
        <cfif qCusts.RecordCount GT 0>
         <cfloop query="qCusts">
          <cfset cust=CreateObject("component","genieObj.custody.custody")>
          <cfset cust.setCUSTODY_REF(CUSTODY_REF)>
          <cfset cust=read(cust)>
          <cfset ArrayAppend(custs,cust)>
         </cfloop>
        </cfif>

        <cfreturn custs>
		
	</cffunction> 

	<cffunction name="doCustodyEnquiry" output="false" access="public" returntype="array">
      <cfargument name="searchTerms" type="struct" required="true" hint="structure of search terms for custody enquiry">
      
      <cfset var qSearchResults="">
      <cfset var searchItem="">
      <cfset var searchKey="">
	  <cfset var custs=ArrayNew(1)>
      <cfset var cust="">
      
      <cfquery name="qSearchResults" datasource="#variables.WarehouseDSN#" RESULT="theSql">
			SELECT * FROM
			(
				SELECT DISTINCT CS.CUSTODY_REF,STATION,cs.NOMINAL_REF,NAME,TO_CHAR(ARREST_TIME,'DD/MM/YY HH24:MI') AS ARR_DATE,
				       			AO_NAME, AO_BADGE, ARREST_TIME, TO_CHAR(CREATION_DATE,'DD') AS REC_DAY, TO_CHAR(CREATION_DATE,'MM') AS REC_MON,
				       			TO_CHAR(CREATION_DATE,'YYYY') AS REC_YEAR, CUSTODY_TYPE, DOB, PLACE_OF_ARREST
				FROM   BROWSER_OWNER.CUSTODY_SEARCH CS, browser_owner.CUSTODY_DETAIL CD
		       <cfif Len(structFind(searchTerms,'reason_for_departure')) GT 0>, browser_owner.CUSTODY_DEPARTURES CDE</cfif>
		       <cfif Len(structFind(searchTerms,'arrest_reason_text')) GT 0>, browser_owner.CUSTODY_REASONS CR</cfif>
           	   <cfif Len(structFind(searchTerms,'warning_marker')) GT 0>, browser_owner.GE_WARNINGS WR</cfif>
				WHERE  CS.CUSTODY_REF=CD.CUSTODY_REF
				AND    CS.SENSETIVE = 'N'
	    	   <cfif Len(structFind(searchTerms,'reason_for_departure')) GT 0>AND CS.CUSTODY_REF=CDE.CUSTODY_REF</cfif>
			   <cfif Len(structFind(searchTerms,'arrest_reason_text')) GT 0>AND CS.CUSTODY_REF=CR.CUSTODY_REF</cfif>
			   <cfloop collection="#arguments.searchTerms#" item="searchKey">
                 <cfset searchItem=StructFind(arguments.searchTerms,PreserveSingleQuotes(searchKey))>
				 <!--- ignore dates and warning marker --->				 	
				 <cfif ListFindNoCase('dob_1,dob_2,arrest_date_1,arrest_time_1,arrest_date_2,arrest_time_2,dep_date_1,dep_time_1,dep_date_2,dep_time_2,warning_marker',searchKey) IS 0>
				    <cfif Len(searchItem) GT 0>	 
				      AND UPPER(#iif(searchKey IS "custody_ref",de('cs.'),de(''))##PreserveSingleQuotes(searchKey)#)
	                 <cfif Find("%",searchItem) OR Find("_",searchItem)>
	                  LIKE
	                 <cfelse>
	                  =
	                 </cfif>
	                 <cfif searchKey IS "custody_ref" AND (Left(searchItem,3) IS "23/" OR Left(searchItem,3) IS "22/")>
					 	 <cfset searchItem=Left(searchItem,2)&Right(searchItem,Len(searchItem)-3)>
					 </cfif>
	                 <cfqueryparam value="#UCase(searchItem)#" cfsqltype="cf_sql_varchar">
	                </cfif>			 
				 </cfif>
			   </cfloop>
			   <cfif Len(structFind(searchTerms,'dob_1')) GT 0 AND Len(structFind(searchTerms,'dob_2')) IS 0>
			   	AND DOB=TO_DATE('#structFind(searchTerms,'dob_1')#','DD/MM/YYYY')
			   </cfif>
			   <cfif Len(structFind(searchTerms,'dob_1')) GT 0 AND Len(structFind(searchTerms,'dob_2')) GT 0>
			   	AND DOB BETWEEN TO_DATE('#structFind(searchTerms,'dob_1')#','DD/MM/YYYY') AND TO_DATE('#structFind(searchTerms,'dob_2')#','DD/MM/YYYY')
			   </cfif>
			   <cfif Len(structFind(searchTerms,'arrest_date_1')) GT 0 AND Len(structFind(searchTerms,'arrest_date_2')) IS 0>
			   	 <cfif Len(structFind(searchTerms,'arrest_time_1')) IS 0>  
			   	   AND TRUNC(ARREST_TIME)=TRUNC(TO_DATE('#structFind(searchTerms,'arrest_date_1')#','DD/MM/YYYY'))
				 <cfelse>
				   AND ARREST_TIME=TO_DATE('#structFind(searchTerms,'arrest_date_1')# #structFind(searchTerms,'arrest_time_1')#:00','DD/MM/YYYY HH24:MI:SS')	 
				 </cfif>
			   </cfif>
			   <cfif Len(structFind(searchTerms,'arrest_date_1')) GT 0 AND Len(structFind(searchTerms,'arrest_date_2')) GT 0>
			   	   <cfif Len(structFind(searchTerms,'arrest_time_1')) GT 0 AND Len(structFind(searchTerms,'arrest_time_2')) GT 0>
			   			AND ARREST_TIME BETWEEN TO_DATE('#structFind(searchTerms,'arrest_date_1')# #structFind(searchTerms,'arrest_time_1')#:00','DD/MM/YYYY HH24:MI:SS') AND TO_DATE('#structFind(searchTerms,'arrest_date_2')# #structFind(searchTerms,'arrest_time_2')#:59','DD/MM/YYYY HH24:MI:SS')
			   	   <cfelse>	
			   			AND TRUNC(ARREST_TIME) BETWEEN TRUNC(TO_DATE('#structFind(searchTerms,'arrest_date_1')#','DD/MM/YYYY')) AND TRUNC(TO_DATE('#structFind(searchTerms,'arrest_date_2')#','DD/MM/YYYY'))
				   </cfif>
			   </cfif>		
			   
			   	<cfif Len(structFind(searchTerms,'dep_date_1')) GT 0 AND Len(structFind(searchTerms,'dep_date_2')) IS 0>
			   	 <cfif Len(structFind(searchTerms,'dep_time_1')) IS 0>  
			   	   AND TRUNC(DEPARTURE_TIME)=TRUNC(TO_DATE('#structFind(searchTerms,'dep_date_1')#','DD/MM/YYYY'))
				 <cfelse>
				   AND DEPARTURE_TIME BETWEEN TO_DATE('#structFind(searchTerms,'dep_date_1')# #structFind(searchTerms,'dep_time_1')#:00','DD/MM/YYYY HH24:MI:SS') AND TO_DATE('#structFind(searchTerms,'dep_date_1')# #structFind(searchTerms,'dep_time_1')#:59','DD/MM/YYYY HH24:MI:SS') 	 
				 </cfif>
			   </cfif>
			   
				<cfif Len(structFind(searchTerms,'dep_date_1')) GT 0 AND Len(structFind(searchTerms,'dep_date_2')) GT 0>
			   	   <cfif Len(structFind(searchTerms,'dep_time_1')) GT 0 AND Len(structFind(searchTerms,'dep_time_2')) GT 0>
			   			AND DEPARTURE_TIME BETWEEN TO_DATE('#structFind(searchTerms,'dep_date_1')# #structFind(searchTerms,'dep_time_1')#:00','DD/MM/YYYY HH24:MI:SS') AND TO_DATE('#structFind(searchTerms,'dep_date_2')# #structFind(searchTerms,'dep_time_2')#:59','DD/MM/YYYY HH24:MI:SS')
			   	   <cfelse>	
			   			AND TRUNC(DEPARTURE_TIME) BETWEEN TRUNC(TO_DATE('#structFind(searchTerms,'dep_date_1')#','DD/MM/YYYY')) AND TRUNC(TO_DATE('#structFind(searchTerms,'dep_date_2')#','DD/MM/YYYY'))
				   </cfif>
			   </cfif>	
			   
			   <cfif Len(structFind(searchTerms,'warning_marker')) GT 0>
		           AND cs.NOMINAL_REF=wr.NOMINAL_REF
		           AND wr.WSC_CODE = <cfqueryparam value="#structFind(searchTerms,'warning_marker')#" cfsqltype="cf_sql_varchar">
		            <cfif structFind(searchTerms,'warning_marker') IS "PY">
		              AND cs.NOMINAL_REF NOT IN (SELECT ge1.NOMINAL_REF FROM browser_owner.GE_WARNINGS ge1
		                                         WHERE ge1.WSC_CODE='XY'
		                                         AND ge1.NOMINAL_REF=cs.NOMINAL_REF)
		            </cfif>         
		           AND wr.DATE_MARKED <= cs.ARREST_TIME
		       </cfif> 
			   			   	   
			   ORDER BY ARREST_TIME DESC
			)
			WHERE ROWNUM < 202
	  </cfquery>	  		  
	  
	  <cfif qSearchResults.RecordCount GT 0>
         <cfloop query="qSearchResults">
          <cfset cust=CreateObject("component","genieObj.custody.custody")>
          <cfset cust.setCUSTODY_REF(CUSTODY_REF)>
          <cfset cust=read(cust)>
          <cfset ArrayAppend(custs,cust)>
         </cfloop>
      </cfif>
	  
	  <cfreturn custs>
    
	</cffunction>

</cfcomponent>