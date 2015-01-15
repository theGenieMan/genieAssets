<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        <cfargument name="rispURL" required="true" type="String">        
        <cfargument name="rispPort" required="true" type="String">                
        <cfargument name="rispSoapAction" required="true" type="String">   
        <cfargument name="rispPersonSearchHeader" required="true" type="String">   
        <cfargument name="rispPersonSearchFooter" required="true" type="String">                   
        <cfargument name="rispPersonSummaryHeader" required="true" type="String">   
        <cfargument name="rispPersonSummaryFooter" required="true" type="String">         
        <cfargument name="rispPersonDetailHeader" required="true" type="String">   
        <cfargument name="rispPersonDetailFooter" required="true" type="String">                       
        <cfargument name="personSearchProcedure" required="true" type="String">              
        <cfargument name="geniePastePath" required="true" type="String">    
        <cfargument name="forceLookup" required="true" type="String"> 
        <cfargument name="wMidsTimeout" required="true" type="String">                                        
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>
        <cfset variables.rispURL=arguments.rispURL>
        <cfset variables.rispPort=arguments.rispPort>
        <cfset variables.rispSoapAction=arguments.rispSoapAction>
        <cfset variables.rispPersonSearchHeader=arguments.rispPersonSearchHeader>
        <cfset variables.rispPersonSearchFooter=arguments.rispPersonSearchFooter>                
        <cfset variables.rispPersonSummaryHeader=arguments.rispPersonSummaryHeader>
        <cfset variables.rispPersonSummaryFooter=arguments.rispPersonSummaryFooter>              
        <cfset variables.rispPersonDetailHeader=arguments.rispPersonDetailHeader>
        <cfset variables.rispPersonDetailFooter=arguments.rispPersonDetailFooter>                        
        <cfset variables.personSearchProcedure=arguments.personSearchProcedure>   
        <cfset variables.geniePastePath=arguments.geniePastePath>   
        <cfset variables.forceLookup=arguments.forceLookup> 
        <cfset variables.wMidsTimeout=arguments.wMidsTimeout>                        
           
        <cfreturn this />  
    </cffunction> 

    <!--- record reads --->
	<cffunction name="readWestMerciaNominal" output="false" access="public" returntype="genieObj.nominal.nominal">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehousedsn#">
			select 	ns.NOMINAL_REF, PNCID_NO, SURNAME_1, SURNAME_2, FORENAME_1, FORENAME_2, 
					MAIDEN_NAME, FAMILIAR_NAME, SEX, DATE_OF_BIRTH, CRO,
		            HANDED, NAME_TYPE, TITLE, ETHNICITY_16, MARITAL_STATUS, 
					PLACE_OF_BIRTH, HEIGHT_CMS, HEIGHT_INS, WEIGHT_KGS, WEIGHT_LBS, 
					BUILD, SHOE_SIZE, SHOE_UNITS, ACCENT, ETHNICITY_6, 
					OCCUPATION, OCC_CODE, OCC_CLASS, POST_TOWN, OTHER_NAMES_FLAG, 
					SUB_TYPE, RANK, BADGE_NUMBER, DECEASED, CURRENT_WORK_LOCATION, 
					ACCESS_LEVEL, USER_ID, DATE_OF_DEATH, RISK_MAN_FLAG,STEP_FLAG, TACAD_FLAG, COMP_STATUS,
                    DOB_ESTIMATE_FLAG,DOD_ESTIMATE_FLAG,COLLECTOR_DIV,COLLECTOR_TXT,RISK_MAN_TYPE,GLASSES_WORN,GLASSES_USED,MOPI_GROUP,
                    CHILD_CARE_PLAN,DATE_STARTED,DATE_FINISHED,QUICK_STEP_FLAG,TTL_FLAG,
                    REPLACE(REPLACE(LTRIM(
				                      RTRIM(ND.TITLE)||' '||
											        RTRIM(NS.SURNAME_1)||DECODE(NS.SURNAME_2,NULL,'','-'||NS.SURNAME_2)||', '||
											        RTRIM(INITCAP(FORENAME_1))||' '||
											        RTRIM(INITCAP(FORENAME_2))),' ,',','),'  ' ,' ')
													    || DECODE(FAMILIAR_NAME,'','', ' (Nick ' || FAMILIAR_NAME || ')')
															|| DECODE(MAIDEN_NAME,NULL,'',' (Nee ' || MAIDEN_NAME || ')') AS FULL_NAME          
			from    BROWSER_OWNER.NOMINAL_SEARCH ns, BROWSER_OWNER.NOMINAL_DETAILS nd
			where   ns.NOMINAL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.obj.getNOMINAL_REF()#" />
            and     ns.NOMINAL_REF = nd.NOMINAL_REF
		</cfquery>

		<cfscript>
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setPNCID_NO(qRead.PNCID_NO);
			obj.setSURNAME_1(qRead.SURNAME_1);
			obj.setSURNAME_2(qRead.SURNAME_2);
			obj.setFORENAME_1(qRead.FORENAME_1);
			obj.setFORENAME_2(qRead.FORENAME_2);
			obj.setMAIDEN_NAME(qRead.MAIDEN_NAME);
			obj.setFAMILIAR_NAME(qRead.FAMILIAR_NAME);
			obj.setFULL_NAME(qRead.FULL_NAME);			
			obj.setSEX(qRead.SEX);
			obj.setDATE_OF_BIRTH(qRead.DATE_OF_BIRTH);
			obj.setDATE_OF_DEATH(qRead.DATE_OF_DEATH);			
			obj.setCRO(qRead.CRO);
            obj.setHANDED(qRead.HANDED);
			obj.setNAME_TYPE(qRead.NAME_TYPE);
			obj.setTITLE(qRead.TITLE);
			obj.setETHNICITY_16(qRead.ETHNICITY_16);
			obj.setMARITAL_STATUS(qRead.MARITAL_STATUS);
			obj.setPLACE_OF_BIRTH(qRead.PLACE_OF_BIRTH);
			obj.setHEIGHT_CMS(qRead.HEIGHT_CMS);
			obj.setHEIGHT_INS(qRead.HEIGHT_INS);
			obj.setWEIGHT_KGS(qRead.WEIGHT_KGS);
			obj.setWEIGHT_LBS(qRead.WEIGHT_LBS);
			obj.setBUILD(qRead.BUILD);
			obj.setSHOE_SIZE(qRead.SHOE_SIZE);
			obj.setSHOE_UNITS(qRead.SHOE_UNITS);
			obj.setACCENT(qRead.ACCENT);
			obj.setETHNICITY_6(qRead.ETHNICITY_6);
			obj.setOCCUPATION(iif(qRead.OCCUPATION IS 'UNEMPLOYED,UNEMPLOYED',DE('UNEMPLOYED'),DE(qRead.OCCUPATION)));
			obj.setOCC_CODE(qRead.OCC_CODE);
			obj.setOCC_CLASS(qRead.OCC_CLASS);
			obj.setPOST_TOWN(qRead.POST_TOWN);
			obj.setOTHER_NAMES_FLAG(qRead.OTHER_NAMES_FLAG);
			obj.setRISK_MAN_FLAG(qRead.RISK_MAN_FLAG);
			obj.setRISK_MAN_TYPE(qRead.RISK_MAN_TYPE);						
			obj.setSTEP_FLAG(qRead.STEP_FLAG);		
			obj.setTACAD_FLAG(qRead.TACAD_FLAG);					
			obj.setCOMP_STATUS(qRead.COMP_STATUS);									
			obj.setSUB_TYPE(qRead.SUB_TYPE);
			obj.setRANK(qRead.RANK);
			obj.setBADGE_NUMBER(qRead.BADGE_NUMBER);
			obj.setDECEASED(qRead.DECEASED);
			obj.setCURRENT_WORK_LOCATION(qRead.CURRENT_WORK_LOCATION);
			obj.setACCESS_LEVEL(qRead.ACCESS_LEVEL);
			obj.setDOB_ESTIMATE_FLAG(qRead.DOB_ESTIMATE_FLAG);
			obj.setDOD_ESTIMATE_FLAG(qRead.DOD_ESTIMATE_FLAG);
			obj.setCOLLECTOR_DIV(qRead.COLLECTOR_DIV);
			obj.setCOLLECTOR_TXT(qRead.COLLECTOR_TXT);		
			obj.setGLASSES_WORN(qRead.GLASSES_WORN);		
			obj.setGLASSES_USED(qRead.GLASSES_USED);		
			obj.setMOPI_GROUP(qRead.MOPI_GROUP);		
			obj.setCHILD_CARE_PLAN(qRead.CHILD_CARE_PLAN);		
			obj.setDATE_STARTED(qRead.DATE_STARTED);		
			obj.setDATE_FINISHED(qRead.DATE_FINISHED);	
			obj.setQUICK_STEP_FLAG(qRead.QUICK_STEP_FLAG);
			obj.setTTL_FLAG(qRead.TTL_FLAG);																						
			return obj;
		</cfscript>
	</cffunction>
    
	<cffunction name="readWestMidsNominalSearchResult" output="false" access="public" returntype="genieObj.nominal.nominal">
		<cfargument name="xmlObj" required="true">

		<cfset var nominal=CreateObject("component","genieObj.nominal.nominal").init()>

        <Cfset xmlObj=XmlParse(xmlobj)>

           <cfif isDefined("xmlObj.namesearchresult.rec_id.sys_ref")>
			<cfset nominal.setNOMINAL_REF(xmlObj.namesearchresult.rec_id.sys_ref.xmlText)>
		   </cfif>

           <cfif isDefined("xmlObj.namesearchresult.rec_id.sys_ref")>
			<cfset nominal.setSYS_REF(xmlObj.namesearchresult.rec_id.sys_ref.xmlText)>
		   </cfif>         
                    
           <cfif isDefined("xmlObj.namesearchresult.rec_id.app_ref")>
			<cfset nominal.setAPP_REF(xmlObj.namesearchresult.rec_id.app_ref.xmlText)>
		   </cfif>                               

           <cfif isDefined("xmlObj.namesearchresult.rec_id.force_ref")>
			<cfset nominal.setFORCE_REF(xmlObj.namesearchresult.rec_id.force_ref.xmlText)>
		   </cfif>                 
                    
           <cfif isDefined("xmlObj.namesearchresult.rec_id.force_ref")>
			<cfset nominal.setDISPLAY_FORCE(ListGetAt(ListGetAt(variables.forceLookup,ListContains(variables.forceLookup,xmlObj.namesearchresult.rec_id.force_ref.xmlText,","),","),2,"|"))>
		   </cfif>                 
                    
           <cfif isDefined("xmlObj.namesearchresult.family_name")>
			<cfset nominal.setSURNAME_1(xmlObj.namesearchresult.family_name.xmlText)>
		   </cfif>                       
                    
           <cfif isDefined("xmlObj.namesearchresult.forename")>
			<cfset nominal.setFORENAME_1(xmlObj.namesearchresult.forename.xmlText)>
		   </cfif>                    
                    
           <cfif isDefined("xmlObj.namesearchresult.date_of_birth")>
			<cfset nominal.setDATE_OF_BIRTH(xmlObj.namesearchresult.date_of_birth.xmlText)>
		   </cfif>                    
                    
           <cfif isDefined("xmlObj.namesearchresult.gender")>
			<cfset nominal.setSEX(xmlObj.namesearchresult.gender.xmlText)>
		   </cfif>               
                    
           <cfif isDefined("xmlObj.namesearchresult.nominal_type")>
			<cfset nominal.setNAME_TYPE(xmlObj.namesearchresult.nominal_type.xmlText)>
		   </cfif>                         
                    
           <cfif isDefined("xmlObj.namesearchresult.nickname")>
			<cfset nominal.setFAMILIAR_NAME(xmlObj.namesearchresult.nickname.xmlText)>
		   </cfif> 

           <cfif isDefined("xmlObj.namesearchresult.pnc_id")>
			<cfset nominal.setPNCID_NO(xmlObj.namesearchresult.pnc_id.xmlText)>
		   </cfif>                    
                    
           <cfif isDefined("xmlObj.namesearchresult.cro")>
			<cfset nominal.setCRO(xmlObj.namesearchresult.cro.xmlText)>
		   </cfif>        
                    
           <cfif isDefined("xmlObj.namesearchresult.maiden_name")>
			<cfset nominal.setMAIDEN_NAME(xmlObj.namesearchresult.maiden_name.xmlText)>
		   </cfif>      
                    
           <cfif isDefined("xmlObj.namesearchresult.place_of_birth")>
			<cfset nominal.setPLACE_OF_BIRTH(xmlObj.namesearchresult.place_of_birth.xmlText)>
		   </cfif>                          
                    
           <cfif isDefined("xmlObj.namesearchresult.postal_town")>
			<cfset nominal.setNOMINAL_REF(xmlObj.namesearchresult.postal_town.xmlText)>
		   </cfif>                                                
                    
           <cfif isDefined("xmlObj.namesearchresult.ethnic_appearance")>
			<cfset nominal.setETHNICITY_6(xmlObj.namesearchresult.ethnic_appearance.xmlText)>
		   </cfif>      
                    
           <cfif isDefined("xmlObj.namesearchresult.photo_exists_ind")>
			<cfset nominal.setRISP_PHOTO_EXISTS(xmlObj.namesearchresult.photo_exists_ind.xmlText)>
		   </cfif>                                    
                    
           <!---
			nominal.setPNCID_NO(qRead.PNCID_NO);
			nominal.setSURNAME_1(qRead.SURNAME_1);
			nominal.setFORENAME_1(qRead.FORENAME_1);
			nominal.setFAMILIAR_NAME(qRead.FAMILIAR_NAME);
			nominal.setSEX(qRead.SEX);
			nominal.setDATE_OF_BIRTH(qRead.DATE_OF_BIRTH);
			nominal.setCRO(qRead.CRO);
			nominal.setNAME_TYPE(qRead.NAME_TYPE);
			nominal.setDATE_OF_BIRTH(qRead.APP_REF);
			nominal.setCRO(qRead.FORCE_REF);
			nominal.setNAME_TYPE(qRead.SYS_REF);
            --->

     <cfreturn nominal>
         
	</cffunction>    
    
    <!--- searches --->
    <cffunction name="doWestMerciaPersonSearch" output="false" access="remote" returntype="query" hint="accepts searchTerms and runs a west mercia person search, returns a struct with query results, result count, paste path (if requested)">
        <cfargument name="searchTerms" requried="true" type="array" hint="structure of search terms to run the search on">

		<cfset var qRead="">
        <cfset var searchVariable="">
        <cfset var i=1>
        <cfset var value="">
        <cfset var startSP="">
		<cfset var endSP="">

        <cfset startSP=getTickCount()>
		 <CFSTOREDPROC
		   procedure="#variables.personSearchProcedure#"
		   datasource="#variables.WarehouseDSN2#" username="#variables.warehouseUID#" password="#variables.warehousePWD#">
                        
           <cfloop from="1" to="#ArrayLen(searchTerms)#" index="i">  
            <cfif searchTerms[i].key IS "P_SEX">           
              <cfif searchTerms[i].value IS "U">
                 <cfset value=""> 
              <cfelse>
                 <cfset value=searchTerms[i].value>
              </cfif> 
              <cfprocparam type="In" cfsqltype="CF_SQL_varchar" variable="#searchTerms[i].key#" value="#value#">	              
            <cfelse>
              <cfprocparam type="In" cfsqltype="CF_SQL_varchar" variable="#searchTerms[i].key#" value="#searchTerms[i].value#">	
            </cfif>
           </cfloop>
                        
		  <CFPROCRESULT NAME="qRead">
		  </CFSTOREDPROC>
        <cfset endSP=getTickCount()>
		<cflog file="geniePersonWebService" type="information" text="Nominal DAO Stored Proc = #endSP-startSP# ms" />        
		<cfreturn qRead>
    </cffunction>    
    
    <!--- searches --->
    <cffunction name="doWestMerciaPersonSearchPaste" output="false" access="remote" returntype="string" hint="creates the ois paste for the search, returns the path to the file created">
        <cfargument name="qSearchResults" requried="true" type="query" hint="query of the search results to create the paste for">
        <cfargument name="pasteFileName" requried="true" type="string" hint="filename to create paste with">        
		<cfset var sPasteText="">
        <cfset var i_Spaces=0>
        <cfset var sPasteFile="">
        <cfset var sFullPastePath="">
        <cfset var arrLines=ArrayNew(1)>
        <cfset var str_NominalText="">

        <cfset sPasteFile="NOM_"&arguments.pasteFileName>
        
		<cfset arrayAppend(arrLines,"West Mercia Constabulary - GENIE")>
		<cfset arrayAppend(arrLines,"Perform Name Searches")>
		<cfset arrayAppend(arrLines,"+-- Matching Nominals ---------------------------------------------------------+")>
		<cfset arrayAppend(arrLines,"|Nom Ref   Name                              S W DOB        Place Of Birth  NT |")>
		
        <cfloop query="qSearchResults" startrow="1" endrow="200">
        
	        <cfset str_NominalText="|"&NOMINAL_REF>
			<cfset i_Spaces=10-Len(NOMINAL_REF)>
            
			<cfloop index="z" from="1" to="#i_Spaces#" step="1">
			<cfset str_NominalText=str_NominalText&chr(32)>
			</cfloop>
            
	        <cfif Len(NAME) GT 33>
			 <cfset str_NominalText=str_NominalText&Left(NAME,33)>
			<cfelse>
			 <cfset str_NominalText=str_NominalText&NAME>
				<cfset i_Spaces=33-Len(NAME)>
				<cfloop index="z" from="1" to="#i_Spaces#" step="1">
				<cfset str_NominalText=str_NominalText&chr(32)>
				</cfloop>	 
			</cfif>
            
			<cfset str_NominalText=str_NominalText&chr(32)&SEX>		
            
			<cfif Len(WARNINGS) GT 0>
			 <cfset str_NominalText=str_NominalText&chr(32)&'Y'>		
			<cfelse>
  	         <cfset str_NominalText=str_NominalText&chr(32)&chr(32)>				
			</cfif>
            
			<cfif Len(DOB) LT 10>
			  <cfset str_NominalText=str_NominalText&chr(32)&DOB&chr(32)>		
			  <cfset i_Spaces=10-Len(DOB)>
			  <cfloop index="z" from="1" to="#i_Spaces#" step="1">
				<cfset str_NominalText=str_NominalText&chr(32)>
			   </cfloop>	 		
			<cfelse>
			<cfset str_NominalText=str_NominalText&chr(32)&DOB&chr(32)>		
			</cfif>
	        <cfif Len(PLACE_OF_BIRTH) GT 14>
			 <cfset str_NominalText=str_NominalText&Left(PLACE_OF_BIRTH,14)>
			<cfelse>
			 <cfset str_NominalText=str_NominalText&PLACE_OF_BIRTH>
				<cfset i_Spaces=15-Len(PLACE_OF_BIRTH)>
				<cfloop index="z" from="1" to="#i_Spaces#" step="1">
				<cfset str_NominalText=str_NominalText&chr(32)>
				</cfloop>	 
			</cfif>
			<cfset str_NominalText=str_NominalText&chr(32)&NAME_TYPE&chr(32)&chr(32)&"|">
			<cfset ArrayAppend(arrLines,str_NominalText)>
            
        </cfloop>
        
        <cfset ArrayAppend(arrLines,"+------------------------------------------------------------------------------+")>

        <!--- write the paste information --->
        <cffile action="write" addnewline="no" file="#variables.geniePastePath##sPasteFile#" output="#ArrayToList(arrLines,chr(10))#">>

		<cfreturn sPasteFile>
    </cffunction>        
    
    <cffunction name="doWestMidsPersonSearch" output="false" access="remote" returntype="any" hint="does the west mids region person search">
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
        <cfset var nominalArrayXml="">
        <cfset var iNom=1>
        <cfset var rispPersonSearchHeader=variables.rispPersonSearchHeader>
        <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
        <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
        
        <!--- replace the user, terminal, unique ref and timestamp vars --->
        <cfset rispPersonSearchHeader=Replace(rispPersonSearchHeader,"**userId**",arguments.userId)>
        <cfset rispPersonSearchHeader=Replace(rispPersonSearchHeader,"**terminalId**",arguments.terminalId)>  
        <cfset rispPersonSearchHeader=Replace(rispPersonSearchHeader,"**uniqueRequestId**",uniqueRef)>  
        <cfset rispPersonSearchHeader=Replace(rispPersonSearchHeader,"**timestamp**",timestamp)>                        
        
        <cfoutput>
        <cfxml variable="searchXML">
          #rispPersonSearchHeader#
          #searchTerms#
          #variables.rispPersonSearchFooter#
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
                   
                    <cfset nominalArrayXml=XmlSearch(resultXml,"//namesearchresult")>
                    
                    <cfloop from="1" to="#ArrayLen(nominalArrayXml)#" index="iNom">                                        
                      <cfset ArrayAppend(westMidsResult.nominals,readWestMidsNominalSearchResult(xmlObj=nominalArrayXml[iNom]))>
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
    
    <cffunction name="doWestMidsPersonDetail" output="false" access="remote" returntype="any" hint="does the west mids region person detail request">
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
        <cfset var rispPersonDetailHeader=variables.rispPersonDetailHeader>
        <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
        <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
        
        <!--- replace the user, terminal, unique ref and timestamp vars --->
        <cfset rispPersonDetailHeader=ReplaceNoCase(rispPersonDetailHeader,"**userId**",arguments.userId,"ALL")>
        <cfset rispPersonDetailHeader=ReplaceNoCase(rispPersonDetailHeader,"**terminalId**",arguments.terminalId,"ALL")>  
        <cfset rispPersonDetailHeader=ReplaceNoCase(rispPersonDetailHeader,"**appRef**",arguments.searchTerms.appRef,"ALL")>
        <cfset rispPersonDetailHeader=ReplaceNoCase(rispPersonDetailHeader,"**sysId**",arguments.searchTerms.sysId,"ALL")>
        <cfset rispPersonDetailHeader=ReplaceNoCase(rispPersonDetailHeader,"**forceId**",arguments.searchTerms.forceId,"ALL")>                          
        <cfset rispPersonDetailHeader=ReplaceNoCase(rispPersonDetailHeader,"**uniqueRequestId**",uniqueRef,"ALL")>  
        <cfset rispPersonDetailHeader=ReplaceNoCase(rispPersonDetailHeader,"**timestamp**",timestamp,"ALL")>                        
        
        <cfoutput>
        <cfxml variable="searchXML">
          #rispPersonDetailHeader#
        </cfxml>      
        </cfoutput>
                            
			<cfhttp url="#variables.rispURL#" method="POST" result="searchResult" timeout="#variables.wMidsTimeout#"
						 port="#variables.rispPort#" useragent="">
				<cfhttpparam type="header" name="SOAPAction" value='"#variables.rispSoapAction#"'> 
				<cfhttpparam type="xml" name="body" value="#searchXml#">       
			</cfhttp>         
           
            
            <cfset westMidsResult.status=searchResult.statusCode>
            <cfset westMidsResult.xml=rispPersonDetailHeader>            
            
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
                    <cfset westMidsResult.nominals=ArrayNew(1)>
                    
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
    
    <cffunction name="doWestMidsPersonSummary" output="false" access="remote" returntype="any" hint="does the west mids region person summary request">
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
        <cfset var rispPersonSummaryHeader=variables.rispPersonSummaryHeader>
        <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
        <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
        
        <!--- replace the user, terminal, unique ref and timestamp vars --->
        <cfset rispPersonSummaryHeader=ReplaceNoCase(rispPersonSummaryHeader,"**userId**",arguments.userId,"ALL")>
        <cfset rispPersonSummaryHeader=ReplaceNoCase(rispPersonSummaryHeader,"**terminalId**",arguments.terminalId,"ALL")>  
        <cfset rispPersonSummaryHeader=ReplaceNoCase(rispPersonSummaryHeader,"**appRef**",arguments.searchTerms.appRef,"ALL")>
        <cfset rispPersonSummaryHeader=ReplaceNoCase(rispPersonSummaryHeader,"**sysId**",arguments.searchTerms.sysId,"ALL")>
        <cfset rispPersonSummaryHeader=ReplaceNoCase(rispPersonSummaryHeader,"**forceId**",arguments.searchTerms.forceId,"ALL")>                          
        <cfset rispPersonSummaryHeader=ReplaceNoCase(rispPersonSummaryHeader,"**uniqueRequestId**",uniqueRef,"ALL")>  
        <cfset rispPersonSummaryHeader=ReplaceNoCase(rispPersonSummaryHeader,"**timestamp**",timestamp,"ALL")>                        
        
        <cfoutput>
        <cfxml variable="searchXML">
          #rispPersonSummaryHeader#
        </cfxml>      
        </cfoutput>
                            
			<cfhttp url="#variables.rispURL#" method="POST" result="searchResult" timeout="#variables.wMidsTimeout#"
						 port="#variables.rispPort#" useragent="">
				<cfhttpparam type="header" name="SOAPAction" value='"#variables.rispSoapAction#"'> 
				<cfhttpparam type="xml" name="body" value="#searchXml#">       
			</cfhttp>         
           
            
            <cfset westMidsResult.status=searchResult.statusCode>
            <cfset westMidsResult.xml=rispPersonSummaryHeader>            
            
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

    <cffunction name="doWestMidsGrouping" output="false" access="remote" returntype="any" hint="groups west mids nomnals together">
      <cfargument name="nominals" type="array" required="true" hint="array of west mids nominals">
      <cfargument name="group" type="string" required="false" default="name" hint="how to group the west midlands results">	
      
      <cfset var groupedInfo=structNew()>
      <cfset var groupQuery=QueryNew('firstname,surname,dob,nominal_ref,app_ref,force_ref,sys_ref,display_force,risp_photo_exists,risp_photo','varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar')>
      <cfset var x=1>
      <cfset var ignore="">
      
      <cfloop from="1" to="#ArrayLen(nominals)#" index="x">
          
        <cfset ignore=QueryAddRow(groupQuery,1)>
        <cfset ignore=QuerySetCell(groupQuery,"firstname",Replace(nominals[x].getFORENAME_1(),"/"," ","ALL"),x)>
        <cfset ignore=QuerySetCell(groupQuery,"surname",Replace(nominals[x].getSURNAME_1(),"/"," ","ALL"),x)>
        <cfset ignore=QuerySetCell(groupQuery,"dob",nominals[x].getDATE_OF_BIRTH(),x)>
        <cfset ignore=QuerySetCell(groupQuery,"nominal_ref",nominals[x].getNOMINAL_REF(),x)>        
        <cfset ignore=QuerySetCell(groupQuery,"app_ref",nominals[x].getAPP_REF(),x)>
        <cfset ignore=QuerySetCell(groupQuery,"force_ref",nominals[x].getFORCE_REF(),x)>
        <cfset ignore=QuerySetCell(groupQuery,"display_force",nominals[x].getDISPLAY_FORCE(),x)>        
        <cfset ignore=QuerySetCell(groupQuery,"sys_ref",nominals[x].getSYS_REF(),x)>    
        <cfset ignore=QuerySetCell(groupQuery,"risp_photo_exists",nominals[x].getRISP_PHOTO_EXISTS(),x)>
        <cfif nominals[x].getRISP_PHOTO_EXISTS() IS "Y">
        <cfset ignore=QuerySetCell(groupQuery,"risp_photo",nominals[x].photo.getPHOTO_URL(),x)>                                                        
        <cfelse>
        <cfset ignore=QuerySetCell(groupQuery,"risp_photo","",x)>                                                                
        </cfif>
      </cfloop>
      
	  <cfif arguments.group is "name">
	
	      <cfquery name="qDis" dbtype="query">
	       SELECT DISTINCT firstname,surname,dob
	       FROM groupQuery
	      </cfquery>
	      
	  <cfelseif arguments.group is "system">
	  
	      <cfquery name="qDis" dbtype="query">
	       SELECT DISTINCT app_ref
	       FROM groupQuery
	      </cfquery>	  
	  
	  <cfelseif arguments.group is "force">
	  
	      <cfquery name="qDis" dbtype="query">
	       SELECT DISTINCT force_ref
	       FROM groupQuery
	      </cfquery>		  
	  
	  </cfif>
      
      <cfset groupedInfo.fullQuery=groupQuery>
      <cfset groupedInfo.distinctQuery=qDis>
            
      <cfreturn groupedInfo>
    
    </cffunction>

    <cffunction name="getWestMerciaNominalTabs" output="false" access="remote" returntype="any" hint="returns a struct of what tabs a nominal should have displayed">
      <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get tabs for">
      
      <cfset var tabs=structNew()>
      <cfset var qTabs="">
      
			<CFQUERY NAME="qTabs" DATASOURCE="#Application.WarehouseDSN#">
			SELECT r.role, a.adr, b.bail, p.proc, l.link, v.veh, t.tel, c.cust, i.int, m.misper, ass.assoc, nd.docs, nf.feat, w.warr, fp.fp, org.org, step.step, occ.occs, warn.warns,ss.ss,s27.s27, rmp.rmp
			FROM (SELECT MAX('Y') role FROM browser_owner.NOMINAL_ROLES WHERE NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) r,
			     (SELECT MAX('Y') adr  FROM browser_owner.GE_ADDRESSES addr, browser_owner.GE_ADD_NOMINALS nom 
			      WHERE  nom.POST_CODE=addr.POST_CODE AND addr.PREMISE_KEY=nom.PREMISE_KEY AND nom.NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> AND rownum < 2) a,
			     (SELECT MAX('Y') bail FROM browser_owner.BAIL_SEARCH WHERE NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">and rownum < 2) b,
			     (SELECT MAX('Y') proc FROM browser_owner.PD_SEARCH WHERE NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> AND rownum < 2) p,
			     (SELECT MAX('Y') link FROM browser_owner.NOMINAL_LINKS nl WHERE nl.REL_TYPE IN ('ALIA','ALDB','CHRI','FORM','WEDD')
			      AND nl.NOMINAL_REF_1=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) l,
			     (SELECT MAX('Y') veh  FROM browser_owner.VEHICLE_USAGES WHERE NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) v,
			     (SELECT MAX('Y') tel  FROM browser_owner.TELEPHONE_USAGES WHERE NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) t,
			     (select MAX('Y') cust FROM browser_owner.CUSTODY_SEARCH WHERE NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> AND rownum < 2) c,
			     (SELECT MAX('Y') int  FROM browser_owner.INTELL_NOMS WHERE NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) i,
			     (SELECT MAX('Y') misper FROM browser_owner.COMP_CASES WHERE NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) m,
			     (select MAX('Y') assoc from browser_owner.nominal_associates nr where nr.nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2 ) ass,
			     (select MAX('Y') docs from browser_owner.nominal_documents nd where nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) nd,
			     (select MAX('Y') feat from browser_owner.nominal_features WHERE nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) nf,
			     (select MAX('Y') warr FROM browser_owner.WARRANTS WHERE NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> AND rownum < 2) w,        
			     (select MAX('Y') fp from browser_owner.family_protection fp where fp.NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) fp,
			     (select MAX('Y') org from browser_owner.nominal_assignments org where org.nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) org,
			     (select MAX('Y') step from browser_owner.step_nominals s where s.nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) step,
                 (select MAX('Y') occs from browser_owner.nominal_occupations occ where occ.nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) occ,
                 (select MAX('Y') warns from browser_owner.ge_warnings wr where wr.nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) warn,
				 (select MAX('Y') ss from browser_owner.stop_search ss where ss.nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) ss,
				 (select MAX('Y') s27 from browser_owner.section_27 s27 where s27.nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) s27,
				 (select MAX('Y') rmp from browser_owner.risk_man_plan_nominals rmpn where rmpn.nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar"> and rownum < 2) rmp                	                                		     
			</cfquery>
			
            <cfscript>
              tabs.Roles=IIf(qTabs.Role IS 'Y',true,false);
              tabs.Addresses=IIf(qTabs.Adr IS 'Y',true,false);
              tabs.Bails=IIf(qTabs.Bail IS 'Y',true,false);
              tabs.ProcDec=IIf(qTabs.Proc IS 'Y',true,false);
              tabs.Alias=IIf(qTabs.Link IS 'Y',true,false);
              tabs.Vehicles=IIf(qTabs.Veh IS 'Y',true,false);
              tabs.TelNos=IIf(qTabs.Tel IS 'Y',true,false);
              tabs.Custodies=IIf(qTabs.Cust IS 'Y',true,false);                                                                                                  
              tabs.Iraqs=IIf(qTabs.Int IS 'Y',true,false);
              tabs.Misper=IIf(qTabs.MisPer IS 'Y',true,false);
              tabs.Assoc=IIf(qTabs.Assoc IS 'Y',true,false);
              tabs.Docs=IIf(qTabs.Docs IS 'Y',true,false);
              tabs.Feat=IIf(qTabs.Feat IS 'Y',true,false);                                                                                                  
              tabs.Warrants=IIf(qTabs.Warr IS 'Y',true,false);
              tabs.FPU=IIf(qTabs.FP IS 'Y',true,false);
              tabs.Orgs=IIf(qTabs.Org IS 'Y',true,false); 
              tabs.Step=IIf(qTabs.Step IS 'Y',true,false);          
              tabs.Occ=IIf(qTabs.Occs IS 'Y',true,false);     
              tabs.Warn=IIf(qTabs.Warns IS 'Y',true,false);  
			  tabs.SS=IIf(qTabs.ss IS 'Y',true,false);
			  tabs.S27=IIf(qTabs.s27 IS 'Y',true,false);  
			  tabs.rmp=IIf(qTabs.rmp IS 'Y',true,false);                                                                      
            </cfscript>
            
      <cfreturn tabs>
    
    </cffunction>

    <cffunction name="getWestMerciaNominalFullName" output="false" access="remote" returntype="any" hint="returns nominals full name in a string">
      <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get full name for">
      
      <cfset var nominalName="">
      <cfset var qNomName="">
      
			<CFQUERY NAME="qNomName" DATASOURCE="#Application.WarehouseDSN#">
			select  REPLACE(REPLACE(LTRIM(
                    RTRIM(ND.TITLE)||' '||
					        RTRIM(NS.SURNAME_1)||DECODE(NS.SURNAME_2,NULL,'','-'||NS.SURNAME_2)||', '||
					        RTRIM(INITCAP(FORENAME_1))||' '||
					        RTRIM(INITCAP(FORENAME_2))),' ,',','),'  ' ,' ')
							    || DECODE(FAMILIAR_NAME,'','', ' (Nick ' || FAMILIAR_NAME || ')')
									|| DECODE(MAIDEN_NAME,NULL,'',' (Nee ' || MAIDEN_NAME || ')') AS FULL_NAME          
			from    BROWSER_OWNER.NOMINAL_SEARCH ns, BROWSER_OWNER.NOMINAL_DETAILS nd
			where   ns.NOMINAL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nominalRef#" />
            and     ns.NOMINAL_REF = nd.NOMINAL_REF			
           </cfquery>

           <cfif qNomName.RecordCount GT 0>
            <cfset nominalName=qNomName.FULL_NAME>
           </cfif>			
            
      <cfreturn nominalName>
    
    </cffunction>
    
    <cffunction name="getWestMerciaVISORNominals" output="false" access="remote" returntype="any" hint="returns query of VISOR nominals">
      <cfargument name="division" type="string" required="true" hint="division to get list of nominals for">

     <cfset qVISOR="">
     <cfset arrNominals=ArrayNew(1)>    
     <cfset nominal="">
     <cfset i=0>

			<cfquery name="qVISOR" datasource="#variables.WarehouseDSN#">
			select  ws.nominal_ref , 
                DECODE(PART_ID,'','',PART_ID||', ')||
                DECODE(BUILDING_NAME,'','',BUILDING_NAME||', ')||
                DECODE(BUILDING_NUMBER,'','',BUILDING_NUMBER||', ')||
                DECODE(STREET_1,'','',STREET_1||', ')||
                DECODE(LOCALITY,'','',LOCALITY||', ')||
                DECODE(TOWN,'','',TOWN||', ')||
                DECODE(COUNTY,'','',COUNTY||' ')||
                DECODE(addr.POST_CODE,'','',addr.POST_CODE) Address,
                TO_CHAR(RECORDED,'DD/MM/YYYY') AS RECORDED, LPA,
                REPLACE(REPLACE(LTRIM(RTRIM(ND.TITLE)||' '||
                  RTRIM(NS.SURNAME_1)||DECODE(NS.SURNAME_2,NULL,'','-'||NS.SURNAME_2)||', '||
                  RTRIM(INITCAP(FORENAME_1))||' '||
                  RTRIM(INITCAP(FORENAME_2))),' ,',','),'  ' ,' ')
                    || DECODE(FAMILIAR_NAME,'','', ' (Nick ' || FAMILIAR_NAME || ')')
                    || DECODE(MAIDEN_NAME,NULL,'',' (Nee ' || MAIDEN_NAME || ')')
                    ||'<br>'||TO_CHAR(DATE_OF_BIRTH,'DD/MM/YYYY') AS NAME,
                  SURNAME_1 AS SURNAME, FORENAME_1 AS FORENAME            
			from browser_owner.ge_warnings ws, browser_owner.ge_add_nominals nadd, 
			     browser_owner.ge_addresses addr, browser_owner.nominal_search ns,browser_owner.NOMINAL_DETAILS nd
			where ((wsc_code = 'VS' AND nadd.latest_flag='Y') OR (wsc_code = 'VT' AND nadd.latest_flag='T'))
			and ws.nominal_ref=nadd.nominal_ref
			and nadd.post_code=addr.post_code
			AND nadd.premise_key=addr.premise_key
			and nadd.nominal_ref=ns.nominal_ref
			and ns.nominal_ref=nd.nominal_ref
			and SUBSTR(addr.LPA,1,1) = <cfqueryparam value="#arguments.division#" cfsqltype="cf_sql_varchar">
            order by LPA, SURNAME, FORENAME
			</cfquery>
	 
			<cfset i=1>
			<cfloop query="qVISOR">
				
                <cfset nominal=CreateObject("component","genieObj.nominal.nominal").init()>
                <cfset nominal.setNOMINAL_REF(NOMINAL_REF)>
                
                <cfset arrNominals[i]=StructNew()>
                <cfset arrNominals[i].nominal=readWestMerciaNominal(obj=nominal)>
                <cfset arrNominals[i].address=ADDRESS>
                <cfset arrNominals[i].addressRecorded=RECORDED>  
                <cfset arrNominals[i].LPA=LPA>                               
			
			<cfset i=i+1>
			</cfloop>
            
      <cfreturn arrNominals>
    
    </cffunction>    

    <cffunction name="getWestMerciaPPONominals" output="false" access="remote" returntype="any" hint="returns query of PPO nominals">
      <cfargument name="division" type="string" required="true" hint="division to get list of nominals for">

      <cfset qPPO="">
      <cfset arrNominals=ArrayNew(1)>    
      <cfset nominal="">
      <cfset i=0>

		<cfquery name="qPPO" datasource="#variables.WarehouseDSN#">
            SELECT distinct ns.nominal_ref,  DECODE(PART_ID,'','',PART_ID||', ')||
                DECODE(BUILDING_NAME,'','',BUILDING_NAME||', ')||
                DECODE(BUILDING_NUMBER,'','',BUILDING_NUMBER||', ')||
                DECODE(STREET_1,'','',STREET_1||', ')||
                DECODE(LOCALITY,'','',LOCALITY||', ')||
                DECODE(TOWN,'','',TOWN||', ')||
                DECODE(COUNTY,'','',COUNTY||' ')||
                DECODE(addr.POST_CODE,'','',addr.POST_CODE) Address,
                TO_CHAR(RECORDED,'DD/MM/YYYY') AS RECORDED, LPA, ns.surname_1, ns.forename_1
            FROM   oms_owner.OMS_JTRACK j, oms_owner.OMS_OFFENDERS o, browser_owner.nominal_search ns, 
                   OMS_OWNER.OMS_OFF_DIVS od, browser_owner.ge_add_nominals nadd, browser_owner.ge_addresses addr
            WHERE  j.PNC_ID=o.pnc_id
            AND    (PPO_START <= sysdate AND sysdate <= PPO_END)
            and    ns.nominal_ref=o.nominal_ref
            and    o.pnc_id=od.pnc_id
            and    addr.lpa like '#arguments.division#%'
            and    nadd.latest_flag='Y'
            and    nadd.nominal_ref=ns.nominal_ref
            and    addr.premise_key=nadd.premise_key
            and    addr.post_code=nadd.post_code
			order by LPA, ns.surname_1, ns.forename_1
        </cfquery>
        
        <cfset i=1>
			<cfloop query="qPPO">
				
                <cfset nominal=CreateObject("component","genieObj.nominal.nominal").init()>
                <cfset nominal.setNOMINAL_REF(NOMINAL_REF)>
                
                <cfset arrNominals[i]=StructNew()>
                <cfset arrNominals[i].nominal=readWestMerciaNominal(obj=nominal)>
                <cfset arrNominals[i].address=ADDRESS>
                <cfset arrNominals[i].addressRecorded=RECORDED>  
                <cfset arrNominals[i].LPA=LPA>                               
			
			  <cfset i=i+1>
			</cfloop>
        
        <cfreturn arrNominals>
   </cffunction>

</cfcomponent>