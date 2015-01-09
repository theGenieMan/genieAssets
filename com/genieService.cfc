<cfcomponent output="false" name="genieService">
      
    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="false" default="wmercia_jdbc" type="String">
        <cfargument name="warehouseDSN2" required="false" default="wmercia" type="String">        
        <cfargument name="warehouseUID" required="false" default="browser_owner" type="String">
        <cfargument name="warehousePWD" required="false" default="brow61dell" type="String">
        <cfargument name="rispURL" required="false" default="" type="String">        
        <cfargument name="rispPort" required="false" default="" type="String">                
        <cfargument name="rispSoapAction" required="false" default="" type="String"> 
        <cfargument name="rispPersonSearchHeader" required="false" default="" type="String"> 
        <cfargument name="rispPersonSearchFooter" required="false" default="" type="String">                 
        <cfargument name="rispPersonSummaryHeader" required="false" default="" type="String"> 
        <cfargument name="rispPersonSummaryFooter" required="false" default="" type="String">          
        <cfargument name="rispPersonDetailHeader" required="false" default="" type="String"> 
        <cfargument name="rispPersonDetailFooter" required="false" default="" type="String">  
        <cfargument name="rispAddressSearchHeader" required="false" default="" type="String"> 
        <cfargument name="rispAddressSummaryFooter" required="false" default="" type="String">     
        <cfargument name="rispAddressSummaryHeader" required="false" default="" type="String"> 
        <cfargument name="rispAddressSearchFooter" required="false" default="" type="String">                                             
        <cfargument name="rispAddressDetailHeader" required="false" default="" type="String"> 
        <cfargument name="rispAddressDetailFooter" required="false" default="" type="String">    
        <cfargument name="rispVehicleSearchHeader" required="false" default="" type="String"> 
        <cfargument name="rispVehicleSearchFooter" required="false" default="" type="String">
        <cfargument name="rispVehicleSummaryHeader" required="false" default="" type="String"> 
        <cfargument name="rispVehicleSummaryFooter" required="false" default="" type="String">                                         
        <cfargument name="rispVehicleDetailHeader" required="false" default="" type="String"> 
        <cfargument name="rispVehicleDetailFooter" required="false" default="" type="String">      
        <cfargument name="rispTelephoneSearchHeader" required="false" default="" type="String"> 
        <cfargument name="rispTelephoneSearchFooter" required="false" default="" type="String">                                
        <cfargument name="rispTelephoneSummaryHeader" required="false" default="" type="String"> 
        <cfargument name="rispTelephoneSummaryFooter" required="false" default="" type="String">         
        <cfargument name="rispTelephoneDetailHeader" required="false" default="" type="String"> 
        <cfargument name="rispTelephoneDetailFooter" required="false" default="" type="String"> 
        <cfargument name="rispImageRequestHeader" required="false" default="" type="String">        
        <cfargument name="rispImsMemo" required="false" default="" type="String">                                                  
        <cfargument name="personSearchProcedure" required="false" default="GE_NAMEX_SEARCH_3_1.GE_Nominal_Array" type="String">   
        <cfargument name="genieImageDir" required="false" default="/genie_photos/" type="String">         
        <cfargument name="genieImagePath" required="false" default="\\svr20200\s$\custody_photos\" type="String">                 
        <cfargument name="nflmsImageDir" required="false" default="" type="String">          
        <cfargument name="geniePastePath" required="false" default="" type="String">     
        <cfargument name="genieAuditPath" required="false" default="" type="String">   
        <cfargument name="damsWebService" required="false" default="" type="String">                                                        
        <cfargument name="forensicArchivePath" required="false" default="" type="String">     
        <cfargument name="forceLookup" required="false" default="" type="String">    
        <cfargument name="wMidsTimeout" required="false" default="" type="String">  
        <cfargument name="SS2DSN" required="false" default="" type="String">                                                                                
        <cfargument name="pactUser" required="false" default="" type="String">                                                                                
        <cfargument name="pactPWD" required="false" default="" type="String">   
        <cfargument name="nominalLink" required="false" default="" type="String">
		<cfargument name="intelFreeTextUrl" required="false" default="" type="String">
		<cfargument name="transformsDir" required="false" default="" type="String">
		<cfargument name="crimePath" required="false" default="" type="String">
		<cfargument name="intelPath" required="false" default="" type="String">
		<cfargument name="intelB99Path" required="false" default="" type="String">
		<cfargument name="redirectorUrl" required="false" default="" type="String">   
		<cfargument name="nominalTempDir" required="false" default="" type="String">   
		<cfargument name="custodyTempDir" required="false" default="" type="String">  
		<cfargument name="caseTempDir" required="false" default="" type="String">  
		<cfargument name="intelFTSTempDir" required="false" default="" type="String">
		<cfargument name="crimeTempDir" required="false" default="" type="String">                                                                                                  
        
        <cfset variables.version="1.1.0.0">    
		<cfset variables.dateServiceStarted=DateFormat(now(),"DDD DD-MMM-YYYY")&" "&TimeFormat(now(),"HH:mm:ss")>                                  
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>
        <cfset variables.rispURL=arguments.rispURL>
        <cfset variables.rispPost=arguments.rispPort>
        <cfset variables.rispSoapAction=arguments.rispSoapAction>
        <cfset variables.rispPersonSearchHeader=arguments.rispPersonSearchHeader>
        <cfset variables.rispPersonSearchFooter=arguments.rispPersonSearchFooter>     
        <cfset variables.rispPersonSummaryHeader=arguments.rispPersonSummaryHeader>
        <cfset variables.rispPersonSummaryFooter=arguments.rispPersonSummaryFooter>                      
        <cfset variables.rispPersonDetailHeader=arguments.rispPersonDetailHeader>
        <cfset variables.rispPersonDetailFooter=arguments.rispPersonDetailFooter>    
        <cfset variables.rispAddressSearchHeader=arguments.rispAddressSearchHeader>
        <cfset variables.rispAddressSearchFooter=arguments.rispAddressSearchFooter>                  
        <cfset variables.rispAddressSummaryHeader=arguments.rispAddressSummaryHeader>
        <cfset variables.rispAddressSummaryFooter=arguments.rispAddressSummaryFooter>    
        <cfset variables.rispAddressDetailHeader=arguments.rispAddressDetailHeader>
        <cfset variables.rispAddressDetailFooter=arguments.rispAddressDetailFooter>          
        <cfset variables.rispVehicleSearchHeader=arguments.rispVehicleSearchHeader>
        <cfset variables.rispVehicleSearchFooter=arguments.rispVehicleSearchFooter>   
        <cfset variables.rispVehicleSummaryHeader=arguments.rispVehicleSummaryHeader>
        <cfset variables.rispVehicleSummaryFooter=arguments.rispVehicleSummaryFooter>                           
        <cfset variables.rispVehicleDetailHeader=arguments.rispVehicleDetailHeader>
        <cfset variables.rispVehicleDetailFooter=arguments.rispVehicleDetailFooter>     
        <cfset variables.rispTelephoneSearchHeader=arguments.rispTelephoneSearchHeader>
        <cfset variables.rispTelephoneSearchFooter=arguments.rispTelephoneSearchFooter>                  
        <cfset variables.rispTelephoneSummaryHeader=arguments.rispTelephoneSummaryHeader>
        <cfset variables.rispTelephoneSummaryFooter=arguments.rispTelephoneSummaryFooter>            
        <cfset variables.rispTelephoneDetailHeader=arguments.rispTelephoneDetailHeader>
        <cfset variables.rispTelephoneDetailFooter=arguments.rispTelephoneDetailFooter>       
        <cfset variables.rispImageRequestHeader=arguments.rispImageRequestHeader>      
        <cfset variables.rispImsMemo=arguments.rispImsMemo>                
        <cfset variables.personSearchProcedure=arguments.personSearchProcedure>  
        <cfset variables.genieImageDir=arguments.genieImageDir>                
        <cfset variables.genieImagePath=arguments.genieImagePath>                        
        <cfset variables.nflmsImageDir=arguments.nflmsImageDir> 
        <cfset variables.geniePastePath=arguments.geniePastePath> 
        <cfset variables.genieAuditPath=arguments.genieAuditPath>                                        
        <cfset variables.damsWebService=arguments.damsWebService> 
        <cfset variables.forensicArchivePath=arguments.forensicArchivePath>  
        <cfset variables.forceLookup=arguments.forceLookup>     
        <cfset variables.wMidsTimeout=arguments.wMidsTimeout>     
        <cfset variables.SS2DSN=arguments.SS2DSN>          
        <cfset variables.pactUser=arguments.pactUser>                                   
        <cfset variables.pactPwd=arguments.pactPwd>   
        <cfset variables.nominalLink=arguments.nominalLink>  
		<cfset variables.intelFreeTextUrl=arguments.intelFreeTextUrl>    
		<cfset variables.transformsDir=arguments.transformsDir>
		<cfset variables.crimePath=arguments.crimePath>
		<cfset variables.intelPath=arguments.intelPath>
		<cfset variables.intelB99Path=arguments.intelB99Path>
		<cfset variables.redirectorUrl=arguments.redirectorUrl> 
		<cfset variables.nominalTempDir=arguments.nominalTempDir>
		<cfset variables.custodyTempDir=arguments.custodyTempDir>  
		<cfset variables.caseTempDir=arguments.caseTempDir>
		<cfset variables.intelFTSTempDir=arguments.intelFTSTempDir>   
		<cfset variables.crimeTempDir=arguments.crimeTempDir>                 
                                  
        <cfset variables.nominalDAO=CreateObject("component","genieObj.nominal.nominalDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 rispURL=variables.rispURL,
                                                                                                 rispPort=variables.rispPost,
                                                                                                 rispSoapAction=variables.rispSoapAction,
                                                                                                 rispPersonSearchHeader=variables.rispPersonSearchHeader,
                                                                                                 rispPersonSearchFooter=variables.rispPersonSearchFooter,
                                                                                                 rispPersonSummaryHeader=variables.rispPersonSummaryHeader,
                                                                                                 rispPersonSummaryFooter=variables.rispPersonSummaryFooter,                                                                                                           
                                                                                                 rispPersonDetailHeader=variables.rispPersonDetailHeader,
                                                                                                 rispPersonDetailFooter=variables.rispPersonDetailFooter,                                                                                                      
                                                                                                 personSearchProcedure=variables.personSearchProcedure,
                                                                                                 geniePastePath=variables.geniePastePath,
                                                                                                 forceLookup=variables.forceLookup,
                                                                                                 wMidsTimeout=variables.wMidsTimeout                                                                                                                                                                                                                                                                                                                          
                                                                                                )>		
                                                                                                
        <cfset variables.familyProtectionDAO=CreateObject("component","genieObj.familyProtection.familyProtectionDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 rispURL=variables.rispURL,
                                                                                                 rispPort=variables.rispPost,
                                                                                                 rispSoapAction=variables.rispSoapAction,
                                                                                                 rispPersonSearchHeader=variables.rispPersonSearchHeader,
                                                                                                 rispPersonSearchFooter=variables.rispPersonSearchFooter,    
                                                                                                 rispPersonSummaryHeader=variables.rispPersonSummaryHeader,
                                                                                                 rispPersonSummaryFooter=variables.rispPersonSummaryFooter,                                                                                                      
                                                                                                 rispPersonDetailHeader=variables.rispPersonDetailHeader,
                                                                                                 rispPersonDetailFooter=variables.rispPersonDetailFooter,                                                                                                      
                                                                                                 personSearchProcedure=variables.personSearchProcedure,
                                                                                                 geniePastePath=variables.geniePastePath,
                                                                                                 forceLookup=variables.forceLookup,
                                                                                                 wMidsTimeout=variables.wMidsTimeout                                                                                                                    
                                                                                                )>	                                                                                                
                                                                                                
        <cfset variables.custodyDAO=CreateObject("component","genieObj.custody.custodyDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 geniePastePath=variables.geniePastePath                                                                                                                  
                                                                                                )>
                                                                                                
        <cfset variables.warrantDAO=CreateObject("component","genieObj.warrants.warrantDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 geniePastePath=variables.geniePastePath                                                                                                                  
                                                                                                )>       
                                                                                                
        <cfset variables.documentDAO=CreateObject("component","genieObj.documents.documentDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 geniePastePath=variables.geniePastePath                                                                                                                  
                                                                                                )>                                                                                                  
                                                                                                
        <cfset variables.jTrackDAO=CreateObject("component","genieObj.nominal.jTrackDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 geniePastePath=variables.geniePastePath                                                                                                                  
                                                                                                )>    
                                                                                                
        <cfset variables.featuresDAO=CreateObject("component","genieObj.nominal.featuresDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD                                                                                                            
                                                                                                )>        
                                                                                                
        <cfset variables.misperDAO=CreateObject("component","genieObj.nominal.misperDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD                                                                                                            
                                                                                                )>                                                                                                                                                                                                   
                                                                                                
        <cfset variables.releasesDAO=CreateObject("component","genieObj.nominal.releasesDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 geniePastePath=variables.geniePastePath                                                                                                                  
                                                                                                )>       
                                                                                                
        <cfset variables.aliasDAO=CreateObject("component","genieObj.nominal.aliasDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 geniePastePath=variables.geniePastePath                                                                                                                  
                                                                                                )>     
                                                                                                
        <cfset variables.associateDAO=CreateObject("component","genieObj.nominal.associateDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 geniePastePath=variables.geniePastePath                                                                                                                  
                                                                                                )>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
                                                                                                
        <cfset variables.bailDAO=CreateObject("component","genieObj.bails.bailDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 geniePastePath=variables.geniePastePath                                                                                                                  
                                                                                                )>	                                                                                                	                                                                                                
                                                                                                
        <cfset variables.warningsDAO=CreateObject("component","genieObj.nominal.warningsDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD           
                                                                                                )>            
                                                                                                
        <cfset variables.addressDAO=CreateObject("component","genieObj.addresses.addressDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 rispURL=variables.rispURL,
                                                                                                 rispPort=variables.rispPost,
                                                                                                 rispSoapAction=variables.rispSoapAction,                                                                                                     
                                                                                                 rispAddressSearchHeader=variables.rispAddressSearchHeader,
                                                                                                 rispAddressSearchFooter=variables.rispAddressSearchFooter,
                                                                                                 rispAddressSummaryHeader=variables.rispAddressSummaryHeader,
                                                                                                 rispAddressSummaryFooter=variables.rispAddressSummaryFooter,                                                                                                     
                                                                                                 rispAddressDetailHeader=variables.rispAddressDetailHeader,
                                                                                                 rispAddressDetailFooter=variables.rispAddressDetailFooter,
                                                                                                 forceLookup=variables.forceLookup,
                                                                                                 wMidsTimeout=variables.wMidsTimeout                                                                                                                  
                                                                                                )>       
                                                                                               
        <cfset variables.vehicleDAO=CreateObject("component","genieObj.vehicles.vehicleDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 rispURL=variables.rispURL,
                                                                                                 rispPort=variables.rispPost,
                                                                                                 rispSoapAction=variables.rispSoapAction,                                                                                                     
                                                                                                 rispVehicleSearchHeader=variables.rispVehicleSearchHeader,
                                                                                                 rispVehicleSearchFooter=variables.rispVehicleSearchFooter,
                                                                                                 rispVehicleSummaryHeader=variables.rispVehicleSummaryHeader,
                                                                                                 rispVehicleSummaryFooter=variables.rispVehicleSummaryFooter,                                                                                                     
                                                                                                 rispVehicleDetailHeader=variables.rispVehicleDetailHeader,
                                                                                                 rispVehicleDetailFooter=variables.rispVehicleDetailFooter,
                                                                                                 forceLookup=variables.forceLookup,
                                                                                                 wMidsTimeout=variables.wMidsTimeout                                                                                                                   
                                                                                                )>    
                                                                                           
        <cfset variables.telephoneDAO=CreateObject("component","genieObj.telephones.telephoneDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 rispURL=variables.rispURL,
                                                                                                 rispPort=variables.rispPost,
                                                                                                 rispSoapAction=variables.rispSoapAction,                                                                                                     
                                                                                                 rispTelephoneSearchHeader=variables.rispTelephoneSearchHeader,
                                                                                                 rispTelephoneSearchFooter=variables.rispTelephoneSearchFooter,
                                                                                                 rispTelephoneSummaryHeader=variables.rispTelephoneSummaryHeader,
                                                                                                 rispTelephoneSummaryFooter=variables.rispTelephoneSummaryFooter,                                                                                                     
                                                                                                 rispTelephoneDetailHeader=variables.rispTelephoneDetailHeader,
                                                                                                 rispTelephoneDetailFooter=variables.rispTelephoneDetailFooter, 
                                                                                                 forceLookup=variables.forceLookup,
                                                                                                 wMidsTimeout=variables.wMidsTimeout                                                                                                                 
                                                                                                )>                                                                                                                                                                                                             
        
        <cfset variables.processDecisionDAO=CreateObject("component","genieObj.processDecisions.processDecisionDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 geniePastePath=variables.geniePastePath           
                                                                                                )>     
                                                                                                
        <cfset variables.propertyDAO=CreateObject("component","genieObj.property.propertyDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD          
                                                                                                )>          
                                                                                                
        <cfset variables.offenceDAO=CreateObject("component","genieObj.offences.offenceDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD          
                                                                                                )>                                                                                                                                                                                                 
                                                                                                
        <cfset variables.organisationsDAO=CreateObject("component","genieObj.organisations.organisationDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD          
                                                                                                )>            
                                                                                                
        <cfset variables.intelDAO=CreateObject("component","genieObj.intel.intelDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 rispImsMemo=variables.rispImsMemo,
                                                                                                 rispURL=variables.rispURL,
                                                                                                 rispPort=variables.rispPost,
                                                                                                 rispSoapAction=variables.rispSoapAction,
                                                                                                 forceLookup=variables.forceLookup,
                                                                                                 wMidsTimeout=variables.wMidsTimeout,
                                                                                                 rispImageRequestHeader=variables.rispImageRequestHeader,
																								 intelFreetextUrl=variables.intelFreeTextUrl          
                                                                                                )>                                                                                                                                                                                                                  

        <cfset variables.photoDAO=CreateObject("component","genieObj.nominal.photoDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 genieImageDir=variables.genieImageDir,
                                                                                                 genieImagePath=variables.genieImagePath,
                                                                                                  rispURL=variables.rispURL,
                                                                                                 rispPort=variables.rispPost,
                                                                                                 rispSoapAction=variables.rispSoapAction,
                                                                                                      forceLookup=variables.forceLookup,
                                                                                                 wMidsTimeout=variables.wMidsTimeout,
                                                                                                     rispImageRequestHeader=variables.rispImageRequestHeader                                                                                                               
                                                                                                )>             
                                                                                                
        <cfset variables.targetDAO=CreateObject("component","genieObj.target.targetDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 genieImageDir=variables.genieImageDir           
                                                                                                )>                                                                                                           
                                                                                                
        <cfset variables.firearmsNominalDAO=CreateObject("component","genieObj.nflms.personDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 nflmsImageDir=variables.genieImageDir           
                                                                                                )>        
                                                                                                
        <cfset variables.firearmsAddressDAO=CreateObject("component","genieObj.nflms.addressDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD,
                                                                                                 nflmsImageDir=variables.genieImageDir           
                                                                                                )>     
                                                                                                
        <cfset variables.occupationsDAO=CreateObject("component","genieObj.nominal.occupationsDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                 warehouseDSN2=variables.warehouseDSN2,
                                                                                                 warehouseUID=variables.warehouseUID,
                                                                                                 warehousePWD=variables.warehousePWD           
                                                                                                )>    
                                                                                                
        <cfset variables.stopSearchDAO=CreateObject("component","genieObj.nominal.stopSearchDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                       warehouseDSN2=variables.warehouseDSN2,
                                                                                                       warehouseUID=variables.warehouseUID,
                                                                                                       warehousePWD=variables.warehousePWD           
                                                                                                       )>                                                                                                     

		<cfset variables.section27DAO=CreateObject("component","genieObj.nominal.section27DAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                       warehouseDSN2=variables.warehouseDSN2,
                                                                                                       warehouseUID=variables.warehouseUID,
                                                                                                       warehousePWD=variables.warehousePWD           
                                                                                                       )>
                                                                                                       
        <cfset variables.rmpDAO=CreateObject("component","genieObj.nominal.rmpDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                       warehouseDSN2=variables.warehouseDSN2,
                                                                                                       warehouseUID=variables.warehouseUID,
                                                                                                       warehousePWD=variables.warehousePWD           
                                                                                                       )>

        <cfset variables.stepDAO=CreateObject("component","genieObj.nominal.stepDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                       warehouseDSN2=variables.warehouseDSN2,
                                                                                                       warehouseUID=variables.warehouseUID,
                                                                                                       warehousePWD=variables.warehousePWD           
                                                                                                       )>
                                                                                                       
        <cfset variables.attachmentsDAO=CreateObject("component","genieObj.attachments.attachmentsDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                       warehouseDSN2=variables.warehouseDSN2,
                                                                                                       warehouseUID=variables.warehouseUID,
                                                                                                       warehousePWD=variables.warehousePWD           
                                                                                                       )>                                                                                                       

        <cfset variables.intelPackageDAO=CreateObject("component","genieObj.nominal.intelPackageDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                       warehouseDSN2=variables.warehouseDSN2,
                                                                                                       warehouseUID=variables.warehouseUID,
                                                                                                       warehousePWD=variables.warehousePWD,
																									   transformsDir=variables.transformsDir,
													                                                   crimePath=variables.crimePath,
													                                                   intelPath=variables.intelPath,
																									   intelB99Path=variables.intelB99Path,
																									   genieImagePath=variables.genieImagePath           
                                                                                                       )>
                                                                                                       
		<cfset variables.notificationsDAO=CreateObject("component","genieObj.nominal.notificationsDAO").init(warehouseDSN=variables.warehouseDSN,
                                                                                                       warehouseDSN2=variables.warehouseDSN2,
                                                                                                       warehouseUID=variables.warehouseUID,
                                                                                                       warehousePWD=variables.warehousePWD,
																									   redirectorUrl=variables.redirectorUrl,
																									   genieService=this           
                                                                                                       )>                                                                                                       
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
        <cfreturn this />    
    </cffunction>  
        
    <cffunction name="getServiceVersion" access="remote" returntype="any" output="false" hint="I get the west mids photos">

     <cfreturn variables.version>
     
    </cffunction>      
	
    <cffunction name="getDateServiceStarted" access="remote" returntype="any" output="false" hint="I get the west mids photos">

     <cfreturn variables.dateServiceStarted>
     
    </cffunction> 	      
        
    <cffunction name="doWestMerciaPersonSearch" access="remote" returntype="struct" output="false" hint="I call the West Mercia Person search, return a query of the search result">
	 <cfargument type="array" name="searchTerms" required="true" hint="Structure of search terms to be passed to the gateway search">
	 <cfargument type="string" name="pasteReq" required="false" default="N" hint="flag for whether a paste text file is required">        
	 <cfargument type="string" name="auditReq" required="false" default="Y" hint="flag for whether an audit is reqd">
	 <cfargument type="string" name="fromWebService" required="false" default="N" hint="flag for whether request is from web service">
	 <cfargument type="struct" name="wsAudit" required="false" default="#structNew()#" hint="struct of audit data">   
	 <cfargument type="string" name="searchUUID" required="false" default="" hint="UUID for search results">      
    	
     <cfset var nom=ArrayNew(1)>
     <cfset var warnings=ArrayNew(1)>
     <cfset var photoStruct=StructNew()>
     <cfset var photoUrl=ArrayNew(1)>     
     <cfset var photoDates=ArrayNew(1)>          
     <cfset var photos=ArrayNew(1)>
	 <cfset var nominalTargets="">
	 <cfset var targets=ArrayNew(1)>
     <cfset var searchResult=StructNew()>
     <cfset var qNoms="">
     <cfset var thisNom="">
     <cfset var pasteFile="">
     <cfset var auditFieldData="">
     <cfset var i="">
	 <cfset var audit=structNew()>
     
         <cfif arguments.pasteReq IS "Y">
          <cfset pasteFile=CreateRandomFilename()>
         </cfif>
     
	     <!--- call the West Mercia person search PL/SQL package. A query is returned, use this to get an array of nominal objects --->                        
	     <cfset qNoms=variables.nominalDAO.doWestMerciaPersonSearch(searchTerms)>
	     
	     <cfset warnings=variables.warningsDAO.getNominalSearchWarnings(qNoms)>
	     
	     <cfset ignore=QueryAddColumn(qNoms,"WARNINGS","VarChar",warnings)>
	     
	     <cfset photoStruct=variables.photoDAO.getNominalLatestPhotoForSearch(qNoms)>
	     <cfset photoUrl=photoStruct.photoUrls>
	     <cfset photoDates=photoStruct.photoDates>
	     
	     <cfset ignore=QueryAddColumn(qNoms,"PHOTO_URL","VarChar",photoUrl)>
	     <cfset ignore=QueryAddColumn(qNoms,"PHOTO_DATE","VarChar",photoDates)>   
		  
		 <cfset ignore=QueryAddColumn(qNoms,"TARGET","VarChar",variables.targetDAO.getNominalSearchTargets(ValueList(qNoms.NOMINAL_REF)))>    
                        
         <cfset searchResult.queryResult=qNoms>
         <cfset searchResult.recordCount=qNoms.recordCount>
         
         <cfif arguments.pasteReq IS "Y">
           <cfset searchResult.pastePath=variables.nominalDAO.doWestMerciaPersonSearchPaste(qNoms,createRandomFilename())>
         <cfelse>
           <cfset searchResult.pastepath="">
         </cfif>      
         
         <cfloop from="1" to="#ArrayLen(searchTerms)#" index="i">             
           <cfif Len(searchTerms[i].value) GT 0>
            <cfset auditFieldData=ListAppend(auditFieldData,searchTerms[i].key&"="&searchTerms[i].value,"|")>
           </cfif>
         </cfloop>
         
		 <cfif auditReq IS "Y">
		 	 
           <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mercia Person Search',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=searchResult.recordCount,
							 department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>
							            
	      </cfif>
	      
	      <cfif Len(arguments.searchUUID) GT 0>
		  	  <cffile action="write" file="#variables.nominalTempDir##searchUUID#.txt" output="#ValueList(qNoms.NOMINAL_REF,",")#">
		  </cfif>
    	     
     <cfreturn searchResult>
     
    </cffunction>
    
    <cffunction name="doWestMidsPersonSearch" access="remote" returntype="any" output="false" hint="I call the West MidsPerson search, returns xml the search result">
	 <cfargument type="string" name="searchTerms" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">  
	 <cfargument type="string" name="fromWebService" required="false" default="N" hint="flag for whether request is from web service">
	 <cfargument type="struct" name="wsAudit" required="false" default="#structNew()#" hint="struct of audit data">                     
    	
     <cfset var searchResult=StructNew()>
     <cfset var x=0>
     <cfset var imageSearchTerms=StructNew()>
	  
	 <cfif arguments.fromWebService IS "Y">
		   		<cfset audit.enquiryUser=wsAudit.enquiryUser>
				<cfset audit.enquiryUserName=wsAudit.enquiryUserName>
				<cfset audit.requestFor=wsAudit.requestFor>
				<cfset audit.reasonCode=wsAudit.reasonCode>
				<cfset audit.reasonText=wsAudit.reasonText>   
				<cfset audit.sessionId=wsAudit.sessionId>
				<cfset audit.terminalId=wsAudit.terminalId>
				<cfset audit.department=wsAudit.enquiryUserDept>
		   <cfelse>
		   		<cfset audit.enquiryUser=session.user.getUserId()>
				<cfset audit.enquiryUserName=session.user.getFullName()>
				<cfset audit.requestFor=session.audit_for>
				<cfset audit.reasonCode=session.audit_code>
				<cfset audit.reasonText=session.audit_details>  
				<cfset audit.sessionId=session.thisUUID>
				<cfset audit.terminalId=session.hostName>
				<cfset audit.department=session.user.getDepartment()> 		   	   
	 </cfif>	  
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset searchResult=variables.nominalDAO.doWestMidsPersonSearch(searchTerms=arguments.searchTerms,
                                                              userId=audit.enquiryUserName,
                                                              terminalId=audit.terminalId,
                                                              sessionId=audit.sessionId)>
                                                              
     <cfif searchResult.searchOK>                                                              
         
         <cfloop from="1" to="#ArrayLen(searchResult.nominals)#" index="x">
         
          <cfset searchResult.nominals[x].photo=CreateObject('component','nominal.photo').init()>
         
          <cfif searchResult.nominals[x].getRISP_PHOTO_EXISTS() IS "Y">
              <cfset imageSearchTerms.appRef=searchResult.nominals[x].getAPP_REF()>
              <cfset imageSearchTerms.sysId=searchResult.nominals[x].getSYS_REF()>
              <cfset imageSearchTerms.forceId=searchResult.nominals[x].getFORCE_REF()>   
              <cfset searchResult.nominals[x].photo=variables.photoDAO.getRispPhoto(searchTerms=imageSearchTerms,
                                                              userId=audit.enquiryUser,
                                                              terminalId=audit.terminalId,
                                                              sessionId=audit.sessionId)> 
                    
          </cfif>
         
         </cfloop>
                                                              
	     <cfset doGenieAudit(userId=session.user.getUserId(),
	                             sessionId=audit.sessionId,
	                             reason=audit.reasonCode,
	                             reasonText=audit.reasonText,
	                             requestFor=audit.requestFor,
	                             fullName=audit.enquiryUserName,
	                             action='West Mids Region Person Search',
	                             fields=StripCr(searchTerms),
	                             details='',
	                             numberOfResults=ArrayLen(searchResult.nominals),
								 department=audit.department)>                                                               
    	     
     </cfif>	     
    
     <cfreturn searchResult>
     
    </cffunction>    
    
    <cffunction name="getRispPhoto" access="remote" returntype="any" output="false" hint="I get the west mids photos">
	 <cfargument type="struct" name="searchTerms" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                      
    	
     <cfset var photo="">
     
     <cfset photo=variables.photoDAO.getRispPhoto(searchTerms=arguments.searchTerms,
                                                              userId=arguments.userId,
                                                              terminalId=arguments.terminalId,
                                                              sessionId=arguments.sessionId)> 
                        
     <cfreturn photo>
     
    </cffunction>     
    
    <cffunction name="getImsInfo" access="remote" returntype="any" output="false" hint="I get the west mids photos">
	 <cfargument type="struct" name="searchTerms" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                      
    	
     <cfset var imsInfo="">
     
     <cfset imsInfo=variables.intelDAO.getImsInfo(searchTerms=arguments.searchTerms,
                                                              userId=arguments.userId,
                                                              terminalId=arguments.terminalId,
                                                              sessionId=arguments.sessionId)> 
                        
     <cfreturn imsInfo>
     
    </cffunction>        
     
    <cffunction name="doWestMidsNominalGrouping" access="remote" returntype="struct" output="false" hint="returns a query of grouped nominals">
	 <cfargument type="array" name="nominals" required="true" hint="nominals to be grouped">
	 <cfargument type="string" name="group" required="false" default="name" hint="how to group nominals">	 
    	
     <cfset var groupedNominals=StructNew()>
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset groupedNominals=variables.nominalDAO.doWestMidsGrouping(nominals=arguments.nominals,group=arguments.group)>                                                           
                                                             
     <cfreturn groupedNominals>
     
    </cffunction>       
    
    <cffunction name="doWestMidsPersonSummary" access="remote" returntype="any" output="false" hint="I call the West Mids summary, returns xml the search result">
	 <cfargument name="searchTerms" type="struct" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                      
    	
     <cfset var summary="">
     <cfset var auditFieldData="">     
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset summary=variables.nominalDAO.doWestMidsPersonSummary(searchTerms=arguments.searchTerms,
                                                                      userId=arguments.userId,
                                                                      terminalId=arguments.terminalId,
                                                                      sessionId=arguments.sessionId)>
                                   
	  <cfloop collection="#searchTerms#" item="key">
		  <cfset auditFieldData=ListAppend(auditFieldData,key&"="&StructFind(searchTerms, key),",")>
	   </cfloop>                               
                                                                      
       <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mids Region Person Summary',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=1,
							 department=session.user.getDepartment())>                                                                         
    	     
     <cfreturn summary>
     
    </cffunction>     
    
    <cffunction name="doWestMidsPersonDetail" access="remote" returntype="any" output="false" hint="I call the West Mids Person detail, returns xml the search result">
	 <cfargument name="searchTerms" type="struct" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                      
    	
     <cfset var nominalDetail="">
     <cfset var auditFieldData="">     
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset nominalDetail=variables.nominalDAO.doWestMidsPersonDetail(searchTerms=arguments.searchTerms,
                                                                      userId=arguments.userId,
                                                                      terminalId=arguments.terminalId,
                                                                      sessionId=arguments.sessionId)>
                                   
	  <cfloop collection="#searchTerms#" item="key">
		  <cfset auditFieldData=ListAppend(auditFieldData,key&"="&StructFind(searchTerms, key),",")>
	   </cfloop>                               
                                                                      
       <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mids Region Person Detail',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=1,
                             department=session.user.getDepartment())>                                                                         
    	     
     <cfreturn nominalDetail>
     
    </cffunction>      
    
    <cffunction name="doWestMerciaFirearmsSearch" access="remote" returntype="any" output="false" hint="I call the West Mercia Firearms Person search, returns query the search result">
	 <cfargument type="struct" name="searchTerms" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument type="string" name="fromWebService" required="false" default="N" hint="flag for whether request is from web service">
	 <cfargument type="struct" name="wsAudit" required="false" default="#structNew()#" hint="struct of audit data">
	  	
     <cfset var nom=ArrayNew(1)>
     <cfset var qNoms="">
     <cfset var thisNom="">
 	 <cfset var lisSearch="">
     <cfset var term="">
	 <cfset var arrFirearmsPhotos=ArrayNew(1)> 
	 <cfset var s_PersonRef="">
	 <cfset var s_ForcePrefix="">
	 <cfset var s_NFLMSFile="">
	 <cfset var s_DestFile="">
	 <cfset var s_DestURL="">
     
     <!--- call the West Mercia Firearms search query. A query is returned, use this to get an array of nominal objects --->
     <cfset qNoms=variables.firearmsNominalDAO.doWestMerciaFirearmsSearch(searchTerms=arguments.searchTerms)>
	  
	 <!--- loop round the firearms results looking for the photos --->
	 <cfloop query="qNoms">
		<!--- find the photo --->
		<cfset s_PersonRef=PERSON_URN>
		<!--- remove the prefix 22 and the suffix P --->
		<cfset s_ForcePrefix=Left(s_PersonRef,2)>
		 <cfif s_ForcePrefix IS "22">
			<cfset s_PersonRef=Right(s_PersonRef,Len(s_PersonRef)-2)>
			<cfset s_PersonRef=Left(s_PersonRef,Len(s_PersonRef)-1)>
			<!--- convert to an in to remove the 0s --->
			<cfset s_PersonRef=Int(s_PersonRef)>	
		 <cfelse>
			<cfset s_PersonRef=Right(s_PersonRef,Len(s_PersonRef)-2)>
			<cfset s_PersonRef=Left(s_PersonRef,Len(s_PersonRef)-1)>    
		    <cfset s_PersonRef=s_ForcePrefix&"-"&Int(s_PersonRef)>
		 </cfif>
		
		<cfset s_NFLMSFile=variables.NFLMSImageDir&s_PersonRef&".jpg">
		
		<cfif FileExists(s_NFLMSFile)>
		 <cfset s_DestFile=variables.genieImagePath&"\NFLMS\NFLMS_"&s_PersonRef&".jpg">
		 <cfset s_DestURL=variables.genieImageDir&"\NFLMS\NFLMS_"&s_PersonRef&".jpg">
		 <cffile action="copy" source="#s_NFLMSFile#" destination="#s_DestFile#">
		<cfelse>
		 <cfset s_DestURL=''>
		</cfif>	 
		<cfset arrayAppend(arrFirearmsPhotos,s_DestUrl)>
	 </cfloop> 

	 <cfset queryAddColumn(qNoms,'PHOTO_URL','varchar',arrFirearmsPhotos)>

	 <cfloop collection="#arguments.searchTerms#" item="term">
	  <cfset lisSearch=ListAppend(lisSearch,term&"="&StructFind(arguments.searchTerms,term),",")>
	 </cfloop>

			<cfif arguments.fromWebService IS "Y">
		   		<cfset audit.enquiryUser=wsAudit.enquiryUser>
				<cfset audit.enquiryUserName=wsAudit.enquiryUserName>
				<cfset audit.requestFor=wsAudit.requestFor>
				<cfset audit.reasonCode=wsAudit.reasonCode>
				<cfset audit.reasonText=wsAudit.reasonText>   
				<cfset audit.sessionId=wsAudit.sessionId>
				<cfset audit.department=wsAudit.enquiryUserDept>
		   <cfelse>
		   		<cfset audit.enquiryUser=session.user.getUserId()>
				<cfset audit.enquiryUserName=session.user.getFullName()>
				<cfset audit.requestFor=session.audit_for>
				<cfset audit.reasonCode=session.audit_code>
				<cfset audit.reasonText=session.audit_details>  
				<cfset audit.sessionId=session.thisUUID>
				<cfset audit.department=session.user.getDepartment()> 		   	   
		   </cfif>	 

	     <cfset doGenieAudit(userId=audit.enquiryUser,
	                             sessionId=audit.sessionId,
	                             reason=audit.reasonCode,
	                             reasonText=audit.reasonText,
	                             requestFor=audit.requestFor,
	                             fullName=audit.enquiryUserName,
	                             action='West Mercia Firearms Search',
	                             fields=lisSearch,
	                             details='',
	                             numberOfResults=qNoms.recordCount,
                                 department=audit.department)>  
    	     
     <cfreturn qNoms>
     
    </cffunction>     
    
    <cffunction name="doWestMerciaAddressFirearmsSearch" access="remote" returntype="any" output="false" hint="I call the West Mercia Firearms Address search, returns struct containin two queries of addresses and people at addresses">
	 <cfargument type="struct" name="searchTerms" required="true" hint="Structure of search terms to be passed to the gateway search">
	 <cfargument type="string" name="searchType" required="false" default="firearmsEnquiry" hint="type of search to perform, firearms enquiry or address enquiry">        
    	
     <cfset var result=structNew()>
	 <cfset var auditFieldData=""> 
    
     <!--- call the West Mercia Firearms Address search query. A query is returned, use this to get an array of nominal objects --->
     <cfset result=variables.firearmsAddressDAO.doWestMerciaFirearmsAddressSearch(searchTerms=arguments.searchTerms,searchType=arguments.searchType)>
    
      <!--- format search data for logging --->
        <cfloop collection="#arguments.searchTerms#" item="searchKey">
           <cfset searchItem=StructFind(arguments.searchTerms,searchKey)>           
           <cfif Len(searchItem) GT 0>
            <cfset auditFieldData=ListAppend(auditFieldData,searchKey&"="&searchItem,"|")>
           </cfif>
         </cfloop>    
                                                                                                                      
         <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mercia Firearms Address Search',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=result.qAddress.recordCount,
                             department=session.user.getDepartment())>    
    	     
     <cfreturn result>
     
    </cffunction>      
       
    <cffunction name="doWestMerciaAddressSearch" access="remote" returntype="any" output="false" hint="I call the West Mercia Address search, returns query the search result">
	 <cfargument type="struct" name="searchTerms" required="true" hint="Structure of search terms to be passed to the gateway search">
    	
     <cfset var searchResult="">
     <cfset var auditFieldData="">
     <cfset var searchItem="">
     <cfset var searchKey="">     
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset searchResult=variables.addressDAO.doWestMerciaAddressSearch(searchTerms=arguments.searchTerms)>
                                                              
      <!--- format search data for logging --->
        <cfloop collection="#arguments.searchTerms#" item="searchKey">
           <cfset searchItem=StructFind(arguments.searchTerms,searchKey)>           
           <cfif Len(searchItem) GT 0>
            <cfset auditFieldData=ListAppend(auditFieldData,searchKey&"="&searchItem,"|")>
           </cfif>
         </cfloop>    
                                                             
                                                              
         <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mercia Address Search',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=searchResult.recordCount,
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>                                                              
    
     <cfreturn searchResult>
     
    </cffunction>       
    
    <cffunction name="doWestMidsAddressSearch" access="remote" returntype="any" output="false" hint="I call the West Mids Address address, returns xml the search result">
	 <cfargument type="string" name="searchTerms" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                      
    	
     <cfset var searchResult=StructNew()>
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset searchResult=variables.addressDAO.doWestMidsAddressSearch(searchTerms=arguments.searchTerms,
                                                              userId=arguments.userId,
                                                              terminalId=arguments.terminalId,
                                                              sessionId=arguments.sessionId)>
                                                              
     <cfif searchResult.searchOK>                                                              
                                                              
	     <cfset doGenieAudit(userId=session.user.getUserId(),
	                             sessionId=session.thisUUID,
	                             reason=session.audit_code,
	                             reasonText=session.audit_details,
	                             requestFor=session.audit_for,
	                             fullName=session.user.getFullName(),
	                             action='West Mids Region Address Search',
	                             fields=StripCr(searchTerms),
	                             details='',
	                             numberOfResults=0,
                                 department=session.user.getDepartment())>                                                          
    	     
     </cfif>	     
    
     <cfreturn searchResult>
     
    </cffunction>           
      
    <cffunction name="doWestMidsAddressGrouping" access="remote" returntype="struct" output="false" hint="returns a query of grouped addresses">
	 <cfargument type="array" name="addresses" required="true" hint="addresses to be grouped">
    	
     <cfset var groupedAddresses=StructNew()>
     
     <cfset groupedAddresses=variables.addressDAO.doWestMidsGrouping(addresses=arguments.addresses)>
                                                             
     <cfreturn groupedAddresses>
     
    </cffunction>       
      
    <cffunction name="doWestMidsAddressSummary" access="remote" returntype="any" output="false" hint="I call the West Mids Address summaryl, returns xml the search result">
	 <cfargument name="searchTerms" type="struct" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                      
    	
     <cfset var summary="">
     <cfset var auditFieldData="">     
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset summary=variables.addressDAO.doWestMidsAddressSummary(searchTerms=arguments.searchTerms,
                                                                      userId=arguments.userId,
                                                                      terminalId=arguments.terminalId,
                                                                      sessionId=arguments.sessionId)>
                                   
	  <cfloop collection="#searchTerms#" item="key">
		  <cfset auditFieldData=ListAppend(auditFieldData,key&"="&StructFind(searchTerms, key),",")>
	   </cfloop>                               
                                                                      
       <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mids Region Address Summary',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=1,
                             department=session.user.getDepartment())>                                                                         
    	     
     <cfreturn summary>
     
    </cffunction>         
      
    <cffunction name="doWestMidsAddressDetail" access="remote" returntype="any" output="false" hint="I call the West Mids Address detail, returns xml the search result">
	 <cfargument name="searchTerms" type="struct" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                      
    	
     <cfset var addressDetail="">
     <cfset var auditFieldData="">     
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset addressDetail=variables.addressDAO.doWestMidsAddressDetail(searchTerms=arguments.searchTerms,
                                                                      userId=arguments.userId,
                                                                      terminalId=arguments.terminalId,
                                                                      sessionId=arguments.sessionId)>
                                   
	  <cfloop collection="#searchTerms#" item="key">
		  <cfset auditFieldData=ListAppend(auditFieldData,key&"="&StructFind(searchTerms, key),",")>
	   </cfloop>                               
                                                                      
       <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mids Region Address Detail',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=1,
							 department=session.user.getDepartment())>                                                                         
    	     
     <cfreturn addressDetail>
     
    </cffunction>    
    
    <cffunction name="doWestMerciaVehicleSearch" access="remote" returntype="any" output="false" hint="I call the West Mercia Vehicle search, returns query the search result">
	 <cfargument type="struct" name="searchTerms" required="true" hint="Structure of search terms to be passed to thesearch">
    	
     <cfset var searchResult=QueryNew("VEH_REF,VRM,Veh_Details,Information,Date_From,Date_To,Type,Ref,Ref_Text,Reason,Usage,Text,Type2,Ref2,Ref_Text2","VarChar,VarChar,VarChar,VarChar,Date,Date,VarChar,VarChar,VarChar,VarChar,Varchar,VarChar,VarChar,VarChar,VarChar")>
     <cfset var qVehResultsSorted="">
     <cfset var vehicleMatches="">
     <cfset var auditFieldData="">
     <cfset var searchItem="">
     <cfset var searchKey="">     
     <cfset var x=1>
     <cfset var str_Info="">
     <cfset var str_Nom_Link="">
     <cfset var lis_Results="">
     <cfset var temp="">
     <cfset var row="">
     <cfset var nominal="">
     <cfset var qCaseDetails="">
     <cfset var str_Case_Doc_Link="">
     <cfset var propertyMatches="">
	 <cfset var arrHasIntel=ArrayNew(1)>
     
     <!--- check if the VRM passed in requires a special search --->
     <cfif Find("*",arguments.searchTerms.VRM) GT 0>
      <cfset arguments.searchTerms.VRM=variables.vehicleDAO.createVRMList(VRM=arguments.searchTerms.VRM)>
     </cfif>
     
     <!--- call the West Mercia Vehicle search a query is returned --->
     <cfset vehicleMatches=variables.vehicleDAO.doWestMerciaVehicleSearch(searchTerms=arguments.searchTerms)>
		
     <!--- populate the usage data from Intel, Crime, Crash, Case, Custody --->
		<cfif vehicleMatches.RecordCount GT 0>
		   <cfset x=1>
		   <cfloop query="vehicleMatches" startrow="1" endrow="200">
		    <cfset lis_Results=ListAppend(lis_Results,"'"&VRM&"'",",")>
			
			<cfset str_Info="">
			
				 <cfif Len(Nominal_Ref) GT 0 AND FindNoCase("CRASH",USAGE) IS 0 AND Len(CASE_URN) IS 0>
		          
		          <!---
		 		  <cfset str_Nom_Link=variables.NominalLink&"str_CRO=#NOMINAL_REF#&str_NoMenu=YES">	
			      <cfif Len(REASON) GT 0>
				  <cfset str_Info=str_Info&REASON&" : <a href=""###NOMINAL_REF#"" onClick=""fullscreen('#str_Nom_Link#&#Session.URLToken#','Nom_Info')""><strong>#NOMINAL_REF#</strong>">
				  <cfelseif Len(USAGE) GT 0>
		 		  <cfset str_Info=str_Info&USAGE&" : <a href=""###NOMINAL_REF#"" onClick=""fullscreen('#str_Nom_Link#&#Session.URLToken#','Nom_Info')""><strong>#NOMINAL_REF#</strong>">		  
			      </cfif>
                                    
                                 
                                    
				  <cfset str_Info=str_Info&" "&nominal.getFULL_NAME()&"</a>">	
				  <cfif Len(TEXT) GT 0>
					 <cfif Len(str_Info) GT 0>
						 <cfset str_info=str_info&"<br>">
					 </cfif>
					<cfset str_Info=str_Info&TEXT>
				  </cfif>
				  --->
				  
				    <cfset nominal=createObject("component","nominal.nominal").init()>
                    <cfset nominal.setNOMINAL_REF(NOMINAL_REF)>
                    <cfset nominal=variables.nominalDAO.readWestMerciaNominal(nominal)> 
				  
		            <cfset row=QueryAddRow(searchResult,1)>
		        	<cfset temp=QuerySetCell(searchResult,"VEH_REF",VEH_REF,x)>						
		        	<cfset temp=QuerySetCell(searchResult,"VRM",VRM,x)>
		        	<cfset temp=QuerySetCell(searchResult,"VEH_DETAILS",MANUFACTURER&" - "&MODEL&". "&BODY_TYPE&" "&SHADE&" "&PRIMARY_COL&" "&SECONDARY_COL&"<br>"&TEXT,x)>		  
					<cfset temp=QuerySetCell(searchResult,"INFORMATION",str_Info,x)>	
					<cfset temp=QuerySetCell(searchResult,"DATE_FROM",START_DATE,x)>
					<cfset temp=QuerySetCell(searchResult,"DATE_TO",END_DATE,x)>
					<cfset temp=QuerySetCell(searchResult,"TEXT",TEXT,x)>
					<cfset temp=QuerySetCell(searchResult,"REASON",REASON,x)>
					<cfset temp=QuerySetCell(searchResult,"USAGE",USAGE,x)>
					<cfset temp=QuerySetCell(searchResult,"TYPE","NOMINAL",x)>
					<cfset temp=QuerySetCell(searchResult,"REF",NOMINAL_REF,x)>
					<cfset temp=QuerySetCell(searchResult,"REF_TEXT",nominal.getFULL_NAME(),x)>		
				 
		         <cfelseif FindNoCase("CRASH",USAGE) GT 0>   
		              
		            <cfset row=QueryAddRow(searchResult,1)>
		        	<cfset temp=QuerySetCell(searchResult,"VEH_REF",VEH_REF,x)>						
		        	<cfset temp=QuerySetCell(searchResult,"VRM",VRM,x)>
		        	<cfset temp=QuerySetCell(searchResult,"VEH_DETAILS",MANUFACTURER&" - "&MODEL&". "&BODY_TYPE&" "&SHADE&" "&PRIMARY_COL&" "&SECONDARY_COL&"<br>"&TEXT,x)>		  
		        	<cfset temp=QuerySetCell(searchResult,"INFORMATION","RTC : <strong><a href=""nominal_details/code/documentview.cfm?#session.URLToken#&str_DocRef=#REASON#&str_DocType=CRASH&crashDate=#DateFormat(START_DATE,"DD/MM/YYYY")#"" target=""_blank"">#REASON#</a></strong>",x)>	
					<cfset temp=QuerySetCell(searchResult,"DATE_FROM",START_DATE,x)>
					<cfset temp=QuerySetCell(searchResult,"DATE_TO",END_DATE,x)>
					<cfset temp=QuerySetCell(searchResult,"REASON",REASON,x)>
					<cfset temp=QuerySetCell(searchResult,"USAGE",USAGE,x)>
					<cfset temp=QuerySetCell(searchResult,"TYPE","CRASH",x)>
					<cfset temp=QuerySetCell(searchResult,"REF",REASON,x)>
					<cfset temp=QuerySetCell(searchResult,"REF_TEXT",REASON,x)>
					<cfset temp=QuerySetCell(searchResult,"TYPE2","INCIDENT",x)>
					<cfset temp=QuerySetCell(searchResult,"REF2",INCIDENT_NO,x)>
					<cfset temp=QuerySetCell(searchResult,"REF_TEXT2",INCIDENT_NO,x)>				              
		              
				 <cfelseif Len(Org_Code) GT 0>
				  <cfset orgName=variables.organisationsDAO.getOrganisationName(orgCode=ORG_CODE)>
				  <!---
				  <Cfset str_Info=str_Info&"-"&orgName>
				  <cfif Len(TEXT) GT 0>
					 <cfif Len(str_Info) GT 0>
						 <cfset str_info=str_info&"<br>">
					 </cfif>
					<cfset str_Info=str_Info&TEXT>
				  </cfif>
				  --->		  
		            <cfset row=QueryAddRow(searchResult,1)>
		        	<cfset temp=QuerySetCell(searchResult,"VEH_REF",VEH_REF,x)>			
		        	<cfset temp=QuerySetCell(searchResult,"VRM",VRM,x)>
		        	<cfset temp=QuerySetCell(searchResult,"VEH_DETAILS",MANUFACTURER&" - "&MODEL&". "&BODY_TYPE&" "&SHADE&" "&PRIMARY_COL&" "&SECONDARY_COL,x)>		  
					<cfset temp=QuerySetCell(searchResult,"INFORMATION",str_Info,x)>	
					<cfset temp=QuerySetCell(searchResult,"DATE_FROM",START_DATE,x)>
					<cfset temp=QuerySetCell(searchResult,"DATE_TO",END_DATE,x)>
					<cfset temp=QuerySetCell(searchResult,"REASON",REASON,x)>
					<cfset temp=QuerySetCell(searchResult,"USAGE",USAGE,x)>
					<cfset temp=QuerySetCell(searchResult,"TYPE","ORG",x)>
					<cfset temp=QuerySetCell(searchResult,"REF",orgName,x)>
					<cfset temp=QuerySetCell(searchResult,"REF_TEXT",orgName,x)>		
				 		
				 
				 <cfelseif Len(Case_URN) GT 0>
                   <cfset qCaseDates=variables.processDecisionDAO.getCaseDatesCreated(case_Urn=CASE_URN)>

				 
				  <cfif qCaseDates.RecordCount GT 0>
				    <cfif Left(VEH_REF,3) IS "22/">
					 <cfif Len(ListGetAt(CASE_URN,1,"/")) GT 0>
					 <cfset str_Case_Doc_Link="<a href=""nominal_details/code/documentview.cfm?#Session.URLToken#&str_DocRef=#CASE_URN#">
					 <cfif Len(ListGetAt(CASE_URN,3,"/")) IS 1>
					  <cfset str_Case_Doc_Link=str_Case_Doc_Link&"0"&ListGetAt(CASE_URN,3,"/")>
					 <cfelse>
					  <cfset str_Case_Doc_Link=str_Case_Doc_Link&ListGetAt(CASE_URN,3,"/")>
					 </cfif>
					 <cfset str_Case_Doc_Link=str_Case_Doc_Link&"&REC_MON=#qCaseDates.REC_MON#&REC_DAY=#qCaseDates.REC_DAY#&REC_YEAR=#qCaseDates.REC_YEAR#&str_DocType=Case"" target=""blank""><strong>#CASE_URN#</strong></a>">
					 <cfelse>
					 <cfset str_Case_Doc_Link="">
					 </cfif>
					<cfelse>
					<cfset str_Case_Doc_Link=CASE_URN>	 
				    </cfif>
				  <cfelse>  		 
					<cfset str_Case_Doc_Link=CASE_URN>	 		  
			      </cfif>
				 
				  <cfset str_Info="CASE : "&str_Case_Doc_Link>
		            <cfset row=QueryAddRow(searchResult,1)>
		        	<cfset temp=QuerySetCell(searchResult,"VEH_REF",VEH_REF,x)>						
		        	<cfset temp=QuerySetCell(searchResult,"VRM",VRM,x)>
		        	<cfset temp=QuerySetCell(searchResult,"VEH_DETAILS",MANUFACTURER&" - "&MODEL&". "&BODY_TYPE&" "&SHADE&" "&PRIMARY_COL&" "&SECONDARY_COL,x)>		  
					<cfset temp=QuerySetCell(searchResult,"INFORMATION",str_Info,x)>	
					<cfset temp=QuerySetCell(searchResult,"DATE_FROM",START_DATE,x)>
					<cfset temp=QuerySetCell(searchResult,"DATE_TO",END_DATE,x)>	
					<cfset temp=QuerySetCell(searchResult,"REASON",REASON,x)>
					<cfset temp=QuerySetCell(searchResult,"USAGE",USAGE,x)>
					<cfset temp=QuerySetCell(searchResult,"TYPE","CASE",x)>
					<cfset temp=QuerySetCell(searchResult,"REF",CASE_URN,x)>
					<cfset temp=QuerySetCell(searchResult,"REF_TEXT",CASE_URN,x)>
					
					<cfif Len(NOMINAL_REF) GT 0>
						<cfset nominal=createObject("component","nominal.nominal").init()>
	                    <cfset nominal.setNOMINAL_REF(NOMINAL_REF)>
	                    <cfset nominal=variables.nominalDAO.readWestMerciaNominal(nominal)>
						<cfset temp=QuerySetCell(searchResult,"TYPE2","NOMINAL",x)>
						<cfset temp=QuerySetCell(searchResult,"REF2",NOMINAL_REF,x)>
						<cfset temp=QuerySetCell(searchResult,"REF_TEXT2",nominal.getFULL_NAME(),x)>
					<cfelse>
						<cfset temp=QuerySetCell(searchResult,"TYPE2","",x)>
						<cfset temp=QuerySetCell(searchResult,"REF2","",x)>
						<cfset temp=QuerySetCell(searchResult,"REF_TEXT2","",x)> 
					</cfif>													  
				  
				 <cfelse>
				  <cfif Len(TEXT) GT 0>
					 <cfif Len(str_Info) GT 0>
						 <cfset str_info=str_info&"<br>">
					 </cfif>
					<cfset str_Info=str_Info&TEXT>
				  </cfif>		 
		            <cfset row=QueryAddRow(searchResult,1)>
		        	<cfset temp=QuerySetCell(searchResult,"VEH_REF",VEH_REF,x)>			
		        	<cfset temp=QuerySetCell(searchResult,"VRM",VRM,x)>
		        	<cfset temp=QuerySetCell(searchResult,"VEH_DETAILS",MANUFACTURER&" - "&MODEL&". "&BODY_TYPE&" "&SHADE&" "&PRIMARY_COL&" "&SECONDARY_COL,x)>		  
					<cfset temp=QuerySetCell(searchResult,"INFORMATION",str_Info,x)>	
					<cfset temp=QuerySetCell(searchResult,"DATE_FROM",START_DATE,x)>
					<cfset temp=QuerySetCell(searchResult,"DATE_TO",END_DATE,x)>				 
				 </cfif>				  
		       

               <cfset arrHasIntel[x]=variables.intelDAO.vehicleHasIntel(vehRef=VEH_REF)>		
			            			
		    <cfset x=x+1>
		   </cfloop>
           
		
		  </cfif>        
          
          <cfif isArray(arguments.searchTerms.VRM)>     
           <cfset vrmLen=ArrayLen(arguments.searchTerms.VRM)>    
          <cfelse> 
           <cfset vrmLen=Len(arguments.searchTerms.VRM)>
          </cfif>
                
		  <cfif vrmLen GT 0 or Len(arguments.searchTerms.MANUFACTURER) GT 0 or Len(arguments.searchTerms.MODEL) GT 0>
           
           <cfset propertyMatches=variables.propertyDAO.doWestMerciaPropertyVehicleSearch(arguments.searchTerms)>
		
		   <cfloop query="propertyMatches">
			<cfset row=QueryAddRow(searchResult,1)>
			<cfset temp=QuerySetCell(searchResult,"VRM",VRM,x)>
			<cfset temp=QuerySetCell(searchResult,"VEH_REF","",x)>	
			<cfset temp=QuerySetCell(searchResult,"VEH_DETAILS",MANUFACTURER&" - "&MODEL,x)>
			<cfset temp=QuerySetCell(searchResult,"INFORMATION",VEH_USAGE&": <strong><a href=""nominal_details/code/documentview.cfm?#session.URLToken#&str_DocRef=#CRIME_NO#&str_DocType=CRIME07&REC_DAY=#REC_DAY#&REC_MON=#REC_MON#&REC_YEAR=#REC_YEAR#&Crimes_Ref=#CRIME_REF#"" target=""_blank"">#CRIME_NO#</a></strong>",x)>	
			<cfset temp=QuerySetCell(searchResult,"DATE_FROM",CRIME_FIRST_DATE,x)>
			<cfset temp=QuerySetCell(searchResult,"DATE_TO",CRIME_LAST_DATE,x)>	
			<cfset temp=QuerySetCell(searchResult,"REASON",'',x)>
			<cfset temp=QuerySetCell(searchResult,"USAGE",VEH_USAGE,x)>
			<cfset temp=QuerySetCell(searchResult,"TYPE","CRIME",x)>
			<cfset temp=QuerySetCell(searchResult,"REF",CRIME_NO,x)>
			<cfset temp=QuerySetCell(searchResult,"REF_TEXT",CRIME_NO,x)>		
				 
            <cfset arrHasIntel[x]="">			
			<cfset x=x+1>
		   </cfloop>
		  </cfif>   
		  
	 <cfset temp=queryAddColumn(searchResult,"hasIntel","VarChar",arrHasIntel)>	       
                
     <cfquery name="qVehResultsSorted" dbtype="query">
	 SELECT *
	 FROM   searchResult
	 ORDER  BY VRM, Date_From DESC
	 </cfquery>	         
                                                                                                                                                                                        
      <!--- format search data for logging --->
        <cfloop collection="#arguments.searchTerms#" item="searchKey">
           <cfset searchItem=StructFind(arguments.searchTerms,searchKey)> 
           <cfif isArray(searchItem)>  
               <cfset auditFieldData=ListAppend(auditFieldData,searchKey&"="&ArrayToList(searchItem,";"),"|")>
           <cfelse>          
	           <cfif Len(searchItem) GT 0>
	            <cfset auditFieldData=ListAppend(auditFieldData,searchKey&"="&searchItem,"|")>
	           </cfif>
           </cfif>
         </cfloop>    
                                                             
                                                              
         <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mercia Vehicle Search',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=qVehResultsSorted.recordCount,
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>                                                                 

     <cfreturn qVehResultsSorted>
     
    </cffunction>     
       
    <cffunction name="doWestMidsVehicleSearch" access="remote" returntype="any" output="false" hint="I call the West Mids vehicle address, returns xml the search result">
	 <cfargument type="string" name="searchTerms" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                      
    	
     <cfset var searchResult=StructNew()>
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset searchResult=variables.vehicleDAO.doWestMidsVehicleSearch(searchTerms=arguments.searchTerms,
                                                              userId=arguments.userId,
                                                              terminalId=arguments.terminalId,
                                                              sessionId=arguments.sessionId)>
                                                              
     <cfif searchResult.searchOK>                                                              
                                                              
	     <cfset doGenieAudit(userId=session.user.getUserId(),
	                             sessionId=session.thisUUID,
	                             reason=session.audit_code,
	                             reasonText=session.audit_details,
	                             requestFor=session.audit_for,
	                             fullName=session.user.getFullName(),
	                             action='West Mids Region Vehicle Search',
	                             fields=StripCr(searchTerms),
	                             details='',
	                             numberOfResults=0,
                                 department=session.user.getDepartment(),
								 ethnicCode=session.ethnic_code,
								 requestCollar=session.audit_for_collar,
								 requestForce=session.audit_for_force)>                                                          
    	     
     </cfif>	     
    
     <cfreturn searchResult>
     
    </cffunction>       
    
    <cffunction name="doWestMidsVehicleSummary" access="remote" returntype="any" output="false" hint="I call the West Mids summary, returns xml the search result">
	 <cfargument name="searchTerms" type="struct" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                      
    	
     <cfset var summary="">
     <cfset var auditFieldData="">     
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset summary=variables.vehicleDAO.doWestMidsVehicleSummary(searchTerms=arguments.searchTerms,
                                                                      userId=arguments.userId,
                                                                      terminalId=arguments.terminalId,
                                                                      sessionId=arguments.sessionId)>
                                   
	  <cfloop collection="#searchTerms#" item="key">
		  <cfset auditFieldData=ListAppend(auditFieldData,key&"="&StructFind(searchTerms, key),",")>
	   </cfloop>                               
                                                                      
       <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mids Region Vehicle Summary',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=1,
                             department=session.user.getDepartment())>                                                                         
    	     
     <cfreturn summary>
     
    </cffunction>        
    
    <cffunction name="doWestMidsVehicleDetail" access="remote" returntype="any" output="false" hint="I call the West Mids Vehicle detail, returns xml the search result">
	 <cfargument name="searchTerms" type="struct" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                      
    	
     <cfset var vehicleDetail="">
     <cfset var auditFieldData="">     
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset vehicleDetail=variables.vehicleDAO.doWestMidsVehicleDetail(searchTerms=arguments.searchTerms,
                                                                      userId=arguments.userId,
                                                                      terminalId=arguments.terminalId,
                                                                      sessionId=arguments.sessionId)>
                                   
	  <cfloop collection="#searchTerms#" item="key">
		  <cfset auditFieldData=ListAppend(auditFieldData,key&"="&StructFind(searchTerms, key),",")>
	   </cfloop>                               
                                                                      
       <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mids Region Vehicle Detail',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=1,
                             department=session.user.getDepartment())>                                                                         
    	     
     <cfreturn vehicleDetail>
     
    </cffunction>     
       
    <cffunction name="doWestMerciaTelephoneSearch" access="remote" returntype="any" output="false" hint="I call the West Mercia Telephone search, returns query the search result">
	 <cfargument type="struct" name="searchTerms" required="true" hint="Structure of search terms to be passed to the gateway search">
    	
     <cfset var searchResult="">
     <cfset var auditFieldData="">
     <cfset var searchItem="">
     <cfset var searchKey="">     
     <cfset var nominals=arrayNew(1)>
     <cfset var nominal="">
     <cfset var hasIntel=arrayNew(1)>
     <cfset var crimes=arrayNew(1)>
	 <cfset var offence="">
     <cfset var temp="">
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset searchResult=variables.telephoneDAO.doWestMerciaTelephoneSearch(searchTerms=arguments.searchTerms)>
     
     <cfloop query="searchResult">
        <cfif Len(NOMINAL_REF) GT 0>
         <cfset nominal=createObject("component","nominal.nominal").init()>
         <cfset nominal.setNOMINAL_REF(NOMINAL_REF)>
         <cfset nominal=variables.nominalDAO.readWestMerciaNominal(nominal)>          
         <cfset ArrayAppend(nominals,nominal.getFULL_NAME())>
        <cfelse>
         <cfset ArrayAppend(nominals,"")>
        </cfif>
        
        <!--- check to see if we have telephone intel --->
        <cfset ArrayAppend(hasIntel,variables.intelDAO.telephoneHasIntel(source=SOURCE,sourceId=SOURCE_ID))>
        
        <!--- get offence details if they exist --->
        <cfif Len(CRIME_REF) GT 0>
		 <cfset offence=createObject("component","offences.offence").init()>
		 <cfset offence.setCRIME_REF(CRIME_REF)>	
		 <cfset offence=variables.offenceDAO.readWestMerciaOffence(id=offence)>
         <cfset ArrayAppend(crimes,offence.getCRIME_NO())>
        <cfelse>
         <cfset ArrayAppend(crimes,"")>   
        </cfif>
        
     </cfloop>
     
     <cfset temp=QueryAddColumn(searchResult,"NOMINAL_NAME","VarChar",nominals)>
     <cfset temp=QueryAddColumn(searchResult,"HAS_INTEL","VarChar",hasIntel)> 
     <cfset temp=QueryAddColumn(searchResult,"CRIME_NO","VarChar",crimes)>          
                                                              
      <!--- format search data for logging --->
        <cfloop collection="#arguments.searchTerms#" item="searchKey">
           <cfset searchItem=StructFind(arguments.searchTerms,searchKey)>           
           <cfif Len(searchItem) GT 0>
            <cfset auditFieldData=ListAppend(auditFieldData,searchKey&"="&searchItem,"|")>
           </cfif>
         </cfloop>    
                                                             
                                                              
         <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mercia Telephone Search',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=searchResult.recordCount,
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>                                                                
    
     <cfreturn searchResult>
     
    </cffunction>            

    <cffunction name="doWestMerciaFirearmsTelephoneSearch" access="remote" returntype="any" output="false" hint="I call the West Mercia Firearms Telephone search, returns a query of firearms holders associated with tel no">
	 <cfargument type="string" name="telephoneNumber" required="true" hint="telephone number to search">
    	
     <cfset var result=structNew()>
    
     <cfset result=variables.firearmsNominalDAO.doWestMerciaFirearmsTelephoneSearch(telephoneNumber=arguments.telephoneNumber)>
    	     
     <cfreturn result>
     
    </cffunction>  
       
    <cffunction name="doWestMidsTelephoneSearch" access="remote" returntype="any" output="false" hint="I call the West Mids telephone search, returns xml the search result">
	 <cfargument type="string" name="searchTerms" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                      
    	
     <cfset var searchResult=StructNew()>
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset searchResult=variables.telephoneDAO.doWestMidsTelephoneSearch(searchTerms=arguments.searchTerms,
                                                              userId=arguments.userId,
                                                              terminalId=arguments.terminalId,
                                                              sessionId=arguments.sessionId)>
                                                              
     <cfif searchResult.searchOK>                                                              
                                                              
	     <cfset doGenieAudit(userId=session.user.getUserId(),
	                             sessionId=session.thisUUID,
	                             reason=session.audit_code,
	                             reasonText=session.audit_details,
	                             requestFor=session.audit_for,
	                             fullName=session.user.getFullName(),
	                             action='West Mids Region Telephone Search',
	                             fields=StripCr(searchTerms),
	                             details='',
	                             numberOfResults=0,
                                 department=session.user.getDepartment())>                                                           
    	     
     </cfif>	     
    
     <cfreturn searchResult>
     
    </cffunction>         

    <cffunction name="doWestMidsTelephoneSummary" access="remote" returntype="any" output="false" hint="I call the West Mids summary, returns xml the search result">
	 <cfargument name="searchTerms" type="struct" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                      
    	
     <cfset var summary="">
     <cfset var auditFieldData="">     
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset summary=variables.telephoneDAO.doWestMidsTelephoneSummary(searchTerms=arguments.searchTerms,
                                                                      userId=arguments.userId,
                                                                      terminalId=arguments.terminalId,
                                                                      sessionId=arguments.sessionId)>
                                   
	  <cfloop collection="#searchTerms#" item="key">
		  <cfset auditFieldData=ListAppend(auditFieldData,key&"="&StructFind(searchTerms, key),",")>
	   </cfloop>                               
                                                                      
       <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mids Region Telephone Summary',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=1,
                             department=session.user.getDepartment())>                                                                         
    	     
     <cfreturn summary>
     
    </cffunction>    
       
    <cffunction name="doWestMidsTelephoneDetail" access="remote" returntype="any" output="false" hint="I call the West Mids telephone detail, returns xml the search result">
	 <cfargument name="searchTerms" type="struct" required="true" hint="Structure of search terms to be passed to the gateway search">
     <cfargument name="userId" required="true" type="string" hint="userId of user making request">
     <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
     <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                      
    	
     <cfset var telephoneDetail="">
     <cfset var auditFieldData="">     
     
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset telephoneDetail=variables.telephoneDAO.doWestMidsTelephoneDetail(searchTerms=arguments.searchTerms,
                                                                      userId=arguments.userId,
                                                                      terminalId=arguments.terminalId,
                                                                      sessionId=arguments.sessionId)>
                                   
	  <cfloop collection="#searchTerms#" item="key">
		  <cfset auditFieldData=ListAppend(auditFieldData,key&"="&StructFind(searchTerms, key),",")>
	   </cfloop>                               
                                                                      
       <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mids Region Vehicle Detail',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=1,
                             department=session.user.getDepartment())>                                                                         
    	     
     <cfreturn telephoneDetail>
     
    </cffunction>         

    <cffunction name="doWestMerciaIntelFreeText" access="remote" returntype="any" output="false" hint="performs a free text search of intelligence logs">
	 <cfargument type="string" name="searchText" required="true" hint="searchText">
	 <cfargument type="string" name="division" required="false" default="" hint="division filter">
	 <cfargument type="string" name="fromDate" required="false" default="" hint="date created from format DD/MM/YYYY">
	 <cfargument type="string" name="toDate" required="false" default="" hint="date created from format DD/MM/YYYY">   
	 <cfargument type="string" name="order" required="false" default="date" hint="order of results date or relevance"> 
	 <cfargument type="string" name="relevance" required="false" default="60" hint="releavnce of results 0-100">
	 <cfargument type="string" name="accessLevel" required="false" default="99" hint="users log access level">  
    	
     <cfset var result=structNew()>
    
     <cfset result=variables.intelDAO.doIntelFreeTextSearch(searchText=arguments.searchText,
									   division=arguments.division,
									   fromDate=arguments.fromDate,
									   toDate=arguments.toDate,
									   order=arguments.order,
									   relevance=arguments.relevance,
									   accessLevel=arguments.accessLevel)>

       <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='West Mercia Intel Free text',
                             fields='searchText='&arguments.searchText&",division="&arguments.division&",fromDate="&arguments.fromDate&',toDate='&arguments.toDate&',order='&arguments.order&'relevance='&arguments.relevance&',accessLevel='&accessLevel,
                             details='',
                             numberOfResults=result.recordCount,
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>      
    	     
     <cfreturn result>
     
    </cffunction>  
    
    <cffunction name="doCustodyWhiteboard" access="remote" returntype="any" output="false" hint="performs a custody whiteboard search">
	 <cfargument type="string" name="custodySuite" required="true" hint="custody suite to get whiteboard for">
	 <cfargument type="string" name="searchUUID" required="false" default="" hint="unique id if a list of search results is required"> 
	 	
     <cfset var custs="">
	 <cfset var iCust=0>
	 <cfset var lisCusts="">
    
     <cfset custs=variables.custodyDAO.doCustodyWhiteboard(custodySuite=custodySuite)>

     <cfloop from="1" to="#ArrayLen(custs)#" index="iCust">
   	   <cfset custs[iCust].setNOMINAL(getWestMerciaNominalDetail(nominalRef=custs[iCust].getNOMINAL_REF(),photosRequired='N',warningsRequired='Y'))>
	   <cfset lisCusts=listAppend(lisCusts,custs[iCust].getCUSTODY_REF()&"|"&custs[iCust].getCUSTODY_TYPE(),",")>
	 </cfloop>
	 
     <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='Custody Whiteboard',
                             fields='custodySuite='&arguments.custodySuite,
                             details='',
                             numberOfResults=arrayLen(custs),
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>     
                             
     <cfif Len(arguments.searchUUID) GT 0>
	 	<cffile action="write" file="#variables.custodyTempDir##searchUUID#.txt" output="#lisCusts#">
	 </cfif>                        
    	     
     <cfreturn custs>
     
    </cffunction>      
    
    <cffunction name="doCustodyEnquiry" access="remote" returntype="any" output="false" hint="performs a custody enquiry search">
	 <cfargument type="struct" name="searchTerms" required="true" hint="Structure of search terms to be passed to the DAO search">
	 <cfargument type="string" name="searchUUID" required="false" default="" hint="unique id if a list of search results is required"> 
    	
     <cfset var custs="">
	 <cfset var iCust=0>
     <cfset var auditFieldData="">
     <cfset var searchItem="">
     <cfset var searchKey=""> 
	 <cfset var lisCusts="">    
          
     <cfset custs=variables.custodyDAO.doCustodyEnquiry(searchTerms=arguments.searchTerms)>
	  
	 <cfloop from="1" to="#ArrayLen(custs)#" index="iCust">
   	   <cfset custs[iCust].setNOMINAL(getWestMerciaNominalDetail(nominalRef=custs[iCust].getNOMINAL_REF(),photosRequired='N',warningsRequired='Y'))>
	   <cfset lisCusts=listAppend(lisCusts,custs[iCust].getCUSTODY_REF()&"|"&custs[iCust].getCUSTODY_TYPE(),",")>
	 </cfloop> 
                                                              
      <!--- format search data for logging --->
        <cfloop collection="#arguments.searchTerms#" item="searchKey">
           <cfset searchItem=StructFind(arguments.searchTerms,searchKey)>           
           <cfif Len(searchItem) GT 0>
            <cfset auditFieldData=ListAppend(auditFieldData,searchKey&"="&searchItem,"|")>
           </cfif>
         </cfloop>    
                                                              
         <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='Custody Enquiry',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=arrayLen(custs),
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>                                                              
    
      <cfif Len(arguments.searchUUID) GT 0>
	 	<cffile action="write" file="#variables.custodyTempDir##searchUUID#.txt" output="#lisCusts#">
	  </cfif>  
    
     <cfreturn custs>
     
    </cffunction>  
    
    <cffunction name="doPDEnquiry" access="remote" returntype="any" output="false" hint="performs a custody enquiry search">
	 <cfargument type="struct" name="searchTerms" required="true" hint="Structure of search terms to be passed to the DAO search">
	 <cfargument type="string" name="searchUUID" required="false" default="" hint="unique id if a list of search results is required"> 
    	
     <cfset var pds="">
	 <cfset var iPd=0>
     <cfset var auditFieldData="">
     <cfset var searchItem="">
     <cfset var searchKey=""> 
	 <cfset var lisPDs="">    
          
     <cfset pds=variables.processDecisionDAO.doPDEnquiry(searchTerms=arguments.searchTerms)>
	
	 <cfloop from="1" to="#ArrayLen(pds)#" index="iPd">
	   <cfset lisPds=listAppend(lisPds,pds[iPd].getCASE_NO()&"|"&pds[iPd].getCASE_TYPE(),",")>
	 </cfloop> 
	
     <!--- format search data for logging --->
     <cfloop collection="#arguments.searchTerms#" item="searchKey">
       <cfset searchItem=StructFind(arguments.searchTerms,searchKey)>           
       <cfif Len(searchItem) GT 0>
        <cfset auditFieldData=ListAppend(auditFieldData,searchKey&"="&searchItem,"|")>
       </cfif>
     </cfloop>
	
	 <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='Process Decision Enquiry',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=arrayLen(pds),
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>                                                                
    
      <cfif Len(arguments.searchUUID) GT 0>
	 	<cffile action="write" file="#variables.caseTempDir##searchUUID#.txt" output="#lisPds#">
	  </cfif>  
    
     <cfreturn pds>
     
    </cffunction>        
    
    <cffunction name="doIntelEnquiry" access="remote" returntype="any" output="false" hint="performs a custody enquiry search">
	 <cfargument type="struct" name="searchTerms" required="true" hint="Structure of search terms to be passed to the DAO search">
	 <cfargument type="string" name="searchUUID" required="false" default="" hint="unique id if a list of search results is required">
	 <cfargument type="string" name="includeNominals" required="false" default="N" hint="include nominals indexed on intel log">  
    	
     <cfset var intel="">
	 <cfset var iInt=0>
     <cfset var auditFieldData="">
     <cfset var searchItem="">
     <cfset var searchKey=""> 
	 <cfset var lisIntel="">  
	 <cfset var logData="">
	 <cfset var arrNominals="">  
	 <cfset var qNomsOnLog="">
          
     <cfset intel=variables.intelDAO.doIntelEnquiry(searchTerms=arguments.searchTerms)>
	
	 <cfloop from="1" to="#ArrayLen(intel)#" index="iInt">
	   <cfset logData=intel[iInt].getLOG_REF()&"|"&intel[iInt].getSECURITY_ACCESS_LEVEL()>
	 	<cfif intel[iInt].getHAND_CODE() IS "5" AND Len(intel[iInt].getHAND_GUIDANCE()) GT 0>
	   		<cfset logData &= "|Y|"&Replace(intel[iInt].getHAND_GUIDANCE(),chr(10),"~","ALL")>
	 	<cfelse>
	   		<cfset logData &= "|N|None">
	 	</cfif>		 
	   <cfset lisIntel=listAppend(lisIntel,logData,",")>
	   <cfif arguments.includeNominals IS "Y">
	   	   <cfset arrNominals=arrayNew(1)>
	       <cfset qNomsOnLog=variables.intelDAO.getNominalsOnLog(intel[iInt].getLOG_REF())>
		   <cfloop query="qNomsOnLog">
			  <cfset arrayAppend(arrNominals,getWestMerciaNominalDetail(NOMINAL_REF))>	   
		   </cfloop>	
		   <cfset intel[iInt].setINDEXED_NOMINALS(arrNominals)>
	   </cfif>   
	 </cfloop> 
     
     <!--- format search data for logging --->
     <cfloop collection="#arguments.searchTerms#" item="searchKey">
           <cfset searchItem=StructFind(arguments.searchTerms,searchKey)>           
           <cfif Len(searchItem) GT 0>
            <cfset auditFieldData=ListAppend(auditFieldData,searchKey&"="&searchItem,"|")>
           </cfif>
     </cfloop>
     	
	 <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='Intelligence Enquiry',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=arrayLen(intel),
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>                                                                
    
      <cfif Len(arguments.searchUUID) GT 0>
	 	<cffile action="write" file="#variables.intelFTSTempDir##searchUUID#.txt" output="#lisIntel#">
	  </cfif>  
    
     <cfreturn intel>
     
    </cffunction>      

    <cffunction name="doOffenceEnquiry" access="remote" returntype="any" output="false" hint="performs an offence enquiry search">
	 <cfargument type="struct" name="searchTerms" required="true" hint="Structure of search terms to be passed to the DAO search">
	 <cfargument type="string" name="searchUUID" required="false" default="" hint="unique id if a list of search results is required"> 
    	
     <cfset var offs="">
	 <cfset var iOffs=0>
     <cfset var auditFieldData="">
     <cfset var searchItem="">
     <cfset var searchKey=""> 
	 <cfset var lisOffs="">    
          
     <cfset offs=variables.offenceDAO.doOffenceEnquiry(searchTerms=arguments.searchTerms)>
	  
	 <cfloop from="1" to="#ArrayLen(offs)#" index="iOff">   	   
	   <cfset lisOffs=listAppend(lisOffs,offs[iOff].getCRIMENO()&"|"&offs[iOff].getCRIME_REF,",")>
	 </cfloop> 
                                                              
      <!--- format search data for logging --->
        <cfloop collection="#arguments.searchTerms#" item="searchKey">
           <cfset searchItem=StructFind(arguments.searchTerms,searchKey)>           
           <cfif Len(searchItem) GT 0>
            <cfset auditFieldData=ListAppend(auditFieldData,searchKey&"="&searchItem,"|")>
           </cfif>
         </cfloop>    
                                                              
         <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='Offence Enquiry',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=arrayLen(offs),
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>                                                                 
    
      <cfif Len(arguments.searchUUID) GT 0>
	 	<cffile action="write" file="#variables.crimeTempDir##searchUUID#.txt" output="#lisOffs#">
	  </cfif>  
    
     <cfreturn offs>
     
    </cffunction>

    <cffunction name="doPropertyEnquiry" access="remote" returntype="any" output="false" hint="performs a property enquiry search">
	 <cfargument type="struct" name="searchTerms" required="true" hint="Structure of search terms to be passed to the DAO search">
	 <cfargument type="string" name="searchUUID" required="false" default="" hint="unique id if a list of search results is required"> 
    	
     <cfset var auditFieldData="">
     <cfset var searchItem="">
     <cfset var searchKey=""> 
	 <cfset var lisCrimes="">
	 <cfset var crimes="">    
          
     <cfset crimes=variables.propertyDAO.doPropertyEnquiry(searchTerms=arguments.searchTerms)>
	
	 <cfloop query="crimes">
	  <cfif ListFind(lisCrimes,CRIME_NUMBER&"|"&CRIME_REF,",") IS 0>
	   <cfset lisCrimes=listAppend(lisCrimes,CRIME_NUMBER&"|"&CRIME_REF,",")>
	  </cfif>
	 </cfloop> 
	
     <!--- format search data for logging --->
     <cfloop collection="#arguments.searchTerms#" item="searchKey">
       <cfset searchItem=StructFind(arguments.searchTerms,searchKey)>           
       <cfif Len(searchItem) GT 0>
        <cfset auditFieldData=ListAppend(auditFieldData,searchKey&"="&searchItem,"|")>
       </cfif>
     </cfloop>
	
	 <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='Property Enquiry',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=crimes.recordCount,
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>                                                                 
    
      <cfif Len(arguments.searchUUID) GT 0>
	 	<cffile action="write" file="#variables.crimeTempDir##searchUUID#.txt" output="#lisCrimes#">
	  </cfif>  
    
     <cfreturn crimes>
     
    </cffunction>  
    
  <cffunction name="doWarningMarkerSearch" access="remote" returntype="any" output="false" hint="does a search for nominals with given warning markers">
     <cfargument name="frmWarnings" required="true" type="string" hint="csv list of warning codes to search on">
	 <cfargument name="frmCurrentOnly" required="true" type="string" hint="Y / N is the warning marker current">
	 <cfargument name="frmHowToUseMarker" required="true" type="string" hint="ALL / ANY does the nominal have to have ALL or ANY of the markers">
	 <cfargument name="frmSortType" required="false" default="ALPHABETICAL" type="string" hint="Way to order the results">
	 <cfargument name="frmDateFrom" required="false" default="" type="string" hint="date marked from">
	 <cfargument name="frmDateTo" required="false" default="" type="string" hint="date marked to">
	 <cfargument name="frmAgeFrom" required="false" default="" type="string" hint="age of nominal from">
	 <cfargument name="frmAgeTo" required="false" default="" type="string" hint="age of nominal to">
	 <cfargument name="frmSex" required="false" default="" type="string" hint="sex of nominal">
	 <cfargument name="frmPostTown" required="false" default="" type="string" hint="current town of persons address">
	 <cfargument name="searchUUID" required="false" default="" type="string" hint="uuid to create nominal list file from">      	    	      	    	
     
     <cfset var result=structNew()>
  	 <cfset var validationFnc=CreateObject("component","applications.cfc.validation")>
  	 <cfset var auditFieldData="">
	 <cfset var thisNominal="">
	 <cfset var lisNominals="">
	    	      
     <cfset result.valid=true>
     <cfset result.errors="">
	 <cfset result.nominals=arrayNew(1)>
     
     <cfif Len(frmWarnings) IS 0>     
       <cfset result.valid=false>
       <cfset result.errors=ListAppend(result.errors,"You must select some warnings to search on","|")>	              
     </cfif>
     
     <cfif result.valid>
                         
         
        <cfset result.query=variables.warningsDAO.doWarningMarkerSearch( frmWarnings,
																		 frmCurrentOnly,
																		 frmHowToUseMarker,
		                                                                 frmDateFrom,
                                                                         frmDateTo,
                                                                         frmAgeFrom,
																		 frmAgeTo,
																		 frmSex,
																		 frmPostTown,
                                                                         frmSortType)>
         
       	<cfloop query="result.query" startrow="1" endrow="201">
		   <cfset thisNominal=getWestMerciaNominalDetail(NOMINAL_REF,"N","Y")>
		   <cfset thisNominal.setLATEST_PHOTO(getWestMerciaNominalLatestPhoto(NOMINAL_REF))>
		   <cfset thisNominal.setLATEST_ADDRESS(getWestMerciaNominalLatestAddress(NOMINAL_REF))>		      
		   <cfset thisNominal.setLATEST_GRIDREF(getWestMerciaNominalLatestGridRef(NOMINAL_REF))>
		   <cfset thisNominal.setWARNINGS(getWestMerciaNominalWarnings(NOMINAL_REF))>   		      	   
		   <cfset arrayAppend(result.nominals,thisNominal)>
		   <cfset lisNominals=listAppend(lisNominals,NOMINAL_REF,",")>
		</cfloop>  
         
         <cfset auditFieldData="Warnings: #frmWarnings#, Current: #frmCurrentOnly#, SearchType: #frmHowToUseMarker#, From: #frmDateFrom#, To: #frmDateTo#, Order:#frmSortType#">                                                              
         
         
         <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='Warning Marker Search',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=result.query.recordCount,
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>         
                             
      <cfif Len(arguments.searchUUID) GT 0>
	 	<cffile action="write" file="#variables.nominalTempDir##searchUUID#.txt" output="#lisNominals#">
	  </cfif>                              
                                                                                               
                                                                  
     </cfif>
                                                                         	     
     <cfreturn result>
     
    </cffunction>     

    <cffunction name="doCrimeBrowserSearch" access="remote" returntype="any" output="false" hint="does crime browser search, returns a struct of validity of request and the query of results">
     <cfargument name="Form" required="true" type="struct" hint="Form data to run search on">	
	 <cfargument type="string" name="searchUUID" required="false" default="" hint="unique id if a list of search results is required">     	
     
     <cfset var result=structNew()>
  	 <cfset var validationFnc=CreateObject("component","applications.cfc.validation")>
  	 <cfset var auditFieldData="">
	 <cfset var sntLpt="">
	 <cfset var idxArea="">
	 <cfset var sntDetails="">
	 <cfset var pzDetails=""> 
	 <cfset var pzBeats="">
	 <cfset var lisOffs="">
  	      
     <cfset result.valid=true>
     <cfset result.errors="">
     
     <cfif Len(Form.frmDateFrom) IS 0>
       <cfset result.valid=false>
       <cfset result.errors=ListAppend(result.errors,"You must enter a From Date","|")>	  
     <cfelse>
	    <!--- check the date is valid --->
            <cfif validationFnc.checkDate(Form.frmDateFrom) IS "NO">
				<cfset result.valid=false>
			    <cfset result.errors=ListAppend(result.errors,"You must enter a valid From Date","|")>			
            </cfif>			
     </cfif>
     
     <cfif Len(Form.frmDateFrom) IS 0>
       <cfset result.valid=false>     
       <cfset result.errors=ListAppend(result.errors,"You must enter a To Date","|")>	              
     <cfelse>
	    <!--- check the date is valid --->
            <cfif validationFnc.checkDate(Form.frmDateTo) IS "NO">
				<cfset result.valid=false>
			    <cfset result.errors=ListAppend(result.errors,"You must enter a valid From Date","|")>						            
            </cfif>
     </cfif>
     
     <cfif Len(Form.frmTimeFrom) IS 0>
       <cfset result.valid=false>     
       <cfset result.errors=ListAppend(result.errors,"You must enter a From Time","|")>	              
     <cfelse>
	    <!--- check the date is valid --->
            <cfif validationFnc.checkTime(Form.frmTimeFrom) IS "NO">
				<cfset result.valid=false>
			    <cfset result.errors=ListAppend(result.errors,"You must enter a valid From Time","|")>						            
            </cfif>
     </cfif>     

     <cfif Len(Form.frmTimeTo) IS 0>
       <cfset result.valid=false>     
       <cfset result.errors=ListAppend(result.errors,"You must enter a To Time","|")>	              
     <cfelse>
	    <!--- check the date is valid --->
            <cfif validationFnc.checkTime(Form.frmTimeTo) IS "NO">
				<cfset result.valid=false>
			    <cfset result.errors=ListAppend(result.errors,"You must enter a valid To Time","|")>						            
            </cfif>
     </cfif>     
     
     <cfif Len(Form.frmOffenceGroupings) IS 0>     
       <cfset result.valid=false>
       <cfset result.errors=ListAppend(result.errors,"You must select at least one theme","|")>	              
     </cfif>
     
     <cfif result.valid>
        
        <cfset Form.frmDateFrom=Form.frmDateFrom&" "&form.frmTimeFrom> 
        <cfset Form.frmDateTo=Form.frmDateTo&" "&form.frmTimeTo>  

		<!--- convert any PZ codes to Beat for looking up crimes --->
		<cfloop list="#Form.frmArea#" index="idxArea" delimiters=",">
			<cfset pzDetails=isPatrolZone(idxArea)>
			<cfif pzDetails.isPZ>
				<cfset pzBeats=ListAppend(pzBeats,pzDetails.beatCodes,",")>
			</cfif>
		</cfloop>  
		
		<!--- snts have been converted to LPTS --->
		<cfif Len(pzBeats) GT 0>
			<cfset Form.frmArea=pzBeats>
		</cfif>	 

		<!--- convert any SNT codes to LPTs for looking up crimes --->
		<cfloop list="#Form.frmArea#" index="idxArea" delimiters=",">
			<cfset sntDetails=isSnt(idxArea)>
			<cfif sntDetails.isSnt>
				<cfset sntLpt=ListAppend(sntLpt,sntDetails.lpaCodes,",")>
			</cfif>
		</cfloop>  
		
		<!--- snts have been converted to LPTS --->
		<cfif Len(sntLpt) GT 0>
			<cfset Form.frmArea=sntLpt>
		</cfif>	       
		 
        <cfset result.query=variables.offenceDAO.doCrimeBrowserSearch( Form.frmDateFrom,
                                                                       Form.frmDateTo,
                                                                       Form.frmArea,
                                                                       Form.frmOffenceGroupings,
                                                                       Form.frmMarker,
                                                                       Form.frmHowToUseMarker,
                                                                       Form.frmDateType,
                                                                       Form.frmSortType)>
         
	    <cfloop query="result.query">   	   
	       <cfset lisOffs=listAppend(lisOffs,CRIME_NO&"|"&CRIME_REF,",")>
	    </cfloop> 
	    
	  <cfif Len(arguments.searchUUID) GT 0>
	 	<cffile action="write" file="#variables.crimeTempDir##searchUUID#.txt" output="#lisOffs#">
	  </cfif>          
         
         <cfset auditFieldData="From: #Form.frmDateFrom#, To: #Form.frmDateTo#, Area: #Form.frmArea#, Groups: #Form.frmOffenceGroupings#, Date Type:#Form.frmDateType#">                                                              
         
         
         <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='Crime Browser Search',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=result.query.recordCount,
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>                                                                           
                                                                  
     </cfif>
                                                                         	     
     <cfreturn result>
     
    </cffunction> 

	<cffunction name="doFirearmsSerialCertif" access="remote" returntype="any" output="false" hint="performs a firearms serial / certif search">
	 <cfargument type="struct" name="searchTerms" required="true" hint="Structure of search terms to be passed to the DAO search">	  
    	
     <cfset var auditFieldData="">
     <cfset var searchItem="">
     <cfset var searchKey=""> 
	 <cfset var lisCrimes="">
	 <cfset var nominals="">    
          
     <cfset nominals=variables.firearmsNominalDAO.doSerialCertifSearch(serialNo=arguments.searchTerms.serial_no,
	                                                                   certifNo=arguments.searchTerms.certificate_no)>
		 
     <!--- format search data for logging --->
     <cfloop collection="#arguments.searchTerms#" item="searchKey">
       <cfset searchItem=StructFind(arguments.searchTerms,searchKey)>           
       <cfif Len(searchItem) GT 0>
        <cfset auditFieldData=ListAppend(auditFieldData,searchKey&"="&searchItem,"|")>
       </cfif>
     </cfloop>
	
	 <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='Firearms Serial/Certif Enquiry',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=nominals.recordCount,
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>                                                                
    
     <cfreturn nominals>
     
    </cffunction> 
    
    <cffunction name="getWestMerciaNominalDetail" access="remote" returntype="any" output="false" hint="Gets full details for a west mercia nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref of nominal get full details for">
	 <cfargument name="photosRequired" type="string" required="false" default="N" hint="set to ALL, CUSTODY OR VISOR if the photos array should be populated, otherwise N">
	 <cfargument name="warningsRequired" type="string" required="false" default="N" hint="set to Y to get warnings populated, otherwise N">  
    	
     <cfset var nominal=CreateObject('component','genieObj.nominal.nominal').init()>
     <cfset var iWarn="">
	 <cfset var sWarnText="">
	    
	   <cfset nominal.setNOMINAL_REF(arguments.nominalRef)>
	   <cfset nominal=variables.nominalDAO.readWestMerciaNominal(obj=nominal)>
	   <cfset nominal.setLATEST_PHOTO(getWestMerciaNominalLatestPhoto(nominal.getNOMINAL_REF()))>
	   <cfset nominal.setLATEST_ADDRESS(getWestMerciaNominalLatestAddress(nominal.getNOMINAL_REF()))>   
	   <cfif arguments.photosRequired IS NOT "N">
       	<cfset nominal.setPHOTOS(getWestMerciaNominalPhotos(nominal.getNOMINAL_REF(),arguments.photosRequired))>
	   </cfif>
	   <cfif arguments.warningsRequired IS NOT "N">	   	   
       	<cfset nominal.setWARNINGS(getWestMerciaNominalWarnings(nominal.getNOMINAL_REF()))>
		<cfloop from="1" to="#ArrayLen(nominal.getWARNINGS())#" index="iWarn">			
			<cfif iWarn GT 1>
				<cfset sWarnText &= "<br>">				
			</cfif>
			<cfset sWarnText &= "<b>"&nominal.getWARNINGS()[iWarn].getWSC_DESC()&"</b>-"&nominal.getWARNINGS()[iWarn].getDATE_MARKED_TEXT()>
		</cfloop>
		<cfset nominal.setWARNINGS_TEXT(sWarnText)>
	   </cfif>         
	   
     <cfreturn nominal>
     
    </cffunction>    
    
    <cffunction name="getWestMerciaNominalLatestPhoto" access="remote" returntype="any" output="false" hint="Gets latest photo for a west mercia nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref of nominal to get photo for">
    	
     <cfset var photo=variables.photoDAO.getLatestNominalPhoto(nominalRef=arguments.nominalRef)>
    	     
     <cfreturn photo>
     
    </cffunction> 

    <cffunction name="getWestMerciaNominalPhotoList" access="remote" returntype="any" output="false" hint="Gets csv list of photo details per nominal photo Url|Date Taken|System">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref of nominal to get photo for">
    	
     <cfset var photoList=variables.photoDAO.getPhotoCSVList(nominalRef=arguments.nominalRef)>
    	     
     <cfreturn photoList>
     
    </cffunction>
	
    <cffunction name="getWestMerciaNominalPhotoCount" access="remote" returntype="any" output="false" hint="Gets the number of photos for a west mercia nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref of nominal get full details for">
    	
     <cfset var iPhoto=variables.photoDAO.getPhotoCount(nominalRef=arguments.nominalRef)>
    	     
     <cfreturn iPhoto>
     
    </cffunction> 
    
    <cffunction name="getWestMerciaNominalTargetInfo" access="remote" returntype="any" output="false" hint="Gets target information for a  west mercia nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get target info for">
    	
     <cfset var target=CreateObject('component','genieObj.target.target').init()>
     <cfset target.setNOMINAL_REF(arguments.nominalRef)>
     <!--- call the West Midlandsperson search web service. A xml object is returned --->
     <cfset target=variables.targetDAO.readCurrentTarget(obj=target)>
                                                                         	     
     <cfreturn target>
     
    </cffunction>        
    
    <cffunction name="getWestMerciaNominalInCustody" access="remote" returntype="any" output="false" hint="Gets custody info for a  west mercia nominal if they are currently in custody">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get custody info for">
    	
     <cfset var custody="">

     <cfset custody=variables.custodyDAO.readInCustody(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn custody>
     
    </cffunction>       
    
    <cffunction name="getWestMerciaNominalOnBail" access="remote" returntype="any" output="false" hint="Gets bail info for a  west mercia nominal if they are currently on bail">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get bail info for">
    	
     <cfset var bail="">

     <cfset bail=variables.bailDAO.readOnBail(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn bail>
     
    </cffunction>       
    
    <cffunction name="getWestMerciaNominalCurrentPrisonerRelease" access="remote" returntype="any" output="false" hint="Gets bail info for a  west mercia nominal if they are about to be or just release from prison">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get release info for">
    	
     <cfset var release="">

     <cfset release=variables.releasesDAO.readCurrentPrisonerRelease(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn release>
     
    </cffunction>       
    
    <cffunction name="getWestMerciaNominalOnWarrant" access="remote" returntype="any" output="false" hint="Gets warrant info for a  west mercia nominal if they are currently on warrant">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get warrant info for">
    	
     <cfset var warrant="">

     <cfset warrant=variables.warrantDAO.readOnWarrant(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn warrant>
     
    </cffunction>        
    
    <cffunction name="getWestMerciaNominalIsPPO" access="remote" returntype="any" output="false" hint="Gets ppo warning info for a  west mercia nominal if they are a current ppo">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominalRef to get ppo info for">
    	
     <cfset var ppo="">

     <cfset ppo=variables.warningsDAO.getNominalIsPPO(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn ppo>
     
    </cffunction>        
    
    <cffunction name="getWestMerciaNominalIsIOM" access="remote" returntype="any" output="false" hint="Gets iom warning info for a  west mercia nominal if they are a current iom">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominalRef to get iom info for">
    	
     <cfset var iom="">

     <cfset iom=variables.warningsDAO.getNominalIsIOM(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn iom>
     
    </cffunction>      

    <cffunction name="getWestMerciaNominalIOMLevel" access="remote" returntype="any" output="false" hint="Gets warning sub type for an IO marker which is the IOM level">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominalRef to get iom info for">
    	
     <cfset var iomLevel="">

     <cfset iomLevel=variables.warningsDAO.getWarningLevel(nominalRef=arguments.nominalRef,wsc_code='IO')>
                                                                         	     
     <cfreturn iomLevel>
     
    </cffunction>   
    
    <cffunction name="getWestMerciaNominalIsPYO" access="remote" returntype="any" output="false" hint="Gets pyo boolean info for a  west mercia nominal if they are a current pyo">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get pyo info for">
    	
     <cfset var pyo="">

     <cfset pyo=variables.warningsDAO.getNominalIsPYO(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn pyo>
     
    </cffunction>       
    
    <cffunction name="getWestMerciaNominalIsFirearms" access="remote" returntype="any" output="false" hint="Gets firearms info for a  west mercia nominal if they have a matching pncId on firearms data">
	 <cfargument name="pncId" type="string" required="true" hint="pncId to get fireamrs info for">
    	
     <cfset var firearms="">

     <cfset firearms=variables.firearmsNominalDAO.isLicenceHolder(pncId=arguments.pncId)>
                                                                         	     
     <cfreturn firearms>
     
    </cffunction>    	
	
    <cffunction name="getWestMerciaNominalTabs" access="remote" returntype="any" output="false" hint="gets a struct of what tabs a nominal has available">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get target info for">
    	
     <cfset var tabs=structNew()>
     <cfset tabs=variables.nominalDAO.getWestMerciaNominalTabs(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn tabs>
     
    </cffunction>     

    <cffunction name="getWestMerciaNominalWarnings" access="remote" returntype="any" output="false" hint="returns an array of nominal warnings for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get warnings for">
     <cfargument name="includeExpired" type="string" default="N" required="false" hint="flag to include expired warnings">
    	
     <cfset var warnings=ArrayNew(1)>
     <cfset warnings=variables.warningsDAO.getNominalWarnings(nominalRef=arguments.nominalRef,includeExpired=arguments.includeExpired)>
                                                                         	     
     <cfreturn warnings>
     
    </cffunction>     
    
    <cffunction name="getWestMerciaNominalOffences" access="remote" returntype="any" output="false" hint="returns a query of nominal offences for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get offences for">
	 <cfargument name="sort" type="string" required="false" hint="nominal ref to get offences for" default="DATE">        
    	
     <cfset var offences="">
     <cfset offences=variables.offenceDAO.getNominalOffences(nominalRef=arguments.nominalRef,sort=arguments.sort)>
                                                                         	     
     <cfreturn offences>
     
    </cffunction>     
    
    <cffunction name="getWestMerciaNominalAddresses" access="remote" returntype="any" output="false" hint="returns a query of nominal addresses for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get addresses for">       
    	
     <cfset var addresses="">
     <cfset addresses=variables.addressDAO.getNominalAddresses(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn addresses>
     
    </cffunction>       

    <cffunction name="getWestMerciaAddress" access="remote" returntype="any" output="false" hint="returns an address object of the address for a postcode and premise key">
	 <cfargument name="postcode" type="string" required="true" hint="postcode to get address for">
	 <cfargument name="premiseKey" type="string" required="true" hint="premiseKey to get address for">        
    	
     <cfset var address=CreateObject('component','genieObj.addresses.address').init()>
	 
	 <cfset address.setPOST_CODE(arguments.postcode)>
	 <cfset address.setPREMISE_KEY(arguments.premiseKey)>
                                                                         	     
     <cfreturn variables.addressDAO.read(address)>
     
    </cffunction>  

    <cffunction name="getWestMerciaNominalLatestAddress" access="remote" returntype="any" output="false" hint="returns a string containing the nominals latest address">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get addresses for">       
    	
     <cfset var addresses="">
	 <cfset var qAddrSort="">
     <cfset addresses=getWestMerciaNominalAddresses(nominalRef=arguments.nominalRef)>
	
	 <cfquery name="qAddrSort" dbtype="query">
	   SELECT *
	   FROM   addresses
	   WHERE  TYPE IN ('HOME','HOME ADDRESS','CUSTODY','CASE')
	 </cfquery>
	 
	 <cfset latestAddress=qAddrSort.ADDRESS&" Recorded:"&qAddrSort.DATE_REC>
                                                                         	     
     <cfreturn latestAddress>
     
    </cffunction>  
    
    <cffunction name="getWestMerciaNominalLatestGridRef" access="remote" returntype="any" output="false" hint="returns a the grid ref of a nominals latest address">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get addresses for">       
    	
     <cfset var addresses="">
	 <cfset var qAddrSort="">
     <cfset addresses=getWestMerciaNominalAddresses(nominalRef=arguments.nominalRef)>
	
	 <cfquery name="qAddrSort" dbtype="query">
	   SELECT GRID
	   FROM   addresses
	   WHERE  TYPE IN ('HOME','HOME ADDRESS','CUSTODY','CASE')
	 </cfquery>
	 
	 <cfset latestAddress=qAddrSort.GRID>
                                                                         	     
     <cfreturn latestAddress>
     
    </cffunction>      
    
    <cffunction name="getWestMerciaNominalBails" access="remote" returntype="any" output="false" hint="returns an array of nominal bails for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get bails for">       
    	
     <cfset var bails="">
     <cfset bails=variables.bailDAO.getNominalBails(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn bails>
     
    </cffunction>        
    
    <cffunction name="getWestMerciaNominalProcDecs" access="remote" returntype="any" output="false" hint="returns an array of nominal process decisions for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get proc decs for">       
    	
     <cfset var pdecs="">
     <cfset pdecs=variables.processDecisionDAO.getNominalProcessDecisions(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn pdecs>
     
    </cffunction>             
    
    <cffunction name="getWestMerciaNominalTelephones" access="remote" returntype="any" output="false" hint="returns a query of nominal telephones for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get telephones for">       
    	
     <cfset var telephones="">
     <cfset telephones=variables.telephoneDAO.getNominalTelephones(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn telephones>
     
    </cffunction>     
    
	<cffunction name="getWestMerciaNominalVehicles" access="remote" returntype="any" output="false" hint="returns an array of nominal vehicles for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get vehicles for">
	 <cfargument name="startDate" type="string" required="false" default="" hint="date to get vehicles from (dd/mm/yyyy)">
	 <cfargument name="endDate" type="string" required="false" default="" hint="date to get vehicles to (dd/mm/yyyy)">         
    	
     <cfset var vehicles=arrayNew(1)>
     <cfset vehicles=variables.vehicleDAO.getNominalVehicles(nominalRef=arguments.nominalRef,startDate=arguments.startDate,endDate=arguments.endDate)>
                                                                         	     
     <cfreturn vehicles>
     
    </cffunction>     
    
    <cffunction name="getWestMerciaNominalDocuments" access="remote" returntype="any" output="false" hint="returns a query of nominal documents for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get documents for">       
    	
     <cfset var documents="">
     <cfset documents=variables.documentDAO.getNominalDocuments(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn documents>
     
    </cffunction>       
    
    <cffunction name="getWestMerciaNominalAlias" access="remote" returntype="any" output="false" hint="returns a query of nominal aliases for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get associates for">       
    	
     <cfset var alias="">
     <cfset alias=variables.aliasDAO.getNominalAliases(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn alias>
     
    </cffunction>     
    
    <cffunction name="getWestMerciaNominalAssociates" access="remote" returntype="any" output="false" hint="returns a query of nominal associates for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get associates for">       
	 <cfargument name="orderBy" type="string" required="false" hint="order to return the nominals in" default="surname">               
    	
     <cfset var associates="">
	 <cfset var assocaitePhotos="">
	 <cfset var photoUrl=ArrayNew(1)>
	 <cfset var photoDates=ArrayNew(1)>
     <cfset var warnings=ArrayNew(1)>
     <cfset var addresses=ArrayNew(1)>
	 
     <cfset associates=variables.associateDAO.getNominalAssociates(nominalRef=arguments.nominalRef,orderBy=arguments.orderBy)>
	
     <cfset photoStruct=variables.photoDAO.getNominalLatestPhotoForSearch(associates)>
     <cfset photoUrl=photoStruct.photoUrls>
     <cfset photoDates=photoStruct.photoDates>
     <cfset warnings=variables.warningsDAO.getNominalSearchWarnings(associates)>
     <cfset addresses=variables.addressDAO.getNominalSearchAddresses(associates)>     
     
     <cfset ignore=QueryAddColumn(associates,"PHOTO_URL","VarChar",photoUrl)>
     <cfset ignore=QueryAddColumn(associates,"PHOTO_DATE","VarChar",photoDates)>  	
     <cfset ignore=QueryAddColumn(associates,"WARNINGS","VarChar",warnings)> 
     <cfset ignore=QueryAddColumn(associates,"ADDRESS","VarChar",addresses)>       	     
                                                                         	     
     <cfreturn associates>
     
    </cffunction>    
    
    <cffunction name="getWestMerciaNominalCustodies" access="remote" returntype="any" output="false" hint="returns an array of nominal custodies for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get custodies for">       
    	
     <cfset var custodies=ArrayNew(1)>
     <cfset custodies=variables.custodyDAO.getNominalCustodies(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn custodies>
     
    </cffunction>     
    
    <cffunction name="getWestMerciaNominalFeatures" access="remote" returntype="any" output="false" hint="returns a struct of nominal features for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get features for">       
    	
     <cfset var features=ArrayNew(1)>
     <cfset features=variables.featuresDAO.getNominalFeatures(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn features>
     
    </cffunction>     
    
    <cffunction name="getWestMerciaNominalWarrants" access="remote" returntype="any" output="false" hint="returns a struct of nominal warrants for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get warrants for">       
    	
     <cfset var warrants=ArrayNew(1)>
     <cfset warrants=variables.warrantDAO.getNominalWarrants(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn warrants>
     
    </cffunction>       
    
    <cffunction name="getWestMerciaNominalOrganisations" access="remote" returntype="any" output="false" hint="returns a query of nominal organisations for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get organisations for">       
    	
     <cfset var organisations=ArrayNew(1)>
     <cfset organisations=variables.organisationsDAO.getNominalOrganisations(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn organisations>
     
    </cffunction>      
  
    <cffunction name="getWestMerciaNominalFamilyProtection" access="remote" returntype="any" output="false" hint="returns an array of nominal family protection files for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get proc decs for">       
    	
     <cfset var famprot="">
     <cfset famprot=variables.familyProtectionDAO.getNominalFamilyProtection(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn famprot>
     
    </cffunction>   
    
    <cffunction name="getWestMerciaNominalIraqs" access="remote" returntype="any" output="false" hint="returns a query of nominal iraqs for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get iraqs for">   
	 <cfargument name="sort" type="string" required="false" default="logno" hint="sort order for the iraqs">           
            
    	
     <cfset var iraqs=ArrayNew(1)>
     <cfset iraqs=variables.intelDAO.getNominalIraqs(nominalRef=arguments.nominalRef,sort=arguments.sort)>
                                                                         	     
     <cfreturn iraqs>
     
    </cffunction>      
    
    <cffunction name="getWestMerciaNominalMisper" access="remote" returntype="any" output="false" hint="returns a query of nominal mis per info for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get mis per info for">       
    	
     <cfset var misper=ArrayNew(1)>
     <cfset misper=variables.misperDAO.getNominalMisper(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn misper>
     
    </cffunction>       

    <cffunction name="getWestMerciaNominalOccupations" access="remote" returntype="any" output="false" hint="returns a query of nominal occupations for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get mis per info for">       
    	
     <cfset var occs="">
     <cfset occs=variables.occupationsDAO.getNominalOccupations(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn occs>
     
    </cffunction>  

    <cffunction name="getWestMerciaNominalStopSearch" access="remote" returntype="any" output="false" hint="returns an array of nominals stop search">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to stop search for">       
    	
     <cfset var ss="">
     <cfset ss=variables.stopSearchDAO.getNominalStopSearch(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn ss>
     
    </cffunction>  

    <cffunction name="getWestMerciaNominalSection27" access="remote" returntype="any" output="false" hint="returns an array of nominals section27s">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to section27 for">       
    	
     <cfset var s27="">
     <cfset s27=variables.section27DAO.getNominalSection27(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn s27>
     
    </cffunction>  
 
    <cffunction name="getWestMerciaNominalFullName" access="remote" returntype="any" output="false" hint="returns a string of the nominals full name">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get full name for">       
    	
     <cfreturn variables.nominalDAO.getWestMerciaNominalFullName(nominalRef=arguments.nominalRef)>                                                                         	     
     
    </cffunction>   
    
    <cffunction name="getWestMerciaNominalIsOnSection27" access="remote" returntype="any" output="false" hint="returns struct of bolean for nominal being on s27 and object of details if true">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to section27 for">       
    	
     <cfset var s27="">
     <cfset s27=variables.section27DAO.getNominalIsOnSection27(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn s27>
     
    </cffunction>      

    <cffunction name="getWestMerciaNominalSTEP" access="remote" returntype="any" output="false" hint="returns a query of nominals step pacakges">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to section27 for">       
    	
     <cfset var step="">
     <cfset step=variables.stepDAO.getNominalSTEP(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn step>
     
    </cffunction>  

    <cffunction name="getWestMerciaNominalRMP" access="remote" returntype="any" output="false" hint="returns an array of nominals risk man plans">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to section27 for">       
    	
     <cfset var rmp="">
     <cfset rmp=variables.rmpDAO.getNominalRMP(nominalRef=arguments.nominalRef)>
                                                                         	     
     <cfreturn rmp>
     
    </cffunction>  
    
    <cffunction name="getWestMerciaNominalIsOnRMP" access="remote" returntype="any" output="false" hint="returns struct of bolean for nominal being on an rmp and object of details if true">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to check RMP for">
	 <cfargument name="rmpType" type="string" required="false" default="" hint="type of RMP ro look for eg, IOM, Child">        
    	
     <cfset var rmp="">
     <cfset rmp=variables.rmpDAO.getNominalIsOnRMP(nominalRef=arguments.nominalRef, rmpType=arguments.rmpType)>
                                                                         	     
     <cfreturn rmp>
     
    </cffunction>   
    
    <cffunction name="getWestMerciaNominalPhotos" access="remote" returntype="any" output="false" hint="returns an array of nominal photos for the passed in nominal">
	 <cfargument name="nominalRef" type="string" required="true" hint="nominal ref to get photos for">
	 <cfargument name="photoFilter" type="string" required="false" default="ALL" hint="filter on type of photo ALL gets all, CUSTODY custody only or VISOR only">        
    	
     <cfset var photos="">
     <cfset photos=variables.photoDAO.getNominalPhotos(nominalRef=arguments.nominalRef,photoFilter=photoFilter)>
                                                                         	     
     <cfreturn photos>
     
    </cffunction>      
 
	<cffunction name="getWestMerciaNominalByWarningMarker" access="remote" returntype="any" output="false" hint="returns an array of nominals for a warning marker or area">
	 <cfargument name="warningMarker" type="string" required="true" hint="warning marker to get nominals for (seperate by comma ',' for more than one marker)">
	 <cfargument name="area" type="string" required="false" hint="area (ie TPU/Div) that the nominal is marked by" default="">	 
	 <cfargument name="currentOnly" type="string" required="false" hint="flag to be only current warning markers (default no all markers)" default="N">	 	 
	 <cfargument name="getPhoto" type="string" required="false" hint="flag to get the current photo for the nominals too" default="N">	
	 <cfargument name="subTypeOrder" type="string" requried="false" default="N" hint="add the sub type to the order by clause">
	 <cfargument name="filterType" type="string" requried="false" default="" hint="filter options DATE_MARKED or SURNAME">
	 <cfargument name="filter" type="string" requried="false" default="" hint="filter data if DATE_MARKED number of days or SURNAME 1st letter of">
	 <cfargument name="incLPA" type="string" requried="false" default="N" hint="include LPA in results">
     <cfargument name="lpaFilter" type="string" requried="false" default="" hint="filter on LPA codes or csv list of codes">	     	 	 
    	
     <cfset var qNominals="">
	 <cfset var thisNominal="">
	 <cfset var nominals=ArrayNew(1)>
	 <cfset var lisNominals=""> 
        
		<!--- get the list of nominals for the warning markers passed in --->
        <cfset qNominals=variables.warningsDAO.getNominalsForMarker(warningMarker=arguments.warningMarker,area=arguments.area,
																	currentOnly=arguments.currentOnly,subTypeOrder=arguments.subTypeOrder,
																	filterType=arguments.filterType,filter=arguments.filter,
																	incLPA=arguments.incLPA, lpaFilter=arguments.lpaFilter)>
		
		<cfloop query="qNominals">
		 <cfif ListFind(lisNominals,NOMINAL_REF,",") IS 0>
		   <cfset thisNominal=getWestMerciaNominalDetail(NOMINAL_REF)>
		   <cfset thisNominal.setLATEST_PHOTO(getWestMerciaNominalLatestPhoto(NOMINAL_REF))>
		   <cfset thisNominal.setLATEST_ADDRESS(getWestMerciaNominalLatestAddress(NOMINAL_REF))>
		   <cfif arguments.incLPA IS "Y">		
		   <cfset thisNominal.setLATEST_LPA(LPA)>
		   </cfif>		      
		   <cfset thisNominal.setLATEST_GRIDREF(getWestMerciaNominalLatestGridRef(NOMINAL_REF))>
		   <cfset thisNominal.setFS_CODE(FS_CODE)>
		   <cfset thisNominal.setWARNING_SUB_TYPE(SUB_TYPE)>		   
		   <cfset arrayAppend(nominals,thisNominal)>
		   <cfset lisNominals=listAppend(lisNominals,NOMINAL_REF,",")>
		 </cfif>
		</cfloop>
                                                                         	     
     <cfreturn nominals>
     
    </cffunction>  
   
    <cffunction name="getWestMerciaNominalCountByWarningMarker" access="remote" returntype="any" output="false" hint="returns a count of nominals for a warning marker or area">
	 <cfargument name="warningMarker" type="string" required="true" hint="warning marker to get nominals for (seperate by comma ',' for more than one marker)">
	 <cfargument name="area" type="string" required="false" hint="area (ie TPU/Div) that the nominal is marked by" default="">	 
	 <cfargument name="currentOnly" type="string" required="false" hint="flag to be only current warning markers (default no all markers)" default="N">
	 <cfargument name="lpaFilter" type="string" required="false" hint="list of LPAs to filter on" default=""> 	 	 
    	
     <cfset var noNominals="">
        
		<!--- get the count of nominals for the warning markers passed in --->
        <cfset noNominals=variables.warningsDAO.getCountForMarker(warningMarker=arguments.warningMarker,area=arguments.area,currentOnly=arguments.currentOnly,lpaFilter=arguments.lpaFilter)>
		                                        	     
     <cfreturn noNominals>
     
    </cffunction>    

    <cffunction name="getWestMerciaCustodyDetail" access="remote" returntype="any" output="false" hint="Gets full details for a west mercia custody">
	 <cfargument name="custodyRef" type="string" required="true" hint="custody tef get full details for">
    	
     <cfset var custody=CreateObject('component','genieObj.custody.custody').init()>
       
	   <cfset custody.setCUSTODY_REF(arguments.custodyRef)>
       <cfset custody=variables.custodyDAO.read(obj=custody)>
            
     <cfreturn custody>
     
    </cffunction>   

    <cffunction name="getIntelCategories" access="remote" returntype="any" output="false" hint="returns a query of intel categories">
	          	
     <cfset var qCats=variables.intelDAO.getCategories()>
                                                                              	     
     <cfreturn qCats>
     
    </cffunction>     

    <cffunction name="getIntelCount" access="remote" returntype="any" output="false" hint="returns a count of logs">
	 <cfargument name="division" required="true" type="string" hint="Div Code">
	 <cfargument name="startDate" required="true" type="string" hint="format dd/mm/yyyy">
	 <cfargument name="endDate" required="true" type="string" hint="format dd/mm/yyyy">		          	
                        	     
     <cfreturn variables.intelDAO.getIntelCount(division=arguments.division, startDate=arguments.startDate, endDate=arguments.endDate)>
     
    </cffunction>     

    <cffunction name="getVISORNominals" access="remote" returntype="any" output="false" hint="returns an array of nominal that are visor">
	 <cfargument name="division" type="string" required="true" hint="division to get nominals for">       
    	
     <cfset var nominals="">
     <cfset var x=0>
     <cfset var qLPA="">
     <cfset nominals=variables.nominalDAO.getWestMerciaVISORNominals(division=arguments.division)>
     
     <cfloop from="1" to="#ArrayLen(nominals)#" index="x">
       <cfset nominals[x].photo=variables.photoDAO.getLatestNominalPhoto(nominalRef=nominals[x].nominal.getNOMINAL_REF())>
       <cfquery name="qLPA" datasource="#variables.SS2DSN#" username="#variables.pactUser#" password="#variables.pactPwd#">
        SELECT AREA_NAME
        FROM   pact_owner.AREAS
        WHERE AR_CODE=<cfqueryparam value="#nominals[x].LPA#" cfsqltype="cf_sql_varchar">
       </cfquery>
       <cfset nominals[x].LPA=nominals[x].LPA&" - "&qLPA.AREA_NAME>
     </cfloop>
                                                                         	     
     <cfreturn nominals>
     
    </cffunction>      
    
    <cffunction name="getPPONominals" access="remote" returntype="any" output="false" hint="returns an array of nominal that are PPOs">
	 <cfargument name="division" type="string" required="true" hint="division to get nominals for">       
    	
     <cfset var nominals="">
     <cfset var x=0>
     <cfset var qLPA="">
     <cfset nominals=variables.nominalDAO.getWestMerciaPPONominals(division=arguments.division)>
     
     <cfloop from="1" to="#ArrayLen(nominals)#" index="x">
       <cfset nominals[x].photo=variables.photoDAO.getLatestNominalPhoto(nominalRef=nominals[x].nominal.getNOMINAL_REF())>
       <cfquery name="qLPA" datasource="#variables.SS2DSN#" username="#variables.pactUser#" password="#variables.pactPwd#">
        SELECT AREA_NAME
        FROM   pact_owner.AREAS
        WHERE AR_CODE=<cfqueryparam value="#nominals[x].LPA#" cfsqltype="cf_sql_varchar">
       </cfquery>
       <cfset nominals[x].LPA=nominals[x].LPA&" - "&qLPA.AREA_NAME>
     </cfloop>
                                                                         	     
     <cfreturn nominals>
     
    </cffunction>       
    
    <cffunction name="getNoForensicImages" access="remote" returntype="string" output="false" hint="checks if any forensic photos are available for an incident or crime no">
      <cfargument name="searchText" required="true" type="string" hint="search text to find out if images are available, eg. Ois No, Crime No">	
		
        <cfset var iNoImages=0>
        	
		<!--- using cfinvoke now so we can set a timeout of 2 seconds in case DAMS is down --->
		<cfinvoke 
		   webservice = '#variables.damsWebService#'
		   method = "getNoImages"
		   timeout = "2"
		   searchText = '#arguments.searchText#'
		   archivePath = '#variables.forensicArchivePath#'
		   returnVariable = "iNoImages" />	
        
        <cfreturn iNoImages>
     
    </cffunction>       
      
    <cffunction name="getUserUpdates" access="remote" returntype="struct" output="false" hint="checks if a user has any updates on their favourite nominals, if Y then returns a query of what has been updated">
      <cfargument name="userId" required="true" type="string" hint="userId to check for updates">	
      <cfargument name="lastLoginDate" required="true" type="Date" hint="time of their last login to check for new updates">	      
		
        <cfset var userUpdates=StructNew()>
        <cfset var qUserNominals=''>
        <cfset var qUpdates=''>
        <cfset var arrayUpdates=ArrayNew(1)>
        <cfset var qUserUpdates=QueryNew('NOMINAL_REF,NAME,UPDATE_DATE,UPDATE_DESCRIPTION','VARCHAR,VARCHAR,DATE,VARCHAR')>
        <cfset var iUpdateCount=1>
        <cfset var thisNominal=''>
        	        
        <cfset userUpdates.hasUpdates=false>	
        
        <!--- get the users nominals who they have requested updates on --->
        <cfquery name='qUserNominals' datasource='#variables.warehousedsn#'>
          SELECT *
          FROM   browser_owner.USER_NOMINALS
          WHERE  USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
          AND    SHOW_UPDATES=<cfqueryparam value='Y' cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfset userUpdates.nominalList=qUserNominals>
        
        <cfset arguments.lastLoginDate=CreateDateTime(DateFormat(arguments.lastLoginDate,"YYYY"),DateFormat(arguments.lastLoginDate,"MM"),DateFormat(arguments.lastLoginDate,"DD"),"00","00","00")>
        
        <!--- if the user has nominals that they require updates on --->
        <cfif qUserNominals.recordCount GT 0>
        
           <!--- query the nominal_updates table to see if the nominals have been updated --->
           <cfquery name='qUpdates' datasource='#variables.warehousedsn#'>
            SELECT *
            FROM   BROWSER_OWNER.NOMINAL_UPDATES
            WHERE  NOMINAL_REF IN (<cfqueryparam value='#ValueList(qUserNominals.NOMINAL_REF)#' cfsqltype="cf_sql_varchar" list="true">)
            AND    (
                            NSPIS_CUSTODY >= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))
                      OR    CRIMES_CUSTODY	>= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))		
					  OR	NSPIS_CASE	>= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))			
					  OR	CRIME_ROLES	>= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))			
					  OR	INTELLIGENCE	>= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))			
					  OR 	INTELLIGENCE_VEHS	>= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))			
					  OR	INTELLIGENCE_TELS	>= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))			
					  OR	WARRANTS	>= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))			
					  OR	FAMILY_PROTECTION	>= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))		
					  OR	PROCESS	>= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))			
					  OR	NOMINAL_RELATIONS	>= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))			
					  OR	NOMINAL_DESC	>= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))		
					  OR	ADDRESS	>= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))	
					  OR	TARGET_MARKER	>= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))		
					  OR	NOMINAL >= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))
					  OR	STOP_SEARCH >= TRUNC(TO_DATE(<cfqueryparam value="#DateFormat(arguments.lastLoginDate,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY'))					  			
                   )
            ORDER BY NOMINAL_REF
           </cfquery>
                                       
           <cfif qUpdates.recordCount GTE 1>

             <!--- there are some updates so set the update flag to true --->
             <cfset userUpdates.hasUpdates=true>
             
             <!--- each nominal that has an update will return 1 row, so loop round each of the nominals to create a query of their updates --->
             <cfloop query='qUpdates'>
           
                 <!--- get the nominals full name --->
                 <cfset thisNominal=getWestMerciaNominalDetail(nominalRef=NOMINAL_REF)>
                 
                 <!--- 
                       check each of the dates in the query and see if they are since the last login time of the user
                       if they are then add a row to the custom query that details each nominals updates                       
                  --->        
                 <cfif Len(NSPIS_CUSTODY) GT 0>           
	 	             <cfif DateDiff('n',NSPIS_CUSTODY,arguments.lastLoginDate) LTE 0> 
	                    <cfset QueryAddRow(qUserUpdates,1)>
		                <cfset QuerySetCell(qUserUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'NAME',thisNominal.getFULL_NAME(),iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DATE',NSPIS_CUSTODY,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DESCRIPTION','New Custody (NSPIS) #DateFormat(NSPIS_CUSTODY,"DDD DD-MMM-YYYY")# #IIf(TimeFormat(NSPIS_CUSTODY,"HH:mm:ss") IS NOT '00:00:00',DE(TimeFormat(NSPIS_CUSTODY,"HH:mm:ss")),DE(''))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
	                    <cfset iUpdateCount++>                                                            
		             </cfif>
                 </cfif>
             
                 <cfif Len(CRIMES_CUSTODY) GT 0>                   
	 	             <cfif DateDiff('n',CRIMES_CUSTODY,arguments.lastLoginDate) LTE 0> 
	                    <cfset QueryAddRow(qUserUpdates,1)>
		                <cfset QuerySetCell(qUserUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'NAME',thisNominal.getFULL_NAME(),iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DATE',CRIMES_CUSTODY,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DESCRIPTION','New Custody (CRIMES) #DateFormat(CRIMES_CUSTODY,"DDD DD-MMM-YYYY")# #IIf(TimeFormat(CRIMES_CUSTODY,"HH:mm:ss") IS NOT '00:00:00',DE(TimeFormat(CRIMES_CUSTODY,"HH:mm:ss")),DE(''))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
	                    <cfset iUpdateCount++>                                                            
		             </cfif>                 
                 </cfif>
        
                 <cfif Len(NSPIS_CASE) GT 0>              
	 	             <cfif DateDiff('n',NSPIS_CASE,arguments.lastLoginDate) LTE 0> 
	                    <cfset QueryAddRow(qUserUpdates,1)>
		                <cfset QuerySetCell(qUserUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'NAME',thisNominal.getFULL_NAME(),iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DATE',NSPIS_CASE,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DESCRIPTION','New Case (NSPIS) #DateFormat(NSPIS_CASE,"DDD DD-MMM-YYYY")# #IIf(TimeFormat(NSPIS_CASE,"HH:mm:ss") IS NOT '00:00:00',DE(TimeFormat(NSPIS_CASE,"HH:mm:ss")),DE(''))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
	                    <cfset iUpdateCount++>                                                            
		             </cfif>              
                 </cfif>
                       
                 <cfif Len(CRIME_ROLES) GT 0>                                                              
	 	             <cfif DateDiff('n',CRIME_ROLES,arguments.lastLoginDate) LTE 0> 
	                    <cfset QueryAddRow(qUserUpdates,1)>
		                <cfset QuerySetCell(qUserUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'NAME',thisNominal.getFULL_NAME(),iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DATE',CRIME_ROLES,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DESCRIPTION','New Roles #DateFormat(CRIME_ROLES,"DDD DD-MMM-YYYY")# #IIf(TimeFormat(CRIME_ROLES,"HH:mm:ss") IS NOT '00:00:00',DE(TimeFormat(CRIME_ROLES,"HH:mm:ss")),DE(''))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
	                    <cfset iUpdateCount++>                                                            
		             </cfif>  
                 </cfif>
                        
                 <cfif Len(INTELLIGENCE) GT 0>                                                              
	 	             <cfif DateDiff('n',INTELLIGENCE,arguments.lastLoginDate) LTE 0> 
	                    <cfset QueryAddRow(qUserUpdates,1)>
		                <cfset QuerySetCell(qUserUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'NAME',thisNominal.getFULL_NAME(),iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DATE',INTELLIGENCE,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DESCRIPTION','New Intelligence #DateFormat(INTELLIGENCE,"DDD DD-MMM-YYYY")# #IIf(TimeFormat(INTELLIGENCE,"HH:mm:ss") IS NOT '00:00:00',DE(TimeFormat(INTELLIGENCE,"HH:mm:ss")),DE(''))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
	                    <cfset iUpdateCount++>                                                            
		             </cfif>               
                 </cfif>                                                                                                 

                 <cfif Len(WARRANTS) GT 0>      
	 	             <cfif DateDiff('n',WARRANTS,arguments.lastLoginDate) LTE 0> 
	                    <cfset QueryAddRow(qUserUpdates,1)>
		                <cfset QuerySetCell(qUserUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'NAME',thisNominal.getFULL_NAME(),iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DATE',WARRANTS,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DESCRIPTION','New Warrants #DateFormat(WARRANTS,"DDD DD-MMM-YYYY")# #IIf(TimeFormat(WARRANTS,"HH:mm:ss") IS NOT '00:00:00',DE(TimeFormat(WARRANTS,"HH:mm:ss")),DE(''))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
	                    <cfset iUpdateCount++>                                                            
		             </cfif>      
                 </cfif>
                        
                 <cfif Len(NOMINAL_RELATIONS) GT 0>                                             
	 	             <cfif DateDiff('n',NOMINAL_RELATIONS,arguments.lastLoginDate) LTE 0> 
	                    <cfset QueryAddRow(qUserUpdates,1)>
		                <cfset QuerySetCell(qUserUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'NAME',thisNominal.getFULL_NAME(),iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DATE',NOMINAL_RELATIONS,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DESCRIPTION','New Alias/Associates #DateFormat(NOMINAL_RELATIONS,"DDD DD-MMM-YYYY")# #IIf(TimeFormat(NOMINAL_RELATIONS,"HH:mm:ss") IS NOT '00:00:00',DE(TimeFormat(NOMINAL_RELATIONS,"HH:mm:ss")),DE(''))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
	                    <cfset iUpdateCount++>                                                            
		             </cfif>                                                              
                 </cfif>
                 
                 <cfif Len(NOMINAL_DESC) GT 0>      
	 	             <cfif DateDiff('n',NOMINAL_DESC,arguments.lastLoginDate) LTE 0> 
	                    <cfset QueryAddRow(qUserUpdates,1)>
		                <cfset QuerySetCell(qUserUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'NAME',thisNominal.getFULL_NAME(),iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DATE',NOMINAL_DESC,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DESCRIPTION','New Nominal Description #DateFormat(NOMINAL_DESC,"DDD DD-MMM-YYYY")# #IIf(TimeFormat(NOMINAL_DESC,"HH:mm:ss") IS NOT '00:00:00',DE(TimeFormat(NOMINAL_DESC,"HH:mm:ss")),DE(''))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
	                    <cfset iUpdateCount++>                                                            
		             </cfif>      
                 </cfif>

                 <cfif Len(ADDRESS) GT 0>      
	 	             <cfif DateDiff('n',ADDRESS,arguments.lastLoginDate) LTE 0> 
	                    <cfset QueryAddRow(qUserUpdates,1)>
		                <cfset QuerySetCell(qUserUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'NAME',thisNominal.getFULL_NAME(),iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DATE',ADDRESS,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DESCRIPTION','New Address #DateFormat(ADDRESS,"DDD DD-MMM-YYYY")# #IIf(TimeFormat(ADDRESS,"HH:mm:ss") IS NOT '00:00:00',DE(TimeFormat(ADDRESS,"HH:mm:ss")),DE(''))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
	                    <cfset iUpdateCount++>                                                            
		             </cfif>      
                 </cfif>
                 
                 <cfif Len(STOP_SEARCH) GT 0>      
	 	             <cfif DateDiff('n',STOP_SEARCH,arguments.lastLoginDate) LTE 0> 
	                    <cfset QueryAddRow(qUserUpdates,1)>
		                <cfset QuerySetCell(qUserUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'NAME',thisNominal.getFULL_NAME(),iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DATE',ADDRESS,iUpdateCount)>
		                <cfset QuerySetCell(qUserUpdates,'UPDATE_DESCRIPTION','New Stop Search #DateFormat(STOP_SEARCH,"DDD DD-MMM-YYYY")# #IIf(TimeFormat(STOP_SEARCH,"HH:mm:ss") IS NOT '00:00:00',DE(TimeFormat(STOP_SEARCH,"HH:mm:ss")),DE(''))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
	                    <cfset iUpdateCount++>                                                            
		             </cfif>      
                 </cfif>                 

             </cfloop>
           </cfif>

           <cfset userUpdates.qUpdates=qUpdates>           
           <cfset userUpdates.qUserUpdates=qUserUpdates>
        
        </cfif>
        
        <cfreturn userUpdates>
     
    </cffunction>          

    <cffunction name="getUserUpdates2" access="remote" returntype="struct" output="false" hint="checks if a user has any updates on their favourite nominals, if Y then returns a query of what has been updated">
      <cfargument name="userId" required="true" type="string" hint="userId to check for updates">	
      <cfargument name="lastLoginDate" required="true" type="Date" hint="time of their last login to check for new updates">	      
		
        <cfset var userUpdates=StructNew()>
        <cfset var qUserNominals=''>
        <cfset var qUpdates=''>
        <cfset var arrayUpdates=ArrayNew(1)>
        <cfset var qUserUpdates=QueryNew('NOMINAL_REF,NAME,UPDATE_DATE,UPDATE_DESCRIPTION','VARCHAR,VARCHAR,DATE,VARCHAR')>
        <cfset var iUpdateCount=1>
        <cfset var thisNominal=''>
		<cfset var iNom=1>
		<cfset var iNomUpd=1>
		<cfset var qDistinctNominals=''>
		<cfset var qNomUpdates=''>
		<cfset var nUpdateData="">
        	        
        <cfset userUpdates.hasUpdates=false>	
        
        <!--- get the users nominals who they have requested updates on --->
        <cfquery name='qUserNominals' datasource='#variables.warehousedsn#'>
          SELECT *
          FROM   browser_owner.USER_NOMINALS
          WHERE  USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">		   
          AND    SHOW_UPDATES=<cfqueryparam value='Y' cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfset arguments.lastLoginDate=CreateDateTime(DateFormat(arguments.lastLoginDate,"YYYY"),DateFormat(arguments.lastLoginDate,"MM"),DateFormat(arguments.lastLoginDate,"DD"),"00","00","00")>
        
        <!--- if the user has nominals that they require updates on --->
        <cfif qUserNominals.recordCount GT 0>
        
           <!--- query the nominal_updates table to see if the nominals have been updated --->
           <cfquery name='qUpdates' datasource='#variables.warehousedsn#'>
            SELECT TIMESTAMP AS UPDATE_DATE, nud.*
            FROM   BROWSER_OWNER.NOMINAL_UPDATE_DETAIL nud
            WHERE  NOMINAL_REF IN (<cfqueryparam value='#ValueList(qUserNominals.NOMINAL_REF)#' cfsqltype="cf_sql_varchar" list="true">)  			
			AND    BUS_REF <> '*|,,,*'
			AND    NOT EXISTS (
								SELECT 'Y'
								FROM browser_owner.USER_UPDATE_READS
								WHERE USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar" />
								AND  NOMINAL_REF=nud.NOMINAL_REF
								AND  BUSINESS_AREA=nud.BUSINESS_AREA
								AND  BUS_REF=nud.BUS_REF
								AND  DATE_DISMISSED > nud.TIMESTAMP
							  )          
			ORDER BY TIMESTAMP DESC
           </cfquery>
                                       
           <cfif qUpdates.recordCount GTE 1>
		   	 
		   	 <!--- there are some updates so set the update flag to true --->
             <cfset userUpdates.hasUpdates=true>
		   	   
		   	 <!--- get distinct nominals and their details --->
		   	 <cfquery name="qDistinctNominals" datasource='#variables.warehousedsn#'>
			    SELECT NOMINAL_REF, max(TIMESTAMP)
				FROM BROWSER_OWNER.NOMINAL_UPDATE_DETAIL nud
				WHERE NOMINAL_REF in (<cfqueryparam value='#ValueList(qUserNominals.NOMINAL_REF)#' cfsqltype="cf_sql_varchar" list="true">)
				AND    NOT EXISTS (
								SELECT 'Y'
								FROM browser_owner.USER_UPDATE_READS
								WHERE USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar" />
								AND  NOMINAL_REF=nud.NOMINAL_REF
								AND  BUSINESS_AREA=nud.BUSINESS_AREA
								AND  BUS_REF=nud.BUS_REF
								AND  DATE_DISMISSED > nud.TIMESTAMP
							  )  
				AND    BUS_REF <> '*|,,,*'
				GROUP BY NOMINAL_REF
				ORDER BY 2 DESC			  
			 </cfquery>  
			 
			 <cfset userUpdates.nominals=arrayNew(1)>
			 <cfloop query="qDistinctNominals">
				<cfset userUpdates.nominals[iNom]=structNew()>
				<cfset userUpdates.nominals[iNom].nominal=getWestMerciaNominalDetail(nominalRef=NOMINAL_REF)>
				
				<!--- get the updates for this nominal --->
				<cfquery name="qNomUpdates" dbtype="query">
				  SELECT *
				  FROM   qUpdates 	
				  WHERE  NOMINAL_REF='#NOMINAL_REF#'
				  ORDER BY UPDATE_DATE DESC
		   	    </cfquery>
		   	    
		   	    <cfset userUpdates.nominals[iNom].nominal.updates=ArrayNew(1)>
				
				<cfset iNomUpd=1>
				<cfloop query="qNomUpdates">      
					<cfset nUpdateData=variables.notificationsDAO.formatNominalUpdate(businessArea=BUSINESS_AREA,businessRef=BUS_REF,nominalRef=NOMINAL_REF)>
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd]=StructNew()>
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd].timestamp=TIMESTAMP>
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd].html=nUpdateData.sHtml>
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd].jQueryClass=nUpdateData.jQueryClass>					
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd].additionalAttributes=nUpdateData.additionalAttributes>
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd].displayData=nUpdateData.displayData>
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd].busRef=BUS_REF>
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd].busArea=BUSINESS_AREA>
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd].displayBusArea=nUpdateData.displayBusArea>
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd].href=nUpdateData.href>
					<cfset iNomUpd++>
				</cfloop>
		   	    
				<cfset iNom++>	 
			 </cfloop>
			 
           </cfif>
        
        </cfif>
        
        <cfreturn userUpdates>
     
    </cffunction>

	<cffunction name="getIOMNominalUpdates2" access="remote" returntype="struct" output="false" hint="checks if a IOM nominal has any updates on their favourite nominals, if Y then returns a query of what has been updated">
      <cfargument name="nominalRef" required="true" type="string" hint="nominalRef to check for updates">	
      <cfargument name="timePeriod" required="true" type="string" hint="time to look back for in hours">	      
		
        <cfset var nominalUpdates=StructNew()>        
        <cfset var qUpdates=''>                
		<cfset var iNomUpd=1>		
        	        
        <cfset nominalUpdates.hasUpdates=false>	
        
        <cfset arguments.timeToCheck=DateAdd("h","-#arguments.timePeriod#",now())>
		<cfset arguments.timeToCheck=CreateDateTime(DateFormat(arguments.timeToCheck,'YYYY'),DateFormat(arguments.timeToCheck,'MM'),DateFormat(arguments.timeToCheck,'DD'),"00","00","00")>
		        
           <!--- query the nominal_updates table to see if the nominals have been updated --->
           <cfquery name='qUpdates' datasource='#variables.warehousedsn#'>
            SELECT TIMESTAMP AS UPDATE_DATE, nud.*
            FROM   BROWSER_OWNER.NOMINAL_UPDATE_DETAIL nud
            WHERE  NOMINAL_REF = <cfqueryparam value='#arguments.nominalRef#' cfsqltype="cf_sql_varchar">  			
			AND    BUS_REF <> '*|,,,*'
			AND    TIMESTAMP >= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')        
			ORDER BY TIMESTAMP DESC
           </cfquery>
                                       
           <cfif qUpdates.recordCount GT 0>
		   	    <cfset nominalUpdates.hasUpdates=true>
				      		   	    
		   	    <cfset nominalUpdates.updates=ArrayNew(1)>
				
				<cfset iNomUpd=1>
				<cfloop query="qUpdates">     					 
					<cfset nominalUpdates.updates[iNomUpd]=StructNew()>
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd].timestamp=TIMESTAMP>
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd].html=variables.notificationsDAO.formatNominalUpdate(businessArea=BUSINESS_AREA,businessRef=BUS_REF,nominalRef=NOMINAL_REF)>
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd].busRef=BUS_REF>
					<cfset userUpdates.nominals[iNom].nominal.updates[iNomUpd].busArea=BUSINESS_AREA>					
					<cfset iNomUpd++>
				</cfloop>
		   	    			 
           </cfif>
                
        <cfreturn nominalUpdates>
     
    </cffunction>

    <cffunction name="getIOMNominalUpdates" access="remote" returntype="struct" output="false" hint="checks if a user has any updates on their favourite nominals, if Y then returns a query of what has been updated">
      <cfargument name="nominalRef" required="true" type="string" hint="nominalRef to check for updates">	
      <cfargument name="timePeriod" required="true" type="string" hint="time to look back for in hours">	      
		
        <cfset var nominalUpdates=StructNew()>
        <cfset var qUpdates=''>
		<cfset var timeToCheck=''>
		<cfset var qNominalUpdates=QueryNew('NOMINAL_REF,UPDATE_DATE,UPDATE_DESCRIPTION','VARCHAR,DATE,VARCHAR')>
		<cfset var iUpdateCount=1>
        	        
        <cfset nominalUpdates.hasUpdates=false>	
        
        <cfset arguments.timeToCheck=DateAdd("h","-#arguments.timePeriod#",now())>
		<cfset arguments.timeToCheck=CreateDateTime(DateFormat(arguments.timeToCheck,'YYYY'),DateFormat(arguments.timeToCheck,'MM'),DateFormat(arguments.timeToCheck,'DD'),"00","00","00")>        
        
           <!--- query the nominal_updates table to see if the nominals have been updated --->
           <cfquery name='qUpdates' datasource='#variables.warehousedsn#'>
            SELECT *
            FROM   BROWSER_OWNER.NOMINAL_UPDATES
            WHERE  NOMINAL_REF = <cfqueryparam value='#arguments.nominalRef#' cfsqltype="cf_sql_varchar">
            AND    (
                            NSPIS_CUSTODY >= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')
                      OR    CRIMES_CUSTODY	>= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')		
					  OR	NSPIS_CASE	>= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')			
					  OR	CRIME_ROLES	>= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')			
					  OR	TRUNC(INTELLIGENCE)	>= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')
					  OR 	INTELLIGENCE_VEHS	>= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')			
					  OR	INTELLIGENCE_TELS	>= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')		
					  OR	WARRANTS	>= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')		
					  OR	FAMILY_PROTECTION	>= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')	
					  OR	PROCESS >= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')			
					  OR	NOMINAL_RELATIONS >= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')			
					  OR	NOMINAL_DESC >= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')
					  OR	ADDRESS	>= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')
					  OR	TARGET_MARKER >= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')
					  OR	NOMINAL >= TO_DATE(<cfqueryparam value="#DateFormat(arguments.timeToCheck,'DD/MM/YYYY')#" cfsqltype="cf_sql_varchar">,'DD/MM/YYYY')
                   )
            ORDER BY NOMINAL_REF
           </cfquery>
                                       

									
           <cfif qUpdates.recordCount GTE 1>

             <!--- there are some updates so set the update flag to true --->
             <cfset nominalUpdates.hasUpdates=true>
             
             <!--- each nominal that has an update will return 1 row, so loop round each of the nominals to create a query of their updates --->
             <cfloop query='qUpdates'>
                           
                 <!--- 
                       check each of the dates in the query and see if they are since the last login time of the user
                       if they are then add a row to the custom query that details each nominals updates                       
                  --->                   
 	             <cfif isDate(NSPIS_CUSTODY)>
			     <cfif DateDiff('n',NSPIS_CUSTODY,arguments.timeToCheck) LTE 0> 
                    <cfset QueryAddRow(qNominalUpdates,1)>
	                <cfset QuerySetCell(qNominalUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DATE',NSPIS_CUSTODY,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DESCRIPTION','New Custody (NSPIS) #DateFormat(NSPIS_CUSTODY,"DDD DD-MMM-YYYY")# #iif(TimeFormat(NSPIS_CUSTODY,"HH:mm:ss") IS "00:00:00",DE(''),DE(TimeFormat(NSPIS_CUSTODY,"HH:mm:ss")))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
                    <cfset iUpdateCount++>                                                            
	             </cfif>
	             </cfif>

 	             <cfif isDate(CRIMES_CUSTODY)>             
 	             <cfif DateDiff('n',CRIMES_CUSTODY,arguments.timeToCheck) LTE 0> 
                    <cfset QueryAddRow(qNominalUpdates,1)>
	                <cfset QuerySetCell(qNominalUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DATE',CRIMES_CUSTODY,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DESCRIPTION','New Custody (CRIMES) #DateFormat(CRIMES_CUSTODY,"DDD DD-MMM-YYYY")# #iif(TimeFormat(CRIMES_CUSTODY,"HH:mm:ss") IS "00:00:00",DE(''),DE(TimeFormat(CRIMES_CUSTODY,"HH:mm:ss")))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
                    <cfset iUpdateCount++>                                                            
	             </cfif>        
	             </cfif>         
        
 	             <cfif isDate(NSPIS_CASE)>		
 	             <cfif DateDiff('n',NSPIS_CASE,arguments.timeToCheck) LTE 0> 
                    <cfset QueryAddRow(qNominalUpdates,1)>
	                <cfset QuerySetCell(qNominalUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DATE',NSPIS_CASE,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DESCRIPTION','New Case (NSPIS) #DateFormat(NSPIS_CASE,"DDD DD-MMM-YYYY")# #iif(TimeFormat(NSPIS_CASE,"HH:mm:ss") IS "00:00:00",DE(''),DE(TimeFormat(NSPIS_CASE,"HH:mm:ss")))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
                    <cfset iUpdateCount++>                                                            
	             </cfif>          
	             </cfif>    
                                             
 	             <cfif isDate(CRIME_ROLES)>											           
 	             <cfif DateDiff('n',CRIME_ROLES,arguments.timeToCheck) LTE 0> 
                    <cfset QueryAddRow(qNominalUpdates,1)>
	                <cfset QuerySetCell(qNominalUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DATE',CRIME_ROLES,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DESCRIPTION','New Roles #DateFormat(CRIME_ROLES,"DDD DD-MMM-YYYY")# #iif(TimeFormat(CRIME_ROLES,"HH:mm:ss") IS "00:00:00",DE(''),DE(TimeFormat(CRIME_ROLES,"HH:mm:ss")))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
                    <cfset iUpdateCount++>                                                            
	             </cfif>  
	             </cfif>
                                             
 	             <cfif isDate(INTELLIGENCE)>				
 	             <cfif DateDiff('n',INTELLIGENCE,arguments.timeToCheck) LTE 0> 
                    <cfset QueryAddRow(qNominalUpdates,1)>
	                <cfset QuerySetCell(qNominalUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DATE',INTELLIGENCE,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DESCRIPTION','New Intelligence #DateFormat(INTELLIGENCE,"DDD DD-MMM-YYYY")# #iif(TimeFormat(INTELLIGENCE,"HH:mm:ss") IS "00:00:00",DE(''),DE(TimeFormat(INTELLIGENCE,"HH:mm:ss")))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
                    <cfset iUpdateCount++>                                                            
	             </cfif>                   
	             </cfif>                                                                                             

 	             <cfif isDate(WARRANTS)>
 	             <cfif DateDiff('n',WARRANTS,arguments.timeToCheck) LTE 0> 
                    <cfset QueryAddRow(qNominalUpdates,1)>
	                <cfset QuerySetCell(qNominalUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DATE',WARRANTS,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DESCRIPTION','New Warrants #DateFormat(WARRANTS,"DDD DD-MMM-YYYY")# #iif(TimeFormat(WARRANTS,"HH:mm:ss") IS "00:00:00",DE(''),DE(TimeFormat(WARRANTS,"HH:mm:ss")))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
                    <cfset iUpdateCount++>                                                            
	             </cfif>      
	             </cfif>
                                             
 	             <cfif isDate(NOMINAL_RELATIONS)>											           
 	             <cfif DateDiff('n',NOMINAL_RELATIONS,arguments.timeToCheck) LTE 0> 
                    <cfset QueryAddRow(qNominalUpdates,1)>
	                <cfset QuerySetCell(qNominalUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DATE',NOMINAL_RELATIONS,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DESCRIPTION','New Associates #DateFormat(NOMINAL_RELATIONS,"DDD DD-MMM-YYYY")# #iif(TimeFormat(NOMINAL_RELATIONS,"HH:mm:ss") IS "00:00:00",DE(''),DE(TimeFormat(NOMINAL_RELATIONS,"HH:mm:ss")))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
                    <cfset iUpdateCount++>                                                            
	             </cfif>        
	             </cfif>                                                      

 	             <cfif isDate(NOMINAL_DESC)>
 	             <cfif DateDiff('n',NOMINAL_DESC,arguments.timeToCheck) LTE 0> 
                    <cfset QueryAddRow(qNominalUpdates,1)>
	                <cfset QuerySetCell(qNominalUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DATE',NOMINAL_DESC,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DESCRIPTION','New Nominal Description #DateFormat(NOMINAL_DESC,"DDD DD-MMM-YYYY")# #iif(TimeFormat(NOMINAL_DESC,"HH:mm:ss") IS "00:00:00",DE(''),DE(TimeFormat(NOMINAL_DESC,"HH:mm:ss")))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
                    <cfset iUpdateCount++>                                                            
	             </cfif>     
	             </cfif> 

 	             <cfif isDate(ADDRESS)>
 	             <cfif DateDiff('n',ADDRESS,arguments.timeToCheck) LTE 0> 
                    <cfset QueryAddRow(qNominalUpdates,1)>
	                <cfset QuerySetCell(qNominalUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DATE',ADDRESS,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DESCRIPTION','New Address #DateFormat(ADDRESS,"DDD DD-MMM-YYYY")# #iif(TimeFormat(ADDRESS,"HH:mm:ss") IS "00:00:00",DE(''),DE(TimeFormat(ADDRESS,"HH:mm:ss")))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
                    <cfset iUpdateCount++>                                                            
	             </cfif>      
	             </cfif>

 	             <cfif isDate(INTELLIGENCE_VEHS)>
 	             <cfif DateDiff('n',INTELLIGENCE_VEHS,arguments.timeToCheck) LTE 0> 
                    <cfset QueryAddRow(qNominalUpdates,1)>
	                <cfset QuerySetCell(qNominalUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DATE',ADDRESS,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DESCRIPTION','New Vehicles #DateFormat(INTELLIGENCE_VEHS,"DDD DD-MMM-YYYY")# #iif(TimeFormat(INTELLIGENCE_VEHS,"HH:mm:ss") IS "00:00:00",DE(''),DE(TimeFormat(INTELLIGENCE_VEHS,"HH:mm:ss")))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
                    <cfset iUpdateCount++>                                                            
	             </cfif> 
	             </cfif>

 	             <cfif isDate(INTELLIGENCE_TELS)>
 	             <cfif DateDiff('n',INTELLIGENCE_TELS,arguments.timeToCheck) LTE 0> 
                    <cfset QueryAddRow(qNominalUpdates,1)>
	                <cfset QuerySetCell(qNominalUpdates,'NOMINAL_REF',NOMINAL_REF,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DATE',ADDRESS,iUpdateCount)>
	                <cfset QuerySetCell(qNominalUpdates,'UPDATE_DESCRIPTION','New Telephone Numbers #DateFormat(INTELLIGENCE_TELS,"DDD DD-MMM-YYYY")# #iif(TimeFormat(INTELLIGENCE_TELS,"HH:mm:ss") IS "00:00:00",DE(''),DE(TimeFormat(INTELLIGENCE_TELS,"HH:mm:ss")))#',iUpdateCount)>                                                                                                                                                                                                                                                                        
                    <cfset iUpdateCount++>                                                            
	             </cfif> 
                 </cfif>
             </cfloop>
           </cfif>

           <cfset nominalUpdates.qUpdates=qUpdates>           
           <cfset nominalUpdates.qNominalUpdates=qNominalUpdates>       
        
        <cfreturn nominalUpdates>
     
    </cffunction>  

    <cffunction name="getOffenceGroupings" access="remote" returntype="any" output="false" hint="returns a query of offence groupings">
    	
     <cfset var groupings="">
     
     <cfset groupings=variables.offenceDAO.getOffenceGroupings()>
                                                                         	     
     <cfreturn groupings>
     
    </cffunction>  
     
    <cffunction name="getOffenceCodes" access="remote" returntype="any" output="false" hint="returns a query of offence codes">
    	
     <cfset var codes="">
     
     <cfset codes=variables.offenceDAO.getOffenceCodes()>
                                                                         	     
     <cfreturn codes>
     
    </cffunction>      

    <cffunction name="doHTCUSearch" access="remote" returntype="any" output="false" hint="does a telephone number search on HTCU data">
     <cfargument name="telNo" required="true" type="string" hint="tel no to search on">	    	
     
        <cfset var qRresult="">
  	
        <cfquery name="qResult" datasource="#variables.warehouseDSN#">
		   SELECT * 
		   FROM   browser_owner.HTCU_INTEL
		   WHERE  PHONE_NO LIKE <cfqueryparam value="#arguments.TelNo#" cfsqltype="cf_sql_varchar">
		   ORDER BY EXAM_DATE DESC                
        </cfquery>
    
         <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='HTCU Intel Search',
                             fields='Tel No: #arguments.telNo#',
                             details='',
                             numberOfResults=qResult.recordCount,
						     department=session.user.getDepartment())>                                                                         
                                                                       
                                                                         	     
     <cfreturn qResult>
     
    </cffunction>  

    <cffunction name="getMissingPersons" access="remote" returntype="any" output="false" hint="returns an struct with an array of nominals in and related missing person cases">
	 <cfargument name="division" type="string" required="true" hint="division to get missing persons for for">       
    	
     <cfset var missingCases="">
     <cfset var nominals=ArrayNew(1)>
	 <cfset var iNominal=1>

     <cfset missingCases=variables.misperDAO.getMisperByDiv(arguments.division)>
	
	 <cfloop query="missingCases">
	   <cfset nominals[iNominal]=StructNew()>
	   <cfset nominals[iNominal].nominal=getWestMerciaNominalDetail(NOMINAL_REF)>
	   <cfset nominals[iNominal].nominal.setLATEST_PHOTO(getWestMerciaNominalLatestPhoto(NOMINAL_REF))>
	   <cfset nominals[iNominal].case_no=CASE_NO>
	   <cfset nominals[iNominal].missing_start=MISSING_START>
	   <cfset nominals[iNominal].risk_desc=RISK_DESC>
	   <cfset nominals[iNominal].oic_dealing=OIC_DEALING>	   	   	   
	   <cfset iNominal++>
	 </cfloop>
                                                                              	     
     <cfreturn nominals>
     
    </cffunction> 

    <cffunction name="getCountMissingPersons" access="remote" returntype="any" output="false" hint="returns a count of nominals in and related missing person cases">
	 <cfargument name="area" type="string" required="true" hint="division to get missing persons for for">       
    	
     <cfset var noNominals="">

     <cfset noNominals=variables.misperDAO.getMisperCount(arguments.area)>
	                                                                              	     
     <cfreturn noNominals>
     
    </cffunction>
	
    <cffunction name="getMostRecentMisper" access="remote" returntype="any" output="false" hint="returns the age of the most recent misper in the units of the returnType passed in">
	 <cfargument name="area" type="string" required="true" hint="division to get missing persons for for">
     <cfargument name="returnType" type="string" required="true" hint="units to get time since misper added: hours, days, months, years, weeks">	         
    	
     <cfset var misperAge="">

     <cfset misperAge=variables.misperDAO.getMisperAge(arguments.area,arguments.returnType)>
	                                                                              	     
     <cfreturn misperAge>
     
    </cffunction>	
	
    <cffunction name="getCountWarrants" access="remote" returntype="any" output="false" hint="returns a count of warrants for an area">
	 <cfargument name="area" type="string" required="true" hint="division to get warrant count for for">       
    	
     <cfset var noWarrants="">

     <cfset noWarrants=variables.warrantDAO.getWarrantCount(arguments.area)>
	                                                                              	     
     <cfreturn noWarrants>
     
    </cffunction>	

    <cffunction name="getWarrantDetails" access="remote" returntype="any" output="false" hint="returns a warrant for a given warrant ref">
	 <cfargument name="warrantRef" type="string" required="true" hint="warrant ref to get details for">       
    	
     <cfset var warrant=CreateObject('component','genieObj.warrants.warrant')>
	  
	 <cfset warrant.setWARRANT_REF(arguments.warrantRef)> 
	  
     <cfset warrant=variables.warrantDAO.read(warrant)>
                                                                         	     
     <cfreturn warrant>
     
    </cffunction>  

    <cffunction name="getMostRecentWarrant" access="remote" returntype="any" output="false" hint="returns the age of the most recent warrant in the units of the returnType passed in">
	 <cfargument name="area" type="string" required="true" hint="division to get missing persons for for">
     <cfargument name="returnType" type="string" required="true" hint="units to get time since misper added: hours, days, months, years, weeks">	         
    	
     <cfset var warrantAge="">

     <cfset warrantAge=variables.warrantDAO.getWarrantAge(arguments.area,arguments.returnType)>
	                                                                              	     
     <cfreturn warrantAge>
     
    </cffunction>	

    <cffunction name="getOffenceMarkerList" access="remote" returntype="any" output="false" hint="returns a query of all offence markers">
    	
     <cfset var qMarkers="">

     <cfset qMarkers=variables.offenceDAO.getOffenceMarkerList()>
	                                                                              	     
     <cfreturn qMarkers>
     
    </cffunction>	 

    <cffunction name="createRandomFilename" access="remote" returntype="string" output="false" hint="creates a random filename for pastring purposes">
    	
		<cfset var str_Char1=Chr(RandRange(65,90))>
		<cfset var str_Char2=Chr(RandRange(65,90))>
		<cfset var str_Char3=Chr(RandRange(65,90))>
		<cfset var str_Char4=Chr(RandRange(65,90))>
		<cfset var str_Char5=Chr(RandRange(65,90))>
		<cfset var str_Char6=Chr(RandRange(65,90))>
		<cfset var str_Char7=Chr(RandRange(65,90))>
		<cfset var str_Char8=Chr(RandRange(65,90))>
		<cfset var str_Char9=Chr(RandRange(65,90))>
		<cfset var i_Num=RandRange(1,100)>
		
		<cfset var str_Filename=str_Char1&str_Char2&str_Char3&str_Char4&str_Char5&str_Char6&str_Char7&str_Char9&str_Char9&i_Num&".txt">
        
        <cfreturn str_Filename>
     
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
          <cfquery name="updUser" datasource="#variables.warehouseDSN2#">
           UPDATE BROWSER_OWNER.USER_LOGINS
           SET    THIS_LOGIN_DATE=<cfqueryparam value="#CreateODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">
           WHERE  USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
          </cfquery>
        <cfelse>                    
          <cfquery name="insUser" datasource="#variables.warehouseDSN2#">
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
    
	<cffunction name="createCrimeBrowserPDF" access="remote" returntype="any" output="false" hint="create a pdf for the briefing">
	  <cfargument name="resultHTML" required="true" type="string">
	  <cfargument name="printedBy" required="true" type="string">	  
	  
	  <cfset var printPdf="">
	  
	  <cfoutput>
      <cfdocument format="pdf" pageType="A4" unit="cm" orientation="landscape" scale="99" marginleft="1.0" marginright="1.0" name="printPdf">
      <?xml version="1.0"? encoding="UTF-8"?>
      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml">	
	    <head>
			<style type="text/css">
			body{
			 font-family:Arial;
			 font-size:10pt;
			} 
			td {
			 font-family: Courier, "Courier New", monospace; 
			 font-size:9pt;
			}
			div {
			 font-family: Courier, "Courier New", monospace; 
			 font-size:9pt;
			}			
			</style>
        </head>
		
	  <cfdocumentitem type = "header">
          <?xml version="1.0"? encoding="UTF-8"?>
          <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
           <html xmlns="http://www.w3.org/1999/xhtml">	
			<head>
			<style type="text/css">
			body{
			 font-family:Arial;
			 font-size:10pt;
			} 
			td {
			 font-family:Arial;
			 font-size:10pt;
			} 		
			div {
			 font-family:Arial;
			 font-size:10pt;
			} 		
			</style>
			</head>
			<body>
		     <div align="center" style="padding-top:5px;">WARWICKSHIRE POLICE AND WEST MERCIA POLICE - RESTRICTED</div>
		    </body>
		    </html>
		 </cfdocumentitem>		  
		 <cfdocumentitem type = "footer" evalAtPrint="true" printedBy="#printedBy#">
	      <?xml version="1.0"? encoding="UTF-8"?>
	      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	      <html xmlns="http://www.w3.org/1999/xhtml">	
			<head>
			<style type="text/css">
			body{
			 font-family:Arial;
			 font-size:10pt;
			} 
			</style>
			</head>
			<body>
		    <div align="center">WARWICKSHIRE POLICE AND WEST MERCIA POLICE - RESTRICTED<br>Printed By #attributes.printedBy# #DateFormat(now(),"DD/MM/YYYY")# #TimeFormat(now(),"HH:mm")#</div>
		    </body>
		    </html>
		</cfdocumentitem>   		 
	   <body>

         <h3 align="center">
			GENIE Crime Browser Results
		 </h3>
		 
		 #arguments.resultHTML#	      
       
	   </body>
	   </html>
	  
	  </cfdocument> 		  
	  </cfoutput>	 

	  	  
	  <cfreturn printPdf>
	  
	</cffunction>	    

	<cffunction name="createStopSearchPDF" access="remote" returntype="any" output="false" hint="create a pdf for a Stop Search Form">
	  <cfargument name="resultHTML" required="true" type="string">
	  <cfargument name="printedBy" required="true" type="string">	  
	  
	  <cfset var printPdf="">
	  
	  <cfoutput>
      <cfdocument format="pdf" pageType="A4" unit="cm" orientation="portrait" scale="99" marginleft="1.25" marginright="1.25" name="printPdf" marginbottom="1.5">
      <?xml version="1.0"? encoding="UTF-8"?>
      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml">	
	    <head>
			<style type="text/css">
			body{
			 font-family:Arial;
			 font-size:12pt;
			} 
			td {
			 font-family: Arial; 
			 font-size:12pt;
			}
			div {
			 font-family: Arial; 
			 font-size:12pt;
			}			
			</style>
        </head>
		
	     <cfdocumentitem type = "header">
          <?xml version="1.0"? encoding="UTF-8"?>
          <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
           <html xmlns="http://www.w3.org/1999/xhtml">	
			<head>
			<style type="text/css">
			body{
			 font-family:Arial;
			 font-size:12pt;
			} 
			td {
			 font-family: Arial; 
			 font-size:12pt;
			}
			div {
			 font-family: Arial; 
			 font-size:10pt;
			}			
			</style>
			</head>
			<body>
		     <div align="center" style="padding-top:5px;">WARKWICKSHIRE AND WEST MERCIA POLICE - RESTRICTED</div>
		    </body>
		    </html>
		 </cfdocumentitem>		  
		 <cfdocumentitem type = "footer" evalAtPrint="true" printedBy="#printedBy#">
	      <?xml version="1.0"? encoding="UTF-8"?>
	      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	      <html xmlns="http://www.w3.org/1999/xhtml">	
			<head>
			<style type="text/css">
			body{
			 font-family:Arial;
			 font-size:12pt;
			} 
			td {
			 font-family: Arial; 
			 font-size:12pt;
			}
			div {
			 font-family: Arial; 
			 font-size:10pt;
			}			
			</style>
			</head>
			<body>
		    <div align="center">WARKWICKSHIRE AND WEST MERCIA POLICE - RESTRICTED<br>Printed By #attributes.printedBy# #DateFormat(now(),"DD/MM/YYYY")# #TimeFormat(now(),"HH:mm")#</div>
		    </body>
		    </html>
		</cfdocumentitem>   		 
	   <body>
		 
		 #arguments.resultHTML#	      
       
	   </body>
	   </html>
	  
	  </cfdocument> 		  
	  </cfoutput>	 
	  	  
	  <cfreturn printPdf>
	  
	</cffunction>

    <cffunction name="getRecentSearches" access="remote" returntype="any" output="false" hint="returns an array of recent nominals searched for">
	 <cfargument name="department" type="string" required="true" hint="department of people to bring audit data back for">
	 <cfargument name="action" type="string" required="true" hint="what the user action is">  
	 <cfargument name="dayBack" type="boolean" required="false" default="false" hint="should the search go back a day too?">        
    	
     <cfset var qRecents="">
	 <cfset var arrSearches=ArrayNew(1)>
	 <cfset var searchCount=0>
	 <cfset var listNominals="">

       <cfquery name="qRecents" datasource="#variables.warehouseDSN#" maxrows="500">
		 SELECT REGEXP_SUBSTR(DETAILS,
                '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]*[A-Z]') NOMINAL_REF, AD.REQUEST_FOR, AD.REQUEST_TIMESTAMP, AD.REASON_TEXT
         FROM  browser_owner.AUDIT_DATA ad
		 WHERE (trunc(request_timestamp)=trunc(sysdate) #iif(arguments.dayBack,de(' or trunc(request_timestamp)=trunc(sysdate-1) '),de(''))#)
		 AND   USER_ACTION = <cfqueryparam value="#arguments.action#" cfsqltype="cf_sql_varchar">
		 AND   DEPARTMENT  = <cfqueryparam value="#arguments.department#" cfsqltype="cf_sql_varchar">
		 ORDER BY REQUEST_TIMESTAMP DESC
	   </cfquery>
	   
	   <cfset searchCount=1>
	   <cfloop query="qRecents">
	   	   <cfif ListFind(listNominals,NOMINAL_REF,"|") IS 0>
		         <cfset listNominals=ListAppend(listNominals,NOMINAL_REF,"|")>
		         <cfset	arrSearches[searchCount]=StructNew()>
		         <cfset arrSearches[searchCount].timestamp=REQUEST_TIMESTAMP>
				 <cfset arrSearches[searchCount].reason=REASON_TEXT> 
				 <cfset arrSearches[searchCount].nominal=getWestMerciaNominalDetail(nominalRef=NOMINAL_REF)>
                 <cfset searchCount++>
		   </cfif>
	   </cfloop>
	                                                                              	     
     <cfreturn arrSearches>
     
    </cffunction>	

    <cffunction name="getWestMerciaDueOnBail" access="remote" returntype="any" output="false" hint="gets people due on bail for a given date and custody suite, returns an array of structures bails and nominals">
     <cfargument name="Form" required="true" type="struct" hint="Form data to run search on">	    	
     
     <cfset var result=structNew()>
  	 <cfset var validationFnc=CreateObject("component","applications.cfc.validation")>
  	 <cfset var auditFieldData="">
	 <cfset var iBail=1>
	 <cfset var thisBail="">
	 <cfset var thisNominal="">
	 <cfset var thisCustody="">
  	      
     <cfset result.valid=true>
     <cfset result.errors="">
     
     <cfif Len(Form.frmDiaryDate) IS 0>
       <cfset result.valid=false>
       <cfset result.errors=ListAppend(result.errors,"You must enter a Bail Diary Date","|")>	  
     <cfelse>
	    <!--- check the date is valid --->
            <cfif validationFnc.checkDate(Form.frmDiaryDate) IS "NO">
				<cfset result.valid=false>
			    <cfset result.errors=ListAppend(result.errors,"You must enter a valid Bail Diary Date","|")>			
            </cfif>			
     </cfif>
      
     <cfif Len(Form.frmDiarySuite) IS 0>     
       <cfset result.valid=false>
       <cfset result.errors=ListAppend(result.errors,"You must select at least one Custody Suite","|")>	   
     <cfelse>
	    <cfif ListLen(Form.frmDiarySuite,",") GT 4>
	    	<cfset result.valid=false>
            <cfset result.errors=ListAppend(result.errors,"The maximum number of Custody Suites that can be selected is 4","|")>
		</cfif>           
     </cfif>
     
     <cfif result.valid>
         
         <cfset result.bails=variables.bailDAO.getDueOnBail( Form.frmDiaryDate, Form.frmDiarySuite )>
		  
		 <cfloop from="1" to="#arrayLen(result.bails)#" index="iBail">
		 	 <cfset thisBail=Duplicate(result.bails[iBail])>
			 <cfset thisNominal=getWestMerciaNominalDetail(thisBail.getNOMINAL_REF())>
			 <cfset thisCustody=getWestMerciaCustodyDetail(thisBail.getCUSTODY_REF())>
			 <cfset result.bails[iBail]=structNew()>
			 <cfset result.bails[iBail].bail=thisBail>
			 <cfset result.bails[iBail].nominal=thisNominal>  
			 <cfset result.bails[iBail].custody=thisCustody> 
		 </cfloop>		
         
         <cfset auditFieldData="Diary Date: #Form.frmDiaryDate#, Suite: #Form.frmDiarySuite#">                                                              
                  
         <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='Bail Diary Search',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=ArrayLen(result.bails),
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>                                                                        
                                                                  
     </cfif>
                                                                         	     
     <cfreturn result>
     
    </cffunction>

    <cffunction name="getWestMerciaBailConditions" access="remote" returntype="any" output="false" hint="get bail conditions for a given from and to date">
     <cfargument name="Form" required="true" type="struct" hint="Form data to run search on">	    	
     
     <cfset var result=structNew()>
  	 <cfset var validationFnc=CreateObject("component","applications.cfc.validation")>
  	 <cfset var auditFieldData="">
	 <cfset var iBail=1>
	 <cfset var thisBail="">
	 <cfset var thisNominal="">
	 <cfset var thisCustody="">
  	      
     <cfset result.valid=true>
     <cfset result.errors="">
     
     <cfif Len(Form.frmFromDate) IS 0>
       <cfset result.valid=false>
       <cfset result.errors=ListAppend(result.errors,"You must enter a From Date dd/mm/yyyy","|")>	  
     <cfelse>
	    <!--- check the date is valid --->
            <cfif validationFnc.checkDate(Form.frmFromDate) IS "NO">
				<cfset result.valid=false>
			    <cfset result.errors=ListAppend(result.errors,"You must enter a valid From Date format dd/mm/yyyy","|")>			
            </cfif>			
     </cfif>

     <cfif Len(Form.frmFromTime) IS 0>
       <cfset result.valid=false>
       <cfset result.errors=ListAppend(result.errors,"You must enter a From Time format hh:mm","|")>	  
     <cfelse>
	    <!--- check the date is valid --->
            <cfif validationFnc.checkTime(Form.frmFromTime) IS "NO">
				<cfset result.valid=false>
			    <cfset result.errors=ListAppend(result.errors,"You must enter a valid From Time format hh:mm","|")>			
            </cfif>			
     </cfif>
      
	<cfif Len(Form.frmToDate) IS 0>
       <cfset result.valid=false>
       <cfset result.errors=ListAppend(result.errors,"You must enter a To Date dd/mm/yyyy","|")>	  
     <cfelse>
	    <!--- check the date is valid --->
            <cfif validationFnc.checkDate(Form.frmToDate) IS "NO">
				<cfset result.valid=false>
			    <cfset result.errors=ListAppend(result.errors,"You must enter a valid To Date dd/mm/yyyy","|")>			
            </cfif>			
     </cfif>
     
     <cfif Len(Form.frmToTime) IS 0>
       <cfset result.valid=false>
       <cfset result.errors=ListAppend(result.errors,"You must enter a To Time format hh:mm","|")>	  
     <cfelse>
	    <!--- check the date is valid --->
            <cfif validationFnc.checkTime(Form.frmToTime) IS "NO">
				<cfset result.valid=false>
			    <cfset result.errors=ListAppend(result.errors,"You must enter a valid To Time format hh:mm","|")>			
            </cfif>			
     </cfif>     
     
     <cfif result.valid>
                  
         <cfset result.bails=variables.bailDAO.getBailConditions( Form.frmFromDate, Form.frmFromTime, Form.frmToDate, Form.frmToTime )>
		  
		 <cfloop from="1" to="#arrayLen(result.bails)#" index="iBail">
		 	 <cfset thisBail=Duplicate(result.bails[iBail])>
			 <cfset thisNominal=getWestMerciaNominalDetail(thisBail.getNOMINAL_REF())>
			 <cfset thisCustody=getWestMerciaCustodyDetail(thisBail.getCUSTODY_REF())>
			 <cfset result.bails[iBail]=structNew()>
			 <cfset result.bails[iBail].bail=thisBail>
			 <cfset result.bails[iBail].nominal=thisNominal>  
			 <cfset result.bails[iBail].custody=thisCustody> 
		 </cfloop>		
         
         <cfset auditFieldData="From Date: #Form.frmFromDate# #Form.frmFromTime#, To Date: #Form.frmToDate# #Form.frmToTime#">                                                              
                  
         <cfset doGenieAudit(userId=session.user.getUserId(),
                             sessionId=session.thisUUID,
                             reason=session.audit_code,
                             reasonText=session.audit_details,
                             requestFor=session.audit_for,
                             fullName=session.user.getFullName(),
                             action='Bail Conditions Search',
                             fields=auditFieldData,
                             details='',
                             numberOfResults=ArrayLen(result.bails),
                             department=session.user.getDepartment(),
							 ethnicCode=session.ethnic_code,
							 requestCollar=session.audit_for_collar,
							 requestForce=session.audit_for_force)>                                                                          
                                                                  
     </cfif>
                                                                         	     
     <cfreturn result>
     
    </cffunction>
    
	<cffunction name="getCrimeCount" access="remote" returntype="any" output="false" hint="based on a csv list of HOMC Codes and two dates to run between counts the number of recorded crimes">
       <cfargument name="homc" type="string" required="false" default="" hint="csv list of homc codes">
	   <cfargument name="startDate" type="date" required="true" hint="date to count from">
	   <cfargument name="endDate" type="date" required="true" hint="date to count to">
	   <cfargument name="type" type="string" required="true" hint="recorded or detected">   
	   <cfargument name="tpu" type="string" required="false" default="" hint="tpu to count for, default is force wide">
	   <cfargument name="lpa" type="string" required="false" default="" hint="lpa/snt to count for, default is force wide">
	   <cfargument name="incNoCrimes" type="string" required="false" default="N" hint="include no crimes in count">     
	      
	   <cfset var qCount="">
	      
	   <cfquery name="qCount" datasource="#variables.warehouseDSN#">
	   	SELECT COUNT(*) AS OFFENCE_COUNT
		FROM browser_owner.OFFENCE_SEARCH os
		WHERE (1=1)
		<cfif Len(arguments.homc) GT 0>
		AND REC_HOMC_CODE IN (<cfqueryparam value="#arguments.homc#" cfsqltype="cf_sql_varchar" list="true">)
		</cfif>
		<cfif arguments.type IS "recorded">
		AND OS.CREATED_DATE BETWEEN TO_DATE('#DateFormat(arguments.startDate,"DD-MMM-YYYY")#" 00:00:00','DD-MON-YYYY HH24:MI:SS')
		                        AND TO_DATE('#DateFormat(arguments.endDate,"DD-MMM-YYYY")# 23:59:59','DD-MON-YYYY HH24:MI:SS')
		<cfif arguments.incNoCrimes IS "N">						
		AND OS.VALIDATION_STATUS IN (0,1,2)
		</cfif>
		<cfelseif arguments.type IS "detected">
		AND OS.DATE_CLEARED_UP  BETWEEN TO_DATE('#DateFormat(arguments.startDate,"DD-MMM-YYYY")#" 00:00:00','DD-MON-YYYY HH24:MI:SS')
		                        AND TO_DATE('#DateFormat(arguments.endDate,"DD-MMM-YYYY")# 23:59:59','DD-MON-YYYY HH24:MI:SS')
		<cfif arguments.incNoCrimes IS "N">						
		AND OS.VALIDATION_STATUS IN (0,1,2)
		</cfif>		
		</cfif>
		<cfif Len(arguments.tpu) GT 0>
		AND SUBSTR(OS.ORG_CODE,3,1)=<cfqueryparam value="#arguments.tpu#" cfsqltype="cf_sql_varchar">	
		</cfif>
		<cfif Len(arguments.lpa) GT 0>
		AND LPA IN (<cfqueryparam value="#arguments.lpa#" cfsqltype="cf_sql_varchar" list="true">)	
		</cfif>		
	   </cfquery>	
	   
	   <cfreturn qCount.OFFENCE_COUNT>	             
    
    </cffunction>

    <cffunction name="getCrimeDetails" access="remote" returntype="query" output="false" hint="based on a csv list of HOMC Codes and two dates to run between returns details of recorded crimes">
       <cfargument name="homc" type="string" required="true" hint="csv list of homc codes">
	   <cfargument name="startDate" type="string" required="true" hint="date to count from">
	   <cfargument name="endDate" type="string" required="true" hint="date to count to">
	   <cfargument name="type" type="string" required="true" hint="recorded or detected">   
	   <cfargument name="tpu" type="string" required="false" default="" hint="tpu to count for, default is force wide">
	      
	   <cfset var qDetails="">
	      
	   <cfquery name="qDetails" datasource="#variables.warehouseDSN#">
	   	SELECT  os.ORG_CODE || '/' || os.SERIAL_NO ||'/' || DECODE(LENGTH(os.YEAR),1, '0' || os.YEAR, os.YEAR) Crime_Number,
		     os.INCIDENT_NO Incident_No,
		     DECODE(os.LAST_COMMITTED,'', TO_CHAR(os.FIRST_COMMITTED,'DD/MM/YYYY HH24:MI'),
             TO_CHAR(os.FIRST_COMMITTED,'DD/MM/YYYY HH24:MI') || ' and ' ||    TO_CHAR(os.LAST_COMMITTED,'DD/MM/YYYY HH24:MI')) Committed,
     		 DECODE(os.DETECTED_FLAG,1,'Y',2,'N','Unknown') Detected,
			 os.REP_TITLE,os.BEAT_CODE,
			 DECODE(PART_ID,'','',PART_ID||', ')||
						DECODE(BUILDING_NAME,'','',BUILDING_NAME||', ')||
						DECODE(BUILDING_NUMBER,'','',BUILDING_NUMBER||' ')||
						DECODE(STREET_1,'','',STREET_1||', ')||
						DECODE(LOCALITY,'','',LOCALITY||', ')||
						DECODE(TOWN,'','',TOWN||', ')||
						DECODE(COUNTY,'','',COUNTY||' ')||
						DECODE(ge.POST_CODE,'','',ge.POST_CODE) As ADDRESS, ge.GRID
		FROM browser_owner.OFFENCE_SEARCH os, browser_owner.GE_ADDRESSES ge
		WHERE REC_HOMC_CODE IN (<cfqueryparam value="#arguments.homc#" cfsqltype="cf_sql_varchar" list="true">)
		<cfif arguments.type IS "recorded">
		AND OS.CREATED_DATE BETWEEN TO_DATE('#DateFormat(arguments.startDate,"DD-MMM-YYYY")#" 00:00:00','DD-MON-YYYY HH24:MI:SS')
		                        AND TO_DATE('#DateFormat(arguments.endDate,"DD-MMM-YYYY")# 23:59:59','DD-MON-YYYY HH24:MI:SS')
		AND OS.VALIDATION_STATUS IN (0,1,2)
		<cfelseif arguments.type IS "detected">
		AND OS.DATE_CLEARED_UP  BETWEEN TO_DATE('#DateFormat(arguments.startDate,"DD-MMM-YYYY")#" 00:00:00','DD-MON-YYYY HH24:MI:SS')
		                        AND TO_DATE('#DateFormat(arguments.endDate,"DD-MMM-YYYY")# 23:59:59','DD-MON-YYYY HH24:MI:SS')
		AND OS.VALIDATION_STATUS IN (0,1,2)			
		</cfif>
		<cfif Len(arguments.tpu) GT 0>
		AND SUBSTR(OS.ORG_CODE,3,1)=<cfqueryparam value="#arguments.tpu#" cfsqltype="cf_sql_varchar">	
		</cfif>
		AND (os.POST_CODE=ge.POST_CODE AND os.PREMISE_KEY=ge.PREMISE_KEY)
	   </cfquery>	
	   
	   <cfreturn qDetails>	             
    
    </cffunction>

    <cffunction name="getNominalsForWarningsOffences" access="remote" returntype="any" output="false" hint="based on tpu, offence list and warning list returns an array of nominals">
       <cfargument name="warningCodeList" type="string" required="true" hint="csv list of warning codes">
	   <cfargument name="offenceCodeList" type="string" required="true" hint="csv list of offences codes">	   
	   <cfargument name="tpu" type="string" required="false" default="" hint="tpu to filter on">
	      
	   <cfset var qNominalList="">
	   <cfset var nominals="">
	   
	   <cfset var photoUrl=ArrayNew(1)>
	   <cfset var photoDates=ArrayNew(1)>
       <cfset var warnings=ArrayNew(1)>
       <cfset var addresses=ArrayNew(1)>	      
	      
	   <cfquery name="qNominalsList" datasource="#variables.warehouseDSN#">
			SELECT gw.NOMINAL_REF, 
			                 (SELECT NVL(MAX(OS1.CREATED_DATE),NULL) AS LAST_OFF 
			                  FROM browser_owner.OFFENCE_SEARCH os1, BROWSER_OWNER.NOMINAL_ROLES nr1 
			                  WHERE  nr1.NOMINAL_REF=gw.NOMINAL_REF
			                  AND    OS1.CRIME_REF=NR1.CRIME_REF
			                  AND   NR1.ROLE='DEFE'
			                  AND    OS1.REC_HOMC_CODE IN (<cfqueryparam value="#arguments.offenceCodeList#" cfsqltype="cf_sql_varchar" list="true">)
			                 ) AS LAST_OFFENCE,
			        REPLACE(REPLACE(LTRIM(
				                      RTRIM(ND.TITLE)||' '||
											        RTRIM(NS.SURNAME_1)||DECODE(NS.SURNAME_2,NULL,'','-'||NS.SURNAME_2)||', '||
											        RTRIM(INITCAP(FORENAME_1))||' '||
											        RTRIM(INITCAP(FORENAME_2))),' ,',','),'  ' ,' ')
													    || DECODE(FAMILIAR_NAME,'','', ' (Nick ' || FAMILIAR_NAME || ')')
															|| DECODE(MAIDEN_NAME,NULL,'',' (Nee ' || MAIDEN_NAME || ')') AS FULL_NAME,
                    TO_CHAR(DATE_OF_BIRTH,'DD/MM/YY') AS DOB,
                    gw.SUB_TYPE															
			FROM   browser_owner.GE_WARNINGS gw, browser_owner.NOMINAL_SEARCH NS, browser_owner.NOMINAL_DETAILS nd
			WHERE  GW.WSC_CODE IN (<cfqueryparam value="#arguments.warningCodeList#" cfsqltype="cf_sql_varchar" list="true">)
			AND    (GW.END_DATE IS NULL OR (TRUNC(END_DATE)>=TRUNC(SYSDATE)))
			<cfif Len(arguments.tpu) GT 0>
			AND    SUBSTR(GW.FS_CODE,3,1)=<cfqueryparam value="#arguments.tpu#" cfsqltype="cf_sql_varchar">
			</cfif>
			AND    gw.NOMINAL_REF=ns.NOMINAL_REF
			AND    ns.NOMINAL_REF=nd.NOMINAL_REF
			AND    EXISTS (SELECT 'Y'
			               FROM   browser_owner.OFFENCE_SEARCH os, BROWSER_OWNER.NOMINAL_ROLES nr
			               WHERE  nr.NOMINAL_REF(+)=gw.NOMINAL_REF
                           AND    OS.CRIME_REF=NR.CRIME_REF(+)
                           AND    NR.ROLE(+)='DEFE'
			               AND    OS.REC_HOMC_CODE IN (<cfqueryparam value="#arguments.offenceCodeList#" cfsqltype="cf_sql_varchar" list="true">))
			order by nvl(last_offence,'01-JAN-1900') desc    
	   </cfquery>	
	   	
	     <cfset photoStruct=variables.photoDAO.getNominalLatestPhotoForSearch(qNominalsList)>
	     <cfset photoUrl=photoStruct.photoUrls>
	     <cfset photoDates=photoStruct.photoDates>
	     <cfset warnings=variables.warningsDAO.getNominalSearchWarnings(qNominalsList)>
	     <cfset addresses=variables.addressDAO.getNominalSearchAddresses(qNominalsList)>     
	     
	     <cfset ignore=QueryAddColumn(qNominalsList,"PHOTO_URL","VarChar",photoUrl)>
	     <cfset ignore=QueryAddColumn(qNominalsList,"PHOTO_DATE","VarChar",photoDates)>  	
	     <cfset ignore=QueryAddColumn(qNominalsList,"WARNINGS","VarChar",warnings)> 
	     <cfset ignore=QueryAddColumn(qNominalsList,"ADDRESS","VarChar",addresses)>       	     
	                                                                         	    
	   <cfreturn qNominalsList>	             
    
    </cffunction>

    <cffunction name="getArrestsByType" access="remote" returntype="any" output="false" hint="based on tpu, arrest type wording and start / end dates returns a query of all custodies that match">   
	   <cfargument name="tpu" type="string" required="false" default="" hint="tpu to filter on">
	   <cfargument name="arrestType" type="string" required="true" hint="wording for arrest, will have % appended either side as this is a free text field">
	   <cfargument name="startDate" type="string" required="true" hint="start date in DD-MMM-YYY format">
	   <cfargument name="endDate" type="string" required="true" hint="end date in DD-MMM-YYYY format">   	
	      
	   <cfset var qCustodyList="">
	   <cfset var photoUrl=ArrayNew(1)>
	   <cfset var photoDates=ArrayNew(1)>
       <cfset var warnings=ArrayNew(1)>
       <cfset var addresses=ArrayNew(1)>	      
	      
	   <cfquery name="qCustodyList" datasource="#variables.warehouseDSN#">
			SELECT DISTINCT CS.CUSTODY_REF, TO_CHAR(CS.ARREST_TIME,'DD/MM/YY HH24:MI') AS ARREST_TIME, CS.NOMINAL_REF,			       
			        REPLACE(REPLACE(LTRIM(
				                      RTRIM(ND.TITLE)||' '||
											        RTRIM(NS.SURNAME_1)||DECODE(NS.SURNAME_2,NULL,'','-'||NS.SURNAME_2)||', '||
											        RTRIM(INITCAP(FORENAME_1))||' '||
											        RTRIM(INITCAP(FORENAME_2))),' ,',','),'  ' ,' ')
													    || DECODE(FAMILIAR_NAME,'','', ' (Nick ' || FAMILIAR_NAME || ')')
															|| DECODE(MAIDEN_NAME,NULL,'',' (Nee ' || MAIDEN_NAME || ')') AS FULL_NAME,
                    TO_CHAR(DATE_OF_BIRTH,'DD/MM/YYYY') AS DOB
			FROM   browser_owner.CUSTODY_SEARCH CS, BROWSER_OWNER.CUSTODY_REASONS cr, 
			       browser_owner.NOMINAL_SEARCH NS, browser_owner.NOMINAL_DETAILS nd
			WHERE  cs.CUSTODY_REF=cr.CUSTODY_REF
			AND    cs.NOMINAL_REF=ns.NOMINAL_REF
			AND    ns.NOMINAL_REF=nd.NOMINAL_REF
			<cfif  Len(arguments.TPU) GT 0>
			AND    SUBSTR(CS.CUSTODY_REF,3,1)=<cfqueryparam value="#arguments.tpu#" cfsqltype="cf_sql_varchar">
		    </cfif>
			AND    CS.ARREST_TIME BETWEEN TO_DATE(<cfqueryparam value="#arguments.startDate# 00:00:00" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')
			                          AND TO_DATE(<cfqueryparam value="#arguments.endDate# 23:59:59" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')		    
			AND    CR.ARREST_REASON_TEXT LIKE <cfqueryparam value="%#Ucase(arguments.arrestType)#%" cfsqltype="cf_sql_varchar">
			ORDER  BY ARREST_TIME DESC  	
	   </cfquery>	
	   	
	     <cfset photoStruct=variables.photoDAO.getNominalLatestPhotoForSearch(qCustodyList)>
	     <cfset photoUrl=photoStruct.photoUrls>
	     <cfset photoDates=photoStruct.photoDates>
	     <cfset warnings=variables.warningsDAO.getNominalSearchWarnings(qCustodyList)>
	     <cfset addresses=variables.addressDAO.getNominalSearchAddresses(qCustodyList)>     
	     
	     <cfset ignore=QueryAddColumn(qCustodyList,"PHOTO_URL","VarChar",photoUrl)>
	     <cfset ignore=QueryAddColumn(qCustodyList,"PHOTO_DATE","VarChar",photoDates)>  	
	     <cfset ignore=QueryAddColumn(qCustodyList,"WARNINGS","VarChar",warnings)> 
	     <cfset ignore=QueryAddColumn(qCustodyList,"ADDRESS","VarChar",addresses)>       	     
	                                                                         	    
	   <cfreturn qCustodyList>	             
    
    </cffunction>

    <cffunction name="getArrestsByPrevious" access="remote" returntype="any" output="false" hint="based on tpu, start / end dates returns, crime codes and having previous DEFE or SUSP role for that crime returns a query of all custodies that match">   
	   <cfargument name="tpu" type="string" required="false" default="" hint="tpu to filter on">
	   <cfargument name="homc_codes" type="string" required="true" hint="list of crime codes for the type of crime that we are looking to see previous on">
	   <cfargument name="startDate" type="string" required="true" hint="start date in DD-MMM-YYY format">
	   <cfargument name="endDate" type="string" required="true" hint="end date in DD-MMM-YYYY format">   	
	      
	   <cfset var qCustodyList="">
	   <cfset var photoUrl=ArrayNew(1)>
	   <cfset var photoDates=ArrayNew(1)>
       <cfset var warnings=ArrayNew(1)>
       <cfset var addresses=ArrayNew(1)>	      
	      
	   <cfquery name="qCustodyList" datasource="#variables.warehouseDSN#">
			SELECT DISTINCT CS.CUSTODY_REF, TO_CHAR(CS.ARREST_TIME,'DD/MM/YY HH24:MI') AS ARREST_TIME, CS.NOMINAL_REF,			       
			        REPLACE(REPLACE(LTRIM(
				                      RTRIM(ND.TITLE)||' '||
											        RTRIM(NS.SURNAME_1)||DECODE(NS.SURNAME_2,NULL,'','-'||NS.SURNAME_2)||', '||
											        RTRIM(INITCAP(FORENAME_1))||' '||
											        RTRIM(INITCAP(FORENAME_2))),' ,',','),'  ' ,' ')
													    || DECODE(FAMILIAR_NAME,'','', ' (Nick ' || FAMILIAR_NAME || ')')
															|| DECODE(MAIDEN_NAME,NULL,'',' (Nee ' || MAIDEN_NAME || ')') AS FULL_NAME,
                    TO_CHAR(DATE_OF_BIRTH,'DD/MM/YYYY') AS DOB
			FROM   browser_owner.CUSTODY_SEARCH CS,  
			       browser_owner.NOMINAL_SEARCH NS, browser_owner.NOMINAL_DETAILS nd,
			       browser_owner.OFFENCE_SEARCH OS, browser_owner.NOMINAL_ROLES NR
			WHERE  cs.NOMINAL_REF=ns.NOMINAL_REF
			AND    ns.NOMINAL_REF=nd.NOMINAL_REF
			AND    cs.NOMINAL_REF=NR.nominal_REF
			AND    os.CRIME_REF=nr.CRIME_REF
			AND    nr.ROLE IN ('DEFE','SUSP')
			AND    os.REC_HOMC_CODE IN (<cfqueryparam value="#arguments.homc_codes#" cfsqltype="cf_sql_varchar" list="true">)	
			<cfif  Len(arguments.TPU) GT 0>
			AND    SUBSTR(CS.CUSTODY_REF,3,1)=<cfqueryparam value="#arguments.tpu#" cfsqltype="cf_sql_varchar">
		    </cfif>
			AND    CS.ARREST_TIME BETWEEN TO_DATE(<cfqueryparam value="#arguments.startDate# 00:00:00" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')
			                          AND TO_DATE(<cfqueryparam value="#arguments.endDate# 23:59:59" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')		    			
			ORDER  BY ARREST_TIME DESC  	
	   </cfquery>	
	   	
	     <cfset photoStruct=variables.photoDAO.getNominalLatestPhotoForSearch(qCustodyList)>
	     <cfset photoUrl=photoStruct.photoUrls>
	     <cfset photoDates=photoStruct.photoDates>
	     <cfset warnings=variables.warningsDAO.getNominalSearchWarnings(qCustodyList)>
	     <cfset addresses=variables.addressDAO.getNominalSearchAddresses(qCustodyList)>     
	     
	     <cfset ignore=QueryAddColumn(qCustodyList,"PHOTO_URL","VarChar",photoUrl)>
	     <cfset ignore=QueryAddColumn(qCustodyList,"PHOTO_DATE","VarChar",photoDates)>  	
	     <cfset ignore=QueryAddColumn(qCustodyList,"WARNINGS","VarChar",warnings)> 
	     <cfset ignore=QueryAddColumn(qCustodyList,"ADDRESS","VarChar",addresses)>       	     
	                                                                         	    
	   <cfreturn qCustodyList>	             
    
    </cffunction>

    <cffunction name="getOISByInitType" access="remote" returntype="any" output="false" hint="based on tpu, initt type and start / end dates returns a query of all ois that match">   
	   <cfargument name="tpu" type="string" required="false" default="" hint="tpu to filter on">
	   <cfargument name="initType" type="string" required="true" hint="wording for arrest, will have % appended either side as this is a free text field">
	   <cfargument name="startDate" type="string" required="true" hint="start date in DD-MMM-YYYY HH24:MI:SS format">
	   <cfargument name="endDate" type="string" required="true" hint="end date in DD-MMM-YYYY HH24:MI:SS format">   	
	      
	   <cfset var qOISList="">
	      
	   <cfquery name="qOISList" datasource="#variables.warehouseDSN#">
			SELECT OIS.CALL_DATE, OIS.OIS_GLOBAL_URN, TO_CHAR(OIS.CALL_DATE,'DD/MM HH24:MI') AS CALL_DATE_F,
			       OIS.LOCATION, OIS.LOG_TYPE, OIS.GRADE, OIS.RESULT_INIT, 'Y' AS ATTENDED
			FROM   browser_owner.INC_HTML_LISTS ois
			WHERE  OIS.CALL_DATE BETWEEN TO_DATE(<cfqueryparam value="#arguments.startDate#" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')
			                         AND TO_DATE(<cfqueryparam value="#arguments.endDate#" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')									                           			                          
			AND    OIS.RESULT_INIT IN (<cfqueryparam value="#arguments.initType#" cfsqltype="cf_sql_varchar" list="true">)
			<cfif  Len(arguments.tpu) GT 0>
			AND    SUBSTR(OIS.PARISH,1,1)=<cfqueryparam value="#arguments.tpu#" cfsqltype="cf_sql_varchar">
			</cfif>
			AND    EXISTS (SELECT 'Y' FROM browser_owner.INC_ATTENDEES att where att.INCIDENT_NUMBER=ois.ois_global_urn)
			UNION
			SELECT OIS.CALL_DATE, OIS.OIS_GLOBAL_URN, TO_CHAR(OIS.CALL_DATE,'DD/MM HH24:MI') AS CALL_DATE_F,
			       OIS.LOCATION, OIS.LOG_TYPE, OIS.GRADE, OIS.RESULT_INIT, 'N' AS ATTENDED
			FROM   browser_owner.INC_HTML_LISTS ois
			WHERE  OIS.CALL_DATE BETWEEN TO_DATE(<cfqueryparam value="#arguments.startDate#" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')
			                         AND TO_DATE(<cfqueryparam value="#arguments.endDate#" cfsqltype="cf_sql_varchar">,'DD-MON-YYYY HH24:MI:SS')  
			AND    OIS.RESULT_INIT IN (<cfqueryparam value="#arguments.initType#" cfsqltype="cf_sql_varchar" list="true">)									                         			                          
			<cfif  Len(arguments.tpu) GT 0>
			AND    SUBSTR(OIS.PARISH,1,1)=<cfqueryparam value="#arguments.tpu#" cfsqltype="cf_sql_varchar">
			</cfif>
			AND    NOT EXISTS (SELECT 'Y' FROM browser_owner.INC_ATTENDEES att where att.INCIDENT_NUMBER=ois.ois_global_urn)	
			ORDER BY 1 DESC   	   
	   </cfquery>	

	   <cfreturn qOISList>	             
    
    </cffunction>

    <cffunction name="getStopSearches" access="remote" returntype="any" output="false" hint="based on tpu, reason, ,grounds, startdate, enddate, officer get all stop searches">   
	   <cfargument name="tpu" type="string" required="false" default="" hint="tpu to filter on">
	   <cfargument name="reason" type="string" required="false" default="" hint="search reason eg. GOING EQUIPPED">
	   <cfargument name="grounds" type="string" required="false" default="" hint="grounds eg. ACTING SUSPICIOUSLY">   
	   <cfargument name="officer" type="string" required="false" default="" hint="collar of officer doing search eg. 4854">      
	   <cfargument name="startDate" type="string" required="true" default="" hint="start date in DD-MON-YYYY HH24:MI:SS format">
	   <cfargument name="endDate" type="string" required="true" default="" hint="end date in DD-MON-YYYY HH24:MI:SS format">   	
	      
	   <cfset var qSearchList=variables.stopSearchDAO.search(tpu=tpu,
	                                                         reason=reason,
	                                                         grounds=grounds,
															 officer=officer,
															 startDate=startDate,
															 endDate=endDate)>
	      	   
	   <cfreturn qSearchList>	             
    
    </cffunction>

    <cffunction name="getStopSearchesByURN" access="remote" returntype="any" output="false" hint="based on an urn or csv list of urns get the stop searches">   
	   <cfargument name="urn" type="string" required="true" hint="an urn or csv list of urns">
	   <cfargument name="removeNullMapRef" type="boolean" required="false" default="false" hint="an urn or csv list of urns">   
	      
	   <cfset var qSearchList=variables.stopSearchDAO.getByURN(urn=arguments.urn,removeNullMapRef=arguments.removeNullMapRef)>
	      	   
	   <cfreturn qSearchList>	             
    
    </cffunction>

    <cffunction name="getRolesForCrime" access="remote" returntype="any" output="false" hint="returns a query of roles for a crime no">   
	   <cfargument name="crimeNo" type="string" required="true" hint="crimeNo to get roles for">
	   <cfargument name="removeNullMapRef" type="boolean" required="false" default="false" hint="an urn or csv list of urns">   
	      
	   <cfset var qSearchList=variables.offenceDAO.getRolesForCrime(crimeNo=crimeNo)>
	      	   
	   <cfreturn qSearchList>	             
    
    </cffunction>

    <cffunction name="favouriteExists" access="remote" returntype="boolean" output="false" hint="returns true or false if a favourite nominal already exists for a user">   
	   <cfargument name="nominalRef" type="string" required="true" hint="nominal ref of nominal to be added as favourite">
	   <cfargument name="userId" type="string" required="true" hint="user id of person adding">
	      
	   <cfset var qFavExists="">
	   <cfset var bFavExists=false>

		<cfquery name="qFavExists" datasource="#variables.WarehouseDSN#">
		SELECT *
		FROM browser_owner.USER_NOMINALS
		WHERE USER_ID=<cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
		AND NOMINAL_REF=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
		</cfquery>
		      	   
		<cfif qFavExists.recordCount GT 0>
		   <cfset bFavExists=true>
		</cfif>	      	   
				   
	   <cfreturn bFavExists>	             
    
    </cffunction>  
    
    <cffunction name="addNominalFavourite" access="remote" returntype="any" output="false" hint="adds a favourite nominal for a user, requires nominal ref to be added and user id of person adding">   
	   <cfargument name="nominalRef" type="string" required="true" hint="nominal ref of nominal to be added as favourite">
	   <cfargument name="userId" type="string" required="true" hint="user id of person adding">
	   <cfargument name="showUpdates" type="string" required="false" default="N" hint="should the user receive updates about the nominal">      
	      
	   <cfset var qNominalInsert="">
	   <cfset var returnStruct=structNew()>
	   <cfset var favExists="">
	   
	   <cfset returnStruct.valid=true>
	   
	   <!---
	   <cftry>
	   --->	
	   	<cfset favExists=favouriteExists(nominalRef=arguments.nominalRef, userId=arguments.userId)>
	   	
		   <!--- check if nominal already has this favourite --->	
		   <cfif not favExists>
		   	 
		   	 <!--- user doesn't have the favourite so add it --->
			 <cfquery name="qNominalInsert" datasource="#variables.WarehouseDSN2#"> 
			  INSERT INTO browser_owner.USER_NOMINALS
			  (
			  USER_ID,
			  NOMINAL_REF,
			  DATE_ADDED,
	          SHOW_UPDATES
			  )
			  VALUES
			  (
			  <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">,
			  <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">,  
			  <cfqueryparam value="#CreateODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">,    
			  <cfqueryparam value="#arguments.showUpdates#" cfsqltype="cf_sql_varchar">                    
			  )
			 </cfquery>	   	 	
		   	 
		   </cfif>
	   <!---
	    <cfcatch type="any">
			<cfset returnStruct.valid=false>
			<cfset returnStruct.error="Could not update favourite nominals">
		</cfcatch>
	   
	   </cftry>
	   --->
	      	   
	   <cfreturn returnStruct>	             
    
    </cffunction>    
    
    <cffunction name="getWestMerciaNominalManualInfo" access="remote" returntype="any" output="false" hint="get manual info data via nominalref and type">   
	   <cfargument name="nominalref" type="string" required="true" hint="nominalref of person to get info for">
	   <cfargument name="infoType" type="string" required="true" hint="type of info that is required">	      	
	      
	   <cfset var qManInfo="">
	      
	   <cfquery name="qManInfo" datasource="#variables.warehouseDSN#">
		 SELECT *
		 FROM   browser_owner.NOMINAL_MANUAL_INFORMATION
		 WHERE  NOMINAL_REF = <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
		 AND    INFO_TYPE   = <cfqueryparam value="#arguments.infoType#" cfsqltype="cf_sql_varchar">		   
	   </cfquery>	

	   <cfreturn qManInfo>	             
    
    </cffunction>    

    <cffunction name="createWestMerciaNominalManualInfo" access="remote" returntype="any" output="false" hint="performs an create for the manual info table">   
	   <cfargument name="nominalref" type="string" required="true" hint="nominalref of person to get info for">
	   <cfargument name="infoType" type="string" required="true" hint="type of info that is required">	   
	   <cfargument name="updateText" type="string" required="true" hint="text to update">	      	
	   <cfargument name="updateBy" type="string" required="true" hint="user id of person doing update">
	   <cfargument name="updateByName" type="string" required="true" hint="full name of person doing update">
	      
	   <cfset var qInsManInfo="">
	   <cfset var returnStruct=structNew()>
	      
	   <cfquery name="qInsManInfo" datasource="#variables.warehouseDSN#">
		 INSERT INTO browser_owner.NOMINAL_MANUAL_INFORMATION
		 (
		  NOMINAL_REF,
		  INFO_TYPE,
		  INFORMATION_TEXT,
		  UPDATE_BY,
		  UPDATE_BY_NAME,
		  UPDATE_DATE	
		 )
		 VALUES
		 (
		   <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#arguments.infoType#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#arguments.updateText#" cfsqltype="cf_sql_clob">,
		   <cfqueryparam value="#arguments.updateBy#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#arguments.updateByName#" cfsqltype="cf_sql_varchar">,
		   <cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">	
		 )		 		   
	   </cfquery>	
	   
	   <cfset returnStruct.success=true>
	   <cfset returnStruct.message='Update for '&nominalRef&' has been successful'>   

	   <cfreturn returnStruct>	             
    
    </cffunction>
    
    <cffunction name="updateWestMerciaNominalManualInfo" access="remote" returntype="any" output="false" hint="performs an update for the manual info table">   
	   <cfargument name="nominalref" type="string" required="true" hint="nominalref of person to get info for">
	   <cfargument name="infoType" type="string" required="true" hint="type of info that is required">	   
	   <cfargument name="updateText" type="string" required="true" hint="text to update">	      	
	   <cfargument name="updateBy" type="string" required="true" hint="user id of person doing update">
	   <cfargument name="updateByName" type="string" required="true" hint="full name of person doing update">
	      
	   <cfset var qUpdManInfo="">
	   <cfset var returnStruct=structNew()>
	      
	   <cfquery name="qUpdManInfo" datasource="#variables.warehouseDSN#">
		 UPDATE browser_owner.NOMINAL_MANUAL_INFORMATION
		 SET    INFORMATION_TEXT = <cfqueryparam value="#arguments.updateText#" cfsqltype="cf_sql_clob">,
		        UPDATE_BY        = <cfqueryparam value="#arguments.updateBy#" cfsqltype="cf_sql_varchar">,
				UPDATE_BY_NAME   = <cfqueryparam value="#arguments.updateByName#" cfsqltype="cf_sql_varchar">,
				UPDATE_DATE      = <cfqueryparam value="#createODBCDateTime(now())#" cfsqltype="cf_sql_timestamp">
		 WHERE  NOMINAL_REF      = <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
		 AND    INFO_TYPE        = <cfqueryparam value="#arguments.infoType#" cfsqltype="cf_sql_varchar">		   
	   </cfquery>	
	   
	   <cfset returnStruct.success=true>
	   <cfset returnStruct.message='Update for '&nominalRef&' has been successful'>   

	   <cfreturn returnStruct>	             
    
    </cffunction>    

    <cffunction name="deleteWestMerciaNominalManualInfo" access="remote" returntype="any" output="false" hint="performs a delete for the manual info table">   
	   <cfargument name="nominalref" type="string" required="true" hint="nominalref of person to get info for">
	   <cfargument name="infoType" type="string" required="true" hint="type of info that is required">	   	   
	      
	   <cfset var qDelManInfo="">
	   <cfset var returnStruct=structNew()>
	      
	   <cfquery name="qDelManInfo" datasource="#variables.warehouseDSN#">
		 DELETE FROM browser_owner.NOMINAL_MANUAL_INFORMATION		 
		 WHERE  NOMINAL_REF      = <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
		 AND    INFO_TYPE        = <cfqueryparam value="#arguments.infoType#" cfsqltype="cf_sql_varchar">		   
	   </cfquery>	
	   
	   <cfset returnStruct.success=true>
	   <cfset returnStruct.message='Update for '&nominalRef&' has been successful'>   

	   <cfreturn returnStruct>	             
    
    </cffunction>

    <cffunction name="getIntelByArea" access="remote" returntype="query" output="false" hint="returns a query of intel for an area">
     <cfargument name="area" type="string" required="true" hint="snt code to check">
	 <cfargument name="dateFrom" type="string" required="true" hint="date from dd/mm/yyyy">
	 <cfargument name="dateTo" type="string" required="true" hint="date to dd/mm/yyyy"> 
	                                                                         	     
     <cfreturn variables.intelDAO.getSNTIntel(area=arguments.area, dateFrom=arguments.dateFrom, dateTo=arguments.dateTo)>
     
    </cffunction>   
    
    <cffunction name="getOrgLookup" access="remote" returntype="any" output="false" hint="returns a query of results for a given org_type">
     <cfargument name="orgType" required="true" type="string" hint="org type to get data for">	
     
     <cfset var qOrgLookup="">
     
     <cfquery name="qOrgLookup" datasource="#variables.warehouseDSN#">
	 	 SELECT *
		 FROM   browser_owner.ORG_LOOKUP
		 WHERE  ORG_TYPE=<cfqueryparam value="#arguments.orgType#" cfsqltype="cf_sql_varchar">
		 ORDER BY ORG_CODE 
	 </cfquery>	  
	                                                                         	     
     <cfreturn qOrgLookup>
     
    </cffunction> 

    <cffunction name="getSntLookup" access="remote" returntype="any" output="false" hint="returns a query of snts">
     
     <cfset var qSntLookup="">
     
     <cfquery name="qSntLookup" datasource="#variables.warehouseDSN#">
	 	 SELECT *
		 FROM   browser_owner.SNT_LOOKUP		 
		 ORDER BY SNT_CODE 
	 </cfquery>	  
	                                                                         	     
     <cfreturn qSntLookup>
     
    </cffunction> 
    
    <cffunction name="isSnt" access="remote" returntype="any" output="false" hint="returns a struct with true / false and a list of lpas if true">
     <cfargument name="sntCode" type="string" required="true" hint="snt code to check">
     
     <cfset var qSnt="">
     <cfset var returnStruct=structNew()>
     
     <cfquery name="qSnt" datasource="#variables.warehouseDSN#">
	 	 SELECT *
		 FROM   browser_owner.SNT_LOOKUP		 
		 WHERE  SNT_CODE=<cfqueryparam value="#arguments.sntCode#" cfsqltype="cf_sql_varchar">
	 </cfquery>	  
	 	
	 <cfif qSnt.recordCount IS 1>
	 	 <cfset returnStruct.isSnt=true>
		 <cfset returnStruct.lpaCodes=Replace(qSnt.LPT_CODES,"|",",","ALL")>
	 <cfelse>
	 	 <cfset returnStruct.isSnt=false>
		 <cfset returnStruct.lpaCodes="">
	 </cfif>		
	                                                                         	     
     <cfreturn returnStruct>
     
    </cffunction>     

    <cffunction name="isPatrolZone" access="remote" returntype="any" output="false" hint="checks if code is a patrol zone returns a struct with true / false and a list of beat codes if true">
     <cfargument name="pzCode" type="string" required="true" hint="patrol zone code to check">
     
     <cfset var qPZ="">
     <cfset var returnStruct=structNew()>
     
     <cfquery name="qPZ" datasource="#variables.warehouseDSN#">
	 	 SELECT *
		 FROM   browser_owner.PATROL_ZONE_BEAT		 
		 WHERE  PZ_CODE=<cfqueryparam value="#arguments.pzCode#" cfsqltype="cf_sql_varchar">
	 </cfquery>	  
	 	
	 <cfif qPZ.recordCount GTE 1>
	 	 <cfset returnStruct.isPZ=true>
		 <cfset returnStruct.beatCodes=ValueList(qPZ.BEAT_CODE)>
	 <cfelse>
	 	 <cfset returnStruct.isPZ=false>
		 <cfset returnStruct.beatCodes="">
	 </cfif>		
	                                                                         	     
     <cfreturn returnStruct>
     
    </cffunction> 

    <cffunction name="getPatrolZones" access="remote" returntype="any" output="false" hint="returns a query of patrol zones">
     
     <cfset var qPZLookup="">
     
     <cfquery name="qPZLookup" datasource="#variables.warehouseDSN#">
	 	 SELECT PZ_CODE, POLICING_AREA||'-'||PZ_NAME AS PZ_DESC
		 FROM   browser_owner.PATROL_ZONE_LOOKUP		 
		 ORDER BY POLICING_AREA,  PZ_NAME
	 </cfquery>	  
	                                                                         	     
     <cfreturn qPZLookup>
     
    </cffunction> 
    
    <cffunction name="getAttachedDocuments" access="remote" returntype="any" output="false" hint="returns an array of attachment objects for a source system and source ref">
     <cfargument name="source_system" type="string" required="true" hint="source_system to get attachments for">
	 <cfargument name="source_ref" type="string" required="true" hint="source_ref to get attachments for"> 
                                                                              	     
     <cfreturn variables.attachmentsDAO.getAttachedDocuments(source_system = source_system,
     	                                                     source_ref    = source_ref)>
     
    </cffunction>     

    <cffunction name="createIntelPackage" access="remote" returntype="any" output="false" hint="returns a pdf intel packages">
     <cfargument name="packageForm" type="struct" required="true" hint="form with corp package data on">
                                                                              	     
     <cfreturn variables.intelPackageDAO.createIntelPackage(packageForm)>
     
    </cffunction> 
    
    <cffunction name="doGenieAudit" access="public" returntype="void" output="false" hint="adds information to the genie audit file">
    	<cfargument type="string" name="userId" required="true" hint="userId to audit for">
    	<cfargument type="string" name="sessionId" required="true" hint="sessionId to audit for">    	
    	<cfargument type="string" name="reason" required="true" hint="reason code for request">    	
    	<cfargument type="string" name="reasonText" required="true" hint="reason text for request">
    	<cfargument type="string" name="requestFor" required="true" hint="sessionId to audit for">    	    	    	    	 	    	    	    	
    	<cfargument type="string" name="fullName" required="true" hint="sessionId to audit for">    	    	    	    	
    	<cfargument type="string" name="action" required="true" hint="sessionId to audit for">    	    	    	    	    	    	    	
    	<cfargument type="string" name="fields" required="false" default='""' hint="sessionId to audit for">    	    	    	    	    	
    	<cfargument type="string" name="details" required="false" default='""' hint="sessionId to audit for">    	    	  
    	<cfargument type="string" name="numberOfResults" required="false" default="0" hint="sessionId to audit for">
		<cfargument type="string" name="department" required="false" default="" hint="department the person works in">
		<cfargument type="string" name="ethnicCode" required="false" default="" hint="ethnic code of driver being checked">
		<cfargument type="string" name="requestCollar" required="false" default="" hint="collar of person requesting">
		<cfargument type="string" name="requestForce" required="false" default="" hint="for of person requesting">		    	    	    	    	    	  	    	    	
    	    	
	    <cfset var qInsertData="">
	    <cfset var computerHostname=ListGetAt(CreateObject("java", "java.net.InetAddress").getLocalHost(),1,"/")>
		
		<!--- if the reason code / text / request for are blank then we may have been moved
			  over servers so we need to grab the previous session to continue for the user --->
	    
	    <cfif   Len(arguments.reason) IS 0 
			AND Len(arguments.reasonText) IS 0
			AND Len(arguments.requestFor) IS 0>
					
	    	<cfset lastSession = application.genieUserService.getLastAuditReason(userId=arguments.userId)>
			<cfset arguments.reason=lastSession.reason>
			<cfset arguments.reasonText=lastSession.reason_text>
			<cfset arguments.requestFor=lastSession.request_for>
			<cfset arguments.requestFor=lastSession.request_for>
			<cfset arguments.ethnicCode=lastSession.ethnic_code>
			<cfset arguments.requestCollar=lastSession.audit_for_collar>
			<cfset arguments.requestForce=lastSession.audit_for_force>		
			<cfset application.genieUserService.updateSession(requestFor=arguments.requestFor,
                                                              reasonCode=arguments.reason,
                                                              reasonText=arguments.reasonText,
                                                              ethnicCode=arguments.ethnicCode,
															  requestForCollar=arguments.requestCollar,
															  requestForForce=arguments.requestForce)>
		
	    </cfif>
	    
	    <cfquery name="qInsertAudit" datasource="#variables.warehouseDSN#" result="insertResult">
	       INSERT INTO browser_owner.AUDIT_DATA
	       (
              SESSION_ID,
              REQUEST_TIMESTAMP,
              USER_ID,
              FULL_NAME,
              REASON,
              REASON_TEXT,
              REQUEST_FOR,
              USER_ACTION,
              FIELDS,
              DETAILS,
              NUMBER_OF_RESULTS,
              SERVER,
              DEPARTMENT,
			  ETHNIC_CODE,
			  REQUEST_FOR_COLLAR,
			  REQUEST_FOR_FORCE	     
	       )
	       VALUES
	       (
	          <cfqueryparam value="#arguments.sessionId#" cfsqltype="cf_sql_varchar">,
	          sysdate,
	          <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">,
	          <cfqueryparam value="#arguments.fullName#" cfsqltype="cf_sql_varchar">,
	          <cfqueryparam value="#arguments.reason#" cfsqltype="cf_sql_varchar">,
	          <cfqueryparam value="#arguments.reasonText#" cfsqltype="cf_sql_varchar">,
	          <cfqueryparam value="#arguments.requestFor#" cfsqltype="cf_sql_varchar">,
	          <cfqueryparam value="#arguments.action#" cfsqltype="cf_sql_varchar">,
	          <cfqueryparam value="#Replace(arguments.fields,chr(34),'','ALL')#" cfsqltype="cf_sql_varchar">,
	          <cfqueryparam value="#arguments.details#" cfsqltype="cf_sql_varchar">,
	          <cfqueryparam value="#arguments.numberOfResults#" cfsqltype="cf_sql_numeric">,
	          <cfqueryparam value="#computerHostname#" cfsqltype="cf_sql_varchar">,
			  <cfqueryparam value="#Replace(arguments.department," & "," ","ALL")#" cfsqltype="cf_sql_varchar">,
			  <cfqueryparam value="#arguments.ethnicCode#" cfsqltype="cf_sql_varchar">,
			  <cfqueryparam value="#arguments.requestCollar#" cfsqltype="cf_sql_varchar">,
			  <cfqueryparam value="#arguments.requestForce#" cfsqltype="cf_sql_varchar">		          
	       )
	    </cfquery>
     
    </cffunction>     
       
</cfcomponent>