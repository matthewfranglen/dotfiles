<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pom="http://maven.apache.org/POM/4.0.0">
<xsl:output method="xml" omit-xml-declaration="yes"/>

<!-- Disable default behaviour to output all text nodes that are found -->
<xsl:template match="text()" />
<!-- Disable the traversal of all nodes -->
<xsl:template match="*" />

<!-- 
This doesnt actually trigger any more templates, but if it did then the
above definitions would make the behaviour more predictable.

This just selects the root version, or the parent version.
If there is a parent version then it is used in preference

The parent version is no longer appropriate - it is usually fixed at 1.0.0.
If a pom is being tested, then the version of that pom is returned.
-->
<xsl:template match="/">
    <xsl:value-of select="pom:project/pom:version" />
</xsl:template>

</xsl:stylesheet>
