<cfcomponent output="false">
	    
    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD"  required="true" type="String">
		<cfargument name="transformsDir" required="true" type="String">
		<cfargument name="crimePath" required="true" type="String">
		<cfargument name="intelPath" required="true" type="String">
		<cfargument name="intelB99Path" required="true" type="String">
		<cfargument name="genieImagePath" required="true" type="String">
        
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>      
		<cfset variables.transformsDir=arguments.transformsDir>
		<cfset variables.crimePath=arguments.crimePath>
		<cfset variables.intelPath=arguments.intelPath>
		<cfset variables.intelB99Path=arguments.intelB99Path>
		<cfset variables.genieImagePath=arguments.genieImagePath>
		<cfset variables.packageXml="">
		
		<cfsavecontent variable="variables.packageXml">
			<IntelPackage URN="%URN%">
			 <NominalRef>%NominalRef%</NominalRef>
			 <Warnings>
			    %Warnings%
			 </Warnings>	
			 <WarningsText><![CDATA[%WarningsText%]]></WarningsText>
			 <Aliases>
			    %Aliases%
			 </Aliases>
			 <Roles>
			    %Roles% 
			 </Roles>
			 <RolesFreeText><![CDATA[%RolesFreeText%]]></RolesFreeText>
			 <Addresses>
			   %Addresses%
			 </Addresses>
			 <Intels>
			   %Intels%
			 </Intels>
			 <IntelFreeText><![CDATA[%IntelFreeText%]]></IntelFreeText>
			 <Telephones>
			   %Telephones%
			 </Telephones>   
			 <Vehicles>
			   %Vehicles%
			 </Vehicles>
			 <AssociateIncludeWarningPhoto>%AssociateIncludeWarningPhoto%</AssociateIncludeWarningPhoto>
			 <Associates>
			   %Associates%
			 </Associates>
			 <OtherText><![CDATA[%OtherText%]]></OtherText>
			</IntelPackage>
		</cfsavecontent>
		
        <cfset variables.warningXml="<Warning>%Warning%</Warning>#chr(10)#">
        <cfset variables.aliasXml="<Alias>%Alias%</Alias>#chr(10)#">
        <cfset variables.rolesXml="<Role>%Role%</Role>#chr(10)#">
		<cfset variables.addressXml="<Address>%Address%</Address>#chr(10)#">
        <cfset variables.telephoneXml="<Telephone>%Telephone%</Telephone>#chr(10)#">
		<cfset variables.vehicleXml="<Vehicle>%Vehicle%</Vehicle>#chr(10)#">
        <cfset variables.associateXml="<Associate>%Associate%</Associate>#chr(10)#">
		<cfset variables.intelXml="<Intel>%Intel%</Intel>#chr(10)#">			
           
        <cfreturn this />  
    </cffunction>

	<cffunction name="createIntelPackage" access="public" returntype="any">
		<cfargument name="packageForm" type="struct" required="true" hint="form contaning intel package requirements">
		<cfargument name="urn" type="string" required="false" default="" hint="if an urn passed then, we have an update not a create">
		
		<cfset var sReturn=StructNew()>
		<cfset var crimeNo=''>
		<cfset var intelLogRef=''>
		<cfset var addressDetail=''>
		<cfset var aliasDetail=''>
		<cfset var telDetail=''>
		<cfset var vehDetail=''>
		<cfset var warningDetail=''>
		<cfset var nominalPdf=''>
		<cfset var iCrime=1>
		<cfset var iIntel=1>
		<cfset var iWarn=1>
		<cfset var iAlias=1>
		<cfset var thisPackageXml=duplicate(variables.packageXml)>
		<cfset var thisCrime="">
		<cfset var incCrimeXml="">
		<cfset var thisCrimeText="">
		<cfset var thisWarning="">
		<cfset var incWarningXml="">
		<cfset var thisWarningText="">		
		<cfset var thisAlias="">
		<cfset var incAliasXml="">
	    <cfset var thisAddress="">
		<cfset var incAddressXml="">
		<cfset var thisAssociate="">
		<cfset var incAssociateXml="">
		<cfset var incAssocPhotoWarn=false>
		<cfset var thisIntel="">
		<cfset var incIntelXml="">
		<cfset var thisIntelText="">
		<cfset var thisTelephone="">
		<cfset var incTelephoneXml="">
		<cfset var thisVehicle="">
		<cfset var incVehicleXml="">
		<cfset var thisOtherText="">
		<cfset var qNextSerial="">
		<cfset var newUrn="">
		<cfset var qInsert="">
		<cfset var versionNo="">
		<cfset var qUpdate="">
		<cfset var minSal=99>
		<cfset var iNext=0>
		<cfset var packageType="">
		<cfset var lisCrimesOutput="">
		
		<!--- no URN so we need to generate one --->
		<cfif Len(urn) IS 0>
			<cfquery name="qUrn" datasource="#variables.warehouseDSN#">
				SELECT SERIAL
				FROM   browser_owner.INTELL_PACKAGE_SERIALS
				WHERE  YEAR = <cfqueryparam value="#DateFormat(now(),"YY")#" cfsqltype="cf_sql_numeric" />
			</cfquery>
			<cfset newUrn=qUrn.SERIAL&"/"&DateFormat(now(),"YY")>
			<cfset thisUrn=newUrn>
			<cfset iNext=Int(qUrn.SERIAL)+1>
			<cfquery name="qUrn" datasource="#variables.warehouseDSN#">
				UPDATE browser_owner.INTELL_PACKAGE_SERIALS 
				 SET   SERIAL=<cfqueryparam value="#iNext#" cfsqltype="cf_sql_numeric" />				
				WHERE  YEAR = <cfqueryparam value="#DateFormat(now(),"YY")#" cfsqltype="cf_sql_numeric" />
			</cfquery>
			<cfset packageType="new">
		<cfelse>
			<cfset thisUrn=arguments.urn>
			<cfset packageType="update">
		</cfif>
		
		<cfif StructKeyExists(arguments.packageForm,'chkIncludeCrimes')>
			<cfloop list="#arguments.packageForm.chkIncludeCrimes#" index="crimeNo" delimiters=",">
				<cfset thisCrime=duplicate(variables.rolesXml)>
				<cfset thisCrime=replace(thisCrime,'%Role%',crimeNo)>
				<cfset incCrimeXml &= thisCrime>
				<cfset StructInsert(sReturn,'#Replace(crimeNo,"/","","ALL")#',REReplaceNoCase(createCrimeSummaryHTML(crimeNo),'<!DOCTYPE[^>[]*(\[[^]]*\])?>','','ALL'))>
			</cfloop>
		</cfif>
		
		<cfset thisPackageXml=Replace(thisPackageXml,'%Roles%',incCrimeXml)>
		
		<cfoutput>
			
			<cfdocument format="PDF" orientation="landscape" pagetype="A4" margintop="0.75" marginbottom="0.75" scale="95" name="nominalPdf">		
				<cfdocumentitem type="header" nominalDetails="#packageForm.nominalFullName# #packageForm.nominalRef#">	
				<!DOCTYPE html>
				<html>	
				 <head>
				 	<style>
				 		div {font-family:Arial, Helvetica, sans-serif; font-size:12pt}
				 	</style>
				 </head>		
				<body>
				 <div align="center">
				     <strong>RESTRICTED</strong>
				     <br><br>
				     <strong>WARWICKSHIRE POLICE AND WEST MERCIA POLICE - GENIE - #attributes.nominalDetails#</strong>
				 </div>
				</body>
				</html>				
				</cfdocumentitem>
				<cfdocumentitem type="footer" printedBy=#Session.LoggedInUser#>
				<!DOCTYPE html>	
				<html>	
				 <head>
				 	<style>
				 		div {font-family:Arial, Helvetica, sans-serif; font-size:12pt}
				 	</style>
				 </head>		
				<body>
				 <div align="center">
				     Created By #attributes.printedBy#. #DateFormat(now(),"DD/MM/YYYY")# #TimeFormat(now(),"HH:mm:ss")#
				     <br><br>
				     <strong>RESTRICTED</strong>
				 </div>
				</body>
				</html>										 
				</cfdocumentitem>
					
				<!DOCTYPE html>
				<html>
				<body>
				
				<style>
					body {font-family: Arial, Helvetica, sans-serif;}
					/* td {font-size:0.75em;} */
					ol {margin-top:1px, margin-bottom:0px;} 
					li {padding:1px;}
					.nominalData td {font-size:110%}
					.dataTitle {font-size:110%; font-weight:bold;}
					.warnings {color:red; font-weight:bold; font-size:110%}
				</style>
				
				<table height="835" width="100%" align="center">
					<tr>
						<td valign="middle">
							<h2 align="center">								
								WARWICKSHIRE POLICE AND WEST MERCIA POLICE<br><br><br>
								GENIE - INTELLIGENCE PACKAGE - #thisUrn#<br><br><br>
								#packageForm.nominalFullName# #packageForm.nominalDOB#<br><br>
							</h2>							
						</td>
					</tr>
					<tr>
						<td valign="bottom" align="center"><img src="/images/A4swoosh.jpg" width="1300" vspace="0"></td>
					</tr>
				</table>
				
				<cfdocumentitem type="pagebreak" />
				
				<!--- nominal basic details --->
				<h2 align="center">#packageForm.nominalFullName# #packageForm.nominalDOB#</h2>	
				<table width="95%" align="center">					
					<tr>
						<td width="65%" valign="top">
							<table width="100%" class="nominalData">
								<tr>
									<td width="25%"><b>Name</b></td>
									<td width="75%">#nominalFullName#</td>
								</tr>
								<tr>
									<td><b>Date of Birth</b></td>
									<td>#nominalDob#</td>									
								</tr>
								<tr>
									<td><b>GENIE Ref</b></td>
									<td>#nominalRef#</td>									
								</tr>				
								<tr>
									<td><b>PNC ID</b></td>
									<td>#nominalPNC#</td>									
								</tr>
								<tr>
									<td><b>CRO</b></td>
									<td>#nominalCRO#</td>									
								</tr>				
								<tr>
									<td><b>Sex</b></td>
									<td>#nominalSex#</td>									
								</tr>				
								<tr>
									<td><b>Height</b></td>
									<td>#nominalHeight#</td>									
								</tr>					
								<tr>
									<td><b>Weight</b></td>
									<td>#nominalWeight#</td>									
								</tr>					
								<tr>
									<td><b>Place of Birth</b></td>
									<td>#nominalPOB#</td>									
								</tr>																																						
							</table>
							<cfif StructKeyExists(arguments.packageForm,'chkIncludeWarnings')>
							<br>
							<div class="warnings">
							  WARNINGS:
							  <br>	
							  <cfloop list="#arguments.packageForm.chkIncludeWarnings#" index="warningDetail" delimiters=",">
							   <cfset thisWarning=duplicate(variables.warningXml)>
							   <cfset thisWarning=replace(thisWarning,'%Warning%',warningDetail)>
							   <cfset incWarningXml &= thisWarning>
							   <cfif iWarn GT 1>, </cfif>#ListGetAt(warningDetail,1,"|")# (#ListGetAt(warningDetail,2,"|",true)#)
							   <cfset iWarn++>							   
							  </cfloop>
							</div>	
							</cfif>
							<cfset thisPackageXml=Replace(thisPackageXml,"%Warnings%",incWarningXml)>
							
							<cfif StructKeyExists(arguments.packageForm,'txtWarningsFreeText')>
							  <cfif Len(arguments.packageForm.txtWarningsFreeText) GT 0>
							   <div class="warnings">	  
							   <cfif not StructKeyExists(arguments.packageForm,'chkIncludeWarnings')>
							   	<br>
							   	WARNINGS:
							    <br>	   
							   </cfif>
							   #arguments.packageForm.txtWarningsFreeText#
							   <cfset thisWarningText=arguments.packageForm.txtWarningsFreeText>
							  </cfif>
							</cfif>
							
							<cfset thisPackageXml=Replace(thisPackageXml,"%WarningsText%",thisWarningText)>

						<!--- do the aliases --->
						<cfif StructKeyExists(arguments.packageForm,'chkIncludeAlias')>
	                        <!---					
							<cfdocumentitem type="pagebreak" />
							---->
							<br>
							<div>
								<span class="dataTitle">ALIASES:</span>
								<br>						
								<cfloop list="#arguments.packageForm.chkIncludeAlias#" index="aliasDetail" delimiters=",">
								  <cfset thisAlias=duplicate(variables.aliasXml)>
							      <cfset thisAlias=replace(thisAlias,'%Alias%',aliasDetail)>
							      <cfset incAliasXml &= thisAlias>									
								 <cfif iAlias GT 1>, </cfif>
									#ListGetAt(aliasDetail,1,"|")#: <b>#ListGetAt(Replace(aliasDetail,"~",",","ALL"),3,"|",true)#</b> #ListGetAt(aliasDetail,4,"|",true)# (#ListGetAt(aliasDetail,2,"|",true)#)
								 <cfset iAlias++>
								</cfloop>									
							</div>
						</cfif>
						<cfset thisPackageXml=Replace(thisPackageXml,"%Aliases%",incAliasXml)>
							
						<!--- do the addresses --->
						<cfif StructKeyExists(arguments.packageForm,'chkIncludeAddresses')>
	                        <!---					
							<cfdocumentitem type="pagebreak" />
							---->
							<br>
							<div>
								<span class="dataTitle">ADDRESSES:</span>
								<br>						
								<cfloop list="#arguments.packageForm.chkIncludeAddresses#" index="addressDetail" delimiters=",">
								  <cfset thisAddress=duplicate(variables.addressXml)>
							      <cfset thisAddress=replace(thisAddress,'%Address%',addressDetail)>
							      <cfset incAddressXml &= thisAddress>										
									#ListGetAt(addressDetail,3,"|")#: <b>#ListGetAt(Replace(addressDetail,"~",",","ALL"),1,"|",true)#</b> (#ListGetAt(addressDetail,2,"|",true)#)<br>
								</cfloop>									
							</div>
						</cfif>
						
						<cfset thisPackageXml=Replace(thisPackageXml,"%Addresses%",incAddressXml)>
												
						<!--- do the telephone numbers --->					
						<cfif StructKeyExists(arguments.packageForm,'chkIncludeTelephones')>
							<!---						
							<cfdocumentitem type="pagebreak" />
							--->
							<br>
							<div>
							  <span class="dataTitle">TELEPHONE NUMBERS:</span>
							  <br>
							<cfloop list="#arguments.packageForm.chkIncludeTelephones#" index="telDetail" delimiters=",">
								  <cfset thisTelephone=duplicate(variables.telephoneXml)>
							      <cfset thisTelephone=replace(thisTelephone,'%Telephone%',telDetail)>
							      <cfset incTelephoneXml &= thisTelephone>									
								<b>#ListGetAt(telDetail,1,"|",true)#</b> (#ListGetAt(telDetail,2,"|",true)#)<br>
							</cfloop>	
							</div>	
						</cfif>
						
						<cfset thisPackageXml=Replace(thisPackageXml,"%Telephones%",incTelephoneXml)>
						
						<!--- do the vehicles --->					
						<cfif StructKeyExists(arguments.packageForm,'chkIncludeVehicles')>
						    <!---
							<cfdocumentitem type="pagebreak" />
							--->
							<br>
							<div>
							<span class="dataTitle">VEHICLES:</span>
							<br>
							<cfloop list="#arguments.packageForm.chkIncludeVehicles#" index="vehDetail" delimiters=",">
								<cfset thisVehicle=duplicate(variables.vehicleXml)>
							    <cfset thisVehicle=replace(thisVehicle,'%Vehicle%',vehDetail)>
							    <cfset incVehicleXml &= thisVehicle>	
								<b>#iif(Len(ListGetAt(vehDetail,6,"|",true)) GT 0,de(ListGetAt(vehDetail,6,"|",true)&':'),de(''))# #ListGetAt(vehDetail,1,"|",true)#</b> #ListGetAt(vehDetail,3,"|",true)# #ListGetAt(vehDetail,4,"|",true)# #ListGetAt(vehDetail,5,"|",true)# (#ListGetAt(vehDetail,2,"|",true)#)<br>
							</cfloop>	
							</div>	
						</cfif>
						
						<cfset thisPackageXml=Replace(thisPackageXml,"%Vehicles%",incVehicleXml)>									
						
						</td>
						<td width="3%">&nbsp;</td>
						<td width="32%" valign="top">
						 <div align="center">	
							<img src="#packageForm.nominalPhoto#" height="400">							
							<cfif len(packageForm.nominalPhotoDate) GT 0>
							<br><br>
							Date Taken: <b>#packageForm.nominalPhotoDate#</b>
							</cfif>
						 </div>
						</td>
					</tr>
					
				</table>				
				
				
				<!--- put a list of crime reports page out --->
				<cfif StructKeyExists(arguments.packageForm,'chkIncludeCrimes')>
				
				    <cfdocumentitem type="pagebreak" />
					<!--- output the crime reports page --->
					<h2>CRIME REPORTS</h2>
					<ol type="1">
					<cfloop list="#arguments.packageForm.chkIncludeCrimes#" index="crimeNo" delimiters=",">
						<li>#crimeNo#</li>
					</cfloop>	
					</ol>
					
				    <cfif StructKeyExists(arguments.packageForm,'txtRolesFreeText')>
					 <cfif Len(arguments.packageForm.txtRolesFreeText) GT 0>
					  <cfdocumentitem type="pagebreak" />					  
					  <h2>Roles Further Information</h2>	
					  #arguments.packageForm.txtRolesFreeText#
					  <cfset thisCrimeText=arguments.packageForm.txtRolesFreeText>
					 </cfif>
					</cfif>			
					
					<cfset thisPackageXml=Replace(thisPackageXml,"%RolesFreeText%",thisCrimeText)>	
				
				    <cfdocumentitem type="pagebreak" />
					<!--- do the crime reports --->
				
					<cfset lisCrimesOutput="">
					<cfloop list="#arguments.packageForm.chkIncludeCrimes#" index="crimeNo" delimiters=",">
					  <cfif listFind(lisCrimesOutput,crimeNo,",") IS 0>	
						  <cfif iCrime GT 1>
						  	  <cfdocumentitem type="pagebreak" />
						  </cfif>
						  #REReplaceNoCase(createCrimeSummaryHTML(crimeNo),'<!DOCTYPE[^>[]*(\[[^]]*\])?>','','ALL')#
						  <cfset iCrime++>
						  <cfset lisCrimesOutput=listAppend(lisCrimesOutput,crimeNo,",")>  
					  </cfif>
					</cfloop>
				</cfif>
				
				<!--- put a list of intel reports page out --->
				<cfif StructKeyExists(arguments.packageForm,'chkIncludeIntel')>
				
				    <cfdocumentitem type="pagebreak" />
					<!--- output the intel reports page --->
					<h2>INTELLIGENCE LOGS</h2>
					<ol type="1">
					<cfloop list="#arguments.packageForm.chkIncludeIntel#" index="intelLogRef" delimiters=",">
						<cfset thisIntel=duplicate(variables.intelXml)>
					    <cfset thisIntel=replace(thisIntel,'%Intel%',intelLogRef)>
					    <cfset incIntelXml &= thisIntel>	
						<cfif Int(ListGetAt(intelLogRef,2,"|")) LT minSal>
						  <cfset minSal=Int(ListGetAt(intelLogRef,2,"|"))>
						</cfif>
						<li>#intelLogRef#</li>
					</cfloop>	
					</ol>	
					
					<cfset thisPackageXml=Replace(thisPackageXml,"%Intels%",incIntelXml)>
					
				    <cfif StructKeyExists(arguments.packageForm,'txtIntelFreeText')>
				     <cfif Len(arguments.packageForm.txtIntelFreeText) GT 0>
					  <cfdocumentitem type="pagebreak" />
					  <h2>Intelligence Further Information</h2>						
					  #arguments.packageForm.txtIntelFreeText#
					  <cfset thisIntelText=arguments.packageForm.txtIntelFreeText>
					 </cfif>
					</cfif>	
					
					<cfset thisPackageXml=Replace(thisPackageXml,"%IntelFreeText%",thisIntelText)>		
				
				    <cfdocumentitem type="pagebreak" />
					<!--- do the intelligence reports --->				    
					<cfloop list="#arguments.packageForm.chkIncludeIntel#" index="intelLogRef" delimiters=",">
					  <cfif iIntel GT 1>
					  	  <cfdocumentitem type="pagebreak" />
					  </cfif>					  
					  #REReplaceNoCase(createIntelHTML(ListGetAt(intelLogRef,1,"|")),'<!DOCTYPE[^>[]*(\[[^]]*\])?>','','ALL')#
					  <cfset iIntel++>					  
					</cfloop>
				</cfif>				
				
				<!--- do the associates --->					
				<cfif StructKeyExists(arguments.packageForm,'chkIncludeAssociates')>
				    
					<cfdocumentitem type="pagebreak" />
					<h2>ASSOCIATES</h2>
					<br>
					<cfif not isDefined('chkAssociatesLongView')>
					<cfloop list="#arguments.packageForm.chkIncludeAssociates#" index="assocDetail" delimiters=",">
						<cfset thisAssociate=duplicate(variables.associateXml)>
					    <cfset thisAssociate=replace(thisAssociate,'%Associate%',assocDetail)>
					    <cfset incAssociateXml &= thisAssociate>	
						#ListGetAt(assocDetail,1,"|",true)#: <b>#Replace(ListGetAt(assocDetail,3,"|",true),"~",",","ALL")# #ListGetAt(assocDetail,4,"|",true)#</b> (#ListGetAt(assocDetail,2,"|",true)#) #ListGetAt(assocDetail,5,"|",true)#<br>
					</cfloop>							
					<cfelse>
					<cfset var incAssocPhotoWarn=true>	
                    <cfset iAssoc=0>				
                    <table width="100%">
                    <tr>
					<cfloop list="#arguments.packageForm.chkIncludeAssociates#" index="assocDetail" delimiters=",">
					<cfif iAssoc MOD 2 IS 0>
						</tr>
						<tr>
					</cfif>
					<td width="50%" valign="top" style="height:375px;">
					<div style="border:1px solid black; width:400px; height:365px; margin:5px; padding:5px; float:left;">
						<b>#ListGetAt(assocDetail,1,"|",true)#: <b>#Replace(ListGetAt(assocDetail,3,"|",true),"~",",","ALL")# #ListGetAt(assocDetail,4,"|",true)#</b><cfif ListGetAt(assocDetail,9,"|",true) IS "Y"> *** DECEASED ***</cfif><br>
						<div style="width:130px;text-align:center">
						<cfif Len(ListGetAt(assocDetail,7,"|",true)) GT 0>
						<img src="#ListGetAt(assocDetail,7,"|",true)#" width="125">
						#ListGetAt(assocDetail,8,"|",true)#
						<cfelse>
						No Photo
						</cfif>
						</div>						
						<cfif Len(ListGetAt(assocDetail,6,"|",true)) GT 0>						
						<div class="warnings">
						WARNINGS: #Replace(ListGetAt(assocDetail,6,"|",true),"<br>",", ","ALL")#
						</div>	
					    </cfif>
					</div>
					</td>
					 <cfset iAssoc++>
					</cfloop>
					</tr>
					</table>
					</cfif>
				</cfif>	
				
				<cfset thisPackageXml=Replace(thisPackageXml,"%Associates%",incAssociateXml)>
				<cfset thisPackageXml=Replace(thisPackageXml,"%AssociateIncludeWarningPhoto%",incAssocPhotoWarn)>
				
		        <cfif StructKeyExists(arguments.packageForm,'txtOtherText')>
					<cfif Len(arguments.packageForm.txtOtherText) GT 0>
					  <cfdocumentitem type="pagebreak" />
					  <h2>Other Information</h2>						
					  #arguments.packageForm.txtOtherText#
					  <cfset thisOtherText=arguments.packageForm.txtOtherText>
					</cfif>
				</cfif>	
				
				<cfset thisPackageXml=Replace(thisPackageXml,"OtherText",thisOtherText)>
				
				</body>
				</html>
			</cfdocument>
		</cfoutput>
		
		<cfif packageType IS "new">					
			<cfquery name="qInsert" datasource="#variables.warehouseDSN#">
				INSERT INTO browser_owner.INTELL_PACKAGES
				(
				  URN,
				  YEAR,
				  SERIAL_NO,
				  NOMINAL_REF,
				  HIGHEST_SAL,
				  CREATED_BY,
				  CREATED_BY_NAME,
				  CREATED_DATE,
				  COVERT,
				  VERSION,
				  AVAILABLE_TO_ALL,
				  XML				  
				)
				VALUES
				(
				 <cfqueryparam value="#newUrn#" cfsqltype="cf_sql_varchar" />,
				 <cfqueryparam value="#ListGetAt(newUrn,2,"/")#" cfsqltype="cf_sql_numeric" />,
				 <cfqueryparam value="#ListGetAt(newUrn,1,"/")#" cfsqltype="cf_sql_numeric" />,
				 <cfqueryparam value="#nominalRef#" cfsqltype="cf_sql_varchar" />,
				 <cfqueryparam value="#minSal#" cfsqltype="cf_sql_numeric" />,
				 <cfqueryparam value="#session.user.getTrueUserId()#" cfsqltype="cf_sql_varchar" />,
				 <cfqueryparam value="#session.user.getFullName()#" cfsqltype="cf_sql_varchar" />,
				 SYSDATE,
				 'N',
				 1,
				 'Y',
				 <cfqueryparam value="#thisPackageXml#" cfsqltype="cf_sql_clob" />  
				)
			</cfquery>
			
		<cfelse>
			<!--- update to an existing package --->
		</cfif>
				
		<cfreturn nominalPdf>
		
	</cffunction>
    
    <cffunction name="createCrimeSummaryHTML" access="public" returntype="string">
		<cfargument name="crimeNo" type="string" required="true" hint="crime no of crime to get summary for. Format 22DA/12345A/14">
		
		<cfset var crimeHtml=''>
		<cfset var qCrime=''>
		<cfset var transformFile=variables.transformsDir&"\crimedoc_summary.xsl">
		<cfset var xmlFile=''>
		<cfset var qSnt=''>
		<cfset var sSnt=''>
		<cfset var lisReplaceChars="#chr(0)#,#chr(1)#,#chr(3)#,#chr(4)#,#chr(5)#,#chr(6)#,#chr(7)#,#chr(14)#,#chr(15)#,#chr(16)#,#chr(17)#,#chr(18)#,#chr(19)#,#chr(20)#,#chr(21)#,#chr(22)#,#chr(23)#,#chr(24)#,#chr(25)#,#chr(26)#,#chr(27)#,#chr(28)#,#chr(29)#,#chr(30)#,#chr(31)#">
		<cfset var lisReplaceWith=" , , , , , , , , , , , , , , , , , , , , , , , , ">
		<cfset var theXml=''>
		<cfset var xmldoc=''>		
		<cfset var parameters=structNew()>
  		
  		<cfset parameters['transformPath']=application.str_Transforms>
		
		<!--- get the crime data required to work out where the xml document is --->
		<cfquery name="qCrime" datasource="#variables.WarehouseDSN#">
		SELECT CRIME_REF, TO_CHAR(CREATED_DATE,'DD') AS REC_DAY, TO_CHAR(CREATED_DATE,'MM') AS REC_MON, 
		       TO_CHAR(CREATED_DATE,'YYYY') AS REC_YEAR, STATUS, LPA
		FROM browser_owner.OFFENCE_SEARCH		
		WHERE ORG_CODE=<cfqueryparam value="#ListGetAt(arguments.crimeNo,1,"/")#" cfsqltype="cf_sql_varchar">
		AND  SERIAL_NO=<cfqueryparam value="#ListGetAt(arguments.crimeNo,2,"/")#" cfsqltype="cf_sql_varchar">
		AND  YEAR=<cfqueryparam value="#Int(ListGetAt(arguments.crimeNo,3,"/"))#" cfsqltype="cf_sql_integer">		
		</cfquery>

		<!--- if the LPA is available then work out the SNT to display --->
		<cfset sSnt="">
		  <cfif qCrime.recordCount GT 0>
			<cfif Len(qCrime.LPA) GT 0>
				<cfquery name="qSNT" datasource="#variables.WarehouseDSN#">
				SELECT SNT_NAME||' (' || SNT_CODE || ')' AS SNT
				FROM   browser_owner.SNT_LOOKUP
				WHERE  LPT_CODES LIKE '%#qCrime.LPA#%'	
				</cfquery>
				<cfif qSNT.recordCount GT 0>
					<cfset sSnt=qSNT.SNT>
				</cfif>
			</cfif>
		  </cfif>	
		  
		<!--- locate the xml file --->
		<cfset xmlFile="#variables.crimePath#\#qCrime.REC_YEAR#\#qCrime.REC_MON#\#qCrime.REC_DAY#\#Replace(qCrime.Crime_Ref,"/","_","ALL")#.xml">	
		
		<!--- if it exists then read it, strip bad chars, parse it and apply the xslt--->
		<cfif fileExists(xmlFile)>
			<cffile action="read" file="#xmlFile#" charset="utf-8" variable="theXml">
			<cfset theXml=ReplaceList(theXml,lisReplaceChars,lisReplaceWith)>			
			<cfset xmldoc=XmlParse(theXml)>			 		
		    <cfset crimeHtml=XmlTransform(xmldoc, transformFile, parameters)>
			<!--- update the crime status with a value from the table --->
			<cfset crimeHtml=Replace(crimeHtml,"*** CRIME_STATUS ***",qCrime.STATUS)>

			<!--- update the SNT info ---> 
			<cfset crimeHtml=Replace(crimeHtml,"*** SNT ***",sSnt)>
		</cfif>
				
		<cfreturn crimeHtml>
		
	</cffunction>   

    <cffunction name="createIntelHTML" access="public" returntype="string">
		<cfargument name="logNo" type="string" required="true" hint="log no to get html for">
		
		<cfset var intelHtml=''>
		<cfset var qIntel=''>
		<cfset var transformHeaderFile=variables.transformsDir&"\intel_doc_header.xsl">
		<cfset var transformBodyFile=variables.transformsDir&"\intel_doc_body.xsl">
		<cfset var xmlFile=''>		
		<cfset var lisReplaceChars="#chr(0)#,#chr(1)#,#chr(3)#,#chr(4)#,#chr(5)#,#chr(6)#,#chr(7)#,#chr(14)#,#chr(15)#,#chr(16)#,#chr(17)#,#chr(18)#,#chr(19)#,#chr(20)#,#chr(21)#,#chr(22)#,#chr(23)#,#chr(24)#,#chr(25)#,#chr(26)#,#chr(27)#,#chr(28)#,#chr(29)#,#chr(30)#,#chr(31)#">
		<cfset var lisReplaceWith=" , , , , , , , , , , , , , , , , , , , , , , , , ">
		<cfset var theXml=''>
		<cfset var xmldoc=''>		
		
		<cfquery name="qIntel" datasource="#variables.WarehouseDSN#">
		SELECT TO_CHAR(DATE_CREATED,'YYYY') AS INTEL_YEAR, TO_CHAR(DATE_CREATED,'MM') AS INTEL_MONTH,
		            TO_CHAR(DATE_CREATED,'DD') AS INTEL_DAY, SECURITY_ACCESS_LEVEL
		FROM BROWSER_OWNER.INTELL_SEARCH
		WHERE LOG_REF=<cfqueryparam value="#arguments.logNo#" cfsqltype="cf_sql_integer">			
		</cfquery>

		<cfif qIntel.SECURITY_ACCESS_LEVEL IS 99>
			<cfset xmlFile=variables.intelPath&"\"&qIntel.INTEL_YEAR&"\"&qIntel.INTEL_MONTH&"\"&qIntel.INTEL_DAY&"\"&arguments.logNo&".xml">
		<cfelse>
			<cfset xmlFile=variables.intelB99Path&"\"&qIntel.INTEL_YEAR&"\"&qIntel.INTEL_MONTH&"\"&qIntel.INTEL_DAY&"\"&arguments.logNo&".xml">
		</cfif>	
		
		<!--- if it exists then read it, strip bad chars, parse it and apply the xslt--->
		<cfif fileExists(xmlFile)>
			<cffile action="read" file="#xmlFile#" charset="utf-8" variable="theXml">
			<cfset theXml=ReplaceList(theXml,lisReplaceChars,lisReplaceWith)>			
			<cfset xmldoc=XmlParse(theXml)>	
					 		
		    <cfset intelHtml  =XmlTransform(xmldoc, transformHeaderFile)>
			<cfset intelHtml &="<hr>">
			<cfset intelHtml &=XmlTransform(xmldoc, transformBodyFile)>				
				
		</cfif>
				
		<cfreturn intelHtml>
		
	</cffunction>     
    
</cfcomponent>