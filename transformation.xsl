<?xml version="1.0" encoding="UTF-8"?>
<!--
    Progetto esame-corso Codifica di testi 20-21
    Studente: Michele Papucci, Sofia Zuffi
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:variable name="space"><![CDATA[&#32;]]></xsl:variable>
    <xsl:template match="/">
        <xsl:comment>
            Progetto esame Codifica di Testi
            Filename: cartoline.html
        </xsl:comment>
        <html>
            <head>
                <title>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/>
                </title>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
                <script src="script.js"></script>
                <link rel="stylesheet" href="style.css"/>
            </head>
            <body>
                <div class="header">
                    <a class="c_toggler active" id="012">Cartolina 012</a>
                    <a class="c_toggler" id="044">Cartolina 044</a>
                    <a class="c_toggler" id="102">Cartolina 102</a>
                </div>
                <div class="c_holder visible" id="c012">
                    <xsl:apply-templates select="/tei:teiCorpus/tei:TEI[1]"/>
                </div>
                <div class="c_holder" id="c044">
                    <xsl:apply-templates select="/tei:teiCorpus/tei:TEI[2]"/>
                </div>
                <div class="c_holder" id="c102">
                    <xsl:apply-templates select="/tei:teiCorpus/tei:TEI[3]"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="/tei:teiCorpus/tei:TEI">
        <xsl:apply-templates select="tei:teiHeader"/>
        <div>
            <input type="radio">
                <xsl:attribute name ="type">radio</xsl:attribute>
                <xsl:attribute name="id">r_<xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>_f</xsl:attribute>
                <xsl:attribute name="name"><xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>_fronte_retro</xsl:attribute>
                <xsl:attribute name="checked">checked</xsl:attribute>
            </input>
            <xsl:element name="label">
                <xsl:attribute name="for">r_<xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>_f</xsl:attribute>
                Fronte
            </xsl:element>
            <input type="radio">
                <xsl:attribute name ="type">radio</xsl:attribute>
                <xsl:attribute name="id">r_<xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>_r</xsl:attribute>
                <xsl:attribute name="name"><xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>_fronte_retro</xsl:attribute>
            </input>
            <xsl:element name="label">
                <xsl:attribute name="for">r_<xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>_r</xsl:attribute>
                Retro
            </xsl:element>
        </div>
        <div>
            <xsl:attribute name="id">f_r_holder_<xsl:value-of select="@xml:id"/></xsl:attribute>
            <xsl:apply-templates select="tei:facsimile"/>
            <xsl:apply-templates select="tei:text"/>
        </div>
    </xsl:template>

    <xsl:template match="tei:teiHeader">
        <div class ="header_c">
            <p>Progetto per l'esame di Codifica di Testi 2020/2021: Tre cartoline della Grande Guerra.</p>
            <h3><xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:bibl/tei:title"/></h3>
            <xsl:if test="count(tei:fileDesc/tei:sourceDesc/tei:bibl/tei:publisher)>0">
                <p>
                    Pubblicato da: <xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:bibl/tei:publisher"/>
                    <xsl:if test="count(tei:fileDesc/tei:sourceDesc/tei:bibl/tei:pubPlace)>0">
                        a <xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:bibl/tei:pubPlace"/>
                    </xsl:if>
                </p>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="tei:facsimile">
        <div class = "immagini_c">
            <xsl:apply-templates select="tei:surface"/>
        </div>
    </xsl:template>

    <xsl:template match="tei:surface">
        <xsl:element name ="img">
            <xsl:attribute name="src">
                <xsl:value-of select ="tei:graphic/@url"/>
            </xsl:attribute>
            <xsl:if test="position() = 1">
                <xsl:attribute name="class">visible</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:text">
        <div class="info_c">
            <xsl:variable name="temp_id_info_fronte" select="tei:body/tei:div[1]/@facs"/>
            <xsl:variable name="final_id_info_fronte" select="substring-after($temp_id_info_fronte, '#')"/>
            <div class="info_r_f visible">
                <xsl:attribute name="id">i_<xsl:value-of select="$final_id_info_fronte"/></xsl:attribute>
                text fronte
            </div>
            <xsl:variable name="temp_id_info_retro" select="tei:body/tei:div[2]/@facs"/>
            <xsl:variable name="final_id_info_retro" select="substring-after($temp_id_info_retro, '#')"/>
            <div class="info_r_f">
                <xsl:attribute name="id">i_<xsl:value-of select="$final_id_info_retro"/></xsl:attribute>
                text retro
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>