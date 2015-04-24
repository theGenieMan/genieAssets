<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        <cfargument name="rispURL" required="true" type="String">        
        <cfargument name="rispPort" required="true" type="String">                
        <cfargument name="rispSoapAction" required="true" type="String">         
        <cfargument name="rispAddressSearchHeader" required="true" type="String">   
        <cfargument name="rispAddressSearchFooter" required="true" type="String">          
        <cfargument name="rispAddressSummaryHeader" required="true" type="String">   
        <cfargument name="rispAddressSummaryFooter" required="true" type="String">     
        <cfargument name="rispAddressDetailHeader" required="true" type="String">   
        <cfargument name="rispAddressDetailFooter" required="true" type="String">     
        <cfargument name="forceLookup" required="true" type="String">
        <cfargument name="wMidsTimeout" required="true" type="String">                            
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>      
        <cfset variables.rispURL=arguments.rispURL>
        <cfset variables.rispPort=arguments.rispPort>
        <cfset variables.rispSoapAction=arguments.rispSoapAction>        
        <cfset variables.rispAddressSearchHeader=arguments.rispAddressSearchHeader>
        <cfset variables.rispAddressSearchFooter=arguments.rispAddressSearchFooter>
        <cfset variables.rispAddressSummaryHeader=arguments.rispAddressSummaryHeader>
        <cfset variables.rispAddressSummaryFooter=arguments.rispAddressSummaryFooter>
        <cfset variables.rispAddressDetailHeader=arguments.rispAddressDetailHeader>
        <cfset variables.rispAddressDetailFooter=arguments.rispAddressDetailFooter>
        <cfset variables.forceLookup=arguments.forceLookup>                
        <cfset variables.wMidsTimeout=arguments.wMidsTimeout>                        
           
        <cfreturn this />  
    </cffunction>   

	<cffunction name="read" output="false" access="public" returntype="genieObj.addresses.address">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			 SELECT
	          DECODE(PART_ID,'','',PART_ID||', ')||
						DECODE(BUILDING_NAME,'','',BUILDING_NAME||', ')||
						DECODE(BUILDING_NUMBER,'','',BUILDING_NUMBER||', ')||
						DECODE(STREET_1,'','',STREET_1||', ')||
						DECODE(LOCALITY,'','',LOCALITY||', ')||
						DECODE(TOWN,'','',TOWN||', ')||
						DECODE(COUNTY,'','',COUNTY||' ')||
						DECODE(POST_CODE,'','',POST_CODE) As FULL_ADDRESS,       	
	          POST_CODE, PREMISE_KEY, PART_ID, BUILDING_NUMBER, BUILDING_NAME, STREET_1, 
						STREET_2, LOCALITY, TOWN, COUNTY, OFFENCE_COUNT, 
						NOMINAL_COUNT, INTEL_COUNT, INCIDENT_COUNT, ORG_COUNT, LPA, 
						GRID, UPDATE_TIME
				from BROWSER_OWNER.GE_ADDRESSES
				where POST_CODE = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getPOST_CODE()#" />
	      AND   PREMISE_KEY = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getPREMISE_KEY()#" />
			</cfquery>
	
			<cfscript>
				obj.setPOST_CODE(qRead.POST_CODE);
				obj.setPREMISE_KEY(qRead.PREMISE_KEY);
				obj.setFULL_ADDRESS(qRead.FULL_ADDRESS);
				obj.setPART_ID(qRead.PART_ID);
				obj.setBUILDING_NUMBER(qRead.BUILDING_NUMBER);
				obj.setBUILDING_NAME(qRead.BUILDING_NAME);
				obj.setSTREET_1(qRead.STREET_1);
				obj.setSTREET_2(qRead.STREET_2);
				obj.setLOCALITY(qRead.LOCALITY);
				obj.setTOWN(qRead.TOWN);
				obj.setCOUNTY(qRead.COUNTY);
				obj.setOFFENCE_COUNT(qRead.OFFENCE_COUNT);
				obj.setNOMINAL_COUNT(qRead.NOMINAL_COUNT);
				obj.setINTEL_COUNT(qRead.INTEL_COUNT);
				obj.setINCIDENT_COUNT(qRead.INCIDENT_COUNT);
				obj.setORG_COUNT(qRead.ORG_COUNT);
				obj.setLPA(qRead.LPA);
				obj.setGRID(qRead.GRID);
				obj.setUPDATE_TIME(qRead.UPDATE_TIME);
				return obj;
			</cfscript>
		</cffunction>
	
	<cffunction name="readWestMidsAddressSearchResult" output="false" access="public" returntype="genieObj.addresses.address">
		<cfargument name="xmlObj" required="true">

		<cfset var address=CreateObject("component","genieObj.addresses.address").init()>

        <Cfset xmlObj=XmlParse(xmlobj)>

           <cfif isDefined("xmlObj.addsearchresult.rec_id.sys_ref")>
			<cfset address.setSYS_REF(xmlObj.addsearchresult.rec_id.sys_ref.xmlText)>
		   </cfif>         
                    
           <cfif isDefined("xmlObj.addsearchresult.rec_id.app_ref")>
			<cfset address.setAPP_REF(xmlObj.addsearchresult.rec_id.app_ref.xmlText)>
		   </cfif>                               
                    
           <cfif isDefined("xmlObj.addsearchresult.rec_id.force_ref")>
			<cfset address.setFORCE_REF(xmlObj.addsearchresult.rec_id.force_ref.xmlText)>
		   </cfif>                 
                    
           <cfif isDefined("xmlObj.addsearchresult.house_number")>
			<cfset address.setBUILDING_NUMBER(xmlObj.addsearchresult.house_number.xmlText)>
		   </cfif>                       
                    
           <cfif isDefined("xmlObj.addsearchresult.flat_number")>
			<cfset address.setPART_ID(xmlObj.addsearchresult.flat_number.xmlText)>
		   </cfif>                    
                    
           <cfif isDefined("xmlObj.addsearchresult.premise_name")>
			<cfset address.setBUILDING_NAME(xmlObj.addsearchresult.premise_name.xmlText)>
		   </cfif>                    
                    
           <cfif isDefined("xmlObj.addsearchresult.street")>
			<cfset address.setSTREET_1(xmlObj.addsearchresult.street.xmlText)>
		   </cfif>               
                    
           <cfif isDefined("xmlObj.addsearchresult.district")>
			<cfset address.setTOWN(xmlObj.addsearchresult.district.xmlText)>
		   </cfif>                         
                    
           <cfif isDefined("xmlObj.addsearchresult.county")>
			<cfset address.setCOUNTY(xmlObj.addsearchresult.county.xmlText)>
		   </cfif> 

           <cfif isDefined("xmlObj.addsearchresult.post_code")>
			<cfset address.setPOST_CODE(xmlObj.addsearchresult.post_code.xmlText)>
		   </cfif>                    

     <cfreturn address>
         
	</cffunction>

    <cffunction name="doWestMerciaAddressSearch" output="false" access="public" returntype="query">
      <cfargument name="searchTerms" type="struct" required="true" hint="structure of search terms for address query">
      
      <cfset var qSearchResults="">
      <cfset var searchItem="">
      <cfset var searchKey="">
      
		  <cfquery name="qSearchResults" datasource="#variables.WarehouseDSN#">
			SELECT * FROM
			(	
			 SELECT     REPLACE(DECODE(PART_ID,'','','FLAT '||PART_ID||', '),'FLAT FLAT','FLAT')||
							DECODE(BUILDING_NAME,'','',BUILDING_NAME||', ')||
							DECODE(BUILDING_NUMBER,'','',BUILDING_NUMBER||', ')||
							DECODE(STREET_1,'','',STREET_1||', ')||
							DECODE(LOCALITY,'','',LOCALITY||', ')||
							DECODE(TOWN,'','',TOWN||', ')||
							DECODE(COUNTY,'','',COUNTY||' ')||
							DECODE(POST_CODE,'','',POST_CODE) Address,addr.*, 							
                            (SELECT SNT_CODE 
                            FROM browser_owner.SNT_LOOKUP sl
                            WHERE sl.LPT_CODES(+) LIKE '%'||addr.LPA||'%'
                             AND addr.LPA IS NOT NULL) AS SNT_CODE          
			 FROM   browser_owner.GE_ADDRESSES addr
			 WHERE  (1=1)			 
             <cfloop collection="#arguments.searchTerms#" item="searchKey">
                <cfset searchItem=StructFind(arguments.searchTerms,PreserveSingleQuotes(searchKey))>
                <cfif Len(searchItem) GT 0>
				<cfif ListFindNoCase('post_code,building_number,building_name,part_id,street_1,locality,town,county',searchKey) GT 0>
				 <cfif searchKey IS "POST_CODE">
				   AND  REPLACE(POST_CODE,' ','')
				   
					<cfif Find("%",searchItem) OR Find("_",searchItem)>
	                  LIKE
	                 <cfelse>
	                  =
	                 </cfif>
	                 <cfqueryparam value="#Replace(UCase(searchItem),' ','','ALL')#" cfsqltype="cf_sql_varchar">			   
				   
				 <cfelse>
	                AND #PreserveSingleQuotes(searchKey)#
	                 <cfif Find("%",searchItem) OR Find("_",searchItem)>
	                  LIKE
	                 <cfelse>
	                  =
	                 </cfif>
	                 <cfqueryparam value="#UCase(searchItem)#" cfsqltype="cf_sql_varchar">
	                </cfif>			 
				 </cfif>
				</cfif>
             </cfloop>     
			 ORDER BY TOWN, LOCALITY, STREET_1, BUILDING_NUMBER, PART_ID
			)
			WHERE ROWNUM < 202
		  </cfquery> 
                
       <cfreturn qSearchResults>      
     
    </cffunction>
    
    <cffunction name="doWestMidsAddressSearch" output="false" access="remote" returntype="any" hint="does the west mids region address search">
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
        <cfset var addressArrayXml="">
        <cfset var iAddr=1>
        <cfset var rispAddressSearchHeader=variables.rispAddressSearchHeader>
        <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
        <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
        
        <!--- replace the user, terminal, unique ref and timestamp vars --->
        <cfset rispAddressSearchHeader=Replace(rispAddressSearchHeader,"**userId**",arguments.userId)>
        <cfset rispAddressSearchHeader=Replace(rispAddressSearchHeader,"**terminalId**",arguments.terminalId)>  
        <cfset rispAddressSearchHeader=Replace(rispAddressSearchHeader,"**uniqueRequestId**",uniqueRef)>  
        <cfset rispAddressSearchHeader=Replace(rispAddressSearchHeader,"**timestamp**",timestamp)>                        
        
        <cfoutput>
        <cfxml variable="searchXML">
          #rispAddressSearchHeader#
          #searchTerms#
          #variables.rispAddressSearchFooter#
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
                    <cfset westMidsResult.addresses=resultXml>
                    
                    <cfset westMidsResult.addresses=ArrayNew(1)>
                    
                    <cfset addressArrayXml=XmlSearch(resultXml,"//addsearchresult")>
                    
                    <cfloop from="1" to="#ArrayLen(addressArrayXml)#" index="iAddr">
                      <cfset ArrayAppend(westMidsResult.addresses,readWestMidsAddressSearchResult(xmlObj=addressArrayXml[iAddr]))>
					  <cfif iAddr GT 500>					
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
			  
			  <cfset errorFile=DateFormat(now(),"YYYYMMDD")&TimeFormat(now(),"HHmmss")&".xml">
			  <cffile action="write" file="d:\address_xml_errors\#errorFile#" output="#searchXml#">
			  
			  <!---
			  <cfoutput>
			  <cfmail to="nick.blackham@westmercia.pnn.police.uk" from="genie@westmercia.pnn.police.uk" subject="West Mids Address Error XML">
			  	  #DateFormat(now(),"DD/MM/YYYY")# #TimeFormat(now(),"HH:mm:ss")#
			  	  New error file : #errorFile#
			  	  Error Text :  #westMidsResult.errorText#
			  </cfmail> 
			  </cfoutput> 
			  --->
			    
            </cfif>
         
		<cfreturn westMidsResult>
        
    </cffunction>     

    <cffunction name="doWestMidsAddressSummary" output="false" access="remote" returntype="any" hint="does the west mids region address detail request">
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
        <cfset var addressArrayXml="">
        <cfset var iAddr=1>
        <cfset var rispAddressSummaryHeader=variables.rispAddressSummaryHeader>
        <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
        <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
        
		
        <!--- replace the user, terminal, unique ref and timestamp vars --->
        <cfset rispAddressSummaryHeader=ReplaceNoCase(rispAddressSummaryHeader,"**userId**",arguments.userId,"ALL")>
        <cfset rispAddressSummaryHeader=ReplaceNoCase(rispAddressSummaryHeader,"**terminalId**",arguments.terminalId,"ALL")>  
        <cfset rispAddressSummaryHeader=ReplaceNoCase(rispAddressSummaryHeader,"**appRef**",arguments.searchTerms.appRef,"ALL")>
        <cfset rispAddressSummaryHeader=ReplaceNoCase(rispAddressSummaryHeader,"**sysId**",arguments.searchTerms.sysId,"ALL")>
        <cfset rispAddressSummaryHeader=ReplaceNoCase(rispAddressSummaryHeader,"**forceId**",arguments.searchTerms.forceId,"ALL")>                          
        <cfset rispAddressSummaryHeader=ReplaceNoCase(rispAddressSummaryHeader,"**uniqueRequestId**",uniqueRef,"ALL")>  
        <cfset rispAddressSummaryHeader=ReplaceNoCase(rispAddressSummaryHeader,"**timestamp**",timestamp,"ALL")>                        
        
        <cfoutput>
        <cfxml variable="searchXML">
          #rispAddressSummaryHeader#
        </cfxml>      
        </cfoutput>
              
			<cfhttp url="#variables.rispURL#" method="POST" result="searchResult" timeout="#variables.wMidsTimeout#"
						 port="#variables.rispPort#" useragent="">
				<cfhttpparam type="header" name="SOAPAction" value='"#variables.rispSoapAction#"'> 
				<cfhttpparam type="xml" name="body" value="#searchXml#">       
			</cfhttp>         
            
            <cfset westMidsResult.status=searchResult.statusCode>
            <cfset westMidsResult.xml=rispAddressSummaryHeader>            
            
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

    <cffunction name="doWestMidsAddressDetail" output="false" access="remote" returntype="any" hint="does the west mids region address detail request">
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
        <cfset var addressArrayXml="">
        <cfset var iAddr=1>
        <cfset var rispAddressDetailHeader=variables.rispAddressDetailHeader>
        <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
        <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
        
        <!--- replace the user, terminal, unique ref and timestamp vars --->
        <cfset rispAddressDetailHeader=ReplaceNoCase(rispAddressDetailHeader,"**userId**",arguments.userId,"ALL")>
        <cfset rispAddressDetailHeader=ReplaceNoCase(rispAddressDetailHeader,"**terminalId**",arguments.terminalId,"ALL")>  
        <cfset rispAddressDetailHeader=ReplaceNoCase(rispAddressDetailHeader,"**appRef**",arguments.searchTerms.appRef,"ALL")>
        <cfset rispAddressDetailHeader=ReplaceNoCase(rispAddressDetailHeader,"**sysId**",arguments.searchTerms.sysId,"ALL")>
        <cfset rispAddressDetailHeader=ReplaceNoCase(rispAddressDetailHeader,"**forceId**",arguments.searchTerms.forceId,"ALL")>                          
        <cfset rispAddressDetailHeader=ReplaceNoCase(rispAddressDetailHeader,"**uniqueRequestId**",uniqueRef,"ALL")>  
        <cfset rispAddressDetailHeader=ReplaceNoCase(rispAddressDetailHeader,"**timestamp**",timestamp,"ALL")>                        
        
        <cfoutput>
        <cfxml variable="searchXML">
          #rispAddressDetailHeader#
        </cfxml>      
        </cfoutput>
                
              
			<cfhttp url="#variables.rispURL#" method="POST" result="searchResult" timeout="#variables.wMidsTimeout#"
						 port="#variables.rispPort#" useragent="">
				<cfhttpparam type="header" name="SOAPAction" value='"#variables.rispSoapAction#"'> 
				<cfhttpparam type="xml" name="body" value="#searchXml#">       
			</cfhttp>         
            
            <cfset westMidsResult.status=searchResult.statusCode>
            <cfset westMidsResult.xml=rispAddressDetailHeader>            
            
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

    <cffunction name="doWestMidsGrouping" output="false" access="remote" returntype="any" hint="groups west mids addresses together">
      <cfargument name="addresses" type="array" required="true" hint="array of west mids addresses">
      
      <cfset var groupedInfo=structNew()>
      <cfset var groupQuery=QueryNew('houseNo,town,street,postcode,app_ref,force_ref,sys_ref','varchar,varchar,varchar,varchar,varchar,varchar,varchar')>
      <cfset var x=1>
      <cfset var ignore="">
      
      <cfloop from="1" to="#ArrayLen(addresses)#" index="x">
        <cfset ignore=QueryAddRow(groupQuery,1)>
        <cfset ignore=QuerySetCell(groupQuery,"houseNo",Replace(addresses[x].getBUILDING_NUMBER(),"/"," ","ALL"),x)>
        <cfset ignore=QuerySetCell(groupQuery,"town",Replace(addresses[x].getTOWN(),"/"," ","ALL"),x)>
        <cfset ignore=QuerySetCell(groupQuery,"postcode",addresses[x].getPOST_CODE(),x)>
        <cfset ignore=QuerySetCell(groupQuery,"street",addresses[x].getSTREET_1(),x)>        
        <cfset ignore=QuerySetCell(groupQuery,"app_ref",addresses[x].getAPP_REF(),x)>
        <cfset ignore=QuerySetCell(groupQuery,"force_ref",addresses[x].getFORCE_REF(),x)>
        <cfset ignore=QuerySetCell(groupQuery,"sys_ref",addresses[x].getSYS_REF(),x)>                                        
      </cfloop>
      
      <cfquery name="qDis" dbtype="query">
       SELECT DISTINCT houseNo,street,town,postcode
       FROM groupQuery
       ORDER BY houseNo, postcode
      </cfquery>
      
      <cfset groupedInfo.fullQuery=groupQuery>
      <cfset groupedInfo.distinctQuery=qDis>
            
      <cfreturn groupedInfo>
    
    </cffunction>

    <cffunction name="getNominalAddresses" output="false" access="public" returntype="query" hint="returns a query nominal addresses">
	     <cfargument name="nominalRef" required="true" type="string" hint="nominal ref to get offences for">
	     
	     <cfset var qAddresses="">
	     
			<CFQUERY NAME = "qAddresses" DATASOURCE="#variables.WarehouseDSN#">
			SELECT REPLACE(DECODE(PART_ID,'','','FLAT '||PART_ID||', '),'FLAT FLAT','FLAT')||
				   DECODE(BUILDING_NAME,'','',BUILDING_NAME||', ')||
				   DECODE(BUILDING_NUMBER,'','',BUILDING_NUMBER||', ')||
				   DECODE(STREET_1,'','',STREET_1||', ')||
				   DECODE(LOCALITY,'','',LOCALITY||', ')||
				   DECODE(TOWN,'','',TOWN||', ')||
				   DECODE(COUNTY,'','',COUNTY||' ')||
				   DECODE(addr.POST_CODE,'','',addr.POST_CODE) Address,				   
				   addr.*, nom.TYPE, TO_CHAR(nom.RECORDED,'DD/MM/YYYY') AS DATE_REC,
				   (SELECT SNT_CODE 
                            FROM browser_owner.SNT_LOOKUP sl
                            WHERE sl.LPT_CODES(+) LIKE '%'||addr.LPA||'%'
                             AND addr.LPA IS NOT NULL) AS SNT_CODE
			FROM   browser_owner.GE_ADDRESSES addr, browser_owner.GE_ADD_NOMINALS nom
			WHERE  nom.POST_CODE=addr.POST_CODE
			AND    addr.PREMISE_KEY=nom.PREMISE_KEY
			AND    nom.NOMINAL_REF='#arguments.nominalRef#'
			ORDER BY RECORDED DESC
			</cfquery>
	                
	     <cfreturn qAddresses>
	     
	    </cffunction> 

   <cffunction name="getNominalSearchAddresses" output="false" access="public" returntype="array" hint="returns an array of html formatted addresses based on a query of nominals being passed in">
     <cfargument name="qNoms" required="true" type="query" hint="query containing a list of nominals with NOMINAL_REF column">
     
     <cfset var arrAddresses=ArrayNew(1)>
     <cfset var lisNominals="">
     <cfset var qAddress="">
     <cfset var qNomAddr="">
     <cfset var iNom="">
     
     <!--- create a list of nominal refs --->
     <cfloop query="arguments.qNoms">
       <cfset lisNominals=ListAppend(lisNominals,NOMINAL_REF,",")>
     </cfloop>
     
     <!--- query for all warnings on nominals in list --->
     <cfquery name="qAddress" datasource="#variables.warehouseDSN#">
	 SELECT DECODE(AD.PART_ID,'','',AD.PART_ID||', ') || DECODE(AD.BUILDING_NAME,'','',AD.BUILDING_NAME||', ') ||
            DECODE(AD.BUILDING_NUMBER,'','',AD.BUILDING_NUMBER||', ') || DECODE(AD.STREET_1,'','',AD.STREET_1||', ') ||
            DECODE(AD.LOCALITY,'','',AD.LOCALITY||', ') || DECODE(AD.TOWN,'','',AD.TOWN||', ')||
            DECODE(AD.COUNTY,'','',AD.COUNTY||' ') || DECODE(AD.POST_CODE,'','',AD.POST_CODE) || ' RECORDED: ' ||
            TO_CHAR(AN.RECORDED,'DD/MM/YYYY') ADDRESS, an.NOMINAL_REF 
	 FROM   browser_owner.GE_ADDRESSES AD, browser_owner.GE_ADD_NOMINALS AN
	 WHERE  an.NOMINAL_REF IN (<cfqueryparam value="#lisNominals#" cfsqltype="cf_sql_varchar" list="true">)	 
     AND    an.latest_flag(+) = 'Y'
     AND    ad.post_code(+) = an.post_code
     AND    ad.premise_key(+) = an.premise_key
     </cfquery>
     
     <!--- loop round all nominals and get their warnings. if they have none then set their position in the array
           to a blank. If they do have warnings then concatenate their array entry with <br> to give a full
           html warning list --->
     <cfset iNom=1>      
     <cfloop query="arguments.qNoms">
         
           <cfquery name="qNomAddr" dbtype="query">
	        SELECT * 
	        FROM   qAddress
	        WHERE  NOMINAL_REF=<cfqueryparam value="#NOMINAL_REF#" cfsqltype="cf_sql_varchar">
           </cfquery>
           
           <cfif qNomAddr.RecordCount GT 0>
             <!--- nominal has no warnings 
             <cfset arrWarnings[iNom]="">
           <cfelse>--->
             <!--- nominal has warnings --->
                  <cfset arrAddresses[iNom]=qNomAddr.ADDRESS> 
           </cfif>
           
           <cfset iNom=iNom+1>
           
     </cfloop>
          
     <cfreturn arrAddresses>
     
   </cffunction>

</cfcomponent>