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
    
    <cffunction name="formatNominalUpdate" access="remote" returntype="string" output="false" hint="Based on a nominal update input of BUSINESS AREA and REF return a html string of the details">
		<cfargument name="businessArea" type="string" required="true" hint="business area to format eg. INTELLIGENCE, NSPIS CUSTODY, CRIME ROLE">
		<cfargument name="businessRef" type="string" required="true" hint="business ref eg intel log no, crime no">
		<cfargument name="nominalRef" type="string" required="true" hint="nominal ref of person the update is about">
		
		<cfset var sHtml=''>
		<cfset var caseRef=''>
		<cfset var custRef=''>
		<cfset var assocNominal=''>
		<cfset var thisAddress=''>
		
		<cfswitch expression="#arguments.businessArea#">
			
			<cfcase value="INTELLIGENCE">
				<cfset sHtml="Intel Log <a href='#redirectorUrl#&type=intel&ref=#arguments.businessRef#' target='_blank'>#arguments.businessRef#</a>">				
			</cfcase> 
			
			<cfcase value="CRIME ROLES">
				<cfset sHtml="Crime Role <a href='#redirectorUrl#&type=crime&ref=#arguments.businessRef#' target='_blank'>#arguments.businessRef#</a>">				
			</cfcase>
			
			<cfcase value="STOP SEARCH">				
				<cfset sHtml="Stop Search <a href='#redirectorUrl#&type=stopsearch&ref=#arguments.businessRef#' target='_blank'>#arguments.businessRef#</a>">				
			</cfcase>  
			
			<cfcase value="NSPIS CASE">
				<!--- Case refs come with an extra / ie 22/DA/1234/14 should be 22DA/1234/14 so format propertly --->
				<cfif ListLen(arguments.businessRef,"/") IS 4>
					<cfset caseRef=ListGetAt(arguments.businessRef,1,"/")&ListGetAt(arguments.businessRef,2,"/")&"/"&ListGetAt(arguments.businessRef,3,"/")&"/"&ListGetAt(arguments.businessRef,4,"/")>
				<cfelse>
					<cfset caseRef=arguments.businessRef>
				</cfif>
				<cfset sHtml="Case <a href='#redirectorUrl#&type=case&ref=#caseRef#' target='_blank'>#caseRef#</a>">				
			</cfcase> 
			
			<cfcase value="NSPIS CUSTODY">
				<cfif ListLen(arguments.businessRef,"/") IS 4>
					<cfset custRef=ListGetAt(arguments.businessRef,1,"/")&ListGetAt(arguments.businessRef,2,"/")&"/"&ListGetAt(arguments.businessRef,3,"/")&"/"&ListGetAt(arguments.businessRef,4,"/")>
				<cfelse>
					<cfset custRef=arguments.businessRef>
				</cfif>
				
				<cfset sHtml="Custody <a href='#redirectorUrl#&type=custody&ref=#custRef#' target='_blank'>#custRef#</a>">				
			</cfcase> 
			
			<cfcase value="VEHICLES">				
				<cfset sHtml="Vehicle <a href='#redirectorUrl#&type=nominal&ref=#arguments.nominalRef#&firstTab=Vehicles' target='_blank'>#arguments.businessRef#</a>">				
			</cfcase>		
			
			<cfcase value="TELEPHONE">				
				<cfset sHtml="Telephone <a href='#redirectorUrl#&type=nominal&ref=#arguments.nominalRef#&firstTab=TelNos' target='_blank'>#arguments.businessRef#</a>">				
			</cfcase>	
			
			<cfcase value="WARRANTS">				
				<cfset sHtml="Warrant <a href='#redirectorUrl#&type=nominal&ref=#arguments.nominalRef#&firstTab=Warrants' target='_blank'>#arguments.businessRef#</a>">				
			</cfcase>		
			
			<cfcase value="FPU">				
				<cfset sHtml="FPU <a href='#redirectorUrl#&type=nominal&ref=#arguments.nominalRef#&firstTab=FPU' target='_blank'>#arguments.businessRef#</a>">				
			</cfcase>
			
			<cfcase value="RELATIONSHIPS">		
				<cfset assocNominal=variables.genieService.getWestMerciaNominalDetail(nominalRef=arguments.businessRef)>				
				<cfset sHtml="Associate <a href='#redirectorUrl#&type=nominal&ref=#arguments.businessRef#' target='_blank'>#assocNominal.getFULL_NAME()#</a>">				
			</cfcase>
			
			<cfcase value="ADDRESS">		
				<cfset thisAddress=variables.genieService.getWestMerciaAddress(postcode=ListGetAt(arguments.businessRef,1,"|"),premiseKey=ListGetAt(arguments.businessRef,2,"|"))>				
				<cfset sHtml="Address <a href='#redirectorUrl#&type=nominal&ref=#arguments.nominalRef#&firstTab=addresses' target='_blank'>#thisAddress.getFULL_ADDRESS()#</a>">				
			</cfcase>							
			
			<cfdefaultcase>
        		<cfset sHtml="#arguments.businessArea# #arguments.businessRef#">
    		</cfdefaultcase>
			
		</cfswitch>
		
		
		<cfreturn sHtml>
		
	</cffunction>
	
</cfcomponent>