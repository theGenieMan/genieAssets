<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2004/07/xpath-functions" xmlns:xdt="http://www.w3.org/2004/07/xpath-datatypes">
	<xsl:template match="/.">
				<xsl:variable name="DomId"><xsl:value-of select="generate-id(.)"/></xsl:variable>
				<table class="small">
					<tbody>
						<tr>
							<td rowspan="3"><img src="..\images\sadface.gif" alt="Sorrrrrrrrry !!!"/></td>
							<td><b>Sorry! An error has occurred retrieving your data.</b></td>
						</tr>
						<tr>
							<td>The following information may be useful to the FLINTS team in solving this issue</td>
						</tr>
						<tr>
							<td >
								<table CLASS="small" >
								<tr>
									<td>Source</td>
									<td style="color:red"><xsl:value-of select="/FLINTS_ERROR/ERROR_SOURCE"/></td>
								</tr>
								<tr>
									<td>Position</td>
									<td style="color:red"><xsl:value-of select="/FLINTS_ERROR/ERROR_POSITION"/></td>
								</tr>
								<tr>
									<td>Text</td>
									<td style="color:red"><xsl:value-of select="/FLINTS_ERROR/ERROR_MESSAGE"/></td>
								</tr>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
				<img style="cursor:hand"	 src="..\images\xml.gif" alt="getthexml">
				<xsl:attribute name="onclick">ShowXML('<xsl:value-of select="$DomId"/>')</xsl:attribute>
				</img>
				<div style="display:none"><xsl:attribute name="id"><xsl:value-of select="$DomId"/>SourceXML</xsl:attribute><xsl:copy-of select="/FLINTS_ERROR/ORIGINAL_REQUEST"/></div>	
	</xsl:template>
</xsl:stylesheet>
