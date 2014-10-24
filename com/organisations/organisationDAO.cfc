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

	<cffunction name="getOrganisationName" output="false" access="public" returntype="string" hint="returns an organisation name for a passed in organisation code">
      <cfargument name="orgCode" type="string" required="true" hint="org code to get name for">
      
      <cfset var qOrg="">
      <cfset var orgName="">
      
		  <cfquery name="qOrg" datasource="#variables.WarehouseDSN#">
			SELECT	O.ORG_NAME AS DETAILS
            FROM	browser_owner.NOMINAL_ASSIGNMENTS O
            WHERE	  O.ORG_TYPE = 'COM'
			AND     O.ORG_CODE = '#arguments.orgCode#'
		  </cfquery> 
                
          <cfif qOrg.RecordCount GT 0>
           <cfset orgName=qOrg.DETAILS>
          </cfif>
                
       <cfreturn orgName>      
     
    </cffunction>  
    
	<cffunction name="getNominalOrganisations" output="false" access="public" returntype="query">
		<cfargument name="nominalRef" required="true">
		<cfset var qRead="">

	    <cfquery name="qRead" DATASOURCE="#variables.WarehouseDSN#">
		select nvl(gao.DESCRIPTION,nom.description) AS DESCRIPTION, nvl(gao.name,nom.org_name) AS ORG_NAME, to_char(nom.date_rec,'DD/MM/YYYY') AS DATE_REC, 
		       nom.telephone_1, nom.telephone_2,  nom.relationship_to_org,
		    DECODE(GA.BUILDING_NUMBER,'','',GA.BUILDING_NUMBER||' ')||
		DECODE(GA.BUILDING_NAME,'','',GA.BUILDING_NAME||'<br>')||
		DECODE(GA.STREET_1,'','',GA.STREET_1||'<br>')||
		DECODE(GA.LOCALITY,'','',GA.LOCALITY||'<br>')||
		DECODE(GA.TOWN,'','',GA.TOWN||'<Br>')||
		DECODE(GA.COUNTY,'','',GA.COUNTY||'<br>')||
		DECODE(GA.POST_CODE,'','',GA.POST_CODE) Address
		from   browser_owner.nominal_assignments nom, browser_owner.ge_add_org gao, browser_owner.ge_addresses ga
		where  nom.nominal_ref=<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
		and    nom.org_type = gao.org_type(+)
		and    nom.org_code = gao.org_code(+)
		and    gao.post_code = ga.post_code(+)
		and    gao.premise_key = ga.premise_key(+)
		</cfquery>
           
       <cfreturn qRead>

	</cffunction>    
    
    
    
    

    
</cfcomponent>