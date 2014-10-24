<?xml version="1.0" encoding="UTF-8"?>
<!--28/12/07 - Mark Compton added Message type sylr -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output version="1.0" omit-xml-declaration="no" indent="no" media-type="text/html"/>
	<xsl:template match="FLINTSSEARCH">
		<xsl:variable name="uniqueid" select="generate-id(SEARCH)"/>
		<xsl:variable name="stype" select="CORE_DETAILS/REFERENCE"/>
		<xsl:variable name="optcount" select="count(SEARCH/SEARCH_OPTIONS/CORE_OPTIONS/OPTION)"/>
		<xsl:variable name="resheight" select="530  - (22 * $optcount)"/>
		<!--<html>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
			<meta http-equiv="pragma" content="nocache"/>
			<link href="..\StyleSheets\Flintsweb.css" type="text/css" rel="stylesheet"/>
			<script src="..\JavaScript\IMS.js"/>
			<head/>
			<body style="width:900px;height:500px" scroll="no" ondragstart="return false">-->
		<div style="position:relative;top:20px"><xsl:attribute name="id">SearchDiv<xsl:value-of select="$uniqueid"/></xsl:attribute>
		<table border="1" width="300px">
			<!--<tr>
				<td colspan="3">
					<img width="800px">
						<xsl:attribute name="src">../helpers/GetImageText.aspx?PICTEXT=FLINTS%20<xsl:value-of select="CORE_DETAILS/SYSTEM_NAME"/></xsl:attribute>
					</img>
				</td>
			</tr>-->
			<tr>
				<td width="350px">
					<table class="small" border="1" width="300px" id="{$uniqueid}" cellspacing="0" cellpadding="0">
						<xsl:for-each select="SEARCH/SEARCH_OPTIONS/CORE_OPTIONS/OPTION">
							<tr>
								<xsl:if test="@TYPE!='MESSAGE'">
								<td width="40%" valign="top"  style="border-top:solid 1px black;border-right:solid 1px black">
									<xsl:value-of select="@TITLE"/>.
									<xsl:if test="@HELPFILE!=''"><img src="..\Images\help.gif" alt="Whats this?" height="14" width="14"><xsl:attribute name="onclick">ShowHelp('<xsl:value-of select="@HELPFILE"/>')</xsl:attribute></img></xsl:if>
								</td>
								<td width="60%"  style="border-top:solid 1px black">
									<xsl:if test="position()=1">
										<input type="hidden"  id="SEARCHTYPE" value="{$stype}"/>
									</xsl:if>
									<xsl:call-template name="OptionItem">
										<xsl:with-param name="OptItem" select="."/>
										<xsl:with-param name="unid" select="$uniqueid"/>
									</xsl:call-template>
								</td>
								</xsl:if>
								<xsl:if test="@TYPE='MESSAGE'">
									<td colspan="2">
										<xsl:value-of select="@VALIDATIONFAILEDMESSAGE"/>
									</td>
								</xsl:if>
							</tr>
						</xsl:for-each>
						<tr style="display:none">
							<td>Taxonomy Level</td><td><input type="input" value="1" id="TAXONOMY_LEVEL"/></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center" >
					<input style="width:190px" type="Submit" value="GO"><!--id=DS-->
					<xsl:attribute name="id"><xsl:value-of select="$uniqueid"/>DefBut</xsl:attribute>					
					<xsl:attribute name="onclick">DoSearch("<xsl:value-of select="$uniqueid"/>")</xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>
				<div>
				<xsl:attribute name="style">height:<xsl:value-of select="$resheight"/>;width:340px;overflow:auto</xsl:attribute>
				<xsl:attribute name="id"><xsl:value-of select="$uniqueid"/>Results</xsl:attribute>
				</div></td>
			</tr>
		</table>
		</div>
		<div style="position:absolute;width:600;height:590;top:22;left:350;border:solid 0px black">
		<xsl:attribute name="id"><xsl:value-of select="$uniqueid"/>Details</xsl:attribute>
		</div>
		<img src="..\images\blank.gif"><xsl:attribute name="onload">SetDefFocus('<xsl:value-of select="$uniqueid"/>')</xsl:attribute></img>
	</xsl:template>
	<xsl:template name="OptionItem">
		<xsl:param name="OptItem"/>
		<xsl:param name="unid"/>
		<xsl:for-each select="$OptItem">
			<xsl:choose>
				<xsl:when test="@TYPE='TextBox'">
					<input type="text" style="font-size:7pt;padding:0 0 0 0;margin:0 0 0 0;width:100%" >
						<xsl:attribute name="maxlength"><xsl:value-of select="@MAXLENGTH"/></xsl:attribute>
						<xsl:attribute name="id"><xsl:value-of select="@PARAMNAME"/></xsl:attribute>
						<xsl:attribute name="onKeyUp">ClearSearchResults('<xsl:value-of select="$unid"/>')</xsl:attribute>
						<xsl:if test="@VALIDATIONREGEX!=''">
							<xsl:attribute name="regex"><xsl:value-of select="@VALIDATIONREGEX"/></xsl:attribute>	
							<xsl:attribute name="failedmessage"><xsl:value-of select="@VALIDATIONFAILEDMESSAGE"/></xsl:attribute>
							<xsl:attribute name="requiredfield"><xsl:value-of select="@REQUIRED_FIELD"/></xsl:attribute>
						</xsl:if>	
						<xsl:if test="@DEFAULTFOCUS='Y'">
							<xsl:attribute name="defaultfocus">Y</xsl:attribute>	
						</xsl:if>
						<xsl:attribute name="DisallowedKeyCodes"><xsl:value-of select="@DISALLOWEDKEYCODES"/></xsl:attribute>
					</input>
				</xsl:when>
				<xsl:when test="@TYPE='NumberBox'">
					<input type="text" style="font-size:7pt;padding:0 0 0 0;margin:0 0 0 0;width:100%" onkeydown="CheckIsDigit()">
						<xsl:attribute name="maxlength"><xsl:value-of select="@MAXLENGTH"/></xsl:attribute>
						<xsl:attribute name="id"><xsl:value-of select="@PARAMNAME"/></xsl:attribute>
						<xsl:attribute name="onKeyUp">ClearSearchResults('<xsl:value-of select="$unid"/>')</xsl:attribute>
						<xsl:if test="@VALIDATIONREGEX!=''">
							<xsl:attribute name="regex"><xsl:value-of select="@VALIDATIONREGEX"/></xsl:attribute>	
							<xsl:attribute name="failedmessage"><xsl:value-of select="@VALIDATIONFAILEDMESSAGE"/></xsl:attribute>
							<xsl:attribute name="requiredfield"><xsl:value-of select="@REQUIRED_FIELD"/></xsl:attribute>
						</xsl:if>	
						<xsl:if test="@DEFAULTFOCUS='Y'">
							<xsl:attribute name="defaultfocus">Y</xsl:attribute>	
						</xsl:if>
					</input>
				</xsl:when>
				<xsl:when test="@TYPE='DateInput'">
					<input type="text" style="font-size:7pt;padding:0 0 0 0;margin:0 0 0 0" value="dd/mm/yyyy"><xsl:attribute name="id"><xsl:value-of select="concat('DATE_',@PARAMNAME)"/></xsl:attribute></input><img src="..\images\calendar.gif" alt="Select a date"/>
				</xsl:when>
				<xsl:when test="@TYPE='CheckBox'">
					<input type="checkbox"/>
				</xsl:when>
				<xsl:when test="@TYPE='ListBox'">
					<xsl:call-template name="ListBox">
						<xsl:with-param name="ListNode" select="."/>
						<xsl:with-param name="ListName" select="@PARAMNAME"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="@TYPE='CheckBoxGroup'">
					<xsl:call-template name="CheckBoxList">
						<xsl:with-param name="ListNode" select="."/>
						<xsl:with-param name="ListName" select="@PARAMNAME"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="@CheckBox">
					<tr>
						<td>
							<input type="checkbox">
								<xsl:attribute name="name"><xsl:value-of select="@PARAMNAME"/></xsl:attribute>
							</input>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="ListBox">
		<xsl:param name="ListNode"/>
		<xsl:param name="ListName"/>
		<xsl:variable name="DefOpt" select="$ListNode/@DEFOPTION"/>
		<select style="font-size:7pt;width:100%">
			<xsl:attribute name="id"><xsl:value-of select="$ListName"/></xsl:attribute>
			<xsl:for-each select="$ListNode/OPTIONS/ITEM">
				<xsl:sort select="@ListOrder"/>
				<option>
					<xsl:if test="@Value=$DefOpt">
						<xsl:attribute name="selected"/>
					</xsl:if>
					<xsl:attribute name="value"><xsl:value-of select="@Value"/></xsl:attribute>
					<xsl:value-of select="@Text"/>
				</option>
			</xsl:for-each>
		</select>
	</xsl:template>
	<xsl:template name="CheckBoxList">
		<xsl:param name="ListNode"/>
		<xsl:param name="ListName"/>
		<table border="0" cellpadding="0" cellspacing="0" class="small">
			<xsl:for-each select="$ListNode/OPTIONS/ITEM">
				<xsl:sort select="@ListOrder"/>
				<tr>
					<td>
						<input type="checkbox" checked="checked">
							<xsl:attribute name="name"><xsl:value-of select="$ListName"/></xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="@Value"/></xsl:attribute>
							<xsl:value-of select="@Text"/>
						</input>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	<xsl:template name="RadioList">
		<xsl:param name="ListNode"/>
		<xsl:param name="ListName"/>
		<table border="0" cellpadding="0" cellspacing="0" class="small">
			<xsl:for-each select="$ListNode/OPTIONS/ITEM">
				<xsl:sort select="@ListOrder"/>
				<tr>
					<td>
						<input type="radio">
							<xsl:if test="position()=1">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
							<xsl:attribute name="name"><xsl:value-of select="$ListName"/></xsl:attribute>
							<xsl:attribute name="id"><xsl:value-of select="$ListName"/></xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="@Value"/></xsl:attribute>
						</input>
						<xsl:value-of select="@Text"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	<xsl:template name="GetFlash">
		<DIV>
			<OBJECT class="flintsflash" id="ZipFlints" style="LEFT: 5px; TOP: 305px" codeBase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" height="25" width="10" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" >
				<PARAM NAME="_cx" VALUE="9525"/>
				<PARAM NAME="_cy" VALUE="794"/>
				<PARAM NAME="FlashVars" VALUE=""/>
				<PARAM NAME="Movie" VALUE="../Images/ZipFLintsSilver.swf"/>
			    <PARAM NAME="Src" VALUE="../Images/ZipFLintsSilver.swf"/>
				<PARAM NAME="WMode" VALUE="Window"/>
				<PARAM NAME="Play" VALUE="0"/>
				<PARAM NAME="Loop" VALUE="-1"/>
				<PARAM NAME="Quality" VALUE="High"/>
				<PARAM NAME="SAlign" VALUE=""/>
				<PARAM NAME="Menu" VALUE="-1"/>
				<PARAM NAME="Base" VALUE=""/>
				<PARAM NAME="AllowScriptAccess" VALUE="always"/>
				<PARAM NAME="Scale" VALUE="ShowAll"/>
				<PARAM NAME="DeviceFont" VALUE="0"/>
				<PARAM NAME="EmbedMovie" VALUE="0"/>
				<PARAM NAME="BGColor" VALUE="C0C0C0"/>
				<PARAM NAME="SWRemote" VALUE=""/>
				<PARAM NAME="MovieData" VALUE=""/>
				<PARAM NAME="SeamlessTabbing" VALUE="1"/>
				<PARAM NAME="Profile" VALUE="0"/>
				<PARAM NAME="ProfileAddress" VALUE=""/>
				<PARAM NAME="ProfilePort" VALUE="0"/>
				<embed src="/Images/ZipFLints.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="50" height="50"></embed>
			</OBJECT>
		</DIV>
	</xsl:template>
</xsl:stylesheet>
