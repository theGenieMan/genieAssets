<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        <cfargument name="redirectorURL" required="true" type="String">   
		<cfargument name="genieService" required="true" type="Any">        		                                        
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>
        <cfset variables.redirectorUrl=arguments.redirectorUrl>
		<cfset variables.genieService=arguments.genieService>		
           
        <cfreturn this />  
    </cffunction> 	
    
    <cffunction name="formatNominalUpdate" access="remote" returntype="struct" output="false" hint="Based on a nominal update input of BUSINESS AREA and REF return a html string of the details">
		<cfargument name="businessArea" type="string" required="true" hint="business area to format eg. INTELLIGENCE, NSPIS CUSTODY, CRIME ROLE">
		<cfargument name="businessRef" type="string" required="true" hint="business ref eg intel log no, crime no">
		<cfargument name="nominalRef" type="string" required="true" hint="nominal ref of person the update is about">
				
		<cfset var updateReturn=structNew()>
		<cfset var caseRef=''>
		<cfset var custRef=''>
		<cfset var assocNominal=''>
		<cfset var thisAddress=''>
		
		<cfswitch expression="#arguments.businessArea#">
			
			<cfcase value="INTELLIGENCE">
				<cfset updateReturn.sHtml="Intel Log <a href='#redirectorUrl#&type=intel&ref=#arguments.businessRef#' target='_blank'>#arguments.businessRef#</a>">
				<cfset updateReturn.jQueryClass="genieIntelLink">		
				<cfset updateReturn.additionalAttributes="">						
				<cfset updateReturn.href=arguments.businessRef>		
				<cfset updateReturn.displayData=arguments.businessRef>
				<cfset updateReturn.displayBusArea="Intel Log">		
			</cfcase> 
			
			<cfcase value="CRIME ROLES">
				<cfset updateReturn.sHtml="Crime Role <a href='#redirectorUrl#&type=crime&ref=#arguments.businessRef#' target='_blank'>#arguments.businessRef#</a>">
				<cfset updateReturn.jQueryClass="genieCrimeLink">
				<cfset updateReturn.additionalAttributes="">					
				<cfset updateReturn.href=arguments.businessRef>
				<cfset updateReturn.displayData=arguments.businessRef>
				<cfset updateReturn.displayBusArea="Crime Role">			
			</cfcase>
			
			<cfcase value="STOP SEARCH">				
				<cfset updateReturn.sHtml="Stop Search <a href='#redirectorUrl#&type=stopsearch&ref=#arguments.businessRef#' target='_blank'>#arguments.businessRef#</a>">
				<cfset updateReturn.jQueryClass="genieStopSearchLink">
				<cfset updateReturn.additionalAttributes="">							
				<cfset updateReturn.href=arguments.businessRef>	
				<cfset updateReturn.displayData=arguments.businessRef>
				<cfset updateReturn.displayBusArea="Stop Search">
			</cfcase>  
			
			<cfcase value="NSPIS CASE">
				<!--- Case refs come with an extra / ie 22/DA/1234/14 should be 22DA/1234/14 so format propertly --->
				<cfif ListLen(arguments.businessRef,"/") IS 4>
					<cfset caseRef=ListGetAt(arguments.businessRef,1,"/")&ListGetAt(arguments.businessRef,2,"/")&"/"&ListGetAt(arguments.businessRef,3,"/")&"/"&ListGetAt(arguments.businessRef,4,"/")>
				<cfelse>
					<cfset caseRef=arguments.businessRef>
				</cfif>
				<cfset updateReturn.sHtml="Case <a href='#redirectorUrl#&type=case&ref=#caseRef#' target='_blank'>#caseRef#</a>">
				<cfset updateReturn.jQueryClass="genieCaseLink">					
				<cfset updateReturn.additionalAttributes="caseType='NSPIS'">					
				<cfset updateReturn.href=caseRef>
				<cfset updateReturn.displayData=caseRef>	
				<cfset updateReturn.displayBusArea="Case">	
			</cfcase> 
			
			<cfcase value="NSPIS CUSTODY">
				<cfif ListLen(arguments.businessRef,"/") IS 4>
					<cfset custRef=ListGetAt(arguments.businessRef,1,"/")&ListGetAt(arguments.businessRef,2,"/")&"/"&ListGetAt(arguments.businessRef,3,"/")&"/"&ListGetAt(arguments.businessRef,4,"/")>
				<cfelse>
					<cfset custRef=arguments.businessRef>
				</cfif>				
				<cfset updateReturn.sHtml="Custody <a href='#redirectorUrl#&type=custody&ref=#custRef#' target='_blank'>#custRef#</a>">
				<cfset updateReturn.jQueryClass="genieCustodyLink">
				<cfset updateReturn.additionalAttributes="custodyType='NSPIS'">					
				<cfset updateReturn.href=custRef>
				<cfset updateReturn.displayData=custRef>		
				<cfset updateReturn.displayBusArea="Custody">
			</cfcase> 
			
			<cfcase value="VEHICLES">				
				<cfset updateReturn.sHtml="Vehicle <a href='#redirectorUrl#&type=nominal&ref=#arguments.nominalRef#&firstTab=Vehicles' target='_blank'>#arguments.businessRef#</a>">
				<cfset updateReturn.jQueryClass="genieNominal">
				<cfset updateReturn.additionalAttributes="firstTab='4'">							
				<cfset updateReturn.href=arguments.nominalRef>
				<cfset updateReturn.displayData=arguments.businessRef>
				<cfset updateReturn.displayBusArea="Vehicle">
			</cfcase>		
			
			<cfcase value="TELEPHONE">				
				<cfset updateReturn.sHtml="Telephone <a href='#redirectorUrl#&type=nominal&ref=#arguments.nominalRef#&firstTab=TelNos' target='_blank'>#arguments.businessRef#</a>">
				<cfset updateReturn.jQueryClass="genieNominal">
				<cfset updateReturn.additionalAttributes="firstTab='5'">						
				<cfset updateReturn.href=arguments.nominalRef>	
				<cfset updateReturn.displayData=arguments.businessRef>
				<cfset updateReturn.displayBusArea="Telephone">
			</cfcase>	
			
			<cfcase value="WARRANTS">				
				<cfset updateReturn.sHtml="Warrant <a href='#redirectorUrl#&type=nominal&ref=#arguments.nominalRef#&firstTab=Warrants' target='_blank'>#arguments.businessRef#</a>">
				<cfset updateReturn.jQueryClass="genieNominal">
				<cfset updateReturn.additionalAttributes="firstTab='11'">						
				<cfset updateReturn.href=arguments.nominalRef>
				<cfset updateReturn.displayData=arguments.businessRef>	
				<cfset updateReturn.displayBusArea="Warrant">	
			</cfcase>		
			
			<cfcase value="FPU">				
				<cfset updateReturn.sHtml="FPU <a href='#redirectorUrl#&type=nominal&ref=#arguments.nominalRef#&firstTab=FPU' target='_blank'>#arguments.businessRef#</a>">
				<cfset updateReturn.jQueryClass="genieNominal">
				<cfset updateReturn.additionalAttributes="firstTab='13'">							
				<cfset updateReturn.href=arguments.nominalRef>
				<cfset updateReturn.displayData=arguments.businessRef>	
				<cfset updateReturn.displayBusArea="FPU">
			</cfcase>
			
			<cfcase value="RELATIONSHIPS">		
				<cfset assocNominal=variables.genieService.getWestMerciaNominalDetail(nominalRef=arguments.businessRef)>				
				<cfset updateReturn.sHtml="Associate <a href='#redirectorUrl#&type=nominal&ref=#arguments.businessRef#' target='_blank'>#assocNominal.getFULL_NAME()#</a>">
				<cfset updateReturn.jQueryClass="genieNominal">
				<cfset updateReturn.additionalAttributes="">							
				<cfset updateReturn.href=assocNominal.getNOMINAL_REF()>
				<cfset updateReturn.displayData=assocNominal.getFULL_NAME()>
				<cfset updateReturn.displayBusArea="Associate">
			</cfcase>
			
			<cfcase value="ADDRESS">		
				<cfset thisAddress=variables.genieService.getWestMerciaAddress(postcode=ListGetAt(arguments.businessRef,1,"|"),premiseKey=ListGetAt(arguments.businessRef,2,"|"))>				
				<cfset updateReturn.sHtml="Address <a href='#redirectorUrl#&type=nominal&ref=#arguments.nominalRef#&firstTab=addresses' target='_blank'>#thisAddress.getFULL_ADDRESS()#</a>">
				<cfset updateReturn.jQueryClass="genieNominal">
				<cfset updateReturn.additionalAttributes="firstTab='1'">						
				<cfset updateReturn.href=arguments.nominalRef>
				<cfset updateReturn.displayData=thisAddress.getFULL_ADDRESS()>
				<cfset updateReturn.displayBusArea="Address">
			</cfcase>							
			
			<cfdefaultcase>
        		<cfset updateReturn.sHtml="#arguments.businessArea# #arguments.businessRef#">
				<cfset updateReturn.jQueryClass="">
				<cfset updateReturn.additionalAttributes="">				
				<cfset updateReturn.href="">
				<cfset updateReturn.displayData=arguments.businessRef>
				<cfset updateReturn.displayBusArea=arguments.businessArea>
    		</cfdefaultcase>
			
		</cfswitch>
		
		<cfreturn updateReturn>
		
	</cffunction>
	
</cfcomponent>