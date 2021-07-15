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
                <div id="header_info">
                    <a id="header_title">Codifica di testi: Tre cartoline della Grande Guerra.
                        <br/>
                    </a>
                    <br/>
                    <a class="bold">Provenienza cartoline:</a>
                    <xsl:value-of select="/tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl"/>
                    conservate al <xsl:value-of
                        select="/tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:repository"/>,
                    <xsl:value-of
                            select="/tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:settlement"/>,
                    <xsl:value-of
                            select="/tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:country"/>
                    <br/>
                    <a class="bold">Guida alla lettura delle cartoline:</a>
                    <br/>
                    <a>- il simbolo […] è stato inserito tutte le volte in cui, a causa di una grafia poco leggibile,
                        non è stato possibile decifrare una parola (o una parte di essa)
                        <br/>
                        - le parole tra [parentesi quadre] corrispondono alla traduzione estesa, o in italiano standard,
                        della corrispondente parola sulla cartolina
                        - passando con il cursore sopra le parti colorate di testo è possibile vedere, evidenziata da un
                        cerchio rosso, la corrispondente area della cartolina
                    </a>
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
                <div class="footer">
                    <a class="footer_title">Progetto per l'esame di Codifica di Testi a.a. 2020/2021</a>
                    <xsl:apply-templates select="/tei:teiCorpus/tei:teiHeader/tei:fileDesc"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:teiHeader/tei:fileDesc">
        <div class="edizione">
            <xsl:apply-templates select="tei:editionStmt/tei:respStmt"/>
        </div>
        <div class="pubblicazione">
            <xsl:apply-templates select="tei:publicationStmt"/>
        </div>
    </xsl:template>

    <xsl:template match="tei:editionStmt/tei:respStmt">
        <a class="bold">
            <xsl:value-of select="tei:resp"/>
        </a>
        <xsl:value-of select="$space" disable-output-escaping="yes"/>
        <xsl:for-each select="tei:name">
            <xsl:choose>
                <xsl:when test="position() != last()">
                    <xsl:choose>
                        <xsl:when test="not(normalize-space(text()))">
                            <xsl:variable name="temp_id">
                                <xsl:value-of select="@ref"/>
                            </xsl:variable>
                            <xsl:variable name="final_id">
                                <xsl:value-of select="substring-after($temp_id, '#')"/>
                            </xsl:variable>
                            <xsl:value-of select="//tei:name[@xml:id=$final_id]"/>,<xsl:value-of select="$space"
                                                                                                 disable-output-escaping="yes"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="text()"/>,<xsl:value-of select="$space"
                                                                          disable-output-escaping="yes"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="not(normalize-space(text()))">
                            <xsl:variable name="temp_id">
                                <xsl:value-of select="@ref"/>
                            </xsl:variable>
                            <xsl:variable name="final_id">
                                <xsl:value-of select="substring-after($temp_id, '#')"/>
                            </xsl:variable>
                            <xsl:value-of select="//tei:name[@xml:id=$final_id]"/>
                            <br/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="text()"/>
                            <br/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:publicationStmt">
        <a class="bold">Editore: </a>
        <xsl:value-of select="tei:publisher"/>
        <br/>
        <a class="bold">Distribuito da: </a>
        <xsl:value-of select="tei:distributor"/>
        <br/>
        <a class="bold">Disponibilità: </a>
        <xsl:value-of select="tei:availability/tei:p"/>
        <br/>
    </xsl:template>

    <xsl:template match="/tei:teiCorpus/tei:TEI">
        <xsl:apply-templates select="tei:teiHeader"/>
        <div class="radio_holder">
            <input type="radio">
                <xsl:attribute name="type">radio</xsl:attribute>
                <xsl:attribute name="id">r_<xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>_f</xsl:attribute>
                <xsl:attribute name="name"><xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>_fronte_retro</xsl:attribute>
                <xsl:attribute name="checked">checked</xsl:attribute>
            </input>
            <xsl:element name="label">
                <xsl:attribute name="for">r_<xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>_f</xsl:attribute>
                Fronte
            </xsl:element>
            <input type="radio">
                <xsl:attribute name="type">radio</xsl:attribute>
                <xsl:attribute name="id">r_<xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>_r</xsl:attribute>
                <xsl:attribute name="name"><xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>_fronte_retro</xsl:attribute>
            </input>
            <xsl:element name="label">
                <xsl:attribute name="for">r_<xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>_r</xsl:attribute>
                Retro
            </xsl:element>
        </div>
        <div class="f_r_holder">
            <xsl:attribute name="id">f_r_holder_<xsl:value-of select="tei:facsimile/@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates select="tei:facsimile"/>
            <xsl:apply-templates select="tei:text"/>
        </div>
    </xsl:template>

    <xsl:template match="tei:teiHeader">
        <div class="header_c">
            <h3>
                <a class="bold">Titolo: </a>
                <xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:bibl/tei:title"/>
            </h3>
            <xsl:if test="count(tei:fileDesc/tei:sourceDesc/tei:bibl/tei:publisher)>0">
                <p>
                    Pubblicato da:
                    <xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:bibl/tei:publisher"/>
                    <xsl:if test="count(tei:fileDesc/tei:sourceDesc/tei:bibl/tei:pubPlace)>0">
                        di
                        <xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:bibl/tei:pubPlace"/>
                    </xsl:if>
                </p>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="tei:facsimile">
        <div class="immagini_c">
            <xsl:apply-templates select="tei:surface"/>
        </div>
    </xsl:template>

    <xsl:template match="tei:surface">
        <xsl:element name="img">
            <xsl:attribute name="src">
                <xsl:value-of select="tei:graphic/@url"/>
            </xsl:attribute>
            <xsl:if test="position() = 1">
                <xsl:attribute name="class">visible</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
        </xsl:element>
        <canvas>
            <xsl:attribute name="id">can_<xsl:value-of select="@xml:id"/>
            </xsl:attribute>
        </canvas>
    </xsl:template>

    <xsl:template match="tei:text">
        <div class="info_c">
            <xsl:variable name="temp_id_info_fronte" select="tei:body/tei:div[1]/@facs"/>
            <xsl:variable name="final_id_info_fronte" select="substring-after($temp_id_info_fronte, '#')"/>
            <div class="info_r_f visible">
                <xsl:attribute name="id">i_<xsl:value-of select="$final_id_info_fronte"/>
                </xsl:attribute>
                <div class="f_desc">
                    <a class="bold">Descrizione:</a>
                    <xsl:value-of select="tei:body/tei:div[1]/tei:figure/tei:figDesc"/>
                    <br/>
                    <br/>
                    <xsl:if test="count(tei:body/tei:div[1]/tei:figure/tei:head/tei:persName)>0">
                        <a class="bold">Autore:</a>
                        <xsl:value-of select="tei:body/tei:div[1]/tei:figure/tei:head/tei:persName"/>
                    </xsl:if>
                    <xsl:if test="(count(tei:body/tei:div[1]/tei:figure/tei:note)>0) or (count(tei:body/tei:div[1]/tei:figure/tei:fw)>0)">
                        <div class="f_desc_note">
                            <a class="titolo_note bold">Note:</a>
                            <br/>
                            <xsl:apply-templates select="tei:body/tei:div[1]/tei:figure/tei:note"/>
                            <xsl:apply-templates select="tei:body/tei:div[1]/tei:figure/tei:fw"/>
                        </div>
                    </xsl:if>
                </div>
            </div>
            <xsl:variable name="temp_id_info_retro" select="tei:body/tei:div[2]/@facs"/>
            <xsl:variable name="final_id_info_retro" select="substring-after($temp_id_info_retro, '#')"/>
            <div class="info_r_f">
                <xsl:attribute name="id">i_<xsl:value-of select="$final_id_info_retro"/>
                </xsl:attribute>
                <div class="r_desc">
                    <xsl:apply-templates select="tei:body/tei:div[2]/tei:div"/>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="tei:body/tei:div[2]/tei:div[@type='message']">
        <xsl:variable name="temp_id" select="current()/@facs"/>
        <xsl:variable name="final_id" select="substring-after($temp_id, '#')"/>
        <div class="stamp">
            <xsl:attribute name="id">
                <xsl:value-of select="$final_id"/>
            </xsl:attribute>
            <span>
                <xsl:choose>
                    <xsl:when test="count(//tei:zone[@xml:id = $final_id]/@ulx)>0">
                        <xsl:attribute name="data-ulx">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id]/@ulx"/>
                        </xsl:attribute>
                        <xsl:attribute name="data-uly">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id]/@uly"/>
                        </xsl:attribute>
                        <xsl:attribute name="data-lrx">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id]/@lrx"/>
                        </xsl:attribute>
                        <xsl:attribute name="data-lry">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id]/@lry"/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="data-points">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id]/@points"/>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
            <xsl:apply-templates select="tei:opener/tei:dateline"/>
            <xsl:choose>
                <xsl:when test="count(tei:closer/tei:dateline)>0">
                    <div class="text_div">
                        <a class="bold">Testo: </a>
                        <xsl:apply-templates select="tei:opener/tei:salute"/>
                        <xsl:apply-templates select="tei:closer/tei:signed"/>
                    </div>
                    <br/>
                    <xsl:apply-templates select="tei:closer/tei:dateline"/>
                </xsl:when>
                <xsl:otherwise>
                    <div class="text_div">
                        <a class="bold">Testo: </a>
                        <xsl:apply-templates select="tei:opener/tei:salute"/>
                        <xsl:apply-templates select="tei:closer"/>
                        <br/>
                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>

    <xsl:template match="tei:body/tei:div[2]/tei:div[@type='destination']">
        <div class="destination_div">

            <a class="bold">Indirizzo: </a>
            <br/>
            <xsl:apply-templates select="tei:p[last()]/tei:address/tei:addrLine"/>
        </div>
        <xsl:if test="count(tei:p/tei:stamp)>0">
            <div class="stamp_div">
                <br/>
                <a class="bold">Timbri e Francobolli: </a>
                <br/>
                <xsl:apply-templates select="tei:p/tei:stamp"/>
            </div>
        </xsl:if>

        <xsl:if test="count(following-sibling::tei:fw)>0">
            <div class="note_segni_div">
                <a class="bold">Note e altre segni: </a>
                <br/>
                <xsl:apply-templates select="following-sibling::tei:fw"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="tei:fw">
        <xsl:variable name="temp_id_stamp" select="@facs"/>
        <xsl:variable name="final_id_stamp" select="substring-after($temp_id_stamp, '#')"/>
        <a class="stamp">
            <xsl:attribute name="id">
                <xsl:value-of select="$final_id_stamp"/>
            </xsl:attribute>
            -
            <xsl:value-of select="text()"/>
            <xsl:value-of select="tei:placeName"/>
            <br/>
            <span>
                <xsl:choose>
                    <xsl:when test="count(//tei:zone[@xml:id = $final_id_stamp]/@ulx)>0">
                        <xsl:attribute name="data-ulx">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id_stamp]/@ulx"/>
                        </xsl:attribute>
                        <xsl:attribute name="data-uly">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id_stamp]/@uly"/>
                        </xsl:attribute>
                        <xsl:attribute name="data-lrx">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id_stamp]/@lrx"/>
                        </xsl:attribute>
                        <xsl:attribute name="data-lry">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id_stamp]/@lry"/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="data-points">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id_stamp]/@points"/>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </a>
    </xsl:template>

    <xsl:template match="tei:p/tei:stamp">
        <xsl:variable name="temp_id_stamp" select="@facs"/>
        <xsl:variable name="final_id_stamp" select="substring-after($temp_id_stamp, '#')"/>
        <div class="stamp">
            <xsl:attribute name="id">
                <xsl:value-of select="$final_id_stamp"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="@type='postmark'">
                    Timbro:
                </xsl:when>
                <xsl:when test="@type='postage'">
                    Francobollo:
                </xsl:when>
            </xsl:choose>
            <xsl:value-of select="$space" disable-output-escaping="yes"/>
            <xsl:value-of select="text()"/>
            <xsl:apply-templates select="tei:damage"/>
            <xsl:if test="count(tei:date)>0">
                <xsl:apply-templates select="tei:date"/>
            </xsl:if>
            <xsl:if test="count(tei:note)>0">
                <br/>
                <a>Nota:</a>
                <xsl:value-of select="$space" disable-output-escaping="yes"/>
                <xsl:apply-templates select="tei:note"/>
            </xsl:if>
            <span>
                <xsl:choose>
                    <xsl:when test="count(//tei:zone[@xml:id = $final_id_stamp]/@ulx)>0">
                        <xsl:attribute name="data-ulx">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id_stamp]/@ulx"/>
                        </xsl:attribute>
                        <xsl:attribute name="data-uly">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id_stamp]/@uly"/>
                        </xsl:attribute>
                        <xsl:attribute name="data-lrx">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id_stamp]/@lrx"/>
                        </xsl:attribute>
                        <xsl:attribute name="data-lry">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id_stamp]/@lry"/>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="data-points">
                            <xsl:value-of select="//tei:zone[@xml:id = $final_id_stamp]/@points"/>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </div>
        <br/>
    </xsl:template>

    <xsl:template match="tei:damage">
        <xsl:value-of select="text()"/>
        <xsl:value-of select="tei:unclear"/>
    </xsl:template>

    <xsl:template match="tei:address/tei:addrLine">
        <xsl:apply-templates select="tei:unclear"/>
        <xsl:choose>
            <xsl:when test="count(tei:choice)>0">
                <a class="abbr">
                    <xsl:value-of select="tei:choice/tei:abbr"/>
                </a>
                <xsl:value-of select="$space" disable-output-escaping="yes"/>
                <a class="expan">[<xsl:value-of select="tei:choice/tei:expan"/>]
                </a>
                <xsl:value-of select="$space" disable-output-escaping="yes"/>
                <xsl:choose>
                    <xsl:when test="count(tei:persName)>0">
                        <xsl:value-of select="tei:persName"/>
                        <br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <br/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="count(tei:placeName)>0">
                <xsl:choose>
                    <xsl:when test="count(tei:placeName/tei:hi)>0">
                        <a class="underline double">
                            <xsl:value-of select="tei:placeName/tei:hi"/>
                        </a>
                        <br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="tei:placeName"/>
                        <br/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="count(tei:persName)>0">
                <xsl:choose>
                    <xsl:when test="count(tei:persName/tei:hi)>0">
                        <xsl:for-each select="tei:persName/tei:hi">
                            <a class="underline">
                                <xsl:value-of select="text()"/>
                            </a>
                            <xsl:value-of select="$space" disable-output-escaping="yes"/>
                        </xsl:for-each>
                        <br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="tei:persName"/>
                        <br/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="count(tei:gap)>0">
                [...]
                <xsl:value-of select="tei:gap/following-sibling::text()"/>
                <br/>
            </xsl:when>
            <xsl:when test="count(tei:seg)>0">
                <xsl:value-of select="text()"/>
                <xsl:value-of select="$space" disable-output-escaping="yes"/>
                <xsl:apply-templates select="tei:seg"/>
                <xsl:value-of select="tei:seg/following-sibling::text()"/>
                <br/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="text()"/>
                <br/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="tei:closer">
        <xsl:apply-templates select="tei:signed"/>
        <xsl:apply-templates select="tei:dateline"/>
    </xsl:template>

    <xsl:template match="tei:dateline">
        <div class="dateline_div">
            <a class="bold">Data e luogo: </a>
            <xsl:apply-templates select="tei:placeName"/>
            <xsl:apply-templates select="tei:date"/>
        </div>
        <br/>
    </xsl:template>

    <xsl:template match="tei:placeName">
        <xsl:value-of select="text()"/>
        <xsl:value-of select="$space" disable-output-escaping="yes"/>
    </xsl:template>

    <xsl:template match="tei:opener/tei:salute">
        <xsl:choose>
            <xsl:when test="count(tei:choice)>0">
                <xsl:value-of select="text()"/>
                <a class="text-error">
                    <xsl:value-of select="tei:choice/tei:sic"/>
                </a>
                <xsl:value-of select="$space" disable-output-escaping="yes"/>
                <a class="text-fix">[<xsl:value-of select="tei:choice/tei:corr"/>]
                </a>
                <xsl:value-of select="$space" disable-output-escaping="yes"/>
                <xsl:value-of select="tei:choice/following-sibling::text()"/>
                <br/>
            </xsl:when>
            <xsl:when test="count(tei:unclear)>0">
                <xsl:value-of select="text()"/>
                <xsl:apply-templates select="tei:unclear"/>
                <xsl:value-of select="tei:unclear/following-sibling::text()"/>
                <br/>
            </xsl:when>
            <xsl:when test="count(tei:hi)>0">
                <xsl:value-of select="text()"/>
                <xsl:value-of select="$space" disable-output-escaping="yes"/>
                <a class="underline">
                    <xsl:apply-templates select="tei:hi/tei:seg"/>
                </a>
                <xsl:value-of select="tei:hi/following-sibling::text()"/>
                <br/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="text()"/>
                <br/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:unclear">
        <xsl:value-of select="text()"/>
        <xsl:apply-templates select="child::node()"/>
    </xsl:template>

    <xsl:template match="tei:unclear/child::node()">
        <xsl:choose>
            <xsl:when test="name() = 'seg'">
                <xsl:value-of select="text()"/>
            </xsl:when>
            <xsl:when test="name() = 'gap'">[...]</xsl:when>
            <xsl:when test="name() = 'abbr'">
                <xsl:value-of select="text()"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:seg">
        <xsl:choose>
            <xsl:when test="count(tei:g)>0">
                <xsl:value-of select="tei:g"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="text()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:signed">
        <xsl:value-of select="tei:persName"/>
        <xsl:if test="count(tei:persName/tei:gap)>0">[...]</xsl:if>
        <br/>
    </xsl:template>

    <xsl:template match="tei:body/tei:div[1]/tei:figure/tei:note">
        <xsl:value-of select="text()"/>
        <br/>
    </xsl:template>

    <xsl:template match="tei:body/tei:div[1]/tei:figure/tei:fw">
        <xsl:if test="@type='logoCartolina'">
            <a class="bold">Logo:</a>
            <br/>
        </xsl:if>
        <xsl:if test="@type='idno.cartolina'">
            <a class="bold">Identificatore cartolina:</a>
            <br/>
        </xsl:if>
        <xsl:variable name="temp_id_fw_fronte" select="@facs"/>
        <xsl:variable name="final_id_fw_fronte" select="substring-after($temp_id_fw_fronte, '#')"/>
        <a>
            <xsl:attribute name="id">
                <xsl:value-of select="$final_id_fw_fronte"/>
            </xsl:attribute>
            <xsl:value-of select="text()"/>
        </a>
        <br/>
    </xsl:template>

    <xsl:template match="tei:date">
        <xsl:value-of select="text()"/>
        <xsl:apply-templates select="tei:gap"/>
        <xsl:apply-templates select="tei:date"/>
        <xsl:value-of select="following-sibling::text()"/>
    </xsl:template>

    <xsl:template match="tei:gap">[...]</xsl:template>

</xsl:stylesheet>