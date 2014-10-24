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

	<cffunction name="readPdHearings" output="false" access="public" returntype="hearings[]">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">
        <cfset var hearings=ArrayNew(1)>

		<cfquery name="qRead" datasource="#variables.warehousedsn#">          
			 SELECT po.*, ph.*
			 FROM   browser_owner.PD_HEARINGS ph, browser_owner.PD_OFFENCES po
			 WHERE  po.PD_REF=ph.PD_REF(+)
			 AND    po.LINE_REF=ph.LINE_REF(+)
			 AND    po.PD_REF=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.id#" />
			 ORDER BY HEARING_DATE DESC, ph.LINE_REF            
		</cfquery>

        <cfloop query="qRead">
		<cfscript>
			obj = createObject("component", "hearings").init();
			obj.setPD_REF(qRead.PD_REF);
			obj.setLINE_REF(qRead.LINE_REF);
			obj.setHEARING_REF(qRead.HEARING_REF);
			obj.setCOURT_NAME(qRead.COURT_NAME);
			obj.setHEARING_DATE(qRead.HEARING_DATE);
			obj.setSTATUS(qRead.STATUS);
			obj.setCRIME_REF(qRead.CRIME_REF);
			obj.setCRIME_NO(qRead.CRIME_NO);
			obj.setOFFENCE_TITLE(qRead.OFFENCE_TITLE);			
            ArrayAppend(hearings,obj);
		</cfscript>
        </cfloop>
        
        <cfreturn hearings>
        
	</cffunction>


</cfcomponent>