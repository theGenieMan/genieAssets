<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        <cfargument name="rispURL" required="true" type="String">        
        <cfargument name="rispPort" required="true" type="String">                
        <cfargument name="rispSoapAction" required="true" type="String">         
        <cfargument name="rispVehicleSearchHeader" required="true" type="String">   
        <cfargument name="rispVehicleSearchFooter" required="true" type="String">          
        <cfargument name="rispVehicleSummaryHeader" required="true" type="String">   
        <cfargument name="rispVehicleSummaryFooter" required="true" type="String">          
        <cfargument name="rispVehicleDetailHeader" required="true" type="String">   
        <cfargument name="rispVehicleDetailFooter" required="true" type="String">     
        <cfargument name="forceLookup" required="true" type="String"> 
        <cfargument name="wMidsTimeout" required="true" type="String">                            
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>      
        <cfset variables.rispURL=arguments.rispURL>
        <cfset variables.rispPort=arguments.rispPort>
        <cfset variables.rispSoapAction=arguments.rispSoapAction>        
        <cfset variables.rispVehicleSearchHeader=arguments.rispVehicleSearchHeader>
        <cfset variables.rispVehicleSearchFooter=arguments.rispVehicleSearchFooter>
        <cfset variables.rispVehicleSummaryHeader=arguments.rispVehicleSummaryHeader>
        <cfset variables.rispVehicleSummaryFooter=arguments.rispVehicleSummaryFooter>        
        <cfset variables.rispVehicleDetailHeader=arguments.rispVehicleDetailHeader>
        <cfset variables.rispVehicleDetailFooter=arguments.rispVehicleDetailFooter> 
        <cfset variables.forceLookup=arguments.forceLookup>   
        <cfset variables.wMidsTimeout=arguments.wMidsTimeout>                        
           
        <cfreturn this />  
    </cffunction>   
    
    <cffunction name="doWestMerciaVehicleSearch" output="false" access="public" returntype="query" hint="function that does the west mercia vehicle search, returns a query of vehicles and their usages">
      <cfargument name="searchTerms" type="struct" required="true" hint="structure of search terms for address query">
      
      <cfset var qSearchResults="">
      <cfset var searchItem="">
      <cfset var searchKey="">
      <cfset var iVrm=0>
      
		  <cfquery name="qSearchResults" datasource="#variables.WarehouseDSN#" result="theQuery">
			    SELECT vs.VEH_REF AS VEH_REF,vu.*, vs.*
				FROM   browser_owner.VEHICLE_SEARCH vs, browser_owner.VEHICLE_USAGES vu
				WHERE vs.veh_ref=vu.veh_ref(+)
	             <cfloop collection="#arguments.searchTerms#" item="searchKey">
	                <cfset searchItem=StructFind(arguments.searchTerms,PreserveSingleQuotes(searchKey))>
                    <!--- VRM can be an Array of VRMS to search, if we can an array then loop through it to get the
                          different VRMS in the query --->
                   <cfif ListFindNoCase('vrm,manufacturer,model,body_type,shade,primary_col,seconday_col,text',searchKey) GT 0>
                    <cfif PreserveSingleQuotes(searchKey) IS "VRM" and isArray(searchItem)>
                    AND ( 
					 <cfset iVrm=1>
					 <cfloop from="1" to="#ArrayLen(searchItem)#" index="iVrm">
					  <cfif iVrm IS 1>
						 VRM
						<cfelse>
						 OR VRM 
						</cfif>
						 <cfif Find("%",searchItem[iVrm]) OR Find("_",searchItem[iVrm])>LIKE<cfelse>=</cfif>
						 '#searchItem[iVrm]#'
					 </cfloop>
					 	)
                    <cfelse>                                                                                                         
		                <cfif Len(searchItem) GT 0>
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
				ORDER BY START_DATE DESC
		  </cfquery> 

                
       <cfreturn qSearchResults>      
     
    </cffunction>    
   
	<cffunction name="readWestMidsVehicleSearchResult" output="false" access="public" returntype="genieObj.vehicles.vehicle">
		<cfargument name="xmlObj" required="true">

		<cfset var vehicle=CreateObject("component","genieObj.vehicles.vehicle").init()>

        <Cfset xmlObj=XmlParse(xmlobj)>

           <cfif isDefined("xmlObj.vehsearchresult.rec_id.sys_ref")>
			<cfset vehicle.setSYS_REF(xmlObj.vehsearchresult.rec_id.sys_ref.xmlText)>
		   </cfif>         
                    
           <cfif isDefined("xmlObj.vehsearchresult.rec_id.app_ref")>
			<cfset vehicle.setAPP_REF(xmlObj.vehsearchresult.rec_id.app_ref.xmlText)>
		   </cfif>                               
                    
           <cfif isDefined("xmlObj.vehsearchresult.rec_id.force_ref")>
			<cfset vehicle.setFORCE_REF(xmlObj.vehsearchresult.rec_id.force_ref.xmlText)>
		   </cfif>          
                    
           <cfif isDefined("xmlObj.vehsearchresult.rec_id.force_ref")>
			<cfset vehicle.setDISPLAY_FORCE(ListGetAt(ListGetAt(variables.forceLookup,ListContains(variables.forceLookup,xmlObj.vehsearchresult.rec_id.force_ref.xmlText,","),","),2,"|"))>
		   </cfif>                              
                    
           <cfif isDefined("xmlObj.vehsearchresult.vrm")>
			<cfset vehicle.setVRM(xmlObj.vehsearchresult.vrm.xmlText)>
		   </cfif>                       
                    
           <cfif isDefined("xmlObj.vehsearchresult.make")>
			<cfset vehicle.setMANUFACTURER(xmlObj.vehsearchresult.make.xmlText)>
		   </cfif>                    
                    
           <cfif isDefined("xmlObj.vehsearchresult.model")>
			<cfset vehicle.setMODEL(xmlObj.vehsearchresult.model.xmlText)>
		   </cfif>                    
                    
           <cfif isDefined("xmlObj.vehsearchresult.colour")>
			<cfset vehicle.setPRIMARY_COL(xmlObj.vehsearchresult.colour.xmlText)>
		   </cfif>               

     <cfreturn vehicle>
         
	</cffunction>   
   
    <cffunction name="doWestMidsVehicleSearch" output="false" access="remote" returntype="any" hint="does the west mids region address search">
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
        <cfset var vehicleArrayXml="">
        <cfset var iVeh=1>
        <cfset var rispVehicleSearchHeader=variables.rispVehicleSearchHeader>
        <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
        <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
        
        <!--- replace the user, terminal, unique ref and timestamp vars --->
        <cfset rispVehicleSearchHeader=Replace(rispVehicleSearchHeader,"**userId**",arguments.userId)>
        <cfset rispVehicleSearchHeader=Replace(rispVehicleSearchHeader,"**terminalId**",arguments.terminalId)>  
        <cfset rispVehicleSearchHeader=Replace(rispVehicleSearchHeader,"**uniqueRequestId**",uniqueRef)>  
        <cfset rispVehicleSearchHeader=Replace(rispVehicleSearchHeader,"**timestamp**",timestamp)>                        
        
        <cfoutput>
        <cfxml variable="searchXML">
          #rispVehicleSearchHeader#
          #searchTerms#
          #variables.rispVehicleSearchFooter#
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
                    
                    <cfset westMidsResult.vehicles=resultXml>
                                   
                    <cfset westMidsResult.vehicles=ArrayNew(1)>

                    <cfset vehicleArrayXml=XmlSearch(resultXml,"//vehsearchresult")>
                    
                    <cfloop from="1" to="#ArrayLen(vehicleArrayXml)#" index="iVeh">
                      <cfset ArrayAppend(westMidsResult.vehicles,readWestMidsVehicleSearchResult(xmlObj=vehicleArrayXml[iVeh]))>
					  <cfif iVeh GT 500>					
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
    
    <cffunction name="doWestMidsVehicleSummary" output="false" access="remote" returntype="any" hint="does the west mids region telephone summary request">
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
        <cfset var rispVehicleSummaryHeader=variables.rispVehicleSummaryHeader>
        <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
        <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
        
        <!--- replace the user, terminal, unique ref and timestamp vars --->
        <cfset rispVehicleSummaryHeader=ReplaceNoCase(rispVehicleSummaryHeader,"**userId**",arguments.userId,"ALL")>
        <cfset rispVehicleSummaryHeader=ReplaceNoCase(rispVehicleSummaryHeader,"**terminalId**",arguments.terminalId,"ALL")>  
        <cfset rispVehicleSummaryHeader=ReplaceNoCase(rispVehicleSummaryHeader,"**appRef**",arguments.searchTerms.appRef,"ALL")>
        <cfset rispVehicleSummaryHeader=ReplaceNoCase(rispVehicleSummaryHeader,"**sysId**",arguments.searchTerms.sysId,"ALL")>
        <cfset rispVehicleSummaryHeader=ReplaceNoCase(rispVehicleSummaryHeader,"**forceId**",arguments.searchTerms.forceId,"ALL")>                          
        <cfset rispVehicleSummaryHeader=ReplaceNoCase(rispVehicleSummaryHeader,"**uniqueRequestId**",uniqueRef,"ALL")>  
        <cfset rispVehicleSummaryHeader=ReplaceNoCase(rispVehicleSummaryHeader,"**timestamp**",timestamp,"ALL")>                        
        
        <cfoutput>
        <cfxml variable="searchXML">
          #rispVehicleSummaryHeader#
        </cfxml>      
        </cfoutput>
                            
			<cfhttp url="#variables.rispURL#" method="POST" result="searchResult" timeout="#variables.wMidsTimeout#"
						 port="#variables.rispPort#" useragent="">
				<cfhttpparam type="header" name="SOAPAction" value='"#variables.rispSoapAction#"'> 
				<cfhttpparam type="xml" name="body" value="#searchXml#">       
			</cfhttp>         
           
            
            <cfset westMidsResult.status=searchResult.statusCode>
            <cfset westMidsResult.xml=rispVehicleSummaryHeader>            
            
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
    
    <cffunction name="doWestMidsVehicleDetail" output="false" access="remote" returntype="any" hint="does the west mids region vehicle detail request">
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
        <cfset var vehicleArrayXml="">
        <cfset var iVehicle=1>
        <cfset var rispVehicleDetailHeader=variables.rispVehicleDetailHeader>
        <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
        <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
        
        <!--- replace the user, terminal, unique ref and timestamp vars --->
        <cfset rispVehicleDetailHeader=ReplaceNoCase(rispVehicleDetailHeader,"**userId**",arguments.userId,"ALL")>
        <cfset rispVehicleDetailHeader=ReplaceNoCase(rispVehicleDetailHeader,"**terminalId**",arguments.terminalId,"ALL")>  
        <cfset rispVehicleDetailHeader=ReplaceNoCase(rispVehicleDetailHeader,"**appRef**",arguments.searchTerms.appRef,"ALL")>
        <cfset rispVehicleDetailHeader=ReplaceNoCase(rispVehicleDetailHeader,"**sysId**",arguments.searchTerms.sysId,"ALL")>
        <cfset rispVehicleDetailHeader=ReplaceNoCase(rispVehicleDetailHeader,"**forceId**",arguments.searchTerms.forceId,"ALL")>                          
        <cfset rispVehicleDetailHeader=ReplaceNoCase(rispVehicleDetailHeader,"**uniqueRequestId**",uniqueRef,"ALL")>  
        <cfset rispVehicleDetailHeader=ReplaceNoCase(rispVehicleDetailHeader,"**timestamp**",timestamp,"ALL")>                        
        
        <cfoutput>
        <cfxml variable="searchXML">
          #rispVehicleDetailHeader#
        </cfxml>      
        </cfoutput>
                
              
			<cfhttp url="#variables.rispURL#" method="POST" result="searchResult" timeout="#variables.wMidsTimeout#"
						 port="#variables.rispPort#" useragent="">
				<cfhttpparam type="header" name="SOAPAction" value='"#variables.rispSoapAction#"'> 
				<cfhttpparam type="xml" name="body" value="#searchXml#">       
			</cfhttp>         
            
            <cfset westMidsResult.status=searchResult.statusCode>
            <cfset westMidsResult.xml=rispVehicleDetailHeader>            
            
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
    
    <cffunction name="createVRMList" output="false" access="public" returntype="array" hint="function creates a list of VRMS for a searching containing special search * markers">
      <cfargument name="VRM" type="string" required="true" hint="special VRM passed in with *s">
      
      <cfset var arrVrms=arrayNew(1)>
      <cfset var specialChars="">
      <cfset var combi="">
      <cfset var iPos1="">
      <cfset var iPos2="">
      <cfset var part1="">
      <cfset var part2="">
      
            <!--- find out if vrm contains 2 stars * --->
            <cfset iPos1=FindNoCase("*",arguments.VRM)>
            <cfset iPos2=FindNoCase("*",arguments.VRM,iPos1+1)>
            <cfset part1=ListFirst(arguments.VRM,"*")>
            <cfif Right(arguments.VRM,1) IS "*">
             <cfset part2="">
            <cfelse>
             <cfset part2=ListLast(arguments.VRM,"*")>            
            </cfif>

            <cfset specialChars=Mid(arguments.VRM,iPos1+1,iPos2-(iPos1+1))>
            <cfset combi=createCombi("",specialChars)>
                
            <cfloop list="#combi#" index="combiItem">
               <cfset ArrayAppend(arrVrms,part1&combiItem&part2)>
            </cfloop>
                
       <cfreturn arrVrms>      
     
    </cffunction>     
    
	<cffunction name="createCombi" returntype="string" output="true" access="private">
	  <cfargument name="word" type="String" required="true">
	  <cfargument name="dictionary" type="String" required="true">
	
	  <cfset var aList="">
	  <cfset var newWord = "">
	  <cfset var newDict = "">
	
	  <cfif Len(dictionary) EQ 1>
	    <cfset newWord = word & dictionary>
	    <cfreturn newWord>
	  </cfif>
	
	  <cfloop from="1" to="#Len(dictionary)#" index="myChar">
	    <cfset newWord = word & Mid(dictionary,myChar,1)>
	    <cfset newDict = RemoveChars(dictionary,myChar,1)>
	
	    <cfset aList = ListAppend(aList,createCombi(newWord, newDict))>
	  </cfloop>
	
	  <cfreturn aList>
	</cffunction>    

	<cffunction name="getNominalVehicles" output="false" access="public" returntype="array">
		<cfargument name="nominalRef" required="true" type="string" hint="nominal ref of person to get vehicles for">
		<cfargument name="startDate" required="false" default="" type="string" hint="start date to get vehicles to (dd/mm/yyyy)">
		<cfargument name="endDate" required="false" default="" type="string" hint="end date to get vehicles to (dd/mm/yyyy)">
		<cfset var qRead="">
        <cfset var vehicles=arrayNew(1)>

		<cfquery name="qRead" datasource="#variables.warehousedsn#">
		    SELECT DISTINCT vu.USAGE AS ROLE, vs.VRM AS REG, vs.PRIMARY_COL AS COLOUR,
			       vs.MANUFACTURER AS MAKE, NVL(vs.MODEL,'&nbsp;') AS MODEL, NVL(vs.BODY_TYPE,'&nbsp;') AS BODY,
						 vu.START_DATE AS FROM_DATE, vu.REASON
			FROM   browser_owner.VEHICLE_SEARCH vs, browser_owner.VEHICLE_USAGES vu
			WHERE  vs.veh_ref=vu.veh_ref
		    AND NOMINAL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nominalRef#" />
			<cfif Len(arguments.startDate) GT 0 AND Len(arguments.endDate) GT 0>
			AND  START_DATE BETWEEN TO_DATE(<cfqueryparam value="#arguments.startDate#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY') 
			                    AND TO_DATE(<cfqueryparam value="#arguments.endDate#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')	
			</cfif>
			ORDER BY vu.START_DATE DESC			
		</cfquery>
   
		<!--- Complete an array of structure with all the vehicle details in --->
		<cfif qRead.RecordCount GT 0>
			<cfset vehicles=ArrayNew(1)>
			<cfset i=1>
			<cfloop query="qRead">
			 <cfset vehicles[i]=StructNew()>
		     <cfif FindNoCase("CRASH",ROLE) GT 0>
		        <cfset vehicles[i].Role='RTC - <b><a href="#REASON#" crashDate="#DateFormat(FROM_DATE,"DD/MM/YYYY")#" class="genieCrashLink">#REASON#</a></b>'>
		     <cfelse>
				 <cfif Len(REASON) IS 0>
			   	  <cfset vehicles[i].Role=ROLE>	
				 <cfelse>
			      <cfset vehicles[i].Role=REASON>	
			     </cfif>
		     </cfif>
			 <cfset vehicles[i].Reg=REG>	
			 <cfset vehicles[i].Colour=COLOUR>	
			 <cfset vehicles[i].Make=MAKE>	
			 <cfset vehicles[i].Model=Model>	
			 <cfset vehicles[i].Body=BODY>		 	 	 	 	 
			 <cfset vehicles[i].DateFrom=FROM_DATE>		 
			 <cfset i=i+1>
			</cfloop>
		</cfif>   
        
        <cfreturn vehicles>
   </cffunction> 
    
</cfcomponent>