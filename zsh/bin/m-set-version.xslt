<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pom="http://maven.apache.org/POM/4.0.0">
<xsl:output method="xml" omit-xml-declaration="yes"/>

<!-- Enable default behaviour to output all text nodes that are found -->
<!--
<xsl:template match="text()" />
-->
<!-- Copy all comments -->
<xsl:template match="comment()">
    <xsl:copy />
</xsl:template>
<!-- Enable the traversal and duplication of all nodes and node attributes -->
<xsl:template match="*" >
    <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates/>
    </xsl:copy>
</xsl:template>

<!-- 
This replaces the <version>...</version> with the updated
version number
-->
<xsl:template xmlns="http://maven.apache.org/POM/4.0.0" match="//pom:dependency/pom:version">
    <xsl:choose>
        <xsl:when test="../pom:groupId[text() = $groupId] and ../pom:artifactId[text() = $artifactId]">
            <xsl:text disable-output-escaping="yes">&lt;version&gt;</xsl:text>
            <xsl:value-of select="$version" />
            <xsl:text disable-output-escaping="yes">&lt;/version&gt;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>
