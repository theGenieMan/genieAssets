<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        <cfargument name="rispImsMemo" required="true" type="String">  
        <cfargument name="rispURL" required="true" type="String">        
        <cfargument name="rispPort" required="true" type="String">                
        <cfargument name="rispSoapAction" required="true" type="String">                 
        <cfargument name="forceLookup" required="true" type="String"> 
        <cfargument name="wMidsTimeout" required="true" type="String"> 
		<cfargument name="intelFreeTextUrl" required="true" type="String">   
      
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>          
        <cfset variables.rispImsMemo=arguments.rispImsMemo>      
        <cfset variables.rispURL=arguments.rispURL>
        <cfset variables.rispPort=arguments.rispPort>
        <cfset variables.rispSoapAction=arguments.rispSoapAction>        
        <cfset variables.forceLookup=arguments.forceLookup> 
        <cfset variables.wMidsTimeout=arguments.wMidsTimeout>
		<cfset variables.intelFreeTextUrl=arguments.intelFreeTextUrl>                      
           
        <cfreturn this />  
    </cffunction>
    
	<cffunction name="read" output="false" access="public" returntype="genieObj.intel.intel">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			 SELECT  *
			   FROM  BROWSER_OWNER.INTELL_SEARCH
		      WHERE  LOG_REF = <cfqueryparam cfsqltype="CF_SQL_NUMERIC" value="#obj.getLOG_REF()#" />	      
			</cfquery>
	
			<cfscript>
				obj.setLOG_REF(qRead.LOG_REF);
				obj.setSOURCE(qRead.SOURCE);
				obj.setSOURCE_DOC_REF(qRead.SOURCE_DOC_REF);
				obj.setSOURCE_LOC(qRead.SOURCE_LOC);
				obj.setDATE_START(qRead.DATE_START);
				obj.setDATE_END(qRead.DATE_END);
				obj.setDATE_CREATED(qRead.DATE_CREATED);
				obj.setBADGE_NUMBER(qRead.BADGE_NUMBER);
				obj.setDIVISION(qRead.DIVISION);
				obj.setINDICATOR(qRead.INDICATOR);				
				obj.setSECURITY_ACCESS_LEVEL(qRead.SECURITY_ACCESS_LEVEL);
				obj.setNAME(qRead.NAME);
				obj.setINFO_CODE(qRead.INFO_CODE);
				obj.setSOURCE_CODE(qRead.SOURCE_CODE);
				obj.setHAND_CODE(qRead.HAND_CODE);
				obj.setORG_CODE_FORCE(qRead.ORG_CODE_FORCE);
				obj.setHAND5_OPT(qRead.HAND5_OPT);
				obj.setHAND_GUIDANCE(qRead.HAND_GUIDANCE);
				return obj;
			</cfscript>
		</cffunction>    
    
    <cffunction name="vehicleHasIntel" output="false" access="public" returntype="string" hint="function that returns true of a vehicle has intel logs or false if it doesn't">
      <cfargument name="vehRef" type="string" required="true" hint="vrm of vehicle to check">
      
      <cfset var hasIntel="NO">
      <cfset var qHasIntel="">
      
		  <cfquery name="qHasIntel" datasource="#variables.WarehouseDSN#">
				  SELECT LOG_REF
				  FROM   browser_owner.INTELL_VEHS
				  WHERE  VEH_REF='#vehRef#'
			  </cfquery> 
	                
	          <cfif qHasIntel.recordCount GT 0>
	           <cfset hasIntel="YES">
	          </cfif>      
	                
	       <cfreturn hasIntel>      
	     
	    </cffunction>     
	    
	<cffunction name="telephoneHasIntel" output="false" access="public" returntype="string" hint="function that returns true of a vehicle has intel logs or false if it doesn't">
	      <cfargument name="source" type="string" required="true" hint="source of telephone to check">
	      <cfargument name="sourceId" type="string" required="true" hint="source id of telephone to check">      
	      
	      <cfset var hasIntel="NO">
	      <cfset var qHasIntel="">
	      
			  <cfquery name="qHasIntel" datasource="#variables.WarehouseDSN#">
				  SELECT LOG_REF, TEL_NO, SOURCE, SOURCE_ID
				  FROM   browser_owner.INTELL_TELS
				  WHERE  SOURCE    =<cfqueryparam value="#arguments.source#" cfsqltype="cf_sql_varchar">
	              AND    SOURCE_ID =<cfqueryparam value="#arguments.sourceId#" cfsqltype="cf_sql_varchar">
			  </cfquery> 
	                
	          <cfif qHasIntel.recordCount GT 0>
	           <cfset hasIntel="YES">
	          </cfif>      
	                
	       <cfreturn hasIntel>      
	     
	    </cffunction>       
	
	<cffunction name="getNominalIraqs" output="false" access="public" returntype="query">
			<cfargument name="nominalRef" required="true">
			<cfargument name="sort" required="true">            
			<cfset var qRead="">
	
			<cfquery name="qRead" DATASOURCE="#variables.WarehouseDSN#">	
			Select ints.log_ref, indicator as LOG_INDICATOR, source_doc_ref,source as doc_source, date_start As DateFrom, 
			       date_end As DateTo, security_access_level, to_char(date_created,'DD') AS day_created, 
				   to_char(date_created,'MM') AS month_created, to_char(date_created,'YYYY') AS year_created,
				   source_code||info_code||hand_code||hand5_opt as five_by_five, source_code, info_code, hand_code, hand5_opt, hand_guidance
			from browser_owner.INTELL_SEARCH ints, browser_owner.INTELL_NOMS intn
			where intn.NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
			and ints.log_ref=intn.log_ref
            <cfif sort is "logno">
			Order By log_ref desc
            </cfif>
            <cfif sort is "date">
            Order By date_start desc
            </cfif>
            <cfif sort is "sal">
            Order By security_access_level, date_start desc
            </cfif>
			</cfquery>
	        
	        <cfreturn qRead>
		</cffunction>
	
    <cffunction name="getIMSInfo" output="false" access="public" returntype="array" hint="returns the IMS Memo Warning/Flag or Operation">
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
	    <cfset var memoArrayXml="">
	    <cfset var rispImsMemo=variables.rispImsMemo>
        <cfset var arrMemo=ArrayNew(1)>
	    <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
	    <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
	    
	    <!--- replace the user, terminal, unique ref and timestamp vars --->
	    <cfset rispImsMemo=ReplaceNoCase(rispImsMemo,"**userId**",arguments.userId,"ALL")>
	    <cfset rispImsMemo=ReplaceNoCase(rispImsMemo,"**terminalId**",arguments.terminalId,"ALL")>  
	    <cfset rispImsMemo=ReplaceNoCase(rispImsMemo,"**appRef**",arguments.searchTerms.appRef,"ALL")>
	    <cfset rispImsMemo=ReplaceNoCase(rispImsMemo,"**sysId**",arguments.searchTerms.sysId,"ALL")>
	    <cfset rispImsMemo=ReplaceNoCase(rispImsMemo,"**forceId**",arguments.searchTerms.forceId,"ALL")>                          
	    <cfset rispImsMemo=ReplaceNoCase(rispImsMemo,"**uniqueRequestId**",uniqueRef,"ALL")>  
	    <cfset rispImsMemo=ReplaceNoCase(rispImsMemo,"**timestamp**",timestamp,"ALL")>                        
	    
	    <cfoutput>
	     <cfxml variable="searchXML">
	       #rispImsMemo#
	     </cfxml>      
	     </cfoutput>
	             
	    
		<cfhttp url="#variables.rispURL#" method="POST" result="searchResult" timeout="#variables.wMidsTimeout#"
					 port="#variables.rispPort#" useragent="">
			<cfhttpparam type="header" name="SOAPAction" value='"#variables.rispSoapAction#"'> 
			<cfhttpparam type="xml" name="body" value="#searchXml#">       
		</cfhttp>   
        
            <cfset westMidsResult.status=searchResult.statusCode>
            <cfset westMidsResult.xml=rispImsMemo>            
            
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
                   <cffile action="append" file="d:\logs\ims_diag.txt" output="#now()# | #resultXml# ">
                  <cfif isXml(resultXml)>
                    <cfset resultXml=XmlParse(resultXml)>        
                                
                    <cfset memoArrayXml=XmlSearch(resultXml,"//IMS_MEMO")>
                    
                    <cfloop from="1" to="#ArrayLen(memoArrayXml)#" index="iMemo">
                       <cfset arrMemo[iMemo]=StructNew()>
                       <cfset arrMemo[iMemo].creator=memoArrayXml[iMemo].CREATOR.XmlText>
                       <cfset arrMemo[iMemo].dateStart=memoArrayXml[iMemo].START_DATE.XmlText>
                       <cfif StructKeyExists(memoArrayXml[iMemo],"END_DATE")>
                       <cfset arrMemo[iMemo].dateEnd=memoArrayXml[iMemo].END_DATE.XmlText>                                              
                       <cfelse>
                       <cfset arrMemo[iMemo].dateEnd="">                                                                     
                       </cfif>
                       <cfset arrMemo[iMemo].message=memoArrayXml[iMemo].MESSAGE.XmlText>                       
                    </cfloop>           
                                                                                              
                  </cfif>
              </cfif>
            </cfif>
                    
    <cfreturn arrMemo>
      
    </cffunction>    
    
	<cffunction name="getCategories" output="false" access="public" returntype="query">
			
			<cfset var qCats="">
	
			<cfquery name="qCats" DATASOURCE="#variables.WarehouseDSN#">	
			Select *
			from browser_owner.INTELL_INDEXES_LOOKUP
			where INDEX_TYPE=<cfqueryparam value="CAT" cfsqltype="cf_sql_varchar">
			order by INDEX_CODE
			</cfquery>
	        
	        <cfreturn qCats>
	 </cffunction>    

	<cffunction name="getIntelCount" output="false" access="public" returntype="numeric" hint="returns a number of intel logs for division / start end dates">
		<cfargument name="division" required="true" type="string" hint="Div Code">
		<cfargument name="startDate" required="true" type="string" hint="format dd/mm/yyyy">
		<cfargument name="endDate" required="true" type="string" hint="format dd/mm/yyyy">	
			
			<cfset var qCount="">
	
			<cfquery name="qCount" DATASOURCE="#variables.WarehouseDSN#" result="qRes">	
			Select COUNT(LOG_REF) as INTEL_COUNT
			from browser_owner.INTELL_SEARCH
			where (1=1)
			and   DIVISION IN (<cfqueryparam value="#arguments.division#" cfsqltype="cf_sql_varchar" list="true">)
			and   TRUNC(DATE_CREATED) BETWEEN  TRUNC(TO_DATE('#arguments.startDate#','DD/MM/YYYY'))
			                               AND TRUNC(TO_DATE('#arguments.endDate#','DD/MM/YYYY'))			
			</cfquery>						
	        
	        <cfreturn qCount.INTEL_COUNT>
	 </cffunction>  

	<cffunction name="getSNTIntel" output="false" access="public" returntype="query" hint="returns intel logs for nominals and addresses on an SNT area">
		<cfargument name="area" required="true" type="string" hint="SNT to get intel for">
		<cfargument name="dateFrom" required="true" type="string" hint="format dd/mm/yyyy">
		<cfargument name="dateTo" required="true" type="string" hint="format dd/mm/yyyy">	
			
			<cfset var qSNTLookup="">
			<cfset var qIntel="">			
			<cfset var lptList="">
			
			<!--- lookup LPT codes for the SNT --->
			<cfquery name="qSNTLookup" datasource="#variables.WarehouseDSN#">
			  SELECT LPT_CODES
			  FROM   browser_owner.SNT_LOOKUP
			  WHERE  SNT_CODE=<cfqueryparam value="#arguments.area#" cfsqltype="cf_sql_varchar">	
			</cfquery>
	
	 		<cfset lptList=replace(qSNTLookup.LPT_CODES,"|",",","ALL")>	
	
			<!--- run the query to get intelligence on nominals who have their latest home address in the area --->
			<cfquery name="qIntel" DATASOURCE="#variables.WarehouseDSN#">	
				SELECT INTS.DATE_CREATED,ints.LOG_REF, ns.NOMINAL_REF, 
				       REPLACE(REPLACE(LTRIM(RTRIM(ND.TITLE)||' '||
				                           RTRIM(NS.SURNAME_1)||DECODE(NS.SURNAME_2,NULL,'','-'||NS.SURNAME_2)||', '||
				                           RTRIM(INITCAP(NS.FORENAME_1))||' '||
				                           RTRIM(INITCAP(NS.FORENAME_2))),' ,',','),'  ' ,' ')
				                           || DECODE(NS.FAMILIAR_NAME,'','', ' (Nick ' || NS.FAMILIAR_NAME || ')')
				                           || DECODE(NS.MAIDEN_NAME,NULL,'',' (Nee ' || NS.MAIDEN_NAME || ')') FULL_NAME,
				       DECODE(addr.PART_ID,'','',addr.PART_ID||', ') || DECODE(addr.BUILDING_NAME,'','',addr.BUILDING_NAME||', ') ||
				       DECODE(addr.BUILDING_NUMBER,'','',addr.BUILDING_NUMBER||', ') || DECODE(addr.STREET_1,'','',addr.STREET_1||', ') ||
				       DECODE(addr.LOCALITY,'','',addr.LOCALITY||', ') || DECODE(addr.TOWN,'','',addr.TOWN||', ')||
				       DECODE(addr.COUNTY,'','',addr.COUNTY||' ') || DECODE(addr.POST_CODE,'','',addr.POST_CODE) Address,
				       TO_CHAR(ADDN.RECORDED,'DD/MM/YYYY') DATE_REC,                                  
				       TO_NUMBER(INTS.SECURITY_ACCESS_LEVEL) AS SECURITY_ACCESS_LEVEL,
				       INTS.INDICATOR,
				       INTS.SOURCE_DOC_REF,
				       INTS.HAND_CODE,
				       INTS.HAND_GUIDANCE,
				       INTS.DIVISION
				FROM   browser_owner.INTELL_SEARCH ints, browser_owner.INTELL_NOMS inom ,
				       browser_owner.GE_ADD_NOMINALS addn, browser_owner.GE_ADDRESSES addr, 
				       browser_owner.NOMINAL_SEARCH ns, browser_owner.NOMINAL_DETAILS nd
				WHERE  TRUNC(INTS.DATE_CREATED) BETWEEN TRUNC(TO_DATE('#arguments.dateFrom#','DD/MM/YYYY'))
			                                	    AND TRUNC(TO_DATE('#arguments.dateTo#','DD/MM/YYYY'))
				AND    ints.LOG_REF=inom.LOG_REF
				AND    inom.NOMINAL_REF=addn.NOMINAL_REF
				AND    inom.NOMINAL_REF=ns.NOMINAL_REF
				AND    ns.NOMINAL_REF=nd.NOMINAL_REF
				AND    (addn.POST_CODE = addr.POST_CODE AND ADDN.PREMISE_KEY = addr.PREMISE_KEY )
				AND    ADDN.LATEST_FLAG = 'Y'
				AND    ADDR.LPA IN (<cfqueryparam value="#lptList#" cfsqltype="cf_sql_varchar" list="true">)
				UNION
				SELECT INTS.DATE_CREATED, ints.LOG_REF, '' AS NOMINAL_REF, '' AS FULL_NAME,
				       DECODE(addr.PART_ID,'','',addr.PART_ID||', ') || DECODE(addr.BUILDING_NAME,'','',addr.BUILDING_NAME||', ') ||
				       DECODE(addr.BUILDING_NUMBER,'','',addr.BUILDING_NUMBER||', ') || DECODE(addr.STREET_1,'','',addr.STREET_1||', ') ||
				       DECODE(addr.LOCALITY,'','',addr.LOCALITY||', ') || DECODE(addr.TOWN,'','',addr.TOWN||', ')||
				       DECODE(addr.COUNTY,'','',addr.COUNTY||' ') || DECODE(addr.POST_CODE,'','',addr.POST_CODE) Address,       
				       '' AS DATE_REC,                                  
				       TO_NUMBER(INTS.SECURITY_ACCESS_LEVEL) AS SECURITY_ACCESS_LEVEL,
				       INTS.INDICATOR,
				       INTS.SOURCE_DOC_REF,
				       INTS.HAND_CODE,
				       INTS.HAND_GUIDANCE,
				       INTS.DIVISION
				FROM   browser_owner.INTELL_SEARCH ints, BROWSER_OWNER.INTELL_ADDS iadd ,
				       browser_owner.GE_ADDRESSES addr
				WHERE  TRUNC(INTS.DATE_CREATED) BETWEEN TRUNC(TO_DATE('#arguments.dateFrom#','DD/MM/YYYY'))
			                                	    AND TRUNC(TO_DATE('#arguments.dateTo#','DD/MM/YYYY'))
				AND    ints.LOG_REF=iadd.LOG_REF
				AND    (iadd.POST_CODE = addr.POST_CODE AND iadd.PREMISE_KEY = addr.PREMISE_KEY )
				AND    ADDR.LPA IN (<cfqueryparam value="#lptList#" cfsqltype="cf_sql_varchar" list="true">)				
				ORDER BY 1 DESC						
			</cfquery>	
			
	        
	        <cfreturn qIntel>
	 </cffunction> 
    
	<cffunction name="doIntelEnquiry" output="false" access="public" returntype="array" hint="function the performs intel enquiry search">
      <cfargument name="searchTerms" type="struct" required="true" hint="structure of search terms for address query">
      
      <cfset var qSearchResults="">
      <cfset var searchItem="">
      <cfset var searchKey="">
      <cfset var intelArray=arrayNew(1)>
	  <cfset var thisIntel="">
	    
		  <cfquery name="qSearchResults" datasource="#variables.WarehouseDSN#">		  	  
		  	 SELECT * FROM (
			  SELECT int.*
				FROM   browser_owner.INTELL_SEARCH int
				       <cfif ListLen(searchTerms.CATEGORY,",") GT 0>
					   , browser_owner.INTELL_INDEXES idx	   
					   </cfif>
				WHERE  (1=1)
				<cfif ListLen(searchTerms.CATEGORY,",") GT 0>
					AND 
					 (
					        idx.LOG_REF=int.LOG_REF
					   AND  idx.INDEX_TYPE=<cfqueryparam value="CAT" cfsqltype="cf_sql_varchar">
					   AND  idx.INDEX_CODE IN (<cfqueryparam value="#searchTerms.CATEGORY#" cfsqltype="cf_sql_varchar" list="true" >)   
					 )
				</cfif>
				<cfif Len(searchTerms.DIVISION) GT 0>
				 AND int.DIVISION IN (<cfqueryparam value="#searchTerms.DIVISION#" cfsqltype="cf_sql_varchar" list="true">)
				</cfif>
				<cfif Len(searchTerms.DATE_CREATED1) GT 0 and Len(searchTerms.DATE_CREATED2) IS 0>
                 AND TRUNC(DATE_CREATED)=TRUNC(TO_DATE('#searchTerms.DATE_CREATED1#','DD/MM/YYYY'))
                <cfelseif  Len(searchTerms.DATE_CREATED1) GT 0 and Len(searchTerms.DATE_CREATED2) GT 0>
                 AND DATE_CREATED BETWEEN TO_DATE('#searchTerms.DATE_CREATED1# 00:00:00','DD/MM/YYYY HH24:MI:SS') AND TO_DATE('#searchTerms.DATE_CREATED2# 23:59:59','DD/MM/YYYY HH24:MI:SS')
                </cfif>
                <cfloop collection="#arguments.searchTerms#" item="searchKey">
	                <cfset searchItem=StructFind(arguments.searchTerms,PreserveSingleQuotes(searchKey))>
					<cfif ListFindNoCase('DIVISION,CATEGORY,DATE_CREATED1,DATE_CREATED2',searchKey) IS 0>
		                <cfif Len(searchItem) GT 0>
		                AND #PreserveSingleQuotes(searchKey)#
		                 <cfif Find("%",searchItem) OR Find("_",searchItem)>
		                  LIKE
		                 <cfelse>
		                  =
		                 </cfif>
		                 <cfqueryparam value="#searchItem#" cfsqltype="cf_sql_varchar">
		                </cfif>
					</cfif>
	             </cfloop> 
				ORDER BY DATE_START DESC
			)
			WHERE ROWNUM < 202				  
		  </cfquery> 
		  
		  <cfloop query="qSearchResults">
		  	  <cfset thisIntel=createObject('component','genieObj.intel.intel')>
			  <cfset thisIntel.setLOG_REF(LOG_REF)>
		  	  <cfset arrayAppend(intelArray,read(thisIntel))>
		  </cfloop>
                
       <cfreturn intelArray>      
     
    </cffunction>      
    
    <cffunction name="getNominalsOnLog" output="false" access="public" returntype="query">
			<cfargument name="logRef" required="true">
			            
			<cfset var qRead="">
	
			<cfquery name="qRead" DATASOURCE="#variables.WarehouseDSN#">	
			SELECT NOMINAL_REF
			FROM   browser_owner.INTELL_NOMS inom
			WHERE  inom.LOG_REF=<cfqueryparam value="#arguments.logRef#" cfsqltype="cf_sql_varchar">
			</cfquery>
	        
	        <cfreturn qRead>
	</cffunction>
    
     <cffunction name="doIntelFreeTextSearch" output="false" access="public" returntype="struct" hint="returns intel logs from free text searching">
		 <cfargument type="string" name="searchText" required="true" hint="searchText">
		 <cfargument type="string" name="division" required="false" default="" hint="division filter">
		 <cfargument type="string" name="fromDate" required="false" default="" hint="date created from format DD/MM/YYYY">
		 <cfargument type="string" name="toDate" required="false" default="" hint="date created from format DD/MM/YYYY">   
		 <cfargument type="string" name="order" required="false" default="date" hint="order of results date or relevance"> 
		 <cfargument type="string" name="relevance" required="false" default="60" hint="relevance of results 0-100"> 
		 <cfargument type="string" name="accessLevel" required="false" default="99" hint="access level of user searching">  
    
         <cfset var returnStruct=structNew()>
		 <cfset var intelFTSUrl=duplicate(variables.intelFreeTextUrl)>
		 <cfset var cfFromDate="">
		 <cfset var cfToDate="">
		 <cfset var fieldText="">
		 <cfset var sXml="">
		 <cfset var response="">
		 <cfset var hitInfo="">
		 <cfset var arrayLogs=arrayNew(1)>
		 <cfset var arrayDRE=arrayNew(1)>
		 <cfset var i=1>
		 <cfset var sortUrl="">
		 
		 <cfif arguments.order IS "date">
		 	 <cfset sortUrl="INTEL_DATE_CREATED_E:numberdecreasing">
		 <cfelse>		 	 
		 	 <cfset sortUrl=arguments.order>
		 </cfif>
		  
		 <cfset intelFTSUrl=ReplaceNoCase(intelFTSUrl,"~sort~",sortUrl)>
		 <cfset intelFTSUrl=ReplaceNoCase(intelFTSUrl,"~minScore~",relevance)>
		  
		 <cfset intelFTSUrl &= "&Text="&searchText>

         
		 <cfif Len(fromDate) GT 0 AND Len(toDate) GT 0>
		 	  <cfset cfFromDate=CreateDate(ListGetAt(fromDate,3,"/"),ListGetAt(fromDate,2,"/"),ListGetAt(fromDate,1,"/"))>
			  <cfset cfToDate=CreateDate(ListGetAt(toDate,3,"/"),ListGetAt(toDate,2,"/"),ListGetAt(toDate,1,"/"))>
			  <cfset fieldText = "(NRANGE{"&getEpochTime(cfFromDate)&","&getEpochTime(cfToDate)&"}:*/INTEL_DATE_CREATED_E)">    		 	  
		 </cfif> 		  
		 
		 <cfif Len(division) GT 0>
			<cfif Len(fieldText) GT 0>
				<cfset fieldText &= "+AND+">
			</cfif>
			<cfset fieldText &= "MATCH{"&division&"}:INTEL_ORG_CODE"> 		 	 
		 </cfif>
		 
		 <cfif Len(fieldText) GT 0>
		 	<cfset intelFTSUrl &= "&FieldText=("&fieldText&")">
		 </cfif>

		 <cfset returnStruct.url=intelFTSUrl>
		 <cfset returnStruct.recordCount=0>
		 <cfset returnStruct.totalHits=0>
		 <cfset returnStruct.hasHigherAccessLogs=false>		
		  
		 <cfhttp url="#returnStruct.url#" resolveurl="no" method="get" />
		 
		 <!--- query has run ok --->
		 <cfif cfhttp.StatusCode IS "200 OK">
		 	<cfset sXml=XMLParse(cfhttp.fileContent)>	 
		 	
		 	<cfset response=XMLSearch(sXml,"/autnresponse")>
        
	        <!--- query has run on search server successfully --->
	        <cfif response[1].response.XmlText IS "SUCCESS">				
				<cfset summaryElems=XMLSearch(sXml,"/autnresponse/responsedata/")>				
				<cfset returnStruct.totalHits=summaryElems[1].TotalHits.XMLText>
				
				<cfif returnStruct.totalHits GT 0>
					<cfset hitInfo=XMLSearch(sXml,"/autnresponse/responsedata/autn:hit/")>
					
					<cfloop index="i" from="1" to="#ArrayLen(hitInfo)#" step="1">
						<cfset thisLog=CreateObject('component','genieObj.intel.intel').init()>
						<cfset thisLog.setLOG_REF(hitInfo[i].Content.Document.INTEL_LOG_REF.XmlText)>
						<cfset thisLog=read(thisLog)>
						<!--- check the security level of this log against the 
						      users access level passed in.
						      if the level of the log is less than the access of the user
						      then they don't have access to it. So don't show the user 
						      the log, but set the boolean so a message can be displayed --->
						
						<cfif thisLog.getSECURITY_ACCESS_LEVEL() LT arguments.accessLevel>
						    <cfset returnStruct.hasHigherAccessLogs=true>							
						<cfelse>
							<cfset ArrayAppend(arrayLogs,thisLog)>
							<cfset ArrayAppend(arrayDRE,hitInfo[i].Content.Document.DRECONTENT.XmlText)>							
							<cfset returnStruct.recordCount++>
						</cfif>
					</cfloop>
					<cfset returnStruct.logRefs=arrayLogs>
					<cfset returnStruct.logDres=arrayDRE>					
				</cfif>
				
			</cfif>
		 	
		 </cfif>
		 
		 <cfreturn returnStruct>
    
	 </cffunction>
	 
	 <cffunction name="getEpochTime" access="private" output="false" returntype="Numeric" hint="from a date return the epoch time">
		 <cfargument name="date" type="date" required="true" hint="date to be converted">
		
		<cfscript>
		var datetime = 0;
		if (ArrayLen(Arguments) eq 0) {
		datetime = Now();
		}
		else {
		datetime = arguments[1];
		}
		return DateDiff("s", DateConvert("utc2Local", "January 1 1970 00:00"), datetime);
		</cfscript>
		
	 </cffunction>
</cfcomponent>