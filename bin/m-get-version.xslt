<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pom="http://maven.apache.org/POM/4.0.0">
<xsl:output method="xml" omit-xml-declaration="yes"/>

<!-- Disable default behaviour to output all text nodes that are found -->
<xsl:template match="text()" />
<!-- Disable the traversal of all nodes (not actually disabled here) -->
<!--
<xsl:template match="*" />
-->

<!-- 
This gets the dependency group, artifact and version.
They are printed out 'maven style' which is:
<group>:<artifact>:<version>

(cannot print out packaging or scope since they do not apply)
-->
<xsl:template match="pom:project">
    <xsl:value-of select="pom:groupId" />
	<xsl:text>:</xsl:text>
	<xsl:value-of select="pom:artifactId" />
	<xsl:text>:</xsl:text>
	<xsl:value-of select="pom:version" />
	<xsl:text>
</xsl:text>
</xsl:template>

</xsl:stylesheet>
