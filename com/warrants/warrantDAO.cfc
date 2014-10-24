<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        <cfargument name="geniePastePath" required="true" type="String">
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>      
        <cfset variables.geniePastePath=arguments.geniePastePath>   

        <cfreturn this />  
    </cffunction>   

	<cffunction name="read" output="false" access="public" returntype="warrant">
		<cfargument name="obj" required="true">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
					select 	WARRANT_REF, NOMINAL_REF, DATE_ISSUED, COURT_NAME, DATE_EXECUTED, EXECUTION_METHOD, 
							OFFENCE, WARRANT_EXECUTED, WARRANT_TYPE, BAIL, NOTEPAD, 
							ADDRESS, ORG_CODE_POLICE, OWN_SECT_CODE, CLASSIFICATION, WARRANT_REFERENCE		
					from BROWSER_OWNER.WARRANTS
					where WARRANT_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getWARRANT_REF()#" />
				</cfquery>
		
				<cfscript>
					obj.setWARRANT_REF(qRead.WARRANT_REF);
					obj.setNOMINAL_REF(qRead.NOMINAL_REF);
					obj.setDATE_ISSUED(qRead.DATE_ISSUED);
					obj.setCOURT_NAME(qRead.COURT_NAME);
					obj.setDATE_EXECUTED(qRead.DATE_EXECUTED);
					obj.setEXECUTION_METHOD(qRead.EXECUTION_METHOD);
					obj.setOFFENCE(qRead.OFFENCE);
					obj.setWARRANT_EXECUTED(qRead.WARRANT_EXECUTED);
					obj.setWARRANT_TYPE(qRead.WARRANT_TYPE);
					obj.setBAIL(qRead.BAIL);
					obj.setNOTEPAD(qRead.NOTEPAD);
					obj.setADDRESS(qRead.ADDRESS);
					obj.setORG_CODE_POLICE(qRead.ORG_CODE_POLICE);
					obj.setOWN_SECT_CODE(qRead.OWN_SECT_CODE);
					obj.setCLASSIFICATION(qRead.CLASSIFICATION);
					obj.setWARRANT_REFERENCE(qRead.WARRANT_REFERENCE);
					return obj;
				</cfscript>
			</cffunction>
		    
			<cffunction name="readOnWarrant" output="false" access="public" returntype="genieObj.warrants.warrant">
				<cfargument name="nominalRef" required="true">
				<cfset var qOnWarrant="">
		        <cfset var warrant=CreateObject("component","genieObj.warrants.warrant")>
		
				<cfquery name="qOnWarrant" datasource="#variables.warehouseDSN#">
					Select Warrant_ref
					From   browser_owner.Warrants
					Where  nominal_ref=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nominalRef#" />
					And    date_executed is null
				</cfquery>
		        
		        <cfif qOnWarrant.RecordCount GT 0>
		            
		          <cfset warrant.setWARRANT_REF(qOnWarrant.WARRANT_REF)>
		          <cfset warrant=read(warrant)>
		        </cfif>
		
		        <cfreturn warrant>
				
			</cffunction>        
		
			<cffunction name="getNominalWarrants" output="false" access="public" returntype="array">
				<cfargument name="nominalRef" required="true">
				<cfset var qRead="">
				<cfset var arr_Warrants=arrayNew(1)>
		        <Cfset var i=0>
		
				<cfquery name="qRead" DATASOURCE="#variables.WarehouseDSN#">
				Select Warrant_ref, Date_Issued, court_name, date_executed,
				       execution_method,nvl(offence,'&nbsp;') as offence,
				       warrant_executed, warrant_type, notepad, classification
				From   browser_owner.warrants w
				Where w.nominal_ref = <cfqueryparam value="#str_CRO#" cfsqltype="cf_sql_varchar">
				Order By Date_Issued DESC
				</cfquery>
				
				<cfset arr_Warrants=ArrayNew(1)>
				<cfset i=1>
				<cfoutput query="qRead">
				 <cfset arr_Warrants[i]=StructNew()>
				 <cfset arr_Warrants[i].Ref=Warrant_Ref>
				 <cfset arr_Warrants[i].Issued=DateFormat(Date_Issued,"DD/MM/YYYY")>
				 <cfset arr_Warrants[i].Executed=DateFormat(Date_Executed,"DD/MM/YYYY")>
				 <cfset arr_Warrants[i].Court=Court_Name>
				 <cfset arr_Warrants[i].Offence=offence>
				 <cfset arr_Warrants[i].wtype=warrant_type>
				 <cfset arr_Warrants[i].ExMeth=execution_method>
				 <cfset arr_Warrants[i].Notes=notepad> 
				 <cfset arr_Warrants[i].Classification=classification>                 
				 <cfset i=i+1>
				</cfoutput>
	            
	            <cfreturn arr_Warrants>
		
			</cffunction>
		
			<cffunction name="getWarrantCount" output="false" access="public" returntype="string">
				<cfargument name="area" required="true">
				<cfset var qRead="">
				<cfset var div="">
				<cfset var iAreaCount="">
		
				<cfquery name="qRead" DATASOURCE="#variables.WarehouseDSN#">
					Select COUNT(*) AS NO_WARRANTS
					From   browser_owner.warrants w
					where (1=1)
					<cfif arguments.area IS NOT "H">
					and    (
					  <cfset iAreaCount=1>
					    <cfloop list="#area#" index="div" delimiters=",">
						 <cfif iAreaCount GT 1>
						 OR
						 </cfif>
						 (
					             substr(w.org_code_police,0,1) = <cfqueryparam value="#div#" cfsqltype="cf_sql_varchar">
					      and    substr(w.own_sect_code,0,1) = <cfqueryparam value="#div#" cfsqltype="cf_sql_varchar">
						 )
						  <cfset iAreaCount++>
						</cfloop>
					)					
					</cfif>
					and    nvl(w.warrant_executed,'N') = 'N'
				</cfquery>
				            
	            <cfreturn qRead.NO_WARRANTS>
		
			</cffunction>	
		
			<cffunction name="getWarrantAge" output="false" access="public" returntype="string">
				<cfargument name="area" required="true">
				<cfargument name="returnType" required="true">
												
				 <cfset var qRead="">
				 <cfset var datePart="">
				 <cfset var div="">
				 <cfset var iAreaCount="">				  
				  
				 <cfswitch expression="#arguments.returnType#">
				 	 <cfcase value="hours">
					  	  <cfset datePart="h">
					 </cfcase>
					 <cfcase value="minutes">
					  	  <cfset datePart="n">
					 </cfcase> 	   
					 <cfcase value="days">
					  	  <cfset datePart="d">
					 </cfcase> 	   
					 <cfcase value="weeks">
					  	  <cfset datePart="ww">
					 </cfcase> 	   
					 <cfcase value="months">
					  	  <cfset datePart="m">
					 </cfcase> 	   
					 <cfcase value="years">
					  	  <cfset datePart="yyyy">
					 </cfcase> 	   			  	  
				 </cfswitch>
		
				<cfquery name="qRead" DATASOURCE="#variables.WarehouseDSN#">
					Select MAX(DATE_ISSUED) AS WARRANT_DATE
					From   browser_owner.warrants w
					Where  (1=1)
					<cfif arguments.area IS NOT "H">					
					 and    (
					  <cfset iAreaCount=1>
					    <cfloop list="#area#" index="div" delimiters=",">
						 <cfif iAreaCount GT 1>
						 OR
						 </cfif>
						 (
					             substr(w.org_code_police,0,1) = <cfqueryparam value="#div#" cfsqltype="cf_sql_varchar">
					      and    substr(w.own_sect_code,0,1) = <cfqueryparam value="#div#" cfsqltype="cf_sql_varchar">
						 )
						  <cfset iAreaCount++>
						</cfloop>
					 )					
					 </cfif>					
					and    nvl(w.warrant_executed,'N') = 'N'
				</cfquery>
				
				<cfif qRead.recordCount GT 0 and isDate(qRead.WARRANT_DATE)>
				   <cfreturn DateDiff(datePart,qRead.WARRANT_DATE,now())>
				<cfelse>
				   <cfreturn '0'>
				</cfif>
		
			</cffunction>			
		
		</cfcomponent>