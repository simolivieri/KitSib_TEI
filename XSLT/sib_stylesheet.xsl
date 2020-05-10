<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">

    <xsl:output method="html" encoding="utf-8"/>

    <xsl:variable name="myGrammar" select="document('sib_TEI.xml')"/>
    <xsl:variable name="myBiblio" select="document('sib_bibl.xml')"/>

    <xsl:template match="$myGrammar/*">
        <html>
            <head>
                <title>The Kitāb Sībawayhi in electronic form</title>
            </head>
            <body>
                <p align="center">
                    <font size="200%">
                        <b>
                            <xsl:text xml:id="title">The Kitāb Sībawayhi in electronic form</xsl:text>
                            <xsl:apply-templates select="title"/>
                        </b>
                    </font>
                </p>
                <br/>
                <xsl:apply-templates select="$myGrammar/descendant::teiHeader"/>
                <br/>
                <b>Chapters [format Volume:Number]</b>
                <lb/>
                <br/>
                <xsl:variable name="index" select="position()"/>
                <xsl:for-each select="$myGrammar/descendant::div">
                    <xsl:variable name="index" select="position()"/>
                    <br/>
                    <a data-toggle="tab" href="out/output{$index}.html" target="_blank">
                        <xsl:text>Chapter </xsl:text>
                        <xsl:value-of select="@n"/>
                        <xsl:text>: </xsl:text>
                        <xsl:value-of select="head"/>
                        <p/>
                    </a>
                </xsl:for-each>
                <xsl:for-each select="$myGrammar/descendant::div">
                    <xsl:variable name="index" select="position()"/>
                    <a>
                        <xsl:result-document href="out/output{$index}.html" encoding="UTF8"
                            method="html">
                            <html>
                                <head>
                                    
                                </head>
                                <body>
                                    <xsl:apply-templates select="."/>                                    
                                </body>
                            </html>
                        </xsl:result-document>
                    </a>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="teiHeader">
        <table border="2" cellspacing="1" cellpadding="6">
            <br/>
            <tr>
                <th>Title</th>
                <th>Responsible for the project</th>
                <th>Funder</th>
                <th>Licence</th>
            </tr>
            <tr>
                <td>
                    <xsl:value-of select="//title"/>
                </td>
                <td>
                    <xsl:value-of select="//name"/>
                    <xsl:text> - </xsl:text>
                    <xsl:value-of select="//orgName"/>
                </td>
                <td>
                    <xsl:value-of select="//funder"/>
                </td>
                <td>
                    <xsl:value-of select="//licence"/>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="div">
        <p dir="rtl">
            <i>
                <xsl:value-of select="@n"/>
            </i>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="head">
        <xsl:text> -- The Kitāb Sībawayhi</xsl:text>
        <table border="1" cellspacing="0" cellpadding="6">
            <tr>
                <th>Chapter title <xsl:value-of select="@n"/>
                    <br/>
                    <b/>
                </th>
            </tr>
            <tr>
                <td>
                    <xsl:value-of select="."/>
                </td>
            </tr>
        </table>
        <br/>
    </xsl:template>

    <xsl:template match="p">
        <br/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="seg">
            <font color="red">
                <b>
                    <xsl:apply-templates/>    
                </b>
            </font>
        <font size="3" color="black">
        <em>
            <sub>
                <xsl:text>[</xsl:text>
                <xsl:value-of select="substring-after(@corresp,'#')"/>
                <xsl:text>] </xsl:text>
            </sub>
            <xsl:apply-templates/>
        </em>
        </font>
    </xsl:template>

    <xsl:template match="pb">
        <font size="3" color="black">
            <em>
                <sub>
                    <xsl:text>[</xsl:text>
                    <xsl:value-of select="@n"/>
                    <xsl:text>]</xsl:text>
                </sub>
                <xsl:apply-templates/>
            </em>
        </font>
    </xsl:template>

</xsl:stylesheet>
