<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!--Yes I really to mean this to be set to XML output. If I set it this way it simplifies escaping stuff.-->
	<xsl:output method="xml" omit-xml-declaration="yes" indent="no"/>

	<!--Follow each dialog block with a newline.-->
	<xsl:template match="div[@class='dialog']">
		<xsl:apply-templates/>
		<xsl:text><!--\n-->
		</xsl:text>
	</xsl:template>

	<!--
		Place the `:` prefix, then the contents of the name span, then a space for clarity.
		In a bit of a kludge, I assume that the colon following the name is always present.
	-->
	<xsl:template match="span[@class='name']">
		<xsl:text>:</xsl:text>
		<xsl:apply-templates/>
		<xsl:text> </xsl:text>
	</xsl:template>

	<!--
		Action divs get 2 things: A > prefix, and a newline.
		Escaping needs to be disabled here because XML/XSL is a silly pony.
	-->
	<xsl:template match="div[@class='action']">
		<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<xsl:apply-templates/>
	</xsl:template>


	<!--Paragraphs get 2 newlines.-->
	<xsl:template match="p">
		<xsl:text>
		<!--\n--><!--\n-->
</xsl:text><!--Who is? You is!-->
		<xsl:apply-templates/>
	</xsl:template>

	<!-- Copy comments over -->
	<xsl:template match="comment()">
		<xsl:text disable-output-escaping="yes">&lt;!--</xsl:text>
		<xsl:value-of select="."/>
		<xsl:text disable-output-escaping="yes">--&gt;</xsl:text>
	</xsl:template>

	<!--
	These are all of the other elements that are used in the existing transcriptions.
	Determined with with:
	 grep -oh -e "<\w\w*[^>]*>" ./*.md | sort -u
	-->
	<xsl:template match="b|strong|i|em|u|sup|sub|font">
		<xsl:copy-of select="."/>
	</xsl:template>

</xsl:stylesheet>