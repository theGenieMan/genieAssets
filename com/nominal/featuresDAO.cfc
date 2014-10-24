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

	<cffunction name="read" output="false" access="public" returntype="features">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN#">
			select 	NOMINAL_REF, SERIAL_NO, FEATURE_NO, FEATURE_TYPE, FEATURE_SUBTYPE, FEATURE, 
					DESC1, DESC2, DESC3
			from BROWSER_OWNER.NOMINAL_FEATURES
			where NOMINAL_REF = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.id#" />
		</cfquery>

		<cfscript>
			obj = createObject("component", "features").init();
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setSERIAL_NO(qRead.SERIAL_NO);
			obj.setFEATURE_NO(qRead.FEATURE_NO);
			obj.setFEATURE_TYPE(qRead.FEATURE_TYPE);
			obj.setFEATURE_SUBTYPE(qRead.FEATURE_SUBTYPE);
			obj.setFEATURE(qRead.FEATURE);
			obj.setDESC1(qRead.DESC1);
			obj.setDESC2(qRead.DESC2);
			obj.setDESC3(qRead.DESC3);
			return obj;
		</cfscript>
	</cffunction>

	<cffunction name="getNominalFeatures" output="false" access="public" returntype="struct">
		<cfargument name="nominalRef" required="true">
		<cfset var qRead="">
		<cfset var arr_features=arrayNew(1)>
        <cfset var lis_FeatureTypes="">
        <cfset var featureStruct=StructNew()>
        <Cfset var i=0>

		<cfquery name="qRead" DATASOURCE="#variables.WarehouseDSN#">	
		Select feature_type, feature, feature_no, Desc1, Desc2, Desc3
		From BROWSER_OWNER.NOMINAL_FEATURES
		Where nominal_ref =<cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
		</cfquery>
		
		<!--- V8 <cfqueryparam value="#str_CRO#" cfsqltype="cf_sql_varchar"> --->
		
		<cfset lis_FeatureTypes="">
		<cfoutput query="qRead">
		 <cfif not ListContains(lis_FeatureTypes,feature,"~")>
		  <cfset lis_FeatureTypes=ListAppend(lis_FeatureTypes,feature,"~")>
		 </cfif>
		</cfoutput>
		
		<cfset i=1>
		<cfoutput query="qRead">
		 <cfset arr_Features[i]=StructNew()>
		 <cfset arr_Features[i].FeatType=Feature>
		 <cfset arr_Features[i].FeatNo=feature_no>
		 <cfset str_Desc="">
		 <cfif Len(Desc1) GT 0>
		  <cfset str_Desc=str_Desc&Desc1>
		 </cfif>
		 <cfif Len(Desc2) GT 0>
		  <cfset str_Desc=str_Desc&" "&Desc2>
		 </cfif>
		 <cfif Len(Desc3) GT 0>
		  <cfset str_Desc=str_Desc&" "&Desc3>
		 </cfif>  
		 <cfset arr_Features[i].Desc=str_Desc>
		 <cfset i=i+1>
		</cfoutput>
        
        <cfset featureStruct.arr_features=arr_Features>
        <cfset featureStruct.lis_featureTypes=lis_FeatureTypes>        

        <cfreturn featureStruct>

	</cffunction>

</cfcomponent>