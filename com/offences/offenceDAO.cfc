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

	<cffunction name="readWestMerciaOffence" output="false" access="public" returntype="genieObj.offences.offence">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
				select 	CRIME_REF, ORG_CODE, SERIAL_NO, YEAR, BEAT_CODE, INCIDENT_NO, 
						SOCO_REPORT_NO, REC_WMC_CODE, REC_HOMC_CODE, REC_HOOC_CODE, REC_ACPO_CAT, 
						REC_ACPO_SUB, REC_OFF_CODE, REC_TITLE, REP_WMC_CODE, REP_HOMC_CODE, 
						REP_HOOC_CODE, REP_ACPO_CAT, REP_ACPO_SUB, REP_OFF_CODE, REP_TITLE, 
						FIRST_COMMITTED, LAST_COMMITTED, NCR_CODE, REPORT_METHOD, REPORT_DATE, 
						DETECTED_FLAG, CUC_CODE, CREATED_DATE, VALIDATION_STATUS, HO_REPORTED_DATE, 
						POST_CODE, PREMISE_KEY, LPA, GRID_REF, STATUS		
				from BROWSER_OWNER.OFFENCE_SEARCH
				where CRIME_REF = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#arguments.id#" />
			</cfquery>
	
			<cfscript>
				obj = createObject("component", "genieObj.offences.offence").init();
				obj.setCRIME_REF(qRead.CRIME_REF);
				obj.setORG_CODE(qRead.ORG_CODE);
				obj.setSERIAL_NO(qRead.SERIAL_NO);
				obj.setYEAR(qRead.YEAR);
				obj.setBEAT_CODE(qRead.BEAT_CODE);
				obj.setINCIDENT_NO(qRead.INCIDENT_NO);
				obj.setSOCO_REPORT_NO(qRead.SOCO_REPORT_NO);
				obj.setREC_WMC_CODE(qRead.REC_WMC_CODE);
				obj.setREC_HOMC_CODE(qRead.REC_HOMC_CODE);
				obj.setREC_HOOC_CODE(qRead.REC_HOOC_CODE);
				obj.setREC_ACPO_CAT(qRead.REC_ACPO_CAT);
				obj.setREC_ACPO_SUB(qRead.REC_ACPO_SUB);
				obj.setREC_OFF_CODE(qRead.REC_OFF_CODE);
				obj.setREC_TITLE(qRead.REC_TITLE);
				obj.setREP_WMC_CODE(qRead.REP_WMC_CODE);
				obj.setREP_HOMC_CODE(qRead.REP_HOMC_CODE);
				obj.setREP_HOOC_CODE(qRead.REP_HOOC_CODE);
				obj.setREP_ACPO_CAT(qRead.REP_ACPO_CAT);
				obj.setREP_ACPO_SUB(qRead.REP_ACPO_SUB);
				obj.setREP_OFF_CODE(qRead.REP_OFF_CODE);
				obj.setREP_TITLE(qRead.REP_TITLE);
				obj.setFIRST_COMMITTED(qRead.FIRST_COMMITTED);
				obj.setLAST_COMMITTED(qRead.LAST_COMMITTED);
				obj.setNCR_CODE(qRead.NCR_CODE);
				obj.setREPORT_METHOD(qRead.REPORT_METHOD);
				obj.setREPORT_DATE(qRead.REPORT_DATE);
				obj.setDETECTED_FLAG(qRead.DETECTED_FLAG);
				obj.setCUC_CODE(qRead.CUC_CODE);
				obj.setCREATED_DATE(qRead.CREATED_DATE);
				obj.setVALIDATION_STATUS(qRead.VALIDATION_STATUS);
				obj.setHO_REPORTED_DATE(qRead.HO_REPORTED_DATE);
				obj.setPOST_CODE(qRead.POST_CODE);
				obj.setPREMISE_KEY(qRead.PREMISE_KEY);
				obj.setLPA(qRead.LPA);
				obj.setGRID_REF(qRead.GRID_REF);
				obj.setSTATUS(qRead.STATUS);
				return obj;
			</cfscript>
		</cffunction>
	    
	<cffunction name="getNominalOffences" output="false" access="public" returntype="query" hint="returns a query nominal offences">
	     <cfargument name="nominalRef" required="true" type="string" hint="nominal ref to get offences for">
	     <cfargument name="sort" required="false" type="string" hint="sort order, DATE or ROLE" default="DATE_CREATED">     
	     
	     <cfset var qOffences="">
	     
	     <!--- query for all warnings on nominals in list --->
			<cfquery NAME = "qOffences" DATASOURCE="#variables.warehouseDSN#">
			SELECT nr.ROLE as ROLE_CODE, nr.PROCESS AS PROC_TYPE, o.REC_TITLE AS SHORT_OFFENCE_TITLE, o.INCIDENT_NO, 
			       DECODE(o.LAST_COMMITTED,'', TO_CHAR(o.FIRST_COMMITTED,'DD/MM/YYYY HH24:MI'),
			       TO_CHAR(o.FIRST_COMMITTED,'DD/MM/YYYY HH24:MI') || ' and ' ||    TO_CHAR(o.LAST_COMMITTED,'DD/MM/YYYY HH24:MI')) AS DATE_COMM,
			       o.ORG_CODE || '/' || O.SERIAL_NO ||'/' || DECODE(LENGTH(O.YEAR),1, '0' || o.YEAR, o.YEAR) Crime_Number,
			 	   o.CRIME_REF, TO_CHAR(o.CREATED_DATE,'DD') AS REC_DAY, TO_CHAR(o.CREATED_DATE,'MM') AS REC_MON,
					TO_CHAR(o.CREATED_DATE,'YYYY') AS REC_YEAR, o.FIRST_COMMITTED, o.LAST_COMMITTED,
					TO_CHAR(O.DATE_FILED,'DD/MM/YYYY') AS DATE_FILED,NR.ELIMINATED,TO_CHAR(NR.DATE_ELIMINATED,'DD/MM/YYYY') AS DATE_ELIMINATED,
					TO_CHAR(o.CREATED_DATE,'DD/MM/YYYY') AS CREATED_DATE
			FROM   browser_owner.NOMINAL_ROLES nr, browser_owner.OFFENCE_SEARCH o
			WHERE  nr.CRIME_REF=o.CRIME_REF
			AND    nr.NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
			<cfif sort IS "DATE_COM">
			ORDER BY o.FIRST_COMMITTED DESC
			</cfif>
			<cfif sort IS "DATE_CREATED">
			ORDER BY o.CREATED_DATE DESC
			</cfif>
			<cfif sort IS "ROLE">
			ORDER BY ROLE, o.FIRST_COMMITTED DESC
			</cfif>
			</cfquery>
	                
	     <cfreturn qOffences>
	     
	   </cffunction>     
	
	<cffunction name="getOffenceGroupings" output="false" access="public" returntype="query" hint="returns a query nominal offences">
	     
	     <cfset var qGroups="">
	     
	     <!--- query for all warnings on nominals in list --->
			<cfquery NAME = "qGroups" DATASOURCE="#variables.warehouseDSN#">
			SELECT *
	        FROM   browser_owner.CRIME_BROWSER_GROUPS
	        WHERE  (LOGICALLY_DELETED IS NULL OR LOGICALLY_DELETED <> 'Y')
	        ORDER  BY GROUP_ID
			</cfquery>
	                
	     <cfreturn qGroups>
	     
	   </cffunction> 
	
	<cffunction name="getGroupSQL" output="false" access="public" returntype="query" hint="returns SQL for a group query nominal offences">
	     <cfargument name="groupId" required="false" default="" hint="groupid to get offences for">
	     <cfset var qSQL="">
	     
	     <!--- query for all warnings on nominals in list --->
			<cfquery NAME = "qSQL" DATASOURCE="#variables.warehouseDSN#">
			SELECT SQL_TEXT
	        FROM   browser_owner.CRIME_BROWSER_GROUPS
	        WHERE  (LOGICALLY_DELETED IS NULL OR LOGICALLY_DELETED <> 'Y')
	        <cfif Len(arguments.groupId) GT 0>
	        AND    GROUP_ID=<cfqueryparam value="#arguments.groupId#" cfsqltype="cf_sql_numeric">
	        </cfif>
			</cfquery>
	                
	     <cfreturn qSQL>
	     
	   </cffunction> 
	
	<cffunction name="getOffenceCodes" output="false" access="public" returntype="query" hint="returns a query nominal offences">
	     <cfargument name="groupId" required="false" default="" hint="groupid to get offences for">
	     <cfset var qCodes="">
	     
	     <!--- query for all warnings on nominals in list --->
			<cfquery NAME = "qCodes" DATASOURCE="#variables.warehouseDSN#">
			SELECT HOMC_CODE, HOOC_CODE
	        FROM   browser_owner.CRIME_BROWSER_OFFENCES
	        WHERE  (LOGICALLY_DELETED IS NULL OR LOGICALLY_DELETED <> 'Y')
	        <cfif Len(arguments.groupId) GT 0>
	        AND    GROUP_ID=<cfqueryparam value="#arguments.groupId#" cfsqltype="cf_sql_numeric">
	        </cfif>
			</cfquery>
	                
	     <cfreturn qCodes>
	     
	   </cffunction> 
	
    <cffunction name="doCrimeBrowserSearch" output="false" access="public" returntype="any" hint="returns a query of offences">
	     <cfargument name="fromDate" type="string" required="true" hint="date to run search from">
	     <cfargument name="toDate" type="string" required="true" hint="date to run search to">     
	     <cfargument name="area" type="string" required="true" hint="area to run search for">          
	     <cfargument name="groups" type="string" required="true" hint="list of offence groups to run search on">     
	     <cfargument name="dateType" type="string" required="true" hint="type of date to use">     
	     <cfargument name="sort" type="string" required="true" hint="sort to use">          
	          
	     <cfset var qSearch="">
	     <cfset var groupId="">
	     <cfset var qOffences="">
	     <cfset var qDisHOMC="">
	     <cfset var qHOOC="">
	     <cfset var iGroupCount=1>     
	     <cfset var areaIsList=false>
	     <cfset var areaListIsSector=false>
		 <cfset var areaListIsSNT=false>
	     <cfset var sectorLen=0>
		 <cfset var qMo="">
		 <cfset var qJoined="">
	     
	     <cfset arguments.area = UCase(arguments.area)>
	     
	     <!--- we do have a list of areas? --->
	     <cfif Find(",",arguments.area) GT 0>
	      <cfset areaIsList=true>
	      <cfif Len(ListGetAt(arguments.area,1,",")) IS 1 OR Len(ListGetAt(arguments.area,1,",")) IS 2>
	        <cfset areaListIsSector=true>
	        <cfset sectorLen=Len(ListGetAt(arguments.area,1,","))>
		  <cfelseif Len(ListGetAt(arguments.area,1,",")) IS 3 OR Len(ListGetAt(arguments.area,1,",")) IS 5>
		    <cfset areaListIsSNT=true>	  
	      </cfif>
	     </cfif>
	     	     		 
	     <!--- query for all warnings on nominals in list --->
			<cfquery NAME = "qSearch" DATASOURCE="#variables.warehouseDSN#" maxrows="200">
			SELECT DISTINCT BEAT_CODE,REC_TITLE,INCIDENT_NO,DETECTED_FLAG,FIRST_COMMITTED,LAST_COMMITTED,CREATED_DATE,O.CRIME_REF,
	                            REPLACE(DECODE(addr.PART_ID,'','','FLAT '||addr.PART_ID||', '),'FLAT FLAT','FLAT')||
								DECODE(addr.BUILDING_NAME,'','',addr.BUILDING_NAME||', ')||
								DECODE(addr.BUILDING_NUMBER,'','',addr.BUILDING_NUMBER||', ')||
								DECODE(addr.STREET_1,'','',addr.STREET_1||', ')||
								DECODE(addr.LOCALITY,'','',addr.LOCALITY||', ')||
								DECODE(addr.TOWN,'','',addr.TOWN||', ')||
								DECODE(addr.COUNTY,'','',addr.COUNTY||' ')||
								DECODE(addr.POST_CODE,'','',addr.POST_CODE) as OffenceAddress,
	               o.ORG_CODE || '/' || O.SERIAL_NO ||'/' || DECODE(LENGTH(O.YEAR),1, '0' || o.YEAR, o.YEAR) CRIME_NO,
	               O.REC_HOMC_CODE AS HOMC, O.REC_HOOC_CODE AS HOOC, o.LPA
	        FROM   BROWSER_OWNER.OFFENCE_SEARCH O, BROWSER_OWNER.GE_ADDRESSES addr
                   <cfif Len(frmMarker) GT 0>
                   , BROWSER_OWNER.OFFENCE_MARKERS om
                   </cfif>
	        WHERE  (1=1)
			<cfif arguments.groups IS NOT "ALL">
			AND 
			   (
			    (
		        <cfif Len(arguments.groups) GT 0>
			                                           
			        <cfloop list="#arguments.groups#" delimiters="," index="groupId">
			          <cfset qOffences=getGroupSQL(groupId=groupId)>
			          <cfif iGroupCount GT 1>
			          OR
			          </cfif>
			          #PreserveSingleQuotes(qOffences.SQL_TEXT)#          
			          <cfset iGroupCount++>
			        </cfloop>
			            
		        </cfif>
		        )
				<cfif Len(frmMarker) GT 0>
				#frmHowToUseMarker#
				(
	              om.IF_CODE IN (<cfqueryparam value="#frmMarker#" cfsqltype="cf_sql_varchar" list="true">)
				)
	            </cfif>
            )        
		  	</cfif>
            <cfif Len(frmMarker) GT 0>
			AND    O.CRIME_REF=om.CRIME_REF(+)
			</cfif>			            
	        <cfif dateType IS "DATE_CREATED">
	        AND    CREATED_DATE BETWEEN TO_DATE('#arguments.fromDate#','DD/MM/YYYY HH24:MI')
	                                AND TO_DATE('#arguments.toDate#','DD/MM/YYYY HH24:MI')
	        <cfelseif dateType IS "DATE_OFFENCE">
	        AND    ((O.FIRST_COMMITTED <= TO_DATE('#toDate#','DD/MM/YYYY HH24:MI') AND
					 O.LAST_COMMITTED >= TO_DATE('#fromDate#','DD/MM/YYYY HH24:MI'))
				   OR (O.FIRST_COMMITTED BETWEEN TO_DATE('#fromDate#','DD/MM/YYYY HH24:MI') AND TO_DATE('#toDate#','DD/MM/YYYY HH24:MI')))
	
	        </cfif>
	        AND    (o.PREMISE_KEY=addr.PREMISE_KEY AND o.POST_CODE=addr.POST_CODE)            
	        <cfif areaIsList>
	            <cfif areaListIsSector>
	             AND SUBSTR(ORG_CODE,3,#sectorLen#) IN (<cfqueryparam value="#arguments.area#" cfsqltype="cf_sql_varchar" list="true">)            
	            <cfelseif areaListIsSNT>
				 AND o.LPA IN (<cfqueryparam value="#arguments.area#" cfsqltype="cf_sql_varchar" list="true">)	
				<cfelse>
	             AND BEAT_CODE IN (<cfqueryparam value="#arguments.area#" cfsqltype="cf_sql_varchar" list="true">)
	            </cfif>
	        <cfelse>
		        <cfif Len(arguments.area) GT 0>                                        
                  <cfif Len(arguments.area) LTE 2>
		            AND    (ORG_CODE LIKE '22#arguments.area#%' OR ORG_CODE LIKE '23#arguments.area#%')
                  <cfelseif Len(arguments.area) IS 4>
		            AND    BEAT_CODE    = '#arguments.area#'
				  <cfelseif Len(arguments.area) IS 3 or Len(arguments.area) IS 5>
					AND    o.LPA    = '#arguments.area#'				  	  	                  
                  </cfif>
		        </cfif>        
	        </cfif>            	        
	        <cfif arguments.sort IS "DATE_CREATED_ASC">
	        ORDER BY CREATED_DATE ASC
	        <cfelseif  arguments.sort IS "DATE_CREATED_DESC">
	        ORDER BY CREATED_DATE DESC
	        <cfelseif  arguments.sort IS "DATE_OFFENCE_ASC">
	        ORDER BY FIRST_COMMITTED ASC        
	        <cfelseif  arguments.sort IS "DATE_OFFENCE_DESC">
	        ORDER BY FIRST_COMMITTED DESC               
	        <cfelseif  arguments.sort IS "OFFENCE">
	        ORDER BY REC_TITLE
	        <cfelseif  arguments.sort IS "BEAT">                                
	        ORDER BY BEAT_CODE
			<cfelseif arguments.sort IS "SNT">
			ORDER BY o.LPA
	        </cfif>
			</cfquery>
	     
	     <cfif qSearch.recordCount GT 0>
		     <cfquery name="qMo" datasource="#variables.warehousedsn#">
			 	 SELECT CRIME_REF,NOTEPAD
				 FROM   BROWSER_OWNER.OFFENCE_NOTES MO
				 WHERE  CRIME_REF IN (<cfqueryparam value="#ValueList(qSearch.CRIME_REF)#" list="true" cfsqltype="cf_sql_numeric">) 
				 AND    NOTE_TYPE_DESC='MO SUMMARY'
			 </cfquery>         
			 
			 <cfquery name="qJoined" dbtype="query">
			 	 SELECT qSearch.*, qMo.NOTEPAD AS MO
				 FROM   qSearch, qMo
				 WHERE  qSearch.CRIME_REF=qMo.CRIME_REF
		        <cfif arguments.sort IS "DATE_CREATED_ASC">
		        ORDER BY CREATED_DATE ASC
		        <cfelseif  arguments.sort IS "DATE_CREATED_DESC">
		        ORDER BY CREATED_DATE DESC
		        <cfelseif  arguments.sort IS "DATE_OFFENCE_ASC">
		        ORDER BY FIRST_COMMITTED ASC        
		        <cfelseif  arguments.sort IS "DATE_OFFENCE_DESC">
		        ORDER BY FIRST_COMMITTED DESC               
		        <cfelseif  arguments.sort IS "OFFENCE">
		        ORDER BY REC_TITLE
		        <cfelseif  arguments.sort IS "BEAT">                                
		        ORDER BY BEAT_CODE
				<cfelseif  arguments.sort IS "SNT">                                
		        ORDER BY LPA
		        </cfif>				 
			 </cfquery>
		 <cfelse>
             <cfset qJoined=QueryNew('X','Varchar')>		 	 
		 </cfif>
		 	              
	     <cfreturn qJoined>
	     
	   </cffunction> 
	
	   <cffunction name="getOffenceMarkerList" output="false" access="public" returntype="query" hint="returns a query offence markers">
	     <cfset var qMarkers="">
	     
	     <!--- query to get a distinct list of used offence markers --->
			<cfquery NAME = "qMarkers" DATASOURCE="#variables.warehouseDSN#">
				select distinct IF_CODE, DESCRIPTION
				from browser_owner.offence_markers om
				order by description
			</cfquery>
	                
	     <cfreturn qMarkers>
	     
	   </cffunction> 
	
	   <cffunction name="getRolesForCrime" output="false" access="public" returntype="query" hint="returns a query of roles for a crime">
	   	 <cfargument name="crimeNo" type="string" required="true" hint="crimeNo to get roles for">  
	   	   
	     <cfset var qRoleInfo="">
	     
	     <!--- query to get a distinct list of used offence markers --->
			<cfquery NAME = "qRoleInfo" DATASOURCE="#variables.warehouseDSN#">
				select role.*
				from   browser_owner.NOMINAL_ROLES role, browser_owner.OFFENCE_SEARCH off
				where  off.ORG_CODE  = <cfqueryparam value="#ListGetAt(arguments.crimeNo,1,"/")#" cfsqltype="cf_sql_varchar">
				and    off.SERIAL_NO = <cfqueryparam value="#ListGetAt(arguments.crimeNo,2,"/")#" cfsqltype="cf_sql_varchar">
				and    off.YEAR      = <cfqueryparam value="#Int(ListGetAt(arguments.crimeNo,3,"/"))#" cfsqltype="cf_sql_numeric">
				and    role.CRIME_REF=off.CRIME_REF
			</cfquery>
	                
	     <cfreturn qRoleInfo>
	     
	   </cffunction>
	
	</cfcomponent>