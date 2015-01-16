<cfcomponent output="false">
    
    <cffunction name="init" access="public" returntype="any" hint="Constructor.">  
        <cfargument name="warehouseDSN" required="true" type="String">
        <cfargument name="warehouseDSN2" required="true" type="String">        
        <cfargument name="warehouseUID" required="true" type="String">
        <cfargument name="warehousePWD" required="true" type="String">
        <cfargument name="genieImageDir" required="true" type="String">      
        <cfargument name="genieImagePath" required="true" type="String">
        <cfargument name="rispImageRequestHeader" required="true" type="String">
        <cfargument name="rispURL" required="true" type="String">        
        <cfargument name="rispPort" required="true" type="String">                
        <cfargument name="rispSoapAction" required="true" type="String"> 
        <cfargument name="wMidsTimeout" required="true" type="String">  
                                                
        <cfset variables.warehousedsn=arguments.warehousedsn>
        <cfset variables.warehousedsn2=arguments.warehousedsn2>        
        <cfset variables.warehouseUID=arguments.warehouseUID>
        <cfset variables.warehousePWD=arguments.warehousePWD>      
        <cfset variables.genieImageDir=arguments.genieImageDir>  
        <cfset variables.genieImagePath=arguments.genieImagePath>   
        <cfset variables.rispImageRequestHeader=arguments.rispImageRequestHeader>                           
        <cfset variables.rispURL=arguments.rispURL>
        <cfset variables.rispPort=arguments.rispPort>
        <cfset variables.rispSoapAction=arguments.rispSoapAction>
        <cfset variables.wMidsTimeout=arguments.wMidsTimeout>   
           
        <cfreturn this />  
    </cffunction>     


	<cffunction name="read" output="false" access="public" returntype="genieObj.nominal.photo">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">

		<cfquery name="qRead" datasource="#variables.warehouseDSN2#">
			select 	RISK_REF, NOMINAL_REF, DATE_MARKED, WSC_CODE, WSC_DESC, WS_NOTE
					
			from BROWSER_OWNER.GE_WARNINGS
			where RISK_REF = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#arguments.id#" />
		</cfquery>

		<cfscript>
			obj = createObject("component", "GE_WARNINGS").init();
			obj.setRISK_REF(qRead.RISK_REF);
			obj.setNOMINAL_REF(qRead.NOMINAL_REF);
			obj.setDATE_MARKED(qRead.DATE_MARKED);
			obj.setWSC_CODE(qRead.WSC_CODE);
			obj.setWSC_DESC(qRead.WSC_DESC);
			obj.setWS_NOTE(qRead.WS_NOTE);
			return obj;
		</cfscript>
	</cffunction>
    
    <cffunction name="getNominalLatestPhotoForSearch" output="false" access="public" returntype="struct" hint="returns the latest photo record for a nominal and it's date. 2 arrays in a struct">
      <cfargument name="qNoms" required="true" type="query" hint="query containing a list of nominals with NOMINAL_REF column">
      
      <cfset var photoStruct=StructNew()>
       
      <cfset var lisNominals=ValueList(arguments.qNoms.NOMINAL_REF)>
      <cfset var qCustPhoto="">	  
      <cfset var iNom="">	  
      <cfset var sYear="">
      <cfset var sStation="">
      <cfset var sSystem="">
      <cfset var sFilename="">
	  <cfset var thisNomRef="">
	  <cfset var arrPos="">  
	    
	  <cfset var totStart="">
	  <cfset var totEnd="">  
	    
	  <cfset var q1Start="">
	  <cfset var q1End="">	    
	    
	  <cfset var structStart="">
	  <cfset var structEnd="">                  
           
     <cfset totStart=getTickCount()>     
      
      <!--- query for all warnings on nominals in list --->
	  <cfset q1Start=getTickCount()>
      <cfquery name="qCustPhoto" datasource="#variables.warehouseDSN#">
	    SELECT df.AS_REF, NVL(DATE_PHOTO_AND_FPRINTS,CREATION_DATE) AS DATE_TAKEN,NOMINAL_REF, df.AS_NUM, df.PHOTO_AVAILABLE, to_blob('') AS PHOTO, 0 AS SEQ_NO, '' AS SYSTEM_ID
	    FROM   common_owner.DEF_ARRESTS df
	    WHERE  NOMINAL_REF IN (<cfqueryparam value="#lisNominals#" cfsqltype="cf_sql_varchar" list="true">)	 
	    AND    PHOTO_AVAILABLE=<cfqueryparam value="Y" cfsqltype="cf_sql_varchar">
	    AND    NVL(DATE_PHOTO_AND_FPRINTS,CREATION_DATE) = (   SELECT MAX(NVL(DATE_PHOTO_AND_FPRINTS,CREATION_DATE))
						                                         FROM   common_owner.DEF_ARRESTS df1
															     WHERE  NOMINAL_REF=df.NOMINAL_REF
															     AND    PHOTO_AVAILABLE=<cfqueryparam value="Y" cfsqltype="cf_sql_varchar">)    
        UNION ALL
        SELECT '' AS AS_REF, PHOTO_DATE AS DATE_TAKEN, NOMINAL_REF, '' AS AS_NUM, 'Y' AS PHOTO_AVAILABLE, PHOTO, SEQ_NO, SYSTEM_ID
		FROM   browser_owner.NOMINAL_PHOTOS np1
		WHERE  NOMINAL_REF IN (<cfqueryparam value="#lisNominals#" cfsqltype="cf_sql_varchar" list="true">)
		AND    PHOTO_DATE = (   SELECT MAX(PHOTO_DATE)
							    FROM   browser_owner.NOMINAL_PHOTOS np2
							    WHERE  np2.NOMINAL_REF=np1.NOMINAL_REF
	                         )
		order by 3,2 desc   
      </cfquery>
      <cfset q1End=getTickCount()>
	  <cflog file="geniePersonWebService" type="information" text="photoDAO q = #q1End-q1Start# ms" />
	  
	  <cfset structStart=getTickCount()>
	    
 		<cfset photoStruct.photoUrls=arrayNew(1)>
	    <cfset photoStruct.photoDates=arrayNew(1)>
	    
	    <cfloop from="1" to="#ListLen(lisNominals,",")#" index="iNom">
		  <cfset photoStruct.photoUrls[iNom]="">
		  <cfset photoStruct.photoDates[iNom]="">	  
	    </cfloop>    
	  
	    <cfset thisNomRef="">
 	    <cfloop query="qCustPhoto">
	  	  <cfif thisNomRef IS NOT NOMINAL_REF>	 	 
			 <cfset arrPos=ListFind(lisNominals,NOMINAL_REF,",")>
			 <cfset photoStruct.photoDates[arrPos]=DateFormat(DATE_TAKEN,"DD/MM/YYYY")>
			 <cfset thisNomRef=NOMINAL_REF>
			 
			 <!--- West Mercia Custody Photo --->			 
			 <cfif Len(AS_REF) GT 0>			 	 
			 	<cfset sYear=ListGetAt(AS_REF,1,"/")>
				<cfset sStation=ListGetAt(AS_REF,2,"/")>
			    <cfset sSystem=ListGetAt(AS_REF,3,"/")>
			    <cfset sFilename=sYear&sStation&sSystem&"_"&ListGetAt(AS_REF,4,"/")&".jpg">				
				<cfset photoStruct.photoUrls[arrPos]=variables.genieImageDir&sYear&"/"&sStation&"/"&sSystem&"/"&sFilename>			 	 
			 <cfelse>			 	 
			 <!--- Other Force or VISOR custody photo --->
			 	<cfif Len(PHOTO) GT 0>								
				<cftry>				     
		         <cfscript>		
		            addImage=ImageNew(PHOTO);
		            imageFilename="#variables.genieImagePath#additional\#NOMINAL_REF#_#SEQ_NO#_#SYSTEM_ID#.jpg";
		            if (!fileExists(imageFilename))
						ImageWrite(addImage,imageFilaname,"0.8");	
		         </cfscript>
		         <cfset photoStruct.photoUrls[arrPos]="#variables.genieImageDir#additional/#NOMINAL_REF#_#SEQ_NO#_#SYSTEM_ID#.jpg">				
				 <cfcatch type="any">
				   <cflog file="duffVisorImages" type="information" text="Duff Image nominalRef=#NOMINAL_REF# seqNo=#SEQ_NO# sysId=#SYSTEM_ID#"> 	 
				 </cfcatch>
				</cftry>				 	
			 </cfif>   
			 	 
			 </cfif>
			 	 	 
		 </cfif>
	  </cfloop>	    
	    
      <cfset structEnd=getTickCount()>
	  <cflog file="geniePersonWebService" type="information" text="Struct = #structEnd-structStart# ms" />
	    
      <cfset totEnd=getTickCount()>
	  <cflog file="geniePersonWebService" type="information" text="Photo DAO Total = #totENd-totStart# ms" />  
      
      <cfreturn photoStruct>
      
    </cffunction>

    <cffunction name="getLatestNominalPhoto" output="false" access="public" returntype="genieObj.nominal.photo" hint="returns the latest photo obj for a nominal">
      <cfargument name="nominalRef" required="true" type="string" hint="nominal ref to get photo info for">
      
      <cfset var qPhoto="">
      <cfset var qCustPhoto="">
      <cfset var qAddPhoto="">
      <cfset var photo=createObject("component","genieObj.nominal.photo").init()>
      <cfset var sYear="">
      <cfset var sStation="">
      <cfset var sSystem="">
      <cfset var sFilename="">    
      <cfset var addPhoto="">
      <cfset var iPhoto=0>      
            
      <!--- query for all warnings on nominals in list --->
      <cfquery name="qCustPhoto" datasource="#variables.warehouseDSN#">
	     SELECT df.AS_REF, NVL(DATE_PHOTO_AND_FPRINTS,CREATION_DATE) AS DATE_TAKEN,NOMINAL_REF, df.AS_NUM, df.PHOTO_AVAILABLE
	     FROM   common_owner.DEF_ARRESTS df
	     WHERE  NOMINAL_REF = <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">	 
	     AND    PHOTO_AVAILABLE=<cfqueryparam value="Y" cfsqltype="cf_sql_varchar">
	     AND    NVL(DATE_PHOTO_AND_FPRINTS,CREATION_DATE) = (   SELECT MAX(NVL(DATE_PHOTO_AND_FPRINTS,CREATION_DATE))
						                                         FROM   common_owner.DEF_ARRESTS df1
															     WHERE  NOMINAL_REF=df.NOMINAL_REF
															     AND    PHOTO_AVAILABLE=<cfqueryparam value="Y" cfsqltype="cf_sql_varchar">)    
      </cfquery>

      <!--- get all additional photos for the nominal --->
 	  <cfquery name="qAddPhoto" datasource="#variables.WarehouseDSN#">
		SELECT *
		FROM   browser_owner.NOMINAL_PHOTOS np1
		WHERE  NOMINAL_REF = <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
		AND    PHOTO_DATE = (   SELECT MAX(PHOTO_DATE)
							    FROM   browser_owner.NOMINAL_PHOTOS np2
							    WHERE  np2.NOMINAL_REF=np1.NOMINAL_REF
	                         )	
		order by nominal_ref
	  </cfquery>
            
      <cfset qPhoto=QueryNew('AS_NUM,AS_REF,NOMINAL_REF,DATE_TAKEN,PHOTO_AVAILABLE,PHOTO_URL,SYSTEM_ID','varchar,varchar,varchar,date,varchar,varchar,varchar')>
      
      <cfset iPhoto=1>
      <cfif qCustPhoto.recordCount GT 0>
		<cfscript>
	        sYear=ListGetAt(qCustPhoto.AS_REF,1,"/");
			sStation=ListGetAt(qCustPhoto.AS_REF,2,"/");
			sSystem=ListGetAt(qCustPhoto.AS_REF,3,"/");
			sFilename=sYear&sStation&sSystem&"_"&ListGetAt(qCustPhoto.AS_REF,4,"/")&".jpg";
            
            QueryAddRow(qPhoto,1);
            QuerySetCell(qPhoto,'AS_NUM',qCustPhoto.AS_NUM,iPhoto);
            QuerySetCell(qPhoto,'AS_REF',qCustPhoto.AS_REF,iPhoto);
            QuerySetCell(qPhoto,'NOMINAL_REF',qCustPhoto.NOMINAL_REF,iPhoto);
            QuerySetCell(qPhoto,'DATE_TAKEN',qCustPhoto.DATE_TAKEN,iPhoto);
            QuerySetCell(qPhoto,'PHOTO_AVAILABLE',qCustPhoto.PHOTO_AVAILABLE,iPhoto);                                                
            QuerySetCell(qPhoto,'PHOTO_URL',variables.genieImageDir&sYear&"/"&sStation&"/"&sSystem&"/"&sFilename,iPhoto);                                                
            QuerySetCell(qPhoto,'SYSTEM_ID','CUSTODY',iPhoto);   
            
            iPhoto++;                                                                                 
		</cfscript>        
      </cfif>
      
      <cfif qAddPhoto.recordCount GT 0>	   	  
	   <cfif Len(qAddPhoto.PHOTO) GT 0>     	
	   	 <cftry>
         <cfscript>            
            addImage=ImageNew(qAddPhoto.PHOTO);
			ImageWrite(addImage,"#variables.genieImagePath#\additional\#qAddPhoto.NOMINAL_REF#_#qAddPhoto.SEQ_NO#_#qAddPhoto.SYSTEM_ID#.jpg","0.8");				
            QueryAddRow(qPhoto,1);
            QuerySetCell(qPhoto,'AS_NUM','',iPhoto);
            QuerySetCell(qPhoto,'AS_REF','',iPhoto);
            QuerySetCell(qPhoto,'NOMINAL_REF',qAddPhoto.NOMINAL_REF,iPhoto);
            QuerySetCell(qPhoto,'DATE_TAKEN',qAddPhoto.PHOTO_DATE,iPhoto);
            QuerySetCell(qPhoto,'PHOTO_AVAILABLE','Y',iPhoto);                                                
            QuerySetCell(qPhoto,'PHOTO_URL','#variables.genieImageDir#additional/#qAddPhoto.NOMINAL_REF#_#qAddPhoto.SEQ_NO#_#qAddPhoto.SYSTEM_ID#.jpg',iPhoto);                                                
            QuerySetCell(qPhoto,'SYSTEM_ID',qAddPhoto.SYSTEM_ID,iPhoto);   			 
           iPhoto++;
         </cfscript>
         <cfcatch type="any">
		   <cflog file="duffVisorImages" type="information" text="Duff Image nominalRef=#arguments.nominalRef# seqNo=#qAddPhoto.SEQ_NO# sysId=#qAddPhoto.SYSTEM_ID#"> 	 
		 </cfcatch>
		</cftry>             
	   </cfif>	   
      </cfif>    
      
      <!--- order all the photos by the date taken --->
      <cfquery name="qPhoto" dbtype="query">
       SELECT    *
       FROM      qPhoto
       ORDER BY  DATE_TAKEN DESC
      </cfquery>              

      <!--- --->
      <cfif qPhoto.RecordCount GT 0>
        
		<cfscript>
			photo.setAS_NUM(qPhoto.AS_NUM);
			photo.setAS_REF(qPhoto.AS_REF);
			photo.setNOMINAL_REF(qPhoto.NOMINAL_REF);
			photo.setCREATION_DATE(qPhoto.DATE_TAKEN);
			photo.setPHOTO_AVAILABLE(qPhoto.PHOTO_AVAILABLE);
			photo.setPHOTO_URL(qPhoto.PHOTO_URL);
			photo.setSYSTEM_ID(qPhoto.SYSTEM_ID);			
		</cfscript>        
      
	  <cfelse>
	  
	    <cfset photo.setPHOTO_URL(variables.genieImageDir&'noimage.gif')>
	
      </cfif>     
    
      <cfreturn photo>
      
    </cffunction>
    
    <cffunction name="getNominalPhotos" output="false" access="public" returntype="genieObj.nominal.photo[]" hint="returns array of nominal photos">
      <cfargument name="nominalRef" required="true" type="string" hint="nominal ref to get photo info for">
	  <cfargument name="photoFilter" required="false" default="ALL" type="string" hint="ALL,CUSTODY OR VISOR">  
      
      <cfset var qCustPhoto="">
      <cfset var qAddPhoto="">
      <cfset var qPhoto="">            
      <cfset var photo=createObject("component","genieObj.nominal.photo").init()>
      <cfset var photos=ArrayNew(1)>
      <cfset var sYear="">
      <cfset var sStation="">
      <cfset var sSystem="">
      <cfset var sFilename="">
      <cfset var iPhoto=0>      
      <cfset var addImage="">    
      
      <cfset qPhoto=QueryNew('AS_NUM,AS_REF,NOMINAL_REF,DATE_TAKEN,PHOTO_AVAILABLE,PHOTO_URL,SYSTEM_ID','varchar,varchar,varchar,date,varchar,varchar,varchar')>
            
      <!--- query for all custody photos for the nominal--->
      <cfquery name="qCustPhoto" datasource="#variables.warehouseDSN#">
	     SELECT df.AS_REF, NVL(DATE_PHOTO_AND_FPRINTS,CREATION_DATE) AS DATE_TAKEN,NOMINAL_REF, df.AS_NUM, df.PHOTO_AVAILABLE
	     FROM   common_owner.DEF_ARRESTS df
	     WHERE  NOMINAL_REF = <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">	 
	     AND    PHOTO_AVAILABLE=<cfqueryparam value="Y" cfsqltype="cf_sql_varchar">
         order by NVL(DATE_PHOTO_AND_FPRINTS,CREATION_DATE)  DESC               
      </cfquery>
      
      <!--- get all additional photos for the nominal --->
 	  <cfquery name="qAddPhoto" datasource="#variables.WarehouseDSN#">
		SELECT *
		FROM   browser_owner.NOMINAL_PHOTOS np1
		WHERE  NOMINAL_REF = <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
		order by PHOTO_DATE DESC
	  </cfquery>	      


      <cfset iPhoto=1>
	    
	  <cfif arguments.photoFilter IS "ALL" OR arguments.photoFilter IS "CUSTODY">
	      <!--- create the query with the custody photos first --->
	      <cfif qCustPhoto.RecordCount GT 0>
	       <cfloop query="qCustPhoto">
			<cfscript>
		        sYear=ListGetAt(qCustPhoto.AS_REF,1,"/");
				sStation=ListGetAt(qCustPhoto.AS_REF,2,"/");
				sSystem=ListGetAt(qCustPhoto.AS_REF,3,"/");
				sFilename=sYear&sStation&sSystem&"_"&ListGetAt(qCustPhoto.AS_REF,4,"/")&".jpg";
	            
	            QueryAddRow(qPhoto,1);
	            QuerySetCell(qPhoto,'AS_NUM',AS_NUM,iPhoto);
	            QuerySetCell(qPhoto,'AS_REF',AS_REF,iPhoto);
	            QuerySetCell(qPhoto,'NOMINAL_REF',NOMINAL_REF,iPhoto);
	            QuerySetCell(qPhoto,'DATE_TAKEN',DATE_TAKEN,iPhoto);
	            QuerySetCell(qPhoto,'PHOTO_AVAILABLE',PHOTO_AVAILABLE,iPhoto);                                                
	            QuerySetCell(qPhoto,'PHOTO_URL',variables.genieImageDir&sYear&"/"&sStation&"/"&sSystem&"/"&sFilename,iPhoto);                                                
	            QuerySetCell(qPhoto,'SYSTEM_ID','CUSTODY',iPhoto);   
	            
	            iPhoto++;                                                                                 
			</cfscript>        
	       </cfloop>
	      </cfif>     
      </cfif>

      <!--- add to the query the additional photos--->
	  <cfif arguments.photoFilter IS "ALL" OR arguments.photoFilter IS "VISOR">
	      <cfif qAddPhoto.recordCount GT 0>
	         <cfloop query="qAddPhoto">	       	
		  	   <cftry> 	 
		         <cfscript>
		            addImage=ImageNew(qAddPhoto.PHOTO);
					ImageWrite(addImage,"#variables.genieImagePath#\additional\#NOMINAL_REF#_#SEQ_NO#_#SYSTEM_ID#.jpg","0.8");	
					
		            QueryAddRow(qPhoto,1);
		            QuerySetCell(qPhoto,'AS_NUM','',iPhoto);
		            QuerySetCell(qPhoto,'AS_REF','',iPhoto);
		            QuerySetCell(qPhoto,'NOMINAL_REF',NOMINAL_REF,iPhoto);
		            QuerySetCell(qPhoto,'DATE_TAKEN',PHOTO_DATE,iPhoto);
		            QuerySetCell(qPhoto,'PHOTO_AVAILABLE','Y',iPhoto);                                                
		            QuerySetCell(qPhoto,'PHOTO_URL','#variables.genieImageDir#additional/#NOMINAL_REF#_#SEQ_NO#_#SYSTEM_ID#.jpg',iPhoto);                                                
		            QuerySetCell(qPhoto,'SYSTEM_ID',SYSTEM_ID,iPhoto);   			 
		
		           iPhoto++;
		         </cfscript>
		         <cfcatch type="any">
				   <cflog file="duffVisorImages" type="information" text="Duff Image nominalRef=#arguments.nominalRef# seqNo=#qAddPhoto.SEQ_NO# sysId=#qAddPhoto.SYSTEM_ID#"> 	 
				 </cfcatch>
				</cftry>     	                  	    
	       </cfloop>
	     </cfif>
     </cfif>
      
      <!--- order all the photos by the date taken --->
      <cfquery name="qPhoto" dbtype="query">
       SELECT    *
       FROM      qPhoto
       ORDER BY  DATE_TAKEN DESC
      </cfquery>
      
      <!--- create an array of the photos --->
      <cfloop query="qPhoto">      
         <cfscript>
            photo=CreateObject('component','genieObj.nominal.photo');
			photo.setAS_NUM(AS_NUM);
			photo.setAS_REF(AS_REF);
			photo.setNOMINAL_REF(NOMINAL_REF);
			photo.setCREATION_DATE(DATE_TAKEN);
			photo.setPHOTO_AVAILABLE(PHOTO_AVAILABLE);			
			photo.setPHOTO_URL(PHOTO_URL);
			photo.setSYSTEM_ID(SYSTEM_ID);			
			ArrayAppend(photos,photo);        
         </cfscript>
      </cfloop>

      <cfreturn photos>
      
    </cffunction>    

    <cffunction name="getPhotoCount" output="false" access="public" returntype="numeric" hint="returns number of photos a nominal has">
      <cfargument name="nominalRef" required="true" type="string" hint="nominal ref to get photo info for">
      
      <cfset var qCustPhoto="">
      <cfset var qAddPhoto="">
      <cfset var iPhoto=0>      
            
      <!--- query for all custody photos for the nominal--->
      <cfquery name="qCustPhoto" datasource="#variables.warehouseDSN#">
	     SELECT 'Y'
	     FROM   common_owner.DEF_ARRESTS df
	     WHERE  NOMINAL_REF = <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">	 
	     AND    PHOTO_AVAILABLE=<cfqueryparam value="Y" cfsqltype="cf_sql_varchar">
         order by NVL(DATE_PHOTO_AND_FPRINTS,CREATION_DATE)  DESC               
      </cfquery>
      
      <!--- get all additional photos for the nominal --->
 	  <cfquery name="qAddPhoto" datasource="#variables.WarehouseDSN#">
		SELECT 'Y'
		FROM   browser_owner.NOMINAL_PHOTOS np1
		WHERE  NOMINAL_REF = <cfqueryparam value="#arguments.nominalRef#" cfsqltype="cf_sql_varchar">
		order by PHOTO_DATE DESC
	  </cfquery>	      

      <cfset iPhoto=qCustPhoto.recordCount+qAddPhoto.recordCount>

      <cfreturn iPhoto>
      
    </cffunction>    

    <cffunction name="getRispPhoto" output="false" access="public" returntype="genieObj.nominal.photo" hint="returns array of nominal photos">
	    <cfargument name="searchTerms" required="true" type="struct" hint="struct consisting of AppRef, ForceId and SysId">
	    <cfargument name="userId" required="true" type="string" hint="userId of user making request">
	    <cfargument name="terminalId" required="true" type="string" hint="terminalId of user making request">
	    <cfargument name="sessionId" required="true" type="string" hint="sessionId of user making request">                
	                  
        <cfset var westMidsResult=StructNew()>                                                                            
	    <cfset var photo=createObject("component","genieObj.nominal.photo").init()>
	    <cfset var searchResult="">
	    <cfset var searchXML="">
	    <cfset var resultXML="">
	    <cfset var resultStart=0>
	    <cfset var resultEnd=0>
	    <cfset var imageArrayXml="">
	    <cfset var iImg=1>
        <cfset var imageFileName="">
        <cfset var imagePath="">
        <cfset var imageUrl="">    
        <cfset var theImage="">    
	    <cfset var rispImageRequestHeader=variables.rispImageRequestHeader>
	    <cfset var uniqueRef=arguments.SessionId&"_"&DateFormat(now(),"DDMMYYYY")&TimeFormat(now(),"HHmmss")>
	    <cfset var timestamp=DateFormat(now(),"YYYY-MM-DD")&"T"&TimeFormat(now(),"HH:mm:ss")&".0Z">
	    
	    <!--- replace the user, terminal, unique ref and timestamp vars --->
	    <cfset rispImageRequestHeader=ReplaceNoCase(rispImageRequestHeader,"**userId**",arguments.userId,"ALL")>
	    <cfset rispImageRequestHeader=ReplaceNoCase(rispImageRequestHeader,"**terminalId**",arguments.terminalId,"ALL")>  
	    <cfset rispImageRequestHeader=ReplaceNoCase(rispImageRequestHeader,"**appRef**",arguments.searchTerms.appRef,"ALL")>
	    <cfset rispImageRequestHeader=ReplaceNoCase(rispImageRequestHeader,"**sysId**",arguments.searchTerms.sysId,"ALL")>
	    <cfset rispImageRequestHeader=ReplaceNoCase(rispImageRequestHeader,"**forceId**",arguments.searchTerms.forceId,"ALL")>                          
	    <cfset rispImageRequestHeader=ReplaceNoCase(rispImageRequestHeader,"**uniqueRequestId**",uniqueRef,"ALL")>  
	    <cfset rispImageRequestHeader=ReplaceNoCase(rispImageRequestHeader,"**timestamp**",timestamp,"ALL")>                        
	    
	    <cfoutput>
	     <cfxml variable="searchXML">
	       #rispImageRequestHeader#
	     </cfxml>      
	     </cfoutput>
	             
		<cfhttp url="#variables.rispURL#" method="POST" result="searchResult" timeout="#variables.wMidsTimeout#"
					 port="#variables.rispPort#" useragent="">
			<cfhttpparam type="header" name="SOAPAction" value='"#variables.rispSoapAction#"'> 
			<cfhttpparam type="xml" name="body" value="#searchXml#">       
		</cfhttp>   
        
            <cfset westMidsResult.status=searchResult.statusCode>
            <cfset westMidsResult.xml=rispImageRequestHeader>            
            
            <cfif westMidsResult.status is "200 OK">
              <cfset westMidsResult.searchOk=true>
              <cfif isXml(searchResult.fileContent)>
                  <cfset resultXML=searchResult.fileContent>
                  
                  <!--- strip off the soap headers --->
                  <cfset resultStart=FindNoCase("Body>",resultXml)>
                  <cfset resultEnd=ReFindNoCase("</[A-Za-z]*:Body>",resultXml)> 
              
                  <cfset westMidsResult.bodyStart=resultStart>
                  <cfset westMidsResult.bodyEnd=resultEnd>                                     
              
                  <!--- reformat the xml header to include all name spaces --->
                  <cfset resultXml='<?xml version="1.0" encoding="utf-8"?>'&Mid(resultXml,westMidsResult.bodyStart+5,westMidsResult.bodyEnd-(westMidsResult.bodyStart+5))>
                  <cfset resultXml=Replace(resultXml,"<m:RispResponse",'<m:RispResponse xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" ')>
                  
                    <cfset resultXml=Replace(resultXml,"m:","","ALL")>
                    <cfset resultXml=Replace(resultXml,"m0:","","ALL")>                    
                    <cfset resultXml=Replace(resultXml,"xsi:","","ALL")>                     
                  
                  <!--- if the xml is valid read the nominals into an array of nominals --->
                  <cfif isXml(resultXml)>
                    <cfset resultXml=XmlParse(resultXml)>        
                    
                    <!---
                    <cffile action="append" file="d:\logs\photo_xml#TimeFormat(now(),'HHmmss')##DateFormat(now(),'DDMMYYYY')#_#RandRange(1,100)##RandRange(1,100)#.xml" output="#resultXml#"> 
                    ---->
                                
                    <cfset imageArrayXml=XmlSearch(resultXml,"//rispImg")>
                    
                    <cfloop from="1" to="#ArrayLen(imageArrayXml)#" index="iImg">
                      <cfset imageFilename=arguments.searchTerms.forceId&Replace(Replace(arguments.searchTerms.sysId,":","","ALL"),"/","","ALL")&arguments.searchTerms.appRef&uniqueRef&".jpg">
                      <cfset imagePath=variables.genieImagePath&"\risp\"&imageFilename>
                      <cfset imageUrl=variables.genieImageDir&"risp/"&imageFilename>      
                      
                      <cftry>
                      <cfset theImage=imageReadBase64(imageArrayXml[iImg].imageBase64.xmlText)>
                      <cfset imageResize(theImage,"200","","highPerformance")>
                                      
                      <cfset imageWrite(theImage,imagePath)>
                      <cfset photo.setPHOTO_URL(imageUrl)>
                      <cfcatch>
                          <cfset photo.setPHOTO_URL('')>
                      </cfcatch>
                      </cftry>
                    </cfloop>           
                                                                                              
                  </cfif>
              </cfif>
            </cfif>
                    
    <cfreturn photo>
      
    </cffunction>

	<cffunction name="getPhotoCSVList" output="false" access="public" returntype="string" hint="returns a csv / pipe seperated list of nominal photos URL|DateTaken|System,URL|DateTaken|System,....">
	 	<cfargument name="nominalRef" required="true" type="string" hint="nominal ref to get photo info for">
		 
		<cfset var returnList="">
		<cfset var arrPhotos=getNominalPhotos(nominalRef=arguments.nominalRef)>
		<cfset var photoItem="">
		<cfset var listItem="">
		
		<cfif ArrayLen(arrPhotos) GT 0>
			<cfloop array="#arrPhotos#" index="photoItem">
				<cfset listItem=ListAppend(listItem,photoItem.getPHOTO_URL(),"|")>
				<cfset listItem=ListAppend(listItem,DateFormat(photoItem.getCREATION_DATE(),"DD/MM/YYYY"),"|")>
				<cfset listItem=ListAppend(listItem,photoItem.getSYSTEM_ID(),"|")>
				<cfset returnList=ListAppend(returnList,listItem,",")>
				<cfset listItem="">
			</cfloop>	
		</cfif>
		
		<cfreturn returnList>
		 
	</cffunction>

    <cffunction name="old_getNominalLatestPhotoForSearch" output="false" access="public" returntype="struct" hint="returns the latest photo record for a nominal and it's date. 2 arrays in a struct">
      <cfargument name="qNoms" required="true" type="query" hint="query containing a list of nominals with NOMINAL_REF column">
      
      <cfset var photoStruct=StructNew()>
      <cfset var arrPhotoUrls=ArrayNew(1)>
      <cfset var arrPhotoDates=ArrayNew(1)>      
      <cfset var lisNominals="">
      <cfset var qPhoto="">
      <cfset var qNomPhoto="">
	  <cfset var qCustPhoto="">
	  <cfset var qAddPhoto="">
      <cfset var iNom="">
	  <cfset var iPhoto="">
      <cfset var sYear="">
      <cfset var sStation="">
      <cfset var sSystem="">
      <cfset var sFilename="">
	    
	  <cfset var totStart="">
	  <cfset var totEnd="">  
	    
	  <cfset var q1Start="">
	  <cfset var q1End="">
	    
	  <cfset var q2Start="">
	  <cfset var q2End="">
	    
	  <cfset var structStart="">
	  <cfset var structEnd="">                  
      
     <!--- create a list of nominal refs 
     <cfloop query="arguments.qNoms">
       <cfset lisNominals=ListAppend(lisNominals,NOMINAL_REF,",")>
     </cfloop>--->
     
     <cfset totStart=getTickCount()>
     
     <cfset lisNominals=ValueList(arguments.qNoms.NOMINAL_REF)>
      
      <!--- query for all warnings on nominals in list --->
	  <cfset q1Start=getTickCount()>
      <cfquery name="qCustPhoto" datasource="#variables.warehouseDSN#">
	     SELECT df.AS_REF, NVL(DATE_PHOTO_AND_FPRINTS,CREATION_DATE) AS DATE_TAKEN,NOMINAL_REF, df.AS_NUM, df.PHOTO_AVAILABLE
	     FROM   common_owner.DEF_ARRESTS df
	     WHERE  NOMINAL_REF IN (<cfqueryparam value="#lisNominals#" cfsqltype="cf_sql_varchar" list="true">)	 
	     AND    PHOTO_AVAILABLE=<cfqueryparam value="Y" cfsqltype="cf_sql_varchar">
	     AND    NVL(DATE_PHOTO_AND_FPRINTS,CREATION_DATE) = (   SELECT MAX(NVL(DATE_PHOTO_AND_FPRINTS,CREATION_DATE))
						                                         FROM   common_owner.DEF_ARRESTS df1
															     WHERE  NOMINAL_REF=df.NOMINAL_REF
															     AND    PHOTO_AVAILABLE=<cfqueryparam value="Y" cfsqltype="cf_sql_varchar">)    
      </cfquery>
      <cfset q1End=getTickCount()>
	    
	  <cflog file="geniePersonWebService" type="information" text="q1 = #q1End-q1Start# ms" />  

      <cfset q2Start=getTickCount()>
      <!--- get all additional photos for the nominal --->
 	  <cfquery name="qAddPhoto" datasource="#variables.WarehouseDSN#">
		SELECT *
		FROM   browser_owner.NOMINAL_PHOTOS np1
		WHERE  NOMINAL_REF IN (<cfqueryparam value="#lisNominals#" cfsqltype="cf_sql_varchar" list="true">)
		AND    PHOTO_DATE = (   SELECT MAX(PHOTO_DATE)
							    FROM   browser_owner.NOMINAL_PHOTOS np2
							    WHERE  np2.NOMINAL_REF=np1.NOMINAL_REF
	                         )	
		order by nominal_ref
	  </cfquery>	
	  <cfset q2End=getTickCount()>	    
	  <cflog file="geniePersonWebService" type="information" text="q2 = #q2End-q2Start# ms" />
	  
	  <cfset qPhoto=QueryNew('AS_NUM,AS_REF,NOMINAL_REF,DATE_TAKEN,PHOTO_AVAILABLE,PHOTO_URL,SYSTEM_ID','varchar,varchar,varchar,date,varchar,varchar,varchar')>
      
      <cfset structStart=getTickCount()>
      <cfset iPhoto=1>
      <cfif qCustPhoto.recordCount GT 0>
	   <cfloop query="qCustPhoto">
		<cfscript>
	        sYear=ListGetAt(qCustPhoto.AS_REF,1,"/");
			sStation=ListGetAt(qCustPhoto.AS_REF,2,"/");
			sSystem=ListGetAt(qCustPhoto.AS_REF,3,"/");
			sFilename=sYear&sStation&sSystem&"_"&ListGetAt(qCustPhoto.AS_REF,4,"/")&".jpg";
            
            QueryAddRow(qPhoto,1);
            QuerySetCell(qPhoto,'AS_NUM',qCustPhoto.AS_NUM,iPhoto);
            QuerySetCell(qPhoto,'AS_REF',qCustPhoto.AS_REF,iPhoto);
            QuerySetCell(qPhoto,'NOMINAL_REF',qCustPhoto.NOMINAL_REF,iPhoto);
            QuerySetCell(qPhoto,'DATE_TAKEN',qCustPhoto.DATE_TAKEN,iPhoto);
            QuerySetCell(qPhoto,'PHOTO_AVAILABLE',qCustPhoto.PHOTO_AVAILABLE,iPhoto);                                                
            QuerySetCell(qPhoto,'PHOTO_URL',variables.genieImageDir&sYear&"/"&sStation&"/"&sSystem&"/"&sFilename,iPhoto);                                                
            QuerySetCell(qPhoto,'SYSTEM_ID','CUSTODY',iPhoto);   
            
            iPhoto++;                                                                                 
		</cfscript> 
		</cfloop>       
      </cfif>
      
      <cfif qAddPhoto.recordCount GT 0>
	   <cfif Len(qAddPhoto.PHOTO) GT 0>     	
	   	<cftry>     
         <cfscript>

            addImage=ImageNew(qAddPhoto.PHOTO);
			ImageWrite(addImage,"#variables.genieImagePath#additional\#qAddPhoto.NOMINAL_REF#_#qAddPhoto.SEQ_NO#_#qAddPhoto.SYSTEM_ID#.jpg","0.8");	
			
            QueryAddRow(qPhoto,1);
            QuerySetCell(qPhoto,'AS_NUM','',iPhoto);
            QuerySetCell(qPhoto,'AS_REF','',iPhoto);
            QuerySetCell(qPhoto,'NOMINAL_REF',qAddPhoto.NOMINAL_REF,iPhoto);
            QuerySetCell(qPhoto,'DATE_TAKEN',qAddPhoto.PHOTO_DATE,iPhoto);
            QuerySetCell(qPhoto,'PHOTO_AVAILABLE','Y',iPhoto);                                                
            QuerySetCell(qPhoto,'PHOTO_URL','#variables.genieImageDir#additional/#qAddPhoto.NOMINAL_REF#_#qAddPhoto.SEQ_NO#_#qAddPhoto.SYSTEM_ID#.jpg',iPhoto);                                                
            QuerySetCell(qPhoto,'SYSTEM_ID',qAddPhoto.SYSTEM_ID,iPhoto);   			 

           iPhoto++;
         </cfscript>
		 <cfcatch type="any">
		   <cflog file="duffVisorImages" type="information" text="Duff Image nominalRef=#qAddPhoto.NOMINAL_REF# seqNo=#qAddPhoto.SEQ_NO# sysId=#qAddPhoto.SYSTEM_ID#"> 	 
		 </cfcatch>
		</cftry>     
	   </cfif>
      </cfif>    	  
	
      <!--- loop round all nominals and get their photos. if they have none then set their position in the array
            to a blank. If they do have a photo then work out the url and add to the photoUrl array. Do the same
            with the date taken and add to the photoDate array --->
      <cfset iNom=1>      
      <cfloop query="arguments.qNoms">
          
            <cfquery name="qNomPhoto" dbtype="query">
	        SELECT * 
	        FROM   qPhoto
	        WHERE  NOMINAL_REF=<cfqueryparam value="#NOMINAL_REF#" cfsqltype="cf_sql_varchar">
			ORDER BY DATE_TAKEN DESC
            </cfquery>
            
            <cfif qNomPhoto.RecordCount IS 0>
              <!--- nominal has no photo --->
              <cfset arrPhotoUrls[iNom]="">
              <cfset arrPhotoDates[iNom]="">  
       
            <cfelse>
              <!--- nominal has photo, check AS NUM is properly formatted and create the link and date --->
              
              <cfif ListLen(qNomPhoto.AS_REF,"/") IS 4>		
	             <cfset sYear=ListGetAt(qNomPhoto.AS_REF,1,"/")>
			     <cfset sStation=ListGetAt(qNomPhoto.AS_REF,2,"/")>
				 <cfset sSystem=ListGetAt(qNomPhoto.AS_REF,3,"/")>
				 <cfset sFilename=sYear&sStation&sSystem&"_"&ListGetAt(qNomPhoto.AS_REF,4,"/")&".jpg">

			     <cfset arrPhotoUrls[iNom]=variables.genieImageDir&sYear&"/"&sStation&"/"&sSystem&"/"&sFilename>
                 <cfset arrPhotoDates[iNom]=DateFormat(qNomPhoto.DATE_TAKEN,"DD/MM/YYYY")>
              <cfelse>
			     <cfif Len(qNomPhoto.PHOTO_URL) GT 0>
	                 <cfset arrPhotoUrls[iNom]=qNomPhoto.PHOTO_URL>
	                 <cfset arrPhotoDates[iNom]=DateFormat(qNomPhoto.DATE_TAKEN,"DD/MM/YYYY")>           				     
				 <cfelse>
	                 <cfset arrPhotoUrls[iNom]="">
	                 <cfset arrPhotoDates[iNom]="">           
	             </cfif>
              </cfif>
			  			
                            
            </cfif>
            
            <cfset iNom=iNom+1>
            
      </cfloop>
      
      <cfset photoStruct.photoUrls=arrPhotoUrls>
      <cfset photoStruct.photoDates=arrPhotoDates>      
      <cfset structEnd=getTickCount()>
	  <cflog file="geniePersonWebService" type="information" text="Struct = #structEnd-structStart# ms" />
	    
      <cfset totEnd=getTickCount()>
	  <cflog file="geniePersonWebService" type="information" text="Photo DAO Total = #totENd-totStart# ms" />  
      
      <cfreturn photoStruct>
      
    </cffunction>

</cfcomponent>