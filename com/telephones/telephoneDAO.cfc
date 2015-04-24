<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        <cfargument name="rispURL" required="true" type="String">        
        <cfargument name="rispPort" required="true" type="String">                
        <cfargument name="rispSoapAction" required="true" type="String">         
        <cfargument name="rispTelephoneSearchHeader" required="true" type="String">   
        <cfargument name="rispTelephoneSearchFooter" required="true" type="String">          
        <cfargument name="rispTelephoneSummaryHeader" required="true" type="String">   
        <cfargument name="rispTelephoneSummaryFooter" required="true" type="String">           
        <cfargument name="rispTelephoneDetailHeader" required="true" type="String">   
        <cfargument name="forceLookup" required="true" type="String"> 
        <cfargument name="wMidsTimeout" required="true" type="String">                    
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>      
        <cfset variables.rispURL=arguments.rispURL>
        <cfset variables.rispPort=arguments.rispPort>
        <cfset variables.rispSoapAction=arguments.rispSoapAction>        
        <cfset variables.rispTelephoneSearchHeader=arguments.rispTelephoneSearchHeader>
        <cfset variables.rispTelephoneSearchFooter=arguments.rispTelephoneSearchFooter>
        <cfset variables.rispTelephoneSummaryHeader=arguments.rispTelephoneSummaryHeader>
        <cfset variables.rispTelephoneSummaryFooter=arguments.rispTelephoneSummaryFooter>        
        <cfset variables.rispTelephoneDetailHeader=arguments.rispTelephoneDetailHeader>
        <cfset variables.rispTelephoneDetailFooter=arguments.rispTelephoneDetailFooter>
        <cfset variables.forceLookup=arguments.forceLookup>  
        <cfset variables.wMidsTimeout=arguments.wMidsTimeout>                        
           
        <cfreturn this />  
    </cffunction>  
    
    <cffunction name="doWestMerciaTelephoneSearch" output="false" access="public" returntype="query" hint="function that does the west mercia telephone search, returns a query of telephones and their usages">
      <cfargument name="searchTerms" type="struct" required="true" hint="structure of search terms for telephone query">
      
      <cfset var qSearchResults="">
      <cfset var searchItem="">
      <cfset var searchKey="">
	  <cfset var isTelSearch=StructFind(arguments.searchTerms,'TEL_NO')>
      
		  <cfquery name="qSearchResults" datasource="#variables.WarehouseDSN#" result="theSql">
          SELECT *
          FROM (
	           SELECT ts.TEL_NO, ts.SOURCE, ts.SOURCE_ID, ts.PHONE_TYPE, ts.ELEC_COMMS, ts.DATE_FROM, ts.DATE_TO,
               td.OWNER_USER, ts.NOTE, nvl(td.NOMINAL_REF,tr.NOMINAL_REF) AS NOMINAL_REF, td.ORGANISATION, td.CUSTODY_REF, 
               td.CASE_REF, nvl(td.CRIME_REF,tr.CRIME_REF) AS CRIME_REF,
			   td.OIS_LOG,td.INTEL_LOG
		       FROM   browser_owner.TELEPHONE_SEARCH ts, browser_owner.TELEPHONE_USAGES td, browser_owner.telephone_roles tr
               WHERE ts.source_id=td.source_id(+)
               AND ts.source_id=tr.source_id(+)
                <cfif Len(searchTerms.DATE_FROM1) GT 0 and Len(searchTerms.DATE_FROM2) IS 0>
                 AND DATE_FROM=TO_DATE('#searchTerms.DATE_FROM1#','DD/MM/YYYY')
                <cfelseif  Len(searchTerms.DATE_FROM1) GT 0 and Len(searchTerms.DATE_FROM2) GT 0>
                 AND DATE_FROM BETWEEN TO_DATE('#searchTerms.DATE_FROM1#','DD/MM/YYYY') AND TO_DATE('#searchTerms.DATE_FROM2#','DD/MM/YYYY')
                </cfif>
                <cfif Len(searchTerms.DATE_TO1) GT 0 and Len(searchTerms.DATE_TO2) IS 0>
                 AND DATE_TO=TO_DATE('#searchTerms.DATE_TO1#','DD/MM/YYYY')
                <cfelseif Len(searchTerms.DATE_TO1) GT 0 and Len(searchTerms.DATE_TO2) GT 0>
                 AND DATE_TO BETWEEN TO_DATE('#searchTerms.DATE_TO1#','DD/MM/YYYY') AND TO_DATE('#searchTerms.DATE_TO2#','DD/MM/YYYY')
                </cfif>                  
	             <cfloop collection="#arguments.searchTerms#" item="searchKey">                                                       
	                <cfset searchItem=StructFind(arguments.searchTerms,PreserveSingleQuotes(searchKey))>            
	                    <cfif Left(PreserveSingleQuotes(searchKey),4) IS NOT "DATE">                                                                                                         
			                <cfif Len(searchItem) GT 0>
			                AND UPPER(#iif(searchKey IS "tel_no",de('ts.'),de(''))##PreserveSingleQuotes(searchKey)#)
			                 <cfif Find("%",searchItem) OR Find("_",searchItem)>
			                  LIKE
			                 <cfelse>
			                  =
			                 </cfif>
			                 <cfif searchKey IS "ELEC_COMMS">
			                 	<cfqueryparam value="#Ucase(searchItem)#" cfsqltype="cf_sql_varchar">	
			                 <cfelseif searchKey IS "NOTE">
								<cfqueryparam value="#Ucase(searchItem)#" cfsqltype="cf_sql_varchar">			                 		                
				             <cfelse>
	       		                 <cfqueryparam value="#searchItem#" cfsqltype="cf_sql_varchar">
				             </cfif>
			                </cfif>
	                    </cfif>
	             </cfloop> 
	           <cfif Len(isTelSearch) GT 0>
			   UNION
			   SELECT CALLERS_PHONE_NUMBER AS TEL_NO, NULL AS SOURCE, NULL AS SOURCE_ID, 'CALLER OIS' AS PHONE_TYPE, NULL AS ELEC_COMMS,
			          CALL_DATE AS DATE_FROM, CALL_DATE AS DATE_TO, '' AS OWNER_USER,SUMMARY AS NOTE, '' AS NOMINAL_REF,
					  LOCATION AS ORGANISATION, NULL AS CUSTODY_REF, NULL AS CASE_REF, NULL AS CRIME_REF, OIS_GLOBAL_URN AS OIS_LOG, '' AS INTEL_LOG
			   FROM   browser_owner.INC_HTML_LISTS
			   WHERE  (1=1)
			   AND    (
			            CALLERS_PHONE_NUMBER 		                 
			             <cfif Find("%",isTelSearch) OR Find("_",isTelSearch)>
		                  LIKE
		                 <cfelse>
		                  =
		                 </cfif>
		                 <cfqueryparam value="#isTelSearch#" cfsqltype="cf_sql_varchar">
					   OR
					   OTHER_PHONE_NUMBER
  						 <cfif Find("%",isTelSearch) OR Find("_",isTelSearch)>
		                  LIKE
		                 <cfelse>
		                  =
		                 </cfif>
		                 <cfqueryparam value="#isTelSearch#" cfsqltype="cf_sql_varchar">
					  )	
			   <cfif Len(searchTerms.DATE_FROM1) GT 0 and Len(searchTerms.DATE_FROM2) IS 0>
                 AND TRUNC(CALL_DATE)=TRUNC(TO_DATE('#searchTerms.DATE_FROM1#','DD/MM/YYYY'))
                <cfelseif  Len(searchTerms.DATE_FROM1) GT 0 and Len(searchTerms.DATE_FROM2) GT 0>
                 AND CALL_DATE BETWEEN TO_DATE('#searchTerms.DATE_FROM1# 00:00:00','DD/MM/YYYY HH24:MI:SS') AND TO_DATE('#searchTerms.DATE_FROM2# 23:59:59','DD/MM/YYYY HH24:MI:SS')
                </cfif>		  				   
			   </cfif>
			   ORDER BY 6 DESC
		 )
		 WHERE ROWNUM < 202
		</cfquery> 
                       
       <cfreturn qSearchResults>      
     
    </cffunction>        

	<cffunction name="readWestMidsTelephoneSearchResult" output="false" access="public" returntype="genieObj.telephones.telephone" hint="puts west mids xml data into a telephone object">
		<cfargument name="xmlObj" required="true">

		<cfset var telephone=CreateObject("component","genieObj.telephones.telephone").init()>

        <Cfset xmlObj=XmlParse(xmlobj)>

           <cfif isDefined("xmlObj.phonesearchresult.rec_id.sys_ref")>
			<cfset telephone.setSYS_REF(xmlObj.phonesearchresult.rec_id.sys_ref.xmlText)>
		   </cfif>         
                    
           <cfif isDefined("xmlObj.phonesearchresult.rec_id.app_ref")>
			<cfset telephone.setAPP_REF(xmlObj.phonesearchresult.rec_id.app_ref.xmlText)>
		   </cfif>                               
                    
           <cfif isDefined("xmlObj.phonesearchresult.rec_id.force_ref")>
			<cfset telephone.setFORCE_REF(xmlObj.phonesearchresult.rec_id.force_ref.xmlText)>
		   </cfif>  
                    
           <cfif isDefined("xmlObj.phonesearchresult.rec_id.force_ref")>
			<cfset telephone.setDISPLAY_FORCE(ListGetAt(ListGetAt(variables.forceLookup,ListContains(variables.forceLookup,xmlObj.phonesearchresult.rec_id.force_ref.xmlText,","),","),2,"|"))>
		   </cfif>                                          
                    
           <cfif isDefined("xmlObj.phonesearchresult.tel_no")>
			<cfset telephone.setTEL_NO(xmlObj.phonesearchresult.tel_no.xmlText)>
		   </cfif>                       
                    
           <cfif isDefined("xmlObj.phonesearchresult.electronic_communications_id")>
			<cfset telephone.setELEC_COMMS(xmlObj.phonesearchresult.electronic_communications_id.xmlText)>
		   </cfif>                    
                    
     <cfreturn telephone>
         
	</cffunction>   

    <cffunction name="doWestMidsTelephoneSearch" output="false" access="remote" returntype="any" hint="does the west mids region telephone search">
		<cfargument name="searchTerms" required="true" type="string" hint="string of xml that make up the person search">
        <cfargument name="userId" required="true" type="string" hint="userId of user making request">
        <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
        <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                
        
        <cfset var westMidsResult=StructNew()>
        <cfset var searchResult="">
        <cfset var searchXML="">
        <cfset var resultXML="">
        <cfset var resultStart=0>
        <cfset var resultEnd=0>
        <cfset var telephoneArrayXml="">
        <cfset var iTel=1>
        <cfset var rispTelephoneSearchHeader=variables.rispTelephoneSearchHeader>
        <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
        <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
        
        <!--- replace the user, terminal, unique ref and timestamp vars --->
        <cfset rispTelephoneSearchHeader=Replace(rispTelephoneSearchHeader,"**userId**",arguments.userId)>
        <cfset rispTelephoneSearchHeader=Replace(rispTelephoneSearchHeader,"**terminalId**",arguments.terminalId)>  
        <cfset rispTelephoneSearchHeader=Replace(rispTelephoneSearchHeader,"**uniqueRequestId**",uniqueRef)>  
        <cfset rispTelephoneSearchHeader=Replace(rispTelephoneSearchHeader,"**timestamp**",timestamp)>                        
        
        <cfoutput>
        <cfxml variable="searchXML">
          #rispTelephoneSearchHeader#
          #searchTerms#
          #variables.rispTelephoneSearchFooter#
        </cfxml>      
        </cfoutput>
                
            <cfset iRequestStart=getTickCount()>
			<cfhttp url="#variables.rispURL#" method="POST" result="searchResult" timeout="#variables.wMidsTimeout#"
						 port="#variables.rispPort#" useragent="">
				<cfhttpparam type="header" name="SOAPAction" value='"#variables.rispSoapAction#"'> 
				<cfhttpparam type="xml" name="body" value="#searchXml#">       
			</cfhttp>         
            <cfset iRequestEnd=getTickCount()>            
            
            <cfset westMidsResult.status=searchResult.statusCode>
			<cfset westMidsResult.overflow=false>
            
            <cfif westMidsResult.status is "200 OK">
              <cfset westMidsResult.searchOk=true>

              <cfif isXml(searchResult.fileContent)>
                  <cfset resultXML=searchResult.fileContent>
                  
                  <!--- strip off the soap headers --->
                  <cfset resultStart=FindNoCase("Body>",resultXml)>
                  <cfset resultEnd=ReFindNoCase("</[A-Za-z]*:Body>",resultXml)> 
              
                  <cfset westMidsResult.bodyStart=resultStart>
                  <cfset westMidsResult.bodyEnd=resultEnd>                                     
              
                  <!--- reformat the xml header to include all name spaces --->
                  <cfset resultXml='<?xml version="1.0" encoding="utf-8"?>'&Mid(resultXml,westMidsResult.bodyStart+5,westMidsResult.bodyEnd-(westMidsResult.bodyStart+5))>
                  <cfset resultXml=Replace(resultXml,"<m:RispResponse",'<m:RispResponse xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" ')>
                  
                  <cfset resultXml=Replace(resultXml,"m:","","ALL")>
                  <cfset resultXml=Replace(resultXml,"m0:","","ALL")>                    
                  <cfset resultXml=Replace(resultXml,"xsi:","","ALL")>                   
                  
                  <!--- if the xml is valid read the nominals into an array of nominals --->
                  <cfif isXml(resultXml)>
                    
                    <cfset resultXml=XmlParse(resultXml)>
                    <cfset westMidsResult.resultXml=resultXml>                    
                     
                    <cfset westMidsResult.telephones=ArrayNew(1)>                 
                    
                    <cfset telephoneArrayXml=XmlSearch(resultXml,"//phonesearchresult")>
                    
                    <cfset westMidsResult.telephoneArray=telephoneArrayXml>                    
                              
                    <cfloop from="1" to="#ArrayLen(telephoneArrayXml)#" index="iTel">
                      <cfset ArrayAppend(westMidsResult.telephones,readWestMidsTelephoneSearchResult(xmlObj=telephoneArrayXml[iTel]))>
					  <cfif iTel GT 500>					
					  	  <cfset westMidsResult.overflow=true>
						  <cfbreak>
					  </cfif>    					    
                    </cfloop>

                  <cfelse>
		              <cfset westMidsResult.searchOk=false>
		              <cfset westMidsResult.errorText=searchResult.statusCode&"<br>"&resultXml>                                
                  </cfif>
              <cfelse>
	              <cfset westMidsResult.searchOk=false>
	              <cfset westMidsResult.errorText=searchResult.statusCode&"<br>"&searchResult.fileContent>              
              </cfif>
            <cfelse>
              <cfset westMidsResult.searchOk=false>
              <cfset westMidsResult.errorText=searchResult.statusCode&"<br>"&searchResult.errorDetail>
            </cfif>
         
		<cfreturn westMidsResult>
     </cffunction>        

    <cffunction name="doWestMidsTelephoneSummary" output="false" access="remote" returntype="any" hint="does the west mids region telephone summary request">
		<cfargument name="searchTerms" required="true" type="struct" hint="struct consisting of AppRef, ForceId and SysId">
        <cfargument name="userId" required="true" type="string" hint="userId of user making request">
        <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
        <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                
        
        <cfset var westMidsResult=StructNew()>
        <cfset var searchResult="">
        <cfset var searchXML="">
        <cfset var resultXML="">
        <cfset var resultStart=0>
        <cfset var resultEnd=0>
        <cfset var nominalArrayXml="">
        <cfset var iNom=1>
        <cfset var rispTelephoneSummaryHeader=variables.rispTelephoneSummaryHeader>
        <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
        <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
        
        <!--- replace the user, terminal, unique ref and timestamp vars --->
        <cfset rispTelephoneSummaryHeader=ReplaceNoCase(rispTelephoneSummaryHeader,"**userId**",arguments.userId,"ALL")>
        <cfset rispTelephoneSummaryHeader=ReplaceNoCase(rispTelephoneSummaryHeader,"**terminalId**",arguments.terminalId,"ALL")>  
        <cfset rispTelephoneSummaryHeader=ReplaceNoCase(rispTelephoneSummaryHeader,"**appRef**",arguments.searchTerms.appRef,"ALL")>
        <cfset rispTelephoneSummaryHeader=ReplaceNoCase(rispTelephoneSummaryHeader,"**sysId**",arguments.searchTerms.sysId,"ALL")>
        <cfset rispTelephoneSummaryHeader=ReplaceNoCase(rispTelephoneSummaryHeader,"**forceId**",arguments.searchTerms.forceId,"ALL")>                          
        <cfset rispTelephoneSummaryHeader=ReplaceNoCase(rispTelephoneSummaryHeader,"**uniqueRequestId**",uniqueRef,"ALL")>  
        <cfset rispTelephoneSummaryHeader=ReplaceNoCase(rispTelephoneSummaryHeader,"**timestamp**",timestamp,"ALL")>                        
        
        <cfoutput>
        <cfxml variable="searchXML">
          #rispTelephoneSummaryHeader#
        </cfxml>      
        </cfoutput>
                            
			<cfhttp url="#variables.rispURL#" method="POST" result="searchResult" timeout="#variables.wMidsTimeout#"
						 port="#variables.rispPort#" useragent="">
				<cfhttpparam type="header" name="SOAPAction" value='"#variables.rispSoapAction#"'> 
				<cfhttpparam type="xml" name="body" value="#searchXml#">       
			</cfhttp>         
           
            
            <cfset westMidsResult.status=searchResult.statusCode>
            <cfset westMidsResult.xml=rispTelephoneSummaryHeader>            
            
            <cfif westMidsResult.status is "200 OK">
              <cfset westMidsResult.searchOk=true>
              <cfif isXml(searchResult.fileContent)>
                  <cfset resultXML=searchResult.fileContent>                 
                  
                  <!--- strip off the soap headers --->
                  <cfset resultStart=FindNoCase("Body>",resultXml)>
                  <cfset resultEnd=ReFindNoCase("</[A-Za-z]*:Body>",resultXml)> 
              
                  <cfset westMidsResult.bodyStart=resultStart>
                  <cfset westMidsResult.bodyEnd=resultEnd>                                     
              
                  <!--- reformat the xml header to include all name spaces --->
                  <cfset resultXml='<?xml version="1.0" encoding="utf-8"?>'&Mid(resultXml,westMidsResult.bodyStart+5,westMidsResult.bodyEnd-(westMidsResult.bodyStart+5))>
                  <cfset resultXml=Replace(resultXml,"<m:RispResponse",'<m:RispResponse xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" ')>
                  
                    <cfset resultXml=Replace(resultXml,"m:","","ALL")>
                    <cfset resultXml=Replace(resultXml,"m0:","","ALL")>                    
                    <cfset resultXml=Replace(resultXml,"xsi:","","ALL")>                     
                  
                  <!--- if the xml is valid read the nominals into an array of nominals --->
                  <cfif isXml(resultXml)>
                    <cfset resultXml=XmlParse(resultXml)>
                    <cfset westMidsResult.nominals=ArrayNew(1)>
                    
                 
                    
                    <cfset westMidsResult.resultXml=resultXml>
                    <cfset westMidsResult.statusCode=searchResult.statusCode>                    
                  <cfelse>
		              <cfset westMidsResult.searchOk=false>
		              <cfset westMidsResult.errorText=searchResult.statusCode&"<br>"&resultXml>          
		              <cfset westMidsResult.statusCode=searchResult.statusCode>                                                                                                
                  </cfif>
              <cfelse>
	              <cfset westMidsResult.searchOk=false>
	              <cfset westMidsResult.errorText=searchResult.statusCode&"<br>"&searchResult.fileContent>              
	              <cfset westMidsResult.statusCode=searchResult.statusCode>                                                            
              </cfif>
            <cfelse>
              <cfset westMidsResult.searchOk=false>
              <cfset westMidsResult.errorText=searchResult.statusCode&"<br>"&searchResult.errorDetail>
              <cfset westMidsResult.statusCode=searchResult.statusCode>              
            </cfif>
         
		<cfreturn westMidsResult>
        
    </cffunction>    

    <cffunction name="doWestMidsTelephoneDetail" output="false" access="remote" returntype="any" hint="does the west mids region telephone detail request">
		<cfargument name="searchTerms" required="true" type="struct" hint="struct consisting of AppRef, ForceId and SysId">
        <cfargument name="userId" required="true" type="string" hint="userId of user making request">
        <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
        <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                
        
        <cfset var westMidsResult=StructNew()>
        <cfset var searchResult="">
        <cfset var searchXML="">
        <cfset var resultXML="">
        <cfset var resultStart=0>
        <cfset var resultEnd=0>
        <cfset var telephoneArrayXml="">
        <cfset var iTel=1>
        <cfset var rispTelephoneDetailHeader=variables.rispTelephoneDetailHeader>
        <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
        <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
        
        <!--- replace the user, terminal, unique ref and timestamp vars --->
        <cfset rispTelephoneDetailHeader=ReplaceNoCase(rispTelephoneDetailHeader,"**userId**",arguments.userId,"ALL")>
        <cfset rispTelephoneDetailHeader=ReplaceNoCase(rispTelephoneDetailHeader,"**terminalId**",arguments.terminalId,"ALL")>  
        <cfset rispTelephoneDetailHeader=ReplaceNoCase(rispTelephoneDetailHeader,"**appRef**",arguments.searchTerms.appRef,"ALL")>
        <cfset rispTelephoneDetailHeader=ReplaceNoCase(rispTelephoneDetailHeader,"**sysId**",arguments.searchTerms.sysId,"ALL")>
        <cfset rispTelephoneDetailHeader=ReplaceNoCase(rispTelephoneDetailHeader,"**forceId**",arguments.searchTerms.forceId,"ALL")>                          
        <cfset rispTelephoneDetailHeader=ReplaceNoCase(rispTelephoneDetailHeader,"**uniqueRequestId**",uniqueRef,"ALL")>  
        <cfset rispTelephoneDetailHeader=ReplaceNoCase(rispTelephoneDetailHeader,"**timestamp**",timestamp,"ALL")>                        
        
        <cfoutput>
        <cfxml variable="searchXML">
          #rispTelephoneDetailHeader#
        </cfxml>      
        </cfoutput>
                
              
			<cfhttp url="#variables.rispURL#" method="POST" result="searchResult" timeout="#variables.wMidsTimeout#"
						 port="#variables.rispPort#" useragent="">
				<cfhttpparam type="header" name="SOAPAction" value='"#variables.rispSoapAction#"'> 
				<cfhttpparam type="xml" name="body" value="#searchXml#">       
			</cfhttp>         
            
            <cfset westMidsResult.status=searchResult.statusCode>
            <cfset westMidsResult.xml=rispTelephoneDetailHeader>            
            
            <cfif westMidsResult.status is "200 OK">
              <cfset westMidsResult.searchOk=true>
              <cfif isXml(searchResult.fileContent)>
                  <cfset resultXML=searchResult.fileContent>
                  
                  <!--- strip off the soap headers --->
                  <cfset resultStart=FindNoCase("Body>",resultXml)>
                  <cfset resultEnd=ReFindNoCase("</[A-Za-z]*:Body>",resultXml)> 
              
                  <cfset westMidsResult.bodyStart=resultStart>
                  <cfset westMidsResult.bodyEnd=resultEnd>                                     
              
                  <!--- reformat the xml header to include all name spaces --->
                  <cfset resultXml='<?xml version="1.0" encoding="utf-8"?>'&Mid(resultXml,westMidsResult.bodyStart+5,westMidsResult.bodyEnd-(westMidsResult.bodyStart+5))>
                  <cfset resultXml=Replace(resultXml,"<m:RispResponse",'<m:RispResponse xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" ')>
                  
                  <!--- if the xml is valid read the nominals into an array of nominals --->
                  <cfif isXml(resultXml)>
                    <cfset resultXml=XmlParse(resultXml)>
                    
                    <cfset resultXml=Replace(resultXml,"m:","","ALL")>
                    <cfset resultXml=Replace(resultXml,"m0:","","ALL")>                    
                    <cfset resultXml=Replace(resultXml,"xsi:","","ALL")>                    
                    
                    <cfset westMidsResult.resultXml=resultXml>
                    <cfset westMidsResult.statusCode=searchResult.statusCode>                    
                  <cfelse>
		              <cfset westMidsResult.searchOk=false>
		              <cfset westMidsResult.errorText=searchResult.statusCode&"<br>"&resultXml>          
		              <cfset westMidsResult.statusCode=searchResult.statusCode>                                                                                                
                  </cfif>
              <cfelse>
	              <cfset westMidsResult.searchOk=false>
	              <cfset westMidsResult.errorText=searchResult.statusCode&"<br>"&searchResult.fileContent>              
	              <cfset westMidsResult.statusCode=searchResult.statusCode>                                                            
              </cfif>
            <cfelse>
              <cfset westMidsResult.searchOk=false>
              <cfset westMidsResult.errorText=searchResult.statusCode&"<br>"&searchResult.errorDetail>
              <cfset westMidsResult.statusCode=searchResult.statusCode>              
            </cfif>
         
		<cfreturn westMidsResult>
        
    </cffunction>

    <cffunction name="getNominalTelephones" output="false" access="public" returntype="query" hint="returns a query nominal telpehones">
     <cfargument name="nominalRef" required="true" type="string" hint="nominal ref to get telephones for">
     
     <cfset var qTelephones="">
     <cfset var qCrimeTels="">
	 <cfset var qCust="">
	 <cfset var qCase="">
     <cfset var crimeLinkText="">
     <cfset var iRow=1>
	 <cfset var sStr="">
	 <cfset var newStr="">
	 <cfset var sSplit="">
	 <cfset var i=0>
	 <cfset var afterSlash1="">
	 <cfset var beforeSlash1=""> 
     
		<CFQUERY NAME = "qTelephones" DATASOURCE="#variables.WarehouseDSN#">
		Select tu.owner_user, ts.tel_no, nvl(ts.note,'&nbsp;') AS TEXT, nvl(ts.phone_type,'&nbsp;') as type, ts.date_from , 
		      nvl(ts.elec_comms,'&nbsp;') as elec_comms, ts.source, ts.source_id, nvl(tu.DATE_CREATED,ts.DATE_FROM) AS DATE_CREATED,
		      tu.CUSTODY_REF, '' AS CUSTODY_TYPE, tu.CASE_REF, '' AS CASE_TYPE, tu.INTEL_LOG, tu.OIS_LOG
		From browser_owner.telephone_search ts, browser_owner.telephone_usages tu
		where ts.source_id=tu.source_id(+)		
		and tu.nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
		UNION
		Select 'U' AS owner_user, ts.tel_no, nvl(ts.note,'&nbsp;') AS TEXT, nvl(ts.phone_type,'&nbsp;') as type, ts.date_from , 
		      nvl(ts.elec_comms,'&nbsp;') as elec_comms, ts.source, ts.source_id, ts.DATE_FROM AS DATE_CREATED,
		      '' AS CUSTODY_REF, '' AS CUSTODY_TYPE, '' AS CASE_REF, '' AS CASE_TYPE, '' AS INTEL_LOG, '' AS OIS_LOG
		From browser_owner.telephone_search ts, browser_owner.telephone_roles tr
		where ts.source_id=tr.source_id(+)		
		and not exists (SELECT 'Y' FROM browser_owner.telephone_usages tu1
                        where TU1.TEL_NO=ts.tel_no
                        and   tu1.NOMINAL_REF=TR.NOMINAL_REF)     
		and tr.nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
		order by 5 desc            
		</cfquery>
        
        <cfloop query="qTelephones">
         <!--- if data is from a crime document then pick up the role and the crime info --->
         <cfif SOURCE IS "CL">
           <cfquery name="qCrimeTels" DATASOURCE="#variables.WarehouseDSN#">
            SELECT DISTINCT tr.ROLE_TYPE, o.ORG_CODE || '/' || O.SERIAL_NO ||'/' || DECODE(LENGTH(O.YEAR),1, '0' || o.YEAR, o.YEAR) Crime_Number
            FROM   browser_owner.telephone_roles tr, browser_owner.offence_search o
            WHERE  tr.source_id=<cfqueryparam value="#SOURCE_ID#" cfsqltype="cf_sql_varchar">
            AND    tr.crime_ref=o.crime_ref
           </cfquery>
           
           <!--- if we have data for the CL role --->
           <cfif qCrimeTels.recordCount GT 0>
             <cfset crimeLinkText="">
             <cfloop query="qCrimeTels">
               <cfset crimeLinkText=ListAppend(crimeLinkText," "&ROLE_TYPE&" "&CRIME_NUMBER,",")>   
             </cfloop>
             <cfset querySetCell(qTelephones,"TEXT",crimeLinkText,iRow)>
           </cfif>
           
         </cfif>
         <cfif SOURCE IS "CT">
		 	 
	 	    <cfset sStr=TEXT>
			<cfset i=1>
			<cfset newStr="">
			<cfloop list="#sStr#" delimiters="/" index="sSplit">
				<cfset iStart=Find(sSplit,sStr)>
				<cfif i GT 1>
					<cfset beforeSlash1=Mid(sStr,iStart-2,1)>
					<cfset afterSlash1=Mid(sStr,iStart,1)>
					<cfif beforeSlash1 IS NOT " " or afterSlash1 IS NOT " ">
					  <cfset sSplit=" / "&sSplit>	
					</cfif>		 		
				</cfif>				
				<cfset newStr &= sSplit>
				<cfset i++>
			</cfloop>
			
			<cfset querySetCell(qTelephones,"TEXT",newStr,iRow)>
						 
		 </cfif>
         <cfif SOURCE IS "CU">
		   <cfquery name="qCust" DATASOURCE="#variables.WarehouseDSN#">
		   	   SELECT CUSTODY_TYPE
			   FROM   browser_owner.CUSTODY_SEARCH cs
			   WHERE  cs.CUSTODY_REF=<cfqueryparam value="#CUSTODY_REF#" cfsqltype="cf_sql_varchar">
		   </cfquery>	 
		   <cfif qCust.recordCount GT 0>
			   <cfset querySetCell(qTelephones,"CUSTODY_TYPE",qCust.CUSTODY_TYPE,iRow)>
			   <cfif Len(CASE_REF) GT 0>
			     <cfset querySetCell(qTelephones,"CASE_TYPE",qCust.CUSTODY_TYPE,iRow)>	   
			   </cfif>
		   </cfif>
		 </cfif>
         <cfif SOURCE IS "CP">
		  <cfif ListLen(CASE_REF,"/") IS "2">
		 	<cfquery name="qCase" DATASOURCE="#variables.WarehouseDSN#">
		   	   SELECT PD_REF
			   FROM   browser_owner.PD_SEARCH ps
			   WHERE  ps.CASE_ORG=<cfqueryparam value="#ListGetAt(CASE_REF,1,"/")#" cfsqltype="cf_sql_varchar">
			   AND    ps.CASE_SERIAL=<cfqueryparam value="#ListGetAt(CASE_REF,2,"/")#" cfsqltype="cf_sql_varchar">
			   AND    ps.CASE_YEAR=<cfqueryparam value="#Int(ListGetAt(CASE_REF,3,"/"))#" cfsqltype="cf_sql_varchar">
		   </cfquery> 
		   <cfif qCase.recordCount GT 0>
			<cfif Left(qCase.PD_REF,3) IS "22/" OR Left(qCase.PD_REF,3) IS "23/">
			  <cfset querySetCell(qTelephones,"CASE_TYPE",'NSPIS',iRow)>
			<cfelse>
			  <cfset querySetCell(qTelephones,"CASE_TYPE",'CRIMES',iRow)>
			</cfif>	 		   
		   </cfif>		   
		  </cfif>
		 </cfif>		 
         <cfset iRow=iRow+1>
        </cfloop>
                
     <cfreturn qTelephones>
     
    </cffunction> 

</cfcomponent>