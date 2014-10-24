<cfcomponent output="false">
       
  <cffunction name="getEnvironment" access="private" returntype="string" hint="returns env we are running on, eg. LIVE, DEV, TEST">
  	<cfset var env="">
	    
	<cfif SERVER_NAME IS "genie.intranet.wmcpolice"  OR SERVER_NAME IS "genie2.intranet.wmcpolice" OR SERVER_NAME IS "genie3.intranet.wmcpolice"
	   OR SERVER_NAME IS "SVR20424" OR SERVER_NAME IS "SVR20306" 
	   OR SERVER_NAME IS "SVR20623" OR SERVER_NAME IS "SVR20624">
	     <cfset env="LIVE">	  
	   <cfelseif SERVER_NAME IS "geniedev.intranet.wmcpolice" OR SERVER_NAME IS "SVR20312">
	     <cfset env="DEV">	 	  
	   <cfelseif SERVER_NAME IS "genietest.intranet.wmcpolice">
	      <cfset env="TEST">	  	 
	   <cfelseif SERVER_NAME is "genietrain.intranet.wmcpolice"> 
		  <cfset env="TRAIN">      	  
	   <cfelseif SERVER_NAME IS "genietrain31.intranet.wmcpolice">
		  <cfset env="TRAIN_TEST">	  
	   <cfelseif SERVER_NAME IS "svr20489">
		  <cfset env="COPY">	  
	   </cfif>  	  
  	  
  	  <cfreturn env>
  	  
  </cffunction>       
       
  <cffunction name="updateFavouriteNominals" access="remote" returntype="void" output="false" hint="changes the value of the SHOW_UPDATES field, needs nominal_ref, userId and value Y or N">        
        <cfargument name="nominalRef" required="true" type="string" hint="nominalRef to change updates value of">
        <cfargument name="userId" required="true" type="string" hint="userId to chnage updates value for">
		<cfargument name="showUpdates" required="true" type="string" hint="value to change SHOW_UPDATES to Y or N">        
		<cfargument name="dsn" required="true" type="string" hint="dsn of the database to update">		

        <cfset var qUpdate="">
           	                    
        <!--- do the update query --->
        <cfquery name='qUpdate' datasource='#arguments.DSN#'>
        UPDATE   BROWSER_OWNER.USER_NOMINALS
        SET      SHOW_UPDATES=<cfqueryparam value="#arguments.showUpdates#" cfsqltype="cf_sql_varchar">                 
        WHERE    USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
        AND      NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
        </cfquery>

   	    <cflog file="genie" type="information" text="Update favourite nominals update setting: user #arguments.userId# set updates for #arguments.nominalRef# to #arguments.showUpdates#">        
             
    </cffunction> 

  <cffunction name="updateFavouriteNotes" access="remote" returntype="void" output="false" hint="changes the value of the USER_NOTES field, needs nominal_ref, userId and text for notes">        
        <cfargument name="nominalRef" required="true" type="string" hint="nominalRef to change updates value of">
        <cfargument name="userId" required="true" type="string" hint="userId to chnage updates value for">
		<cfargument name="userNotes" required="true" type="string" hint="value to change USER_NOTES to">        
		<cfargument name="dsn" required="true" type="string" hint="dsn of the database to update">		

        <cfset var qUpdate="">
           	                    
        <!--- do the update query --->
        <cfquery name='qUpdate' datasource='#arguments.DSN#'>
        UPDATE   BROWSER_OWNER.USER_NOMINALS
        SET      USER_NOTES=<cfqueryparam value="#arguments.userNotes#" cfsqltype="cf_sql_varchar">                 
        WHERE    USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
        AND      NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
        </cfquery>

   	    <cflog file="genie" type="information" text="Update favourite nominals notes for #arguments.nominalRef# have been updated">        
             
    </cffunction> 

  <cffunction name="deleteFavouriteNominal" access="remote" returntype="void" output="false" hint="deletes a nominal_ref for a userId">        
        <cfargument name="nominalRef" required="true" type="string" hint="nominalRef to delete">
        <cfargument name="userId" required="true" type="string" hint="userId to delete nominal for">
		<cfargument name="dsn" required="true" type="string" hint="dsn of the database to do the delete">		

        <cfset var qDelete="">
           	                    
        <!--- do the update query --->
        <cfquery name='qDelete' datasource='#arguments.DSN#'>
        DELETE   FROM  BROWSER_OWNER.USER_NOMINALS                      
        WHERE    USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
        AND      NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
        </cfquery>

   	    <cflog file="genie" type="information" text="Favourite nominals #arguments.nominalRef# has been deleted for #arguments.userId#">        
             
    </cffunction> 

  <cffunction name="getCrimeMO" access="remote" returntype="Any" output="false" hint="gets an MO for a given Crime No">        
        <cfargument name="crimeNo" required="true" type="string" hint="crime No to get mo for">                
		<cfargument name="dsn" required="true" type="string" hint="dsn of the database to get data from">
		<cfargument name="json" required="false" type="string" default="N" hint="should result be returned in JSON format">		

        <cfset var qCrimeMo="">
		<cfset var validCrime="">	
		<cfset var returnStruct=structNew()>	
		
		<cfset validCrime=checkValidCrime(arguments.crimeNo,arguments.DSN)>
		
		<!--- check if it's a valid crime no and it exists 1st --->
		<cfif validCrime.valid>
			 
		     <!--- crime valid and exists so go and get the mo --->
			 <cfquery name="qCrimeMo" datasource="#arguments.DSN#">
			 	 SELECT NOTEPAD
				 FROM   browser_owner.OFFENCE_NOTES offn
				 WHERE  CRIME_REF=<cfqueryparam value="#validCrime.crimeRef#" cfsqltype="cf_sql_numeric">
				 AND    NOTE_TYPE_CODE=<cfqueryparam value="PM" cfsqltype="cf_sql_varchar">
			 </cfquery>	 
			 
			 <cfif arguments.json IS "N">
			 	<cfreturn qCrimeMo.NOTEPAD>
			 <cfelse>
			 	<cfset returnStruct.crimeMO=qCrimeMo.NOTEPAD>
			 	<cfreturn serializeJSON(returnStruct)> 
			 </cfif>
			 
		<cfelse>
			 <cfif arguments.json IS "N">
			 	<cfreturn 'Invalid Crime No '&arguments.crimeNo&', not correct format or does not exist'>
			 <cfelse>
			    <cfreturn serializeJSON('Invalid Crime No '&arguments.crimeNo&', not correct format or does not exist')>
			 </cfif>
		</cfif>	
			
 
     
    </cffunction> 

  <cffunction name="getNominal" access="remote" returnformat="JSON" output="false" hint="gets a Nominal for a given Nominal Ref">        
        <cfargument name="nominalRef" required="true" type="string" hint="crime No to get mo for">                
		<cfargument name="dsn" required="true" type="string" hint="dsn of the database to get data from">		

        <cfset var qNominal="">						
        <cfset var nominalStruct=StructNew()>
		
		<cfset nominalStruct.validNominal=false>		
					 
		     <!--- get the nominal details --->
			 <cfquery name="qNominal" datasource="#arguments.DSN#">
			 	 SELECT ns.*,nd.*,REPLACE(REPLACE(LTRIM(
				                                    RTRIM(ND.TITLE)||' '||
											        RTRIM(NS.SURNAME_1)||DECODE(NS.SURNAME_2,NULL,'','-'||NS.SURNAME_2)||', '||
											        RTRIM(INITCAP(FORENAME_1))||' '||
											        RTRIM(INITCAP(FORENAME_2))),' ,',','),'  ' ,' ')
											    || DECODE(FAMILIAR_NAME,'','', ' (Nick ' || FAMILIAR_NAME || ')')
												|| DECODE(MAIDEN_NAME,NULL,'',' (Nee ' || MAIDEN_NAME || ')') AS FULL_NAME
				 FROM   browser_owner.NOMINAL_SEARCH ns, browser_owner.NOMINAL_DETAILS nd
				 WHERE  ns.NOMINAL_REF=<cfqueryparam value="#UCASE(arguments.nominalRef)#" cfsqltype="cf_sql_varchar">
				 AND    ns.NOMINAL_REF=nd.NOMINAL_REF
			 </cfquery>	 
			 
			 <cfif qNominal.recordCount GT 0>
			 	 <cfset nominalStruct.validNominal=true>
				 <cfset nominalStruct.NOMINAL_REF=qNominal.NOMINAL_REF>
				 <cfset nominalStruct.NAME_TYPE=qNominal.NAME_TYPE>
				 <cfset nominalStruct.FULL_NAME=qNominal.FULL_NAME>
				 <cfset nominalStruct.PNC_ID=qNominal.PNCID_NO>
				 <cfset nominalStruct.CRO=qNominal.CRO>
				 <cfset nominalStruct.DOB=DateFormat(qNominal.DATE_OF_BIRTH,"DD/MM/YYYY")>
				 <cfset nominalStruct.ETHNICITY_16=qNominal.ETHNICITY_16>
				 <cfset nominalStruct.ETHNICITY_6=qNominal.ETHNICITY_6>      
			 </cfif>
			 
			 <cfreturn serializeJSON(nominalStruct)>			  
     
    </cffunction> 

  <cffunction name="checkValidCrime" access="public" returntype="struct" hint="returns a struct with validity of no and crime ref if valid">
		<cfargument name="crimeNo" type="string" required="true">
		<cfargument name="dsn" required="true" type="string" hint="dsn of the database to get data from">
        
		<cfset var return=StructNew()>
		<cfset var regExpList="22[A-Z][A-Z]/[0-9][0-9]*[A-Z]/[0-9][0-9]">
		<cfset var found="">
		<cfset var rExp="">
		<cfset var orgCode="">
		<cfset var serialNo="">
		<cfset var cYear="">
		<cfset var qIsValid="">
		
		<cfset return.valid=false>
		<cfset return.crimeRef="">
		
		    <!--- check the crime no is valid format --->
			<cfloop list="#regExpList#" index="rExp" delimiters="|">
			     <cfset found=REFindNoCase(rExp,arguments.crimeNo,0,false)>
			     <cfif found GT 0>
			       <cfset return.valid=true>
  			       <cfbreak>			       
			     </cfif>
			</cfloop>
			
			<!--- check the crime no exists --->
			<cfif return.valid>
				<cfset orgCode=ListGetAt(arguments.crimeNo,1,"/")>
				<cfset serialNo=ListGetAt(arguments.crimeNo,2,"/")>
				<cfset cYear=ListGetAt(arguments.crimeNo,3,"/")>
				
				<cfquery name='qIsValid' datasource='#arguments.DSN#'>
		        SELECT   CRIME_REF
		        FROM     BROWSER_OWNER.OFFENCE_SEARCH
		        WHERE    ORG_CODE=<cfqueryparam value="#orgCode#" cfsqltype="cf_sql_varchar">
		        AND      SERIAL_NO=<cfqueryparam value="#serialNo#" cfsqltype="cf_sql_varchar">
		        AND      YEAR=<cfqueryparam value="#cYear#" cfsqltype="cf_sql_integer">
		        </cfquery>
		        
		        <cfif qIsValid.recordCount IS 1>
				    <cfset return.value=true>
					<cfset return.crimeRef=qIsValid.CRIME_REF>
				<cfelse>
					<cfset return.valid=false>	
				</cfif>
				
			</cfif>
				
		<cfreturn return>
		
	</cffunction>

  <cffunction name="submitOfficerCheck" access="remote" returntype="string" hint="updates the stop search database with the fact that an officer has asked for a check, but not for stop search">
		<cfargument name="crimesDSN" required="true" type="string" hint="crimes database dsn">
		<cfargument name="dsn" required="true" type="string" hint="warehouse dsn">
		<cfargument name="opUserId" required="true" type="string" hint="userId of operator doing check">
		<cfargument name="opBadge" required="true" type="string" hint="collar of operator doing check">
		<cfargument name="auditText" required="true" type="string" hint="auditText for officer collar and location">
		<cfargument name="nominalRef" required="true" type="string" hint="nominalRef of person being checked">

        <cfset var hrService=createObject('component','applications.cfc.hr_oo.hrService').init(dsn=arguments.dsn)>
		<cfset var officerHRDetails="">
        <cfset var return="">
		<cfset var qAssignmentRef="">
		<cfset var qNominal="">
		<cfset var qXYcoords="">
		<cfset var qSSeq="">
		<cfset var qSSInsert="">
		<cfset var officerBadge="">
		<cfset var officerLocation="">
		<cfset var officerDivision="">
		<cfset var xyCoords="">
		<cfset var assignmentRef=chr(0)>
		<cfset var personId=chr(0)>
		<cfset var nominalName=chr(0)>
		<cfset var nominalDob=chr(0)>
		<cfset var nominalSex=chr(0)>
		<cfset var nominalEth=chr(0)>
		<cfset var nominalEAC=chr(0)>
		<cfset var SS_URN="">
		
		    <!--- **1 make sure the audit details are of correct format Officer Collar [SPACE] Officer Location --->
		    <cfif ListLen(arguments.auditText," ") GTE 2>
			   
			   <cfset officerBadge=ListGetAt(arguments.auditText,1," ")>
			   <cfset officerLocation=ListRest(arguments.auditText," ")>
			
				<!--- **2 make sure the officer badge is a number, if it's not then make unavailable --->
				<cfif isNumeric(officerBadge)>					
							
					<cfquery name="qAssignmentRef" datasource="#arguments.crimesDSN#">
						SELECT BAAS.ASSIGNMENT_REF, NOM.PERSONNEL_PERSON_ID, 
						       decode(forename_2,null,forename_1,forename_1||' '||forename_2)||' '||
			            	   decode(surname_2,null,surname_1,surname_1||'-'||surname_2) AS OFFICER_NAME
						FROM   BADGE_ASSIGNMENTS BAAS, NOMINALS NOM
						WHERE  BAAS.NOMINAL_REF = NOM.NOMINAL_REF
						AND    BAAS.END_DATE is null
						AND    BAAS.ORG_CODE_FORCE = '22'
						AND    BAAS.BADGE_NUMBER = ltrim(<cfqueryparam value="#officerBadge#" cfsqltype="cf_sql_varchar">)
					</cfquery>										
					
					<!--- **3 check that the assignment ref query has brought us a row back,
					      if it hasn't then the badge no is unknown --->					      
					<cfif qAssignmentRef.recordCount GT 0>

					    <!--- use the hr service to get the officers tpu --->
					    <cfset officerHRDetails=hrService.getUserByCollar(collar=officerBadge)>
						<cfset officerDivision=officerHRDetails.getDivision()>
	
						<cfset assignmentRef=qAssignmentRef.ASSIGNMENT_REF>
						<cfset personId=qAssignmentRef.PERSONNEL_PERSON_ID>
						
						<!--- get x/y coords for the officer --->
						<cfquery name="qXYcoords" datasource="#arguments.crimesDSN#">
							SELECT X||Y AS COORDS
							FROM   CRIME.APLS_STAFF_AVIS_HIST_VIEW
							WHERE  callsign = <cfqueryparam value="#officerBadge#" cfsqltype="cf_sql_varchar">
							AND    time_to = (SELECT max(time_to)
											  FROM   CRIME.APLS_STAFF_AVIS_HIST_VIEW
											  WHERE  callsign = <cfqueryparam value="#officerBadge#" cfsqltype="cf_sql_varchar">
											  AND    time_to >= sysdate -.021)
						</cfquery>				
						
						<cfif qXYcoords.recordCount GT 0>
							<cfset xyCoords=qXYcoords.COORDS>
						</cfif>
						
						<!--- get the nominal details from the ref passed in --->
					    <cfquery name="qNominal" datasource="#arguments.crimesDSN#">
						  SELECT REPLACE(REPLACE(LTRIM(
							                      RTRIM(NS.TITLE)||' '||
														        RTRIM(NS.SURNAME_1)||DECODE(NS.SURNAME_2,NULL,'','-'||NS.SURNAME_2)||', '||
														        RTRIM(INITCAP(FORENAME_1))||' '||
														        RTRIM(INITCAP(FORENAME_2))),' ,',','),'  ' ,' ') AS FULL_NAME,
						       DATE_OF_BIRTH, ETHNICITY, EA_CODE, SEX
						  FROM   crime.NOMINALS ns
					   	  WHERE  ns.NOMINAL_REF = <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
					    </cfquery>		
					    
					    <cfset nominalName=qNominal.FULL_NAME>
						<cfset nominalDob=qNominal.DATE_OF_BIRTH>
						<cfset nominalEAC=qNominal.EA_CODE>
						<cfset nominalEth=qNominal.ETHNICITY>
						<cfset nominalSex=qNominal.SEX>
					    
					    <!--- get the next seq no for the Stop Search Table --->
						<cfquery name="qSSeq" datasource="#arguments.crimesDSN#">	
							SELECT CRIME.SEQ_STOP_SEARCH.NEXTVAL AS NEXT_SEQ
							FROM   SYS.DUAL			
						</cfquery>
						
						<cfset SS_URN=qSSeq.NEXT_SEQ>
						
						<cfquery name="qSSInsert" datasource="#arguments.crimesDSN#">
							INSERT INTO crime.STOP_SEARCH
							(SS_URN,
							 DATE_CREATED,
							 CREATED_BY,
							 ASSIGNMENT_REF_OC,
							 PERSON_ID_OC,
							 FORCE_CODE_OC,
							 NOMINAL_REF,
							 SUBJECT_NAME,
							 DOB,
							 ETHNICITY,
							 SS_LOCATION,
							 TPU,
							 SS_DATE,
							 SS_MAP_REF,
							 EA_CODE,
							 SEX,
							 SS_TYPE)
							VALUES
							(<cfqueryparam value="#SS_URN#" cfsqltype="cf_sql_varchar">, 
							 <cfqueryparam value="#CreateODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">,
							 <cfqueryparam value="#arguments.opUserId#" cfsqltype="cf_sql_varchar">,
							 <cfqueryparam value="#assignmentRef#" cfsqltype="cf_sql_varchar">, 
							 <cfqueryparam value="#personId#" cfsqltype="cf_sql_varchar">,
							 <cfqueryparam value="22" cfsqltype="cf_sql_varchar">,
							 <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">, 
							 <cfqueryparam value="#nominalName#" cfsqltype="cf_sql_varchar">,
							 <cfqueryparam value="#nominalDOB#" cfsqltype="cf_sql_timestamp" null="#Iif(len(nominalDOB) IS 0,de(true),de(false))#">, 
							 <cfqueryparam value="#nominalEth#" cfsqltype="cf_sql_varchar">, 
							 <cfqueryparam value="#officerLocation#" cfsqltype="cf_sql_varchar">, 
							 <cfqueryparam value="#officerDivision#" cfsqltype="cf_sql_varchar">, 
							 <cfqueryparam value="#CreateODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">, 
							 <cfqueryparam value="#xyCoords#" cfsqltype="cf_sql_varchar">,
							 <cfqueryparam value="#nominalEAC#" cfsqltype="cf_sql_varchar">, 
							 <cfqueryparam value="#nominalSex#" cfsqltype="cf_sql_varchar">, 
							 <cfqueryparam value="GC" cfsqltype="cf_sql_varchar">)				
						</cfquery>
						
						<cfset return="Officer Check Recored Ref: "&ss_urn>
	
					<cfelse>
						
						<cfset return="Collar no entered in audit details does not exist">
					</cfif>	<!--- **3 end --->				  		     	

			<cfelse>
			  <cfset return="Audit details Officer Collar No is not correct">
			</cfif>	<!--- **2 end --->
		  	
		<cfelse>
		     <cfset return="Audit details not of format Officer Collar [Space] Location">
		</cfif>	<!--- **1 end --->	
        				
		<cfreturn return>
		
	</cffunction>

  <cffunction name="getTickerInfo" access="remote" returntype="any" output="false" hint="gets ois incidents by initial type">                                
		<cfargument name="dsn" required="true" type="string" hint="dsn of the database to get data from">		
		<cfargument name="tpu" type="string" required="false" default="" hint="tpu to filter on">
	    <cfargument name="initType" type="string" required="false" default="" hint="init type for incidents in the ticker">
		<cfargument name="homcCodes" type="string" required="false" default="" hint="homc crime codes for the crimes in the ticker">
		<cfargument name="arrestType" type="string" required="false" default="" hint="arrest type for custodies in the ticker">
	    <cfargument name="startDate" type="string" required="false" default="#DateFormat(DateAdd("n","-60",now()),"DD-MMM-YYYY")# #TimeFormat(DateAdd("n","-60",now()),"HH:mm:ss")#" hint="start date in DD-MMM-YYYY HH24:MI:SS format, default last 60 minutes">
	    <cfargument name="endDate" type="string" required="false" default="#DateFormat(now(),"DD-MMM-YYYY")# #TimeFormat(now(),"HH:mm:ss")#" hint="end date in DD-MMM-YYYY HH24:MI:SS format, default last 30 minutes">   	
	      
	   <cfset var qTicker="">
	      
	   <cfquery name="qTicker" datasource="#arguments.dsn#">
			SELECT OIS.CALL_DATE AS TICKER_DATE, OIS.OIS_GLOBAL_URN AS URN, 
			       'Incident - ' || TO_CHAR(OIS.CALL_DATE,'DD/MM HH24:MI') || ', Grade:'|| OIS.GRADE ||', Type:'||OIS.RESULT_INIT||', Location:'||OIS.LOCATION AS DETAILS, 
			       'OIS' AS REDIRECT_TYPE, ((sysdate - OIS.CALL_DATE) * 24 * 60) AS MIN_DIFF
			FROM   browser_owner.INC_HTML_LISTS ois
			WHERE  OIS.CALL_DATE BETWEEN TO_DATE(<cfqueryparam value="#arguments.startDate#" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')
			                         AND TO_DATE(<cfqueryparam value="#arguments.endDate#" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')
			<cfif  Len(arguments.initType) GT 0>						 									                           			                          
			AND    OIS.RESULT_INIT IN (<cfqueryparam value="#arguments.initType#" cfsqltype="cf_sql_varchar" list="true">)
			</cfif>
			<cfif  Len(arguments.tpu) GT 0>
			AND    SUBSTR(OIS.PARISH,1,1)=<cfqueryparam value="#arguments.tpu#" cfsqltype="cf_sql_varchar">
			</cfif>				
			UNION
		    SELECT OS.CREATED_DATE AS TICKER_DATE, os.ORG_CODE || '/' || os.SERIAL_NO ||'/' || DECODE(LENGTH(os.YEAR),1, '0' || os.YEAR, os.YEAR) AS URN,
		     os.REP_TITLE||', Date:'||DECODE(os.LAST_COMMITTED,'', TO_CHAR(os.FIRST_COMMITTED,'DD/MM/YYYY HH24:MI'),
             TO_CHAR(os.FIRST_COMMITTED,'DD/MM/YYYY HH24:MI') || ' and ' ||    TO_CHAR(os.LAST_COMMITTED,'DD/MM/YYYY HH24:MI'))||', Address:'||
			 DECODE(PART_ID,'','',PART_ID||', ')||
						DECODE(BUILDING_NAME,'','',BUILDING_NAME||', ')||
						DECODE(BUILDING_NUMBER,'','',BUILDING_NUMBER||' ')||
						DECODE(STREET_1,'','',STREET_1||', ')||
						DECODE(LOCALITY,'','',LOCALITY||', ')||
						DECODE(TOWN,'','',TOWN||', ')||
						DECODE(COUNTY,'','',COUNTY||' ')||
						DECODE(ge.POST_CODE,'','',ge.POST_CODE) AS DETAILS,
			'CRIME' AS REDIRECT_TYPE,((sysdate - OS.CREATED_DATE) * 24 * 60) AS MIN_DIFF
			FROM browser_owner.OFFENCE_SEARCH os, browser_owner.GE_ADDRESSES ge
			WHERE (1=1)
			<cfif Len(arguments.homcCodes) GT 0>
			AND REC_HOMC_CODE IN (<cfqueryparam value="#arguments.homcCodes#" cfsqltype="cf_sql_varchar" list="true">)
			</cfif>			
			AND OS.CREATED_DATE BETWEEN TO_DATE(<cfqueryparam value="#arguments.startDate#" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')
			                        AND TO_DATE(<cfqueryparam value="#arguments.endDate#" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')
			AND OS.VALIDATION_STATUS IN (0,1,2)
			<cfif Len(arguments.tpu) GT 0>
			AND SUBSTR(OS.ORG_CODE,3,1)=<cfqueryparam value="#arguments.tpu#" cfsqltype="cf_sql_varchar">	
			</cfif>
			AND (os.POST_CODE=ge.POST_CODE AND os.PREMISE_KEY=ge.PREMISE_KEY)
			UNION
			SELECT DISTINCT CS.ARREST_TIME, CS.CUSTODY_REF AS URN, STATION||' Arrest: '||			       
			        REPLACE(REPLACE(LTRIM(
				                      RTRIM(ND.TITLE)||' '||
											        RTRIM(NS.SURNAME_1)||DECODE(NS.SURNAME_2,NULL,'','-'||NS.SURNAME_2)||', '||
											        RTRIM(INITCAP(FORENAME_1))||' '||
											        RTRIM(INITCAP(FORENAME_2))),' ,',','),'  ' ,' ')
													    || DECODE(FAMILIAR_NAME,'','', ' (Nick ' || FAMILIAR_NAME || ')')
															|| DECODE(MAIDEN_NAME,NULL,'',' (Nee ' || MAIDEN_NAME || ')')||', DOB:'||
                    TO_CHAR(DATE_OF_BIRTH,'DD/MM/YYYY') AS DETAILS,
                    'CUSTODY' AS REDIRECT_TYPE,((sysdate - CS.ARREST_TIME) * 24 * 60) AS MIN_DIFF
			FROM   browser_owner.CUSTODY_SEARCH CS, BROWSER_OWNER.CUSTODY_REASONS cr, 
			       browser_owner.NOMINAL_SEARCH NS, browser_owner.NOMINAL_DETAILS nd
			WHERE  cs.CUSTODY_REF=cr.CUSTODY_REF
			AND    cs.NOMINAL_REF=ns.NOMINAL_REF
			AND    ns.NOMINAL_REF=nd.NOMINAL_REF
			<cfif  Len(arguments.TPU) GT 0>
			AND    SUBSTR(CS.CUSTODY_REF,3,1)=<cfqueryparam value="#arguments.tpu#" cfsqltype="cf_sql_varchar">
		    </cfif>
			AND    CS.ARREST_TIME BETWEEN TO_DATE(<cfqueryparam value="#arguments.startDate#" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')
			                          AND TO_DATE(<cfqueryparam value="#arguments.endDate#" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')
		    <cfif  Len(arguments.arrestType) GT 0>		    
			AND    CR.ARREST_REASON_TEXT LIKE <cfqueryparam value="%#Ucase(arguments.arrestType)#%" cfsqltype="cf_sql_varchar">
			</cfif>			  			
			ORDER BY 1 DESC   	   
	   </cfquery>	

	   <cfreturn serializeJSON(qTicker)>				
 
    </cffunction> 

  <cffunction name="updateSessionUser" access="remote" returntype="any" output="false" hint="gets ois incidents by initial type">
  	  <cfargument name="user" type="string" required="true">
	
	  <cflog file="genie" text="is there a session? #isDefined('session')#" type="information" >	
	  <cfset session.loggedInUser=user>	
	
	  <cfreturn "User changed to "&user>	
		
  </cffunction>
  
  <cffunction name="quickNominalSearch" access="remote" returntype="xml" output="false" hint="quick search for nominals forename, surname, dob and nominal ref only options">
  	  <cfargument name="user" type="string" required="true" hint="person requesting search">
	  <cfargument name="dsn" type="string" required="false" hint="datasource to search" default="wmercia_jdbc">	
	  <cfargument name="nominalForename" type="string" required="true" hint="nominal forename">
	  <cfargument name="nominalSurname" type="string" required="true" hint="nominal Surname">
	  <cfargument name="nominalDOB" type="string" required="true" hint="nominal DOB">
	  <cfargument name="nominalRef" type="string" required="true" hint="nominalRef">	   

      <cfset var returnXml='<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><NominalSearchResults xmlns="http://tempuri.org/"><resultCount>%resultCount%</resultCount><nominalResults>%nominalResults%</nominalResults></NominalSearchResults></soap:Body></soap:Envelope>'>
	  <cfset var nominalXml="<nominal><nominalRef>%nominalRef%</nominalRef><fullName><![CDATA[%fullName%]]></fullName><forename1>%forename1%</forename1><surname1>%surname1%</surname1><surname2>%surname2%</surname2><DOB>%DOB%</DOB><Address><![CDATA[%Address%]]></Address><Warnings><![CDATA[%Warnings%]]></Warnings><postTown>%postTown%</postTown><placeOfBirth>%placeOfBirth%</placeOfBirth><photoUrl><![CDATA[%photoUrl%]]></photoUrl><photoDate><![CDATA[%photoDate%]]></photoDate><nameType>%nameType%</nameType></nominal>">
	  <cfset var searchFields = ArrayNew(1)>
  	  <cfset var keyPair = StructNew()>	
	  <cfset var westMerResults = "">
 	  <cfset var sDob = "">
	  <cfset var sDobPart = "">  
	  <cfset var nominalXmlResults="">
	  <cfset var thisNominal=""> 	
	  <cfset var genieService=createObject("component","genieObj.genieService").init()>
	  <cfset var iNomCount=0>
	  
	  <cflog file="genie" text="322 quick genie search, Forename: #arguments.nominalForename#; Surname: #arguments.nominalSurname#; DOB: #arguments.nominalDOB#; Ref: #arguments.nominalRef# by #arguments.user#" type="information" />	
	
      <!--- setup the search structure --->	
		
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_NOMINAL_REF">
		<cfset keyPair.value = UCase(arguments.nominalRef)>
		<cfset searchFields[1] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_PNC">
		<cfset keyPair.value = ''>
		<cfset searchFields[2] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_SURNAME_1">
		<cfset keyPair.value = UCase(arguments.nominalSurname)>
		<cfset searchFields[3] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_SURNAME_2">
		<cfset keyPair.value = ''>
		<cfset searchFields[4] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_FORENAME_1">
		<cfset keyPair.value = UCase(arguments.nominalForename)>
		<cfset searchFields[5] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_FORENAME_2">
		<cfset keyPair.value = ''>
		<cfset searchFields[6] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_MAIDEN">
		<cfset keyPair.value = ''>
		<cfset searchFields[7] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_FAMILIAR">
		<cfset keyPair.value = ''>
		<cfset searchFields[8] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_FUZZY">
		<cfset keyPair.value = 'N'>
		<cfset searchFields[9] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_SEX">
		<cfset keyPair.value = ''>
		<cfset searchFields[10] = keyPair>
	
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_DOB_PART">
		<cfset keyPair.value = ''>
		<cfset searchFields[11] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_DOB">
		<cfset keyPair.value = arguments.nominalDOB>
		<cfset searchFields[12] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_AGE_1">
		<cfset keyPair.value = ''>
		<cfset searchFields[13] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_AGE_2">
		<cfset keyPair.value = ''>
		<cfset searchFields[14] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_CRO">
		<cfset keyPair.value = ''>
		<cfset searchFields[15] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_POB">
		<cfset keyPair.value = ''>
		<cfset searchFields[16] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_TOWN">
		<cfset keyPair.value = ''>
		<cfset searchFields[17] = keyPair>
	
		<cfset keyPair = StructNew()>
		<cfset keyPair.key = "P_EXACT">
		<cfset keyPair.value = 'N'>
		<cfset searchFields[18] = keyPair>
	
		<cfset westMerResults = genieService.doWestMerciaPersonSearch(searchTerms=searchFields, 
		                                                                          pasteReq='Y',
																				  auditReq='N')>     
	    
	    <!--- only get the nominals that are a primary name type 
		<cfquery name="qNameTypeP" dbtype="query">
			SELECT *
			FROM   westMerResults.queryResult
			WHERE  NAME_TYPE='P' 
		</cfquery>	--->
	    	    
	    <cfloop query="westMerResults.queryResult">
		  <cfif NAME_TYPE IS "P">			  	
			<cfset thisNominal=duplicate(nominalXml)>
			<cfset thisNominal=Replace(thisNominal,'%nominalRef%',NOMINAL_REF)>
			<cfset thisNominal=Replace(thisNominal,'%forename1%',FORENAME_1)>				
			<cfset thisNominal=Replace(thisNominal,'%surname1%',SURNAME_1)>	
			<cfset thisNominal=Replace(thisNominal,'%surname2%',SURNAME_2)>	
			<cfset thisNominal=Replace(thisNominal,'%fullName%',NAME)>	
			<cfset thisNominal=Replace(thisNominal,'%DOB%',DOB)>
			<cfset thisNominal=Replace(thisNominal,'%Address%',ADDRESS)>
			<cfset thisNominal=Replace(thisNominal,'%Warnings%',WARNINGS)>
			<cfset thisNominal=Replace(thisNominal,'%postTown%',POST_TOWN)>
			<cfset thisNominal=Replace(thisNominal,'%placeOfBirth%',PLACE_OF_BIRTH)>
			<cfset thisNominal=Replace(thisNominal,'%photoUrl%',PHOTO_URL)>
			<cfset thisNominal=Replace(thisNominal,'%photoDate%',PHOTO_DATE)>
			<cfset thisNominal=Replace(thisNominal,'%nameType%',NAME_TYPE)>								
			<cfset nominalXmlResults &= thisNominal>
			<cfset iNomCount++>
		  </cfif>	
		</cfloop>
	    
	    <cfset returnXml=Replace(returnXml,'%resultCount%',iNomCount)>
		<cfset returnXml=Replace(returnXml,'%nominalResults%',nominalXmlResults)>
		
	
	  <cfreturn returnXml>	
		
  </cffunction> 

  <cffunction name="getMergeList" access="remote" returntype="xml" output="false" hint="gets an xml list of nominal merges requested">
  	  <cfargument name="requestBy" type="string" required="true" hint="person requesting merge">
	  <cfargument name="actionBy" type="string" required="true" hint="person actioning merge">
	  <cfargument name="filterYear" type="string" required="true" hint="year to filter on">	
	  <cfargument name="nominalRef" type="string" required="true" hint="nominalref of merge">
	  <cfargument name="mergeId" type="string" required="true" hint="mergeId of merge">  
	  <cfargument name="dateFrom" type="string" required="true" hint="request from date dd/mm/yyyy">
	  <cfargument name="dateTo" type="string" required="true" hint="request to date dd/mm/yyyy">  	 
	  <cfargument name="actioned" type="string" required="true" hint="has the merge been actioned Y or N">	    
	  <cfargument name="dsn" type="string" required="false" hint="datasource to search" default="wmercia_jdbc">	
	  
	  <cfset var returnXml='<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><MergeResults xmlns="http://tempuri.org/"><resultCount>%resultCount%</resultCount><Merges>%nominalMerges%</Merges></MergeResults></soap:Body></soap:Envelope>'>
	  <cfset var mergeXml="<Merge><mergeId>%mergeId%</mergeId><nominalRef>%nominalRef%</nominalRef><fullName><![CDATA[%fullName%]]></fullName><DOB>%DOB%</DOB><requestBy><![CDATA[%requestBy%]]></requestBy><requestDate>%requestDate%</requestDate><actionResult>%actionResult%</actionResult><actionBy>%actionBy%</actionBy><nameType>%nameType%</nameType></Merge>">
	  <cfset var qMergeList = "">
	  <cfset var mergeXmlResults="">
	  <cfset var thisMerge="">	  	    
	  <cfset var theEnv=getEnvironment()>
	    
	  <cfif theEnv IS "LIVE">
	  	 <cfset arguments.dsn="wmercia_jdbc">
	  <cfelseif theEnv IS "DEV">
	  	 <cfset arguments.dsn="waredev">
	  <cfelseif theEnv IS "COPY">
	  	 <cfset arguments.dsn="warecopy">
	  <cfelseif theEnv IS "TEST">
	  	 <cfset arguments.dsn="waredev">
	  </cfif> 	    
	  
	  <cflog file="genie" type="information" text="genieProxy getMergeList env=#theEnv# dsn=#arguments.dsn#" >
	    
	  <cfquery name="qMergeList" datasource="#arguments.DSN#">
		SELECT ml.*, nl.NOMINAL_REF, nl.NOMINAL_NAME, nl.NOMINAL_DOB, nl.NOMINAL_PNCID, nl.NOMINAL_CRO, nl.NOMINAL_NT
		FROM   browser_owner.NOMINAL_MERGE_LIST ml, browser_owner.NOMINALS_TO_MERGE nl
		WHERE  ml.MERGE_ID=nl.MERGE_ID
		AND    nl.CORRECT_NOMINAL='Y'
		<cfif Len(actioned) GT 0>
		AND    ml.ACTIONED=<cfqueryparam value="#actioned#" cfsqltype="cf_sql_varchar" />
		</cfif>
		<cfif Len(filterYear) GT 0>
		AND    TO_CHAR(ml.REQUEST_DATE,'YYYY')=<cfqueryparam value="#filterYear#" cfsqltype="cf_sql_varchar" />
		</cfif>
		<cfif Len(nominalRef) GT 0>
		AND ml.MERGE_ID IN (SELECT nl2.MERGE_ID
		                 FROM browser_owner.NOMINALS_TO_MERGE nl2
		                 WHERE nl2.NOMINAL_REF=<cfqueryparam value="#nominalRef#" cfsqltype="cf_sql_varchar" />)
		</cfif>
		<cfif Len(mergeId) GT 0>
		AND ml.MERGE_ID=<cfqueryparam value="#mergeId#" cfsqltype="cf_sql_varchar" />
		</cfif>
		<cfif Len(actionBy) GT 0>
		AND ml.ACTIONED_BY=<cfqueryparam value="#actionBy#" cfsqltype="cf_sql_varchar" />
		</cfif>
		<cfif Len(dateFrom) GT 0 AND Len(dateTo) IS 0>
		AND TRUNC(REQUEST_DATE)=TO_DATE('#dateFrom#','DD/MM/YYYY')	
		</cfif>
		<cfif Len(dateFrom) GT 0 AND Len(dateTo) GT 0>
		AND REQUEST_DATE BETWEEN TO_DATE('#dateFrom# 00:00:00','DD/MM/YYYY HH24:MI:SS')
		                     AND TO_DATE('#dateTo# 23:59:59','DD/MM/YYYY HH24:MI:SS')	
		</cfif>
		<cfif Len(requestBy) GT 0>
		AND REQUEST_BY = <cfqueryparam value="#requestBy#" cfsqltype="cf_sql_varchar" />	
		</cfif>
		ORDER BY ml.MERGE_ID
	  </cfquery>	  	  

	    <cfloop query="qMergeList">		  		  	
			<cfset thisMerge=duplicate(mergeXml)>
			<cfset thisMerge=Replace(thisMerge,'%nominalRef%',NOMINAL_REF)>
			<cfset thisMerge=Replace(thisMerge,'%mergeId%',MERGE_ID)>				
			<cfset thisMerge=Replace(thisMerge,'%fullName%',NOMINAL_NAME)>	
			<cfset thisMerge=Replace(thisMerge,'%DOB%',DateFormat(NOMINAL_DOB,"DD/MM/YYYY"))>
			<cfset thisMerge=Replace(thisMerge,'%nameType%',NOMINAL_NT)>
			<cfset thisMerge=Replace(thisMerge,'%requestBy%',REQUEST_BY_NAME)>
			<cfset thisMerge=Replace(thisMerge,'%requestDate%',DateFormat(REQUEST_DATE,"DD/MM/YY")&" "&TimeFormat(REQUEST_DATE,"HH:mm"))>
			<cfset thisMerge=Replace(thisMerge,'%actionResult%',ACTION_RESULT)>
			<cfset thisMerge=Replace(thisMerge,'%actionBy%',ACTIONED_BY_NAME)>											
			<cfset mergeXmlResults &= thisMerge>				  
		</cfloop>
	    
	    <cfset returnXml=Replace(returnXml,'%resultCount%',qMergeList.recordCount)>
		<cfset returnXml=Replace(returnXml,'%nominalMerges%',mergeXmlResults)>
		
	
	  <cfreturn returnXml>	    
	    
  </cffunction> 

  <cffunction name="getMergeCurrentAction" access="remote" returntype="xml" output="false" hint="gets an xml structure of the action data">
  	  <cfargument name="mergeId" type="numeric" required="true" hint="mergeId of merge">  
	  <cfargument name="dsn" type="string" required="false" hint="datasource to search" default="wmercia_jdbc">	
	  
	  <cfset var returnXml='<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><MergeAction xmlns="http://tempuri.org/"><mergeId>%mergeId%</mergeId><actionBy>%actionBy%</actionBy><actionByName>%actionByName%</actionByName><actionDate>%actionDate%</actionDate><actionResult>%actionResult%</actionResult></MergeAction></soap:Body></soap:Envelope>'>	  
	  <cfset var qMergeAction = "">	  	
	  <cfset var theEnv=getEnvironment()>
	    
	  <cfif theEnv IS "LIVE">
	  	 <cfset arguments.dsn="wmercia_jdbc">
	  <cfelseif theEnv IS "DEV">
	  	 <cfset arguments.dsn="waredev">
	  <cfelseif theEnv IS "COPY">
	  	 <cfset arguments.dsn="warecopy">
	  <cfelseif theEnv IS "TEST">
	  	 <cfset arguments.dsn="waredev">
	  </cfif> 	  	    
	    
	  <cfquery name="qMergeAction" datasource="#arguments.DSN#">
		SELECT ml.*
		FROM   browser_owner.NOMINAL_MERGE_LIST ml
		WHERE   ml.MERGE_ID=<cfqueryparam value="#mergeId#" cfsqltype="cf_sql_numeric" />		
	  </cfquery>	  	  

	  <cfset returnXml=Replace(returnXml,'%mergeId%',qMergeAction.MERGE_ID)>
	  <cfset returnXml=Replace(returnXml,'%actionBy%',qMergeAction.ACTIONED_BY)>
	  <cfset returnXml=Replace(returnXml,'%actionByName%',qMergeAction.ACTIONED_BY_NAME)>
	  <cfset returnXml=Replace(returnXml,'%actionDate%',DateFormat(qMergeAction.ACTIONED_DATE,"DD/MM/YYYY")&" "&TimeFormat(qMergeAction.ACTIONED_DATE,"HH:mm:ss"))>    
	  <cfset returnXml=Replace(returnXml,'%actionResult%',qMergeAction.ACTION_RESULT)>		
	
	  <cfreturn returnXml>	    
	    
  </cffunction>   

  <cffunction name="updateNotificationsRead" access="remote" returntype="void" output="false" hint="marks user nominal updates as being read">
  	  <cfargument name="userId" type="string" required="true" hint="userId of person dismissing the update">
	  <cfargument name="nominalRef" type="string" required="true" hint="nominalRef of item being dismissed">
	  <cfargument name="businessArea" type="string" required="true" hint="business area of item being dismissed">
	  <cfargument name="businessRef" type="string" required="true" hint="business ref of item being dismissed">	    
	  <cfargument name="dsn" type="string" required="false" hint="datasource to search" default="wmercia_jdbc">	
	  	  	  
	  <cfset var qInsertUserRead = "">	  	
	  <cfset var theEnv=getEnvironment()>
	    
	  <cfif theEnv IS "LIVE" or theEnv is "DEV_UAT">
	  	 <cfset arguments.dsn="wmercia_jdbc">
	  <cfelseif theEnv IS "DEV">
	  	 <cfset arguments.dsn="waredev">
	  <cfelseif theEnv IS "COPY">
	  	 <cfset arguments.dsn="warecopy">
	  <cfelseif theEnv IS "TEST">
	  	 <cfset arguments.dsn="waredev">
	  </cfif> 	  	    
	  
	  <cflog file="userUpdatesRead" type="information" text="#userId# has marked #nominalRef# #businessArea# #businessRef# as read on #dsn#" />
	  
	  <cfquery name="qInsertUserRead" datasource="#arguments.dsn#">
	  	INSERT INTO browser_owner.USER_UPDATE_READS
		(
			USER_ID,
			NOMINAL_REF,
			BUSINESS_AREA,
			BUS_REF,
			DATE_DISMISSED
		)
		VALUES
		(
			<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar" />,
			<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar" />,
			<cfqueryparam value="#arguments.businessArea#" cfsqltype="cf_sql_varchar" />,
			<cfqueryparam value="#arguments.businessRef#" cfsqltype="cf_sql_varchar" />,
			<cfqueryparam value="#CreateODBCDateTime(now())#" cfsqltype="cf_sql_timestamp" />
		)
	  </cfquery>	  	  	    
	    
  </cffunction>   

  <cffunction name="doWriteAjaxError" access="remote" returntype="void" output="false" hint="writes dams errors from ajax calls">
  	  <cfargument name="references" required="true" type="string">
	  <cfargument name="errorThrown" required="true" type="string">
  	  
  	  <cflog file="ajaxErrors" type="error" text="#references# ---- #errorThrown#">
  	  
  </cffunction>
  
</cfcomponent>