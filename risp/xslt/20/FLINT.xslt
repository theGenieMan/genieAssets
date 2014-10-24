<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2004/07/xpath-functions" xmlns:xdt="http://www.w3.org/2004/07/xpath-datatypes">
	<xsl:include href="hyperlinks.xslt"/>
	<xsl:include href="PrintPage.xslt"/>
	<xsl:template match="/.">
		<xsl:variable name="forcename" select="SAS/CORE_DETAILS/FORCE_NAME"/>
		<xsl:variable name="forceid" select="SAS/CORE_DETAILS/FORCE"/>
				<table class="small">
				<tr>
					<td><img src="../images/LogoRotate2.gif" alt="Flints Logo"/></td>
					<td>Sorry .. The Flints graphical view is not yet implemented in this version - please refer to the Legacy version of FLINTS for more information.  This feature will be implemented in the next release of Web Flints.</td>
				</tr>
				</table>
				<xsl:call-template name="PrintPage">
					<xsl:with-param name="dom" select="./."/>
				</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
