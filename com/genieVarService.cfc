<cfcomponent output="false" name="genieVarService">
      
    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        
        <cfset variables.version="1.1.0.0">    
		<cfset variables.dateServiceStarted=DateFormat(now(),"DDD DD-MMM-YYYY")&" "&TimeFormat(now(),"HH:mm:ss")>                                  
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
        <cfreturn this />    
    </cffunction>
    
    <cffunction name="getAppVars" access="public" returntype="struct" hint="returns app vars (only non object ones) as a struct">
	
		<cfset var appVars=StructNew()>
		<cfset var thisAppVar="">
		
		<cfloop collection="#application#" item="thisAppVar">
			<cfif not isObject(thisAppVar) AND not isStruct(thisAppVar) AND not isQuery(thisAppVar)>
				<cfset structInsert(appVars,thisAppVar,structFind(application,thisAppVar))>
			</cfif>
		</cfloop>
		
		<cfreturn appVars>
	
	</cffunction>  

</cfcomponent>