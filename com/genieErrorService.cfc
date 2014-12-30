<cfcomponent output="false" name="genieUserService">
      
    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="false" default="wmercia_jdbc" type="String">
		<cfargument name="warehouseDSN2" required="false" default="wmercia_odbc" type="String">
		<cfargument name="errorHtmlDirectory" required="false" default="\\svr20200\g$\genie_data\errors\" type="String">
		
        <cfset variables.version="1.1.0.0">    
		<cfset variables.dateServiceStarted=DateFormat(now(),"DDD DD-MMM-YYYY")&" "&TimeFormat(now(),"HH:mm:ss")>                                  
        
        <cfset variables.warehousedsn=arguments.warehousedsn>  
		<cfset variables.warehousedsn2=arguments.warehousedsn2> 
		<cfset variables.errorHtmlDirectory=arguments.errorHtmlDirectory>    
		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
        <cfreturn this />    
    </cffunction>  
        
    <cffunction name="getServiceVersion" access="remote" returntype="any" output="false" hint="I get the west mids photos">

     <cfreturn variables.version>
     
    </cffunction>      
	
    <cffunction name="getDateServiceStarted" access="remote" returntype="any" output="false" hint="I get the west mids photos">

     <cfreturn variables.dateServiceStarted>
     
    </cffunction> 	      
    
    <cffunction name="logError" access="remote" returntype="string" output="false" hint="logs a genie error returns error ref">
        <cfargument name="errorData" required="true" type="struct" hint="error data structure">
		
        <cfset var seqError=''>
        <cfset var insError=''>    	
        <cfset var errorUrn=''>         
		<cfset var errorFilePageHtml=variables.errorHtmlDirectory>
		<cfset var errorFilePagePath="">
		<cfset var errorFileResponseHtml=variables.errorHtmlDirectory>
		<cfset var errorFileResponsePath="">
		<cfset var errorPath=DateFormat(now(),"YYYY")&"\"&DateFormat(now(),"MM")&"\">               
                
	    <!--- get the next exhibit id sequence no --->
	    <cfquery name="seqError" datasource="#variables.warehouseDSN#">
		  select BROWSER_OWNER.GENIE_ERROR_SEQ.nextval errorSeq
	      from dual
	    </cfquery>         
	    
	    <!---	    
	    <cfsavecontent variable="sErrorData">
			<cfdump var="#errorData#" format="html">
		</cfsavecontent>
		
		<cffile action="write" file="d:\error_#timeformat(now(),"HHmmss")#.html" output="#sErrorData#">
		--->
	    
	    <cfset errorUrn="GENIE_ERROR/"&seqError.errorSeq&"/"&DateFormat(now(),"YY")>
		
		<cfif not directoryExists(errorFilePageHtml&errorPath)>
			<cfdirectory action="create" directory="#errorFilePageHtml##errorPath#" >
		</cfif>
		
		<cfset errorFilePageHtml=errorFilePageHtml&errorPath&seqError.errorSeq&"_"&DateFormat(now(),"YY")&"_page.html">
		<cfset errorFilePagePath=errorPath&seqError.errorSeq&"_"&DateFormat(now(),"YY")&"_page.html">
		<cfset errorFileResponseHtml=errorFileResponseHtml&errorPath&seqError.errorSeq&"_"&DateFormat(now(),"YY")&"_response.html">
		<cfset errorFileResponsePath=errorPath&seqError.errorSeq&"_"&DateFormat(now(),"YY")&"_response.html">        
                            
        <cfquery name="insError" datasource="#variables.warehouseDSN#">
           INSERT INTO BROWSER_OWNER.GENIE_ERRORS
           (
              ERROR_URN,
			  ERROR_DATE,
			  ERROR_USER,
			  ERROR_USER_NAME,
			  SESSION_START_TIME,
			  UUID,
			  PAGE_HTML,
			  HTTP_STATUS,
			  STATUS_TEXT,
			  RESPONSE_TEXT,
			  PAGE_TITLE,
			  PAGE_URL,
			  ERROR_TYPE,
			  AJAX_URL,
			  AJAX_DATA,
			  AJAX_TYPE,
			  ACTIVE_ELEMENT_ID,
			  ACTIVE_ELEMENT_VALUE,
			  ACTIVE_ELEMENT_HTML,
              HOSTNAME,
              SERVER,
              SERVER_IP_ADDR,
              VERSION,
              PAGE_HTML_PATH,
              RESPONSE_TEXT_PATH
           )
           VALUES
           (
             <cfqueryparam value="#errorUrn#" cfsqltype="cf_sql_varchar">,             
             <cfqueryparam value="#CreateODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">,
			 <cfqueryparam value="#session.user.getTrueUserId()#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#session.user.getFullName()#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#CreateODBCDateTime(session.starttime)#" cfsqltype="cf_sql_timestamp">,
			 <cfqueryparam value="#session.thisuuid#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#errorData.pageHtml#" cfsqltype="cf_sql_clob">,
			 <cfqueryparam value="#errorData.httpStatus#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#errorData.statusText#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#errorData.responseText#" cfsqltype="cf_sql_clob">,
			 <cfqueryparam value="#errorData.pageTitle#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#errorData.url#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#errorData.eventErrorType#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#errorData.ajaxUrl#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#errorData.ajaxData#" cfsqltype="cf_sql_clob">,
			 <cfqueryparam value="#errorData.ajaxType#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#errorData.activeElementId#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#errorData.activeElementValue#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#errorData.activeElementHTML#" cfsqltype="cf_sql_clob">,
			 <cfqueryparam value="#session.hostname#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#session.server#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#session.serverIp#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#application.Version#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#errorFilePagePath#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#errorFileResponsePath#" cfsqltype="cf_sql_varchar">
           )
        </cfquery>        
        
        <cffile action="write" file="#errorFilePageHtml#" output="#errorData.pageHtml#">
		<cffile action="write" file="#errorFileResponseHtml#" output="#errorData.responseText#"> 
        
        <cfreturn errorUrn>
     
    </cffunction>           

    <cffunction name="updateError" access="remote" returntype="string" output="false" hint="updates a genie error returns error ref">
        <cfargument name="errorData" required="true" type="struct" hint="error data structure">
		
		<cfset var returnVar=true>
		<cfset var qUpdate="">
		
		<cfquery name="qUpdate" datasource="#variables.warehouseDSN#">
			UPDATE browser_owner.GENIE_ERRORS
			SET    PROBLEM_TYPE=<cfqueryparam value="#errorData.problemType#" cfsqltype="cf_sql_varchar" />,
			       RESOLUTION_TEXT=<cfqueryparam value="#errorData.problemNotes#" cfsqltype="cf_sql_clob" />,
				   RESOLVED=<cfqueryparam value="#errorData.resolved#" cfsqltype="cf_sql_varchar" />,
				   <cfif errorData.RESOLVED IS "Y">
				   STATUS=<cfqueryparam value="RESOLVED" cfsqltype="cf_sql_varchar" />,
				   <cfelse>
				   STATUS=<cfqueryparam value="OUTSTANDING" cfsqltype="cf_sql_varchar" />,	   
				   </cfif>	   
				   RESOLVED_BY=<cfqueryparam value="#errorData.resolvedByUID#" cfsqltype="cf_sql_varchar" />,
				   RESOLVED_BY_NAME=<cfqueryparam value="#errorData.resolvedByName#" cfsqltype="cf_sql_varchar" />
				   <cfif Len(errorData.dateResolved) GT 0>
				   	   <cfif LSIsDate(errorData.dateResolved)>
					   ,RESOLUTION_DATE=<cfqueryparam value="#CreateODBCDate(LSParseDateTime(errorData.dateResolved))#" cfsqltype="cf_sql_timestamp">
					   </cfif>
				   </cfif>
			WHERE  ERROR_URN=<cfqueryparam value="#errorData.errorUrn#" cfsqltype="cf_sql_varchar" />
		</cfquery>
		
		<cfreturn returnVar>
		
	</cffunction>

	<cffunction name="getErrorList" access="remote" returntype="xml" output="false" hint="gets an xml list of genie errors">
  	  <cfargument name="errorUrn" type="string" required="true" hint="urn of the error">
	  <cfargument name="errorYear" type="string" required="true" hint="error year">	    	  	  
	  <cfargument name="dateFrom" type="string" required="true" hint="error from date dd/mm/yyyy">
	  <cfargument name="dateTo" type="string" required="true" hint="error to date dd/mm/yyyy">
	  <cfargument name="errorBy" type="string" required="true" hint="person who generated the error">
	  <cfargument name="status" type="string" required="true" hint="error status">
    
      <cfset var returnXml='<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><ErrorResults xger.s="http://tempuri.org/"><resultCount>%resultCount%</resultCount><Errors>%errorList%</Errors></ErrorResults></soap:Body></soap:Envelope>'>
	  <cfset var errorXml="<Error><errorUrn>%errorUrn%</errorUrn><errorBy><![CDATA[%errorBy%]]></errorBy><errorDate>%errorDate%</errorDate><errorDetails><![CDATA[%errorDetails%]]></errorDetails><errorStatus>%errorStatus%</errorStatus></Error>">
	  <cfset var qErrorList = "">
	  <cfset var errorXmlResults="">
	  <cfset var thisError="">	  	    
    
      <cfquery name="qErrorList" datasource="#variables.warehouseDSN#" result="eSql">
		SELECT ger.*
		FROM   browser_owner.GENIE_ERRORS ger
		WHERE  (1=1)
		<cfif Len(status) GT 0>
		AND    ger.STATUS=<cfqueryparam value="#status#" cfsqltype="cf_sql_varchar" />
		</cfif>
		<cfif Len(errorYear) GT 0>
		AND    TO_CHAR(ger.ERROR_DATE,'YYYY')=<cfqueryparam value="#errorYear#" cfsqltype="cf_sql_varchar" />
		</cfif>		
		<cfif Len(errorUrn) GT 0>
		AND ger.ERROR_URN=<cfqueryparam value="#errorUrn#" cfsqltype="cf_sql_varchar" />
		</cfif>
		<cfif Len(errorBy) GT 0>
		AND ger.ERROR_USER=<cfqueryparam value="#errorBy#" cfsqltype="cf_sql_varchar" />
		</cfif>
		<cfif Len(dateFrom) GT 0 AND Len(dateTo) IS 0>
		AND TRUNC(ERROR_DATE)=TO_DATE('#dateFrom#','DD/MM/YYYY')	
		</cfif>
		<cfif Len(dateFrom) GT 0 AND Len(dateTo) GT 0>
		AND ERROR_DATE BETWEEN TO_DATE('#dateFrom# 00:00:00','DD/MM/YYYY HH24:MI:SS')
		                     AND TO_DATE('#dateTo# 23:59:59','DD/MM/YYYY HH24:MI:SS')	
		</cfif>		
		ORDER BY ger.ERROR_DATE DESC
	  </cfquery>
	  
	  
	    <cfloop query="qErrorList">		  		  	
			<cfset thisError=duplicate(errorXml)>
			<cfset thisError=ReplaceNoCase(thisError,'%errorUrn%',ERROR_URN)>
			<cfset thisError=ReplaceNoCase(thisError,'%errorBy%',ERROR_USER_NAME)>				
			<cfset thisError=ReplaceNoCase(thisError,'%errorDate%',DateFormat(ERROR_DATE,"DD/MM/YYYY")&" "&TimeFormat(ERROR_DATE,"HH:mm:ss"))>				
			<cfset thisError=ReplaceNoCase(thisError,'%errorDetails%','UUID:'&UUID&"<br>Page Title:"&PAGE_TITLE&"<Br>Page Url:"&PAGE_URL&"<Br>Ajax Url:"&AJAX_URL&"<br>Error Type:"&ERROR_TYPE&", HTTP Status:"&HTTP_STATUS&"<Br>Response Text:"&STATUS_TEXT)>
			<cfset thisError=ReplaceNoCase(thisError,'%errorStatus%',STATUS)>
			<cfset errorXmlResults &= thisError>				  
		</cfloop>
	    
	    <cfset returnXml=Replace(returnXml,'%resultCount%',qErrorList.recordCount)>
		<cfset returnXml=Replace(returnXml,'%errorList%',errorXmlResults)>
		
		<cffile action="write" file="d:\errorList.xml" output="#returnXml#">
    
     <cfreturn returnXml>
    
	</cffunction>

	<cffunction name="logBug" access="remote" returntype="string" output="false" hint="logs a genie bug returns bug ref">
        <cfargument name="bugData" required="true" type="struct" hint="bug data structure">
		
        <cfset var seqBug=''>
        <cfset var insBug=''>    	
        <cfset var bugUrn=''>         
		        
	    <!--- get the next exhibit id sequence no --->
	    <cfquery name="seqBug" datasource="#variables.warehouseDSN#">
		  select BROWSER_OWNER.GENIE_BUG_SEQ.nextval bugSeq
	      from dual
	    </cfquery>         
	    
	    <cfset bugUrn="GENIE_BUG/"&seqbug.bugSeq&"/"&DateFormat(now(),"YY")>
		                    
        <cfquery name="insBug" datasource="#variables.warehouseDSN#">
           INSERT INTO BROWSER_OWNER.BUG_REPORTS
           (
              BUG_ID,
              BUG_URN,
			  BUG_DATE,
			  BUG_BY,
			  BUG_BY_NAME,
			  BUG_BY_EMAIL,
			  SCREEN,
			  BUG_TYPE,
			  BUG_DESCRIPTION
           )
           VALUES
           (
             <cfqueryparam value="#seqbug.bugSeq#" cfsqltype="cf_sql_varchar">,
             <cfqueryparam value="#bugUrn#" cfsqltype="cf_sql_varchar">,             
             <cfqueryparam value="#CreateODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">,
			 <cfqueryparam value="#bugData.bugUser#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#bugData.bugName#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#bugData.bugEmail#" cfsqltype="cf_sql_varchar">,			 
			 <cfqueryparam value="#bugData.bugScreen#" cfsqltype="cf_sql_varchar">,
			 <cfqueryparam value="#bugData.bugType#" cfsqltype="cf_sql_clob">,
			 <cfqueryparam value="#bugData.bugDesc#" cfsqltype="cf_sql_varchar">   )
        </cfquery>        
        
        <cfreturn bugUrn>
     
    </cffunction>      

	<cffunction name="getBugList" access="remote" returntype="xml" output="false" hint="gets an xml list of genie bugss">
  	  <cfargument name="bugUrn" type="string" required="true" hint="urn of the bug">
	  <cfargument name="bugYear" type="string" required="true" hint="bug year">	    	  	  
	  <cfargument name="dateFrom" type="string" required="true" hint="bug from date dd/mm/yyyy">
	  <cfargument name="dateTo" type="string" required="true" hint="bug to date dd/mm/yyyy">
	  <cfargument name="bugBy" type="string" required="true" hint="person who generated the bug">
	  <cfargument name="status" type="string" required="true" hint="bug status">
    
      <cfset var returnXml='<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><BugResults xger.s="http://tempuri.org/"><resultCount>%resultCount%</resultCount><Bugs>%bugList%</Bugs></BugResults></soap:Body></soap:Envelope>'>
	  <cfset var bugXml="<Bug><bugUrn>%bugUrn%</bugUrn><bugBy><![CDATA[%bugBy%]]></bugBy><bugDate>%bugDate%</bugDate><bugDetails><![CDATA[%bugDetails%]]></bugDetails><bugStatus>%bugStatus%</bugStatus></Bug>">
	  <cfset var qBugList = "">
	  <cfset var bugXmlResults="">
	  <cfset var thisBug="">	  	    
    
      <cfquery name="qBugList" datasource="#variables.warehouseDSN#" result="eSql">
		SELECT br.*
		FROM   browser_owner.BUG_REPORTS br
		WHERE  (1=1)
		<cfif Len(status) GT 0>
		AND    br.STATUS=<cfqueryparam value="#status#" cfsqltype="cf_sql_varchar" />
		</cfif>
		<cfif Len(bugYear) GT 0>
		AND    TO_CHAR(br.BUG_DATE,'YYYY')=<cfqueryparam value="#bugYear#" cfsqltype="cf_sql_varchar" />
		</cfif>		
		<cfif Len(bugUrn) GT 0>
		AND br.BUG_URN=<cfqueryparam value="#bugUrn#" cfsqltype="cf_sql_varchar" />
		</cfif>
		<cfif Len(bugBy) GT 0>
		AND br.BUG_BY=<cfqueryparam value="#bugBy#" cfsqltype="cf_sql_varchar" />
		</cfif>
		<cfif Len(dateFrom) GT 0 AND Len(dateTo) IS 0>
		AND TRUNC(BUG_DATE)=TO_DATE('#dateFrom#','DD/MM/YYYY')	
		</cfif>
		<cfif Len(dateFrom) GT 0 AND Len(dateTo) GT 0>
		AND BUG_DATE BETWEEN TO_DATE('#dateFrom# 00:00:00','DD/MM/YYYY HH24:MI:SS')
		                     AND TO_DATE('#dateTo# 23:59:59','DD/MM/YYYY HH24:MI:SS')	
		</cfif>		
		ORDER BY br.BUG_DATE DESC
	  </cfquery>
	  	  
	    <cfloop query="qBugList">		  		  	
			<cfset thisBug=duplicate(bugXml)>
			<cfset thisBug=ReplaceNoCase(thisBug,'%bugUrn%',BUG_URN)>
			<cfset thisBug=ReplaceNoCase(thisBug,'%bugBy%',BUG_BY_NAME)>				
			<cfset thisBug=ReplaceNoCase(thisBug,'%bugDate%',DateFormat(BUG_DATE,"DD/MM/YYYY")&" "&TimeFormat(BUG_DATE,"HH:mm:ss"))>				
			<cfset thisBug=ReplaceNoCase(thisBug,'%bugDetails%','Screen:<b>'&SCREEN&"</b><br>Type:<b>"&BUG_TYPE&"</b><Br>Short Text:<b>"&Left(BUG_DESCRIPTION,120)&"</b>")>
			<cfset thisBug=ReplaceNoCase(thisBug,'%bugStatus%',STATUS)>
			<cfset bugXmlResults &= thisBug>				  
		</cfloop>
	    
	    <cfset returnXml=Replace(returnXml,'%resultCount%',qBugList.recordCount)>
		<cfset returnXml=Replace(returnXml,'%bugList%',bugXmlResults)>				
    
     <cfreturn returnXml>
    
	</cffunction>

    <cffunction name="updateBug" access="remote" returntype="string" output="false" hint="updates a genie error returns error ref">
        <cfargument name="bugData" required="true" type="struct" hint="bug data structure">
		
		<cfset var returnVar=true>
		<cfset var qUpdate="">
		
		<cfquery name="qUpdate" datasource="#variables.warehouseDSN#">
			UPDATE browser_owner.BUG_REPORTS
			SET    REPLICATED=<cfqueryparam value="#bugData.replicated#" cfsqltype="cf_sql_varchar" />,
			       FIXED=<cfqueryparam value="#bugData.fixed#" cfsqltype="cf_sql_varchar" />,
				   FIXED_VERSION=<cfqueryparam value="#bugData.fixedVersion#" cfsqltype="cf_sql_varchar" />,
				   FIXED_DETAILS=<cfqueryparam value="#bugData.fixedNotes#" cfsqltype="cf_sql_clob" />,				  				   
				   <cfif bugData.FIXED IS "Y">
				   STATUS=<cfqueryparam value="FIXED" cfsqltype="cf_sql_varchar" />,
				   <cfelse>
				   STATUS=<cfqueryparam value="OUTSTANDING" cfsqltype="cf_sql_varchar" />,	   
				   </cfif>	   
				   FIXED_BY=<cfqueryparam value="#bugData.fixedByUID#" cfsqltype="cf_sql_varchar" />,
				   FIXED_BY_NAME=<cfqueryparam value="#bugData.fixedByName#" cfsqltype="cf_sql_varchar" />
				   <cfif Len(bugData.dateFixed) GT 0>
				   	   <cfif LSIsDate(bugData.dateFixed)>
					   ,FIXED_DATE=<cfqueryparam value="#CreateODBCDate(LSParseDateTime(bugData.dateFixed))#" cfsqltype="cf_sql_timestamp">
					   </cfif>
				   </cfif>
			WHERE  BUG_URN=<cfqueryparam value="#bugData.bugUrn#" cfsqltype="cf_sql_varchar" />
		</cfquery>
		
		<cfreturn returnVar>
		
	</cffunction>
       
</cfcomponent>