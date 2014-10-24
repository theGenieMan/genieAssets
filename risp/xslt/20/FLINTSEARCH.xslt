<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output version="1.0" omit-xml-declaration="no" indent="no" media-type="text/html"/>
	<xsl:template match="/">
		<html>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
			<meta http-equiv="pragma" content="nocache"/>
			<link href="..\StyleSheets\Flintsweb.css" type="text/css" rel="stylesheet"/>
			<script src="..\JavaScript\IMS.js"/>
			<head/>
			<body style="margin:2px; padding: 2px;" scroll="no" ondragstart="return false">
				<table class="small" border="1" width="95%">
					<xsl:for-each select="FLINTSSEARCH/SEARCH/SEARCH_OPTIONS/CORE_OPTIONS/OPTION">
							<tr>
								<td width="30%"><xsl:value-of select="@Title"/></td>
								<td width="60%">
									<xsl:choose>
										<xsl:when test="@Type='Text'">
											<input type="text"><xsl:attribute name="maxlength"><xsl:value-of select="@MaxLength"/></xsl:attribute></input>
										</xsl:when>
										<xsl:when test="@Type='CheckBox'"><input type="checkbox"></input></xsl:when>
										<xsl:when test="@Type='ListBox'">
										<select>
											<xsl:for-each select="OPTIONS/ITEM">
												<option><xsl:attribute name="value"><xsl:value-of select="@Value"/></xsl:attribute><xsl:value-of select="."/></option></xsl:for-each>
										</select>
										</xsl:when>
										<xsl:otherwise></xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
