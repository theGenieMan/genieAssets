<cfcomponent output="false" name="genieUserService">
      
    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="false" default="wmercia_jdbc" type="String">
		<cfargument name="warehouseDSN2" required="false" default="wmercia_odbc" type="String">
		<cfargument name="defaultStylesheet" required="false" default="jquery-ui-1.10.4.custom.css" type="String">
		<cfargument name="defaultFont" required="false" default="Arial" type="String">
	    <cfargument name="defaultFontSize" required="false" default="10" type="String">
		<cfargument name="defaultDPATimeout" required="false" default="5" type="String">
        
        <cfset variables.version="1.1.0.0">    
		<cfset variables.dateServiceStarted=DateFormat(now(),"DDD DD-MMM-YYYY")&" "&TimeFormat(now(),"HH:mm:ss")>                                  
        
        <cfset variables.warehousedsn=arguments.warehousedsn>  
		<cfset variables.warehousedsn2=arguments.warehousedsn2>    
		<cfset variables.defaultStylesheet=arguments.defaultStylesheet>    
		<cfset variables.defaultFont=arguments.defaultFont>    
		<cfset variables.defaultFontSize=arguments.defaultFontSize>     
		<cfset variables.defaultDPATimeout=arguments.defaultDPATimeout>                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
        <cfreturn this />    
    </cffunction>  
        
    <cffunction name="getServiceVersion" access="remote" returntype="any" output="false" hint="I get the west mids photos">

     <cfreturn variables.version>
     
    </cffunction>      
	
    <cffunction name="getDateServiceStarted" access="remote" returntype="any" output="false" hint="I get the west mids photos">

     <cfreturn variables.dateServiceStarted>
     
    </cffunction> 	      
    
    <cffunction name="logUserIn" access="remote" returntype="any" output="false" hint="logs a user in">
        <cfargument name="userId" required="true" type="string" hint="userId to log in">
        <cfargument name="fullName" required="true" type="string" hint="full name of user to log in">        

        <cfset var qUserExists=''>
        <cfset var insUser=''>    	
        <cfset var updUser=''>
        <cfset var qLastLogin=''>                
        
        <!--- see if the user already has a row in the user logins table --->
        <cfquery name='qUserExists' datasource='#variables.warehouseDSN#'>
        SELECT 'Y' AS USER_EXISTS
        FROM   BROWSER_OWNER.USER_LOGINS
        WHERE  USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
        </cfquery> 
        
        <!--- if user exists then update the table, if not then insert a new record --->
        <cfif qUserExists.recordCount GT 0>            
          <cfquery name="updUser" datasource="#variables.warehouseDSN#">
           UPDATE BROWSER_OWNER.USER_LOGINS
           SET    THIS_LOGIN_DATE=<cfqueryparam value="#CreateODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">
           WHERE  USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
          </cfquery>
        <cfelse>                    
          <cfquery name="insUser" datasource="#variables.warehouseDSN#">
           INSERT INTO BROWSER_OWNER.USER_LOGINS
           (
             USER_ID,
             FULL_NAME,
             THIS_LOGIN_DATE
           )
           VALUES
           (
             <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">,
             <cfqueryparam value="#arguments.fullName#" cfsqltype="cf_sql_varchar">,
             <cfqueryparam value="#CreateODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">
           )
          </cfquery>        
        </cfif>

        <cfquery name='qLastLogin' datasource='#variables.warehouseDSN#'>
        SELECT TRUNC(NVL(LAST_LOGIN_DATE,SYSDATE-7)) AS LAST_LOGIN
        FROM   BROWSER_OWNER.USER_LOGINS
        WHERE  USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
        </cfquery>                
        
        <cfreturn qLastLogin.LAST_LOGIN>
     
    </cffunction>           
    
    <cffunction name="logUserOut" access="remote" returntype="void" output="false" hint="logs a user out">
        <cfargument name="userId" required="true" type="string" hint="userId to log out">
        <cfargument name="fullName" required="true" type="string" hint="full name to log out">        

        <cfset var qLogOut=''>           	      
                
        <!--- see if the user already has a row in the user logins table --->
        <cfquery name='qLogOut' datasource='#variables.warehouseDSN#'>
        UPDATE   BROWSER_OWNER.USER_LOGINS
        SET      SESSION_END_DATE=SYSDATE,
                 LAST_LOGIN_DATE=THIS_LOGIN_DATE,
                 THIS_LOGIN_DATE=NULL
        WHERE    USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
        AND      THIS_LOGIN_DATE IS NOT NULL
        </cfquery>   	        
             
    </cffunction>          

    <cffunction name="getLastAuditReason" access="remote" returntype="struct" output="false" hint="retreives the last audit reason a user has in case their session is swapped to another server">
        <cfargument name="userId" required="true" type="string" hint="userId to log out">               

        <cfset var qLastAuditReason=''>
		<cfset var structLastAudit=StructNew()>
        
   	    <cflog file="genie" type="information" text="Last Audit Reason Called For #arguments.userId#">        
                
        <!---  get all the audit reasons for the last 2 days (in case spanning midnight and pick the top row for the info --->
        <cfquery name='qLastAuditReason' datasource='#variables.warehouseDSN#'>
		SELECT *
  		FROM (	
			select request_timestamp, reason_text, request_for, reason, session_id, server, request_for_collar, request_for_force, ethnic_code
			from browser_owner.audit_data ad
			where AD.USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
			and trunc(request_timestamp) > trunc(sysdate-2)
			order by request_timestamp desc
			)
		WHERE rownum=1
        </cfquery>
        
		<cfif qLastAuditReason.recordCount IS 0>
			<!--- we can't find any audit reasons so we are going to return an invalid --->
			<cfset structLastAudit.valid=false>
			<cflog file="genie" type="information" text="Last Audit Reason For #arguments.userId# cannot be found">	
		<cfelse>
			<!--- we can find some records so use the top one for the info --->
			<cfset structLastAudit.valid=true>
			<cfset structLastAudit.reason=qLastAuditReason.reason>
			<cfset structLastAudit.reason_text=qLastAuditReason.reason_text>
			<cfset structLastAudit.request_for=qLastAuditReason.request_for>
			<cfset structLastAudit.sessionId=qLastAuditReason.session_Id>
			<cfset structLastAudit.server=qLastAuditReason.server>
			<cfset structLastAudit.ethnic_code=qLastAuditReason.ethnic_code>
			<cfset structLastAudit.audit_for_collar=qLastAuditReason.request_for_collar>
			<cfset structLastAudit.audit_for_force=qLastAuditReason.request_for_force>
			<cflog file="genie" type="information" text="Last Audit Reason For #arguments.userId#, Reason:#structLastAudit.reason#, Reason Text:#structLastAudit.reason_text#, Request For:#structLastAudit.reason#, Server=#structLastAudit.server# SessionId=#structLastAudit.sessionId#">
		</cfif>

		<cfreturn structLastAudit>
             
    </cffunction> 
    
    <cffunction name="getUserSettings" access="remote" returntype="struct" output="false" hint="retreives the user settings">
        <cfargument name="userId" required="true" type="string" hint="userId to get settings for">
		<cfargument name="userName" required="true" type="string" hint="userName to get settings for">               

        <cfset var qSettings=''>
		<cfset var structUserSettings=StructNew()>
                
        <!---  get user settings --->
        <cfquery name='qSettings' datasource='#variables.warehouseDSN#'>
			SELECT *
			FROM   browser_owner.USER_SETTINGS
			WHERE  USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar" >
        </cfquery>
        
        <!--- if no settings then create users settings and rerun the query to get them --->
		<cfif qSettings.recordCount IS 0>						
			<cfquery name='qSettings' datasource='#variables.warehouseDSN#'>
				INSERT INTO browser_owner.USER_SETTINGS
				(
					USER_ID,
					USER_NAME
				)
				VALUES
				(
					<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar">
				)
			</cfquery>
			
			<cfquery name='qSettings' datasource='#variables.warehouseDSN#'>
			SELECT *
			FROM   browser_owner.USER_SETTINGS
			WHERE  USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar" >
        	</cfquery>
				
		</cfif>
			
		<!--- has settings now either way so read them into struct --->
        <cfset structUserSettings.stylesheet=qSettings.STYLE_SHEET>
		<cfset structUserSettings.openNewWindow=qSettings.OPEN_NEW_WINDOW>
		<cfset structUserSettings.peType=qSettings.PERSON_SEARCH_TYPE>
		<cfset structUserSettings.font=qSettings.FONT>
		<cfset structUserSettings.fontSize=qSettings.FONT_SIZE>
		<cfset structUserSettings.collapse=qSettings.COLLAPSE_ON_SEARCH>
		<cfset structUserSettings.lastUpdate=qSettings.LAST_UPDATE>	
		
		<cfreturn structUserSettings>
             
    </cffunction>      
       
    <cffunction name="updateUserSettings" access="remote" returntype="void" output="false" hint="updates the user settings">
        <cfargument name="userId" required="true" type="string" hint="userId to update settings for">
		<cfargument name="userName" required="true" type="string" hint="userName to update settings for">               
		<cfargument name="font" required="true" type="string" hint="font style to use">
		<cfargument name="stylesheet" required="true" type="string" hint="stylesheet to use">
		<cfargument name="peType" required="true" type="string" hint="person enquiry search type default">
		<cfargument name="collapse" required="true" type="string" hint="should sections collapse on search">
		<cfargument name="fontSize" required="true" type="string" hint="font size for settings update">		

        <cfset var qSettings=''>
       
		<cfquery name='qSettings' datasource='#variables.warehouseDSN#'>
			UPDATE browser_owner.USER_SETTINGS
			SET    USER_NAME = <cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar">,
				   STYLE_SHEET = <cfqueryparam value="#arguments.stylesheet#" cfsqltype="cf_sql_varchar">,
				   PERSON_SEARCH_TYPE = <cfqueryparam value="#arguments.peType#" cfsqltype="cf_sql_varchar">,
				   FONT = <cfqueryparam value="#arguments.font#" cfsqltype="cf_sql_varchar">,
				   FONT_SIZE = <cfqueryparam value="#arguments.fontSize#" cfsqltype="cf_sql_varchar">,
				   COLLAPSE_ON_SEARCH = <cfqueryparam value="#arguments.collapse#" cfsqltype="cf_sql_varchar">,
				   LAST_UPDATE = SYSDATE
			WHERE  USER_ID = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar"> 				
		</cfquery>			
             
    </cffunction>         

    <cffunction name="resetSession" access="remote" returntype="void" output="false" hint="resets the user session variables">
       		
       		<cflog file="genie" type="information" text="resetSession has been called" />
       		<cfset onSessionStart()>
			<cflog file="genie" type="information" text="resetSession ended" />
             
    </cffunction> 

 	<cffunction name="getUserNominals" access="remote" returntype="any" output="false" hint="gets a list of nominals for a user">
        <cfargument name="userId" required="true" type="string" hint="userId to log in">
		
		<cfset var qNominals="">
		
		<cfquery name="qNominals" datasource="#variables.WarehouseDSN#">
		SELECT *
		FROM browser_owner.USER_NOMINALS
		WHERE USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
		ORDER BY DATE_ADDED DESC
		</cfquery>
		
		<cfreturn qNominals>
		
	 </cffunction>
	 
    <cffunction name="addUserFavourite" access="remote" returntype="string" returnFormat="plain" output="false" hint="adds a user favourite nominal">
   	  <cfargument name="userId" type="string" required="true" hint="person to add favourite for">
	  <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to add">
	  <cfargument name="showUpdates" type="string" required="true" hint="Y or N for updates required">
	  <cfargument name="notes" type="string" required="true" hint="any notes to add">  	  
	
	  <cfset var returnData="Added">
	  <cfset var qInsert="">
	    
	    <cfquery name="qInsert" datasource="#variables.WarehouseDSN2#"> 
		  INSERT INTO browser_owner.USER_NOMINALS
		  (
		  USER_ID,
		  NOMINAL_REF,
		  DATE_ADDED,
          SHOW_UPDATES,
          USER_NOTES
		  )
		  VALUES
		  (
		  <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">,
		  <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">,  
		  <cfqueryparam value="#CreateODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">,    
		  <cfqueryparam value="#arguments.showUpdates#" cfsqltype="cf_sql_varchar">,
		  <cfqueryparam value="#arguments.notes#" cfsqltype="cf_sql_varchar">                    
		  )
		 </cfquery>  
	    
	  <cfreturn returnData>  
	    
  </cffunction>  	 

  	<cffunction name="updateFavouriteNominals" access="remote" returntype="void" output="false" hint="changes the value of the USER_NOTES field, needs nominal_ref, userId and text for notes">        
        <cfargument name="nominalRef" required="true" type="string" hint="nominalRef to change updates value of">
        <cfargument name="userId" required="true" type="string" hint="userId to chnage updates value for">
		<cfargument name="showUpdates" required="true" type="string" hint="value to change SHOW_UPDATES to Y or N">
		<cfargument name="notes" required="true" type="string" hint="value to change USER_NOTES to">        
	
        <cfset var qUpdate="">
           	                    
        <!--- do the update query --->
        <cfquery name='qUpdate' datasource='#variables.warehouseDSN2#'>
        UPDATE   BROWSER_OWNER.USER_NOMINALS
        SET      USER_NOTES=<cfqueryparam value="#arguments.notes#" cfsqltype="cf_sql_varchar">,
		         SHOW_UPDATES=<cfqueryparam value="#arguments.showUpdates#" cfsqltype="cf_sql_varchar">                 
        WHERE    USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
        AND      NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
        </cfquery>
   	         
    </cffunction> 

  	<cffunction name="deleteFavouriteNominal" access="remote" returntype="void" output="false" hint="deletes a nominal_ref for a userId">        
        <cfargument name="nominalRef" required="true" type="string" hint="nominalRef to delete">
        <cfargument name="userId" required="true" type="string" hint="userId to delete nominal for">
	
        <cfset var qDelete="">
           	                    
        <!--- do the update query --->
        <cfquery name='qDelete' datasource='#variables.warehouseDSN2#'>
        DELETE   FROM  BROWSER_OWNER.USER_NOMINALS                      
        WHERE    USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
        AND      NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
        </cfquery>
             
    </cffunction> 
	
	<cffunction name="updateSession" access="remote" output="false" returntype="void">
		<cfargument name="requestFor" type="string" required="true" hint="update of request for field">
		<cfargument name="reasonCode" type="string" required="true" hint="update of request code field">
		<cfargument name="reasonText" type="string" required="true" hint="update of reason text field">
		<cfargument name="ethnicCode" type="string" required="false" default="" hint="update of ethnicity code">
		<cfargument name="requestForCollar" type="string" required="false" default="" hint="update of collar of person requesting">
		<cfargument name="requestForForce" type="string" required="false" default="" hint="update of Force of person requesting">
	 	
	 	<!---
	 	<cflog file="genie" type="information" text="updateSession (Service) called #session.urlToken#" >
	 	--->
		
		<!--- 
		<cfsavecontent variable="sessionDetails">
		<cfdump var="#session#" format="text" > 
		</cfsavecontent>
		
		<cflog file="genie" type="information" text="updateSession (Service) #sessionDetails#" >
		 
		<cfif isDefined('session.lastDPAUpdate')>
		<cflog file="genie" type="information" text="updateSession (Service) before = #session.lastDPAUpdate#,#session.audit_code#,#session.audit_for#,#session.audit_details#,#session.ethnic_code#,#session.audit_for_collar#,#session.audit_for_force#">
		</cfif>
		---> 
	 	<cflock timeout=20 scope="Session" type="Exclusive">
		 	<cfset session.lastDPAUpdate=now()>		
			<cfset session.audit_code=arguments.reasoncode>
			<cfset session.audit_for=arguments.requestFor>
			<cfset session.audit_details=arguments.reasonText>
			<cfset session.ethnic_code=arguments.ethnicCode>
			<cfset session.audit_for_collar=arguments.requestForCollar>
			<cfset session.audit_for_force=arguments.requestForForce>
		</cflock>
		
		<!---	 
		<cflog file="genie" type="information" text="updateSession (Service) after = #session.lastDPAUpdate#,#session.audit_code#,#session.audit_for#,#session.audit_details#,#session.ethnic_code#,#session.audit_for_collar#,#session.audit_for_force#">	
		--->
		
	</cffunction>       

    <cffunction name="getUserLogAccessLevel" access="public" returntype="string" output="false" hint="returns users log access level for intel logs based on user id">
     <cfargument name="userId" type="string" required="true" hint="userId to get log access level for">
                                                                              	     
     <cfset var logAccessLevel = 99>
     <cfset var qry_LogAccess="">
	  	 
	 <cftry>
        
		 <cfquery name="qry_LogAccess" datasource="#variables.WarehouseDSN#">
		 SELECT ACCESS_LEVEL
		 FROM  browser_owner.NOMINAL_DETAILS
		 WHERE  USER_ID=<cfqueryparam value="#UCase(arguments.userId)#" cfsqltype="cf_sql_varchar">
		 </cfquery>
		 		 
		 <cfif qry_LogAccess.RecordCount GT 0>
		  <cfif Len(qry_LogAccess.Access_level) GT 0>		  	  
		   <cfset logAccessLevel=qry_LogAccess.Access_Level>		      		  
		  </cfif>		 
		 </cfif>
		 	
		 <cfcatch type="database">
		  <cflog file="genieUserService" type="information" text="getUserLogAccess - #userId# - error caught - returning #logAccessLevel#" />	 
		  <cfreturn logAccessLevel>
		 </cfcatch>
	 </cftry>
	  
	 <cfreturn logAccessLevel> 	
     
    </cffunction> 

    <cffunction name="getUserRoleSettings" access="public" returntype="struct" output="false" hint="returns a struct of the users DPA retention and timeout settings">
     <cfargument name="role" type="string" required="true" hint="users organisational role">
                                                                              	     
     <cfset var roleSettings = structNew()>
     <cfset var qRoleinfo="">

     <cfset roleSettings.dpaClear=true>
	 <cfset roleSettings.dpaTimeout=variables.defaultDPATimeout>
	  	 
     <cftry>        
		 <cfquery name="qRoleInfo" datasource="#variables.WarehouseDSN#">
		 SELECT CLEAR_DPA, DPA_TIMEOUT
		 FROM   browser_owner.ROLE_SETTINGS
		 WHERE  UPPER(ROLE)=<cfqueryparam value="#UCase(arguments.role)#" cfsqltype="cf_sql_varchar">
		 </cfquery>
		 		  
		 <cfif qRoleInfo.RecordCount GT 0>		    	 
		   <cfset roleSettings.dpaClear=iif(qRoleInfo.CLEAR_DPA IS "Y",de(true),de(false))>
		   <cfset roleSettings.dpaTimeout=qRoleInfo.DPA_TIMEOUT>		   		  		   		 
		 </cfif>
		 	
		 <cfcatch type="database">
		  <cflog file="genieUserService" type="information" text="getUserRoleSettings - #role# - error caught - returning defaults" />	 
		  <cfreturn roleSettings>
		 </cfcatch>
	 </cftry>
	 
	 <cfreturn roleSettings> 	
     
    </cffunction> 

</cfcomponent>