<cfcomponent output="false" name="genieUserService">
      
    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="false" default="wmercia_jdbc" type="String">
		<cfargument name="defaultStylesheet" required="false" default="jquery-ui-1.10.4.custom.css" type="String">
		<cfargument name="defaultFont" required="false" default="Arial" type="String">
        
        <cfset variables.version="1.1.0.0">    
		<cfset variables.dateServiceStarted=DateFormat(now(),"DDD DD-MMM-YYYY")&" "&TimeFormat(now(),"HH:mm:ss")>                                  
        
        <cfset variables.warehousedsn=arguments.warehousedsn>    
		<cfset variables.defaultStylesheet=arguments.defaultStylesheet>                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
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
			select request_timestamp, reason_text, request_for, reason, session_id, server
			from browser_owner.audit_data ad
			where AD.USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
			and trunc(request_timestamp) > trunc(sysdate-1)
			order by request_timestamp desc
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
        
        <!--- if no settings then create users settings and return --->
		<cfif qSettings.recordCount IS 0>
			<cfset structUserSettings.stylesheet=variables.defaultStylesheet>
			<cfset structUserSettings.openNewWindow='N'>
			<cfset structUserSettings.font=variables.defaultFont>
			<cfset structUserSettings.lastUpdate=now()>
			<cfquery name='qSettings' datasource='#variables.warehouseDSN#'>
				INSERT INTO browser_owner.USER_SETTINGS
				(
					USER_ID,
					USER_NAME,
					STYLE_SHEET,
					OPEN_NEW_WINDOW,
					FONT
				)
				VALUES
				(
					<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#structUserSettings.stylesheet#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#structUserSettings.openNewWindow#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#structUserSettings.font#" cfsqltype="cf_sql_varchar">
				)
			</cfquery>	
		<cfelse>	
		<!--- has settings so read them into struct --->
         	<cfset structUserSettings.stylesheet=qSettings.STYLE_SHEET>
			<cfset structUserSettings.openNewWindow=qSettings.OPEN_NEW_WINDOW>
			<cfset structUserSettings.font=qSettings.FONT>
			<cfset structUserSettings.lastUpdate=qSettings.LAST_UPDATE>
		</cfif>
		
		<cfreturn structUserSettings>
             
    </cffunction>      
       
    <cffunction name="updateUserSettings" access="remote" returntype="void" output="false" hint="updates the user settings">
        <cfargument name="userId" required="true" type="string" hint="userId to update settings for">
		<cfargument name="userName" required="true" type="string" hint="userName to update settings for">               
		<cfargument name="font" required="true" type="string" hint="userId to update settings for">
		<cfargument name="stylesheet" required="true" type="string" hint="userName to update settings for">
		<cfargument name="openNewWindow" required="true" type="string" hint="userId to update settings for">		

        <cfset var qSettings=''>
       
		<cfquery name='qSettings' datasource='#variables.warehouseDSN#'>
			UPDATE browser_owner.USER_SETTINGS
			SET    USER_NAME = <cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar">,
				   STYLE_SHEET = <cfqueryparam value="#arguments.stylesheet#" cfsqltype="cf_sql_varchar">,
				   OPEN_NEW_WINDOW = <cfqueryparam value="#arguments.openNewWindow#" cfsqltype="cf_sql_varchar">,
				   FONT = <cfqueryparam value="#arguments.font#" cfsqltype="cf_sql_varchar">,
				   LAST_UPDATE = SYSDATE
			WHERE  USER_ID = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar"> 				
		</cfquery>			
             
    </cffunction>         

    <cffunction name="resetSession" access="remote" returntype="void" output="false" hint="resets the user session variables">
       		
       		<cflog file="genie" type="information" text="resetSession has been called" />
       		<cfset onSessionStart()>
			<cflog file="genie" type="information" text="resetSession ended" />
             
    </cffunction> 
       
</cfcomponent>