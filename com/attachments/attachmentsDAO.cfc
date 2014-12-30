<cfcomponent output="false">

    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>      
           
        <cfreturn this />  
    </cffunction>   

	<cffunction name="read" output="false" access="public" returntype="genieObj.attachments.attachments" hint="read an attachment, requires an attachment obj with SOURCE_SYSTEM, SOURCE_REF, DOCUMENT_NO">
		<cfargument name="obj" required="true">
		<cfset var qRead="">
		
		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			 SELECT	 *        
			 FROM    BROWSER_OWNER.ATTACHED_DOCUMENTS
			 WHERE   SOURCE_SYSTEM = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getSOURCE_SYSTEM()#" />
	      	 AND     SOURCE_REF    = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#obj.getSOURCE_REF()#" />
			 AND     DOCUMENT_NO   = <cfqueryparam cfsqltype="CF_SQL_NUMERIC" value="#obj.getDOCUMENT_NO()#" />
			</cfquery>
	
			<cfscript>
				obj.setSOURCE_SYSTEM(qRead.SOURCE_SYSTEM);
				obj.setSOURCE_REF(qRead.SOURCE_REF);
				obj.setDOCUMENT_NO(qRead.DOCUMENT_NO);
				obj.setDOC_TYPE(qRead.DOC_TYPE);
				obj.setFILE_NAME(qRead.FILE_NAME);				
				obj.setORIGINATOR(qRead.ORIGINATOR);
				obj.setDATE_CREATED(qRead.DATE_CREATED);
				return obj;
			</cfscript>
		</cffunction>
		
    <cffunction name="getAttachedDocuments" output="false" access="public" returntype="array" hint="returns an array of attachment objects for a given source system & ref">
	     <cfargument name="SOURCE_SYSTEM" required="true" type="string" hint="Source System for attachments">
		 <cfargument name="SOURCE_REF" required="true" type="string" hint="Source Ref for attachments"> 
	     
	     <cfset var arrAttach=arrayNew(1)>
		 <cfset var thisAttach="">
	     <cfset var qAttach="">
	     
			<CFQUERY NAME = "qAttach" DATASOURCE="#variables.WarehouseDSN#">
			SELECT SOURCE_SYSTEM, SOURCE_REF, DOCUMENT_NO
			FROM   browser_owner.ATTACHED_DOCUMENTS
			WHERE  SOURCE_SYSTEM = <cfqueryparam value="#arguments.SOURCE_SYSTEM#" cfsqltype="cf_sql_varchar" />
			AND    SOURCE_REF 	 = <cfqueryparam value="#arguments.SOURCE_REF#" cfsqltype="cf_sql_varchar" />		
			ORDER BY DOCUMENT_NO
			</cfquery>
			
			<cfloop query="qAttach">
				<cfset thisAttach=createObject('component','genieObj.attachments.attachments').init()>
				<cfset thisAttach.setSOURCE_SYSTEM(SOURCE_SYSTEM)>
				<cfset thisAttach.setSOURCE_REF(SOURCE_REF)>
				<cfset thisAttach.setDOCUMENT_NO(DOCUMENT_NO)>
				<cfset arrayAppend(arrAttach,read(thisAttach))>
			</cfloop>
	                
	     <cfreturn arrAttach>
	     
	</cffunction> 

</cfcomponent>