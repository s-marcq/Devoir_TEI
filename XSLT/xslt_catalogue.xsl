<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">

    <xsl:output method="html" indent="yes"/>

    <!-- variable : nom de fichier pour la page d'accueil -->
    <xsl:variable name="home">
        <xsl:value-of select="concat('catalogue_home', '.html')"/>
    </xsl:variable>

    <!-- variable : code du header repris dans chaque page -->
    <xsl:variable name="header">
        <head>
            <!-- Métadonnées -->
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <xsl:element name="meta">
                <xsl:attribute name="name">description</xsl:attribute>
                <xsl:attribute name="content">
                    <xsl:value-of select="//biblStruct/monogr/title"/>, <xsl:value-of
                        select="//biblStruct/monogr/author"/>
                </xsl:attribute>
            </xsl:element>
            <meta name="author" content="Sarah Marcq"/>
            <title> Catalogue </title>
            <!-- liens vers bootstrap et jquery pour le style -->
            <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"/>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"/>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                rel="stylesheet"
                integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
                crossorigin="anonymous"/>
            <link rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css"/>

            <style>
                /* CSS */
                body {
                    overflow-x: hidden;
                }
                #navbarToggleExternalContent {
                    position: absolute;
                    height: auto;
                    top: 55px;
                    width: 350px;
                    max-width: 100%;
                    z-index: 200000;
                }
                .bi {
                    margin-right: 10px;
                }
                .text-justify {
                    text-align: justify;
                    text-justify: inter-word;
                }
                .grille-img {
                    text-align: center;
                    column-count: 3;
                }
                .img-grille {
                    display: inline-block;
                    width: 100%;
                }
                .img-index {
                    width: 100%;
                    display: block;
                }
                .pointer {
                    cursor: pointer;
                }
                .hover-darker:hover {
                    filter: brightness(80%);
                }</style>
        </head>
    </xsl:variable>

    <!-- variable : retour à l'accueil -->
    <xsl:variable name="return_home">
        <a href="./{$home}" class="nav-link text-white hover-darker">
            <i class="bi bi-house-fill"/>
        </a>
    </xsl:variable>


    <!-- variable : code du menu de navigation repris dans chaque page -->
    <xsl:template name="nav">
        <!-- contenu quand le menu est affiché -->
        <div class="collapse" id="navbarToggleExternalContent">
            <div class="bg-dark p-4 mt-4">
                <h3 class="text-white mb-4 text-center">Navigation</h3>
                <ul class="nav navbar-nav mt-3 mb-2">
                    <xsl:for-each select="//listPerson/person">
                        <xsl:variable name="artiste" select="./@xml:id"/>
                        <xsl:variable name="indice_liste" select="position()"/>
                        <li class="nav-item my-1 my-3">
                            <a class="link text-white hover-darker">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="concat('./', $artiste, '.html')"/>
                                </xsl:attribute>
                                <h5>
                                    <xsl:value-of select="./persName"/>
                                </h5>
                            </a>

                            <ul class="text-white ml-5">
                                <xsl:for-each
                                    select="//entryFree[@corresp = concat('#', $artiste)]/listObject/object">
                                    <li>
                                        <i>
                                            <xsl:value-of
                                                select="./objectIdentifier/objectName/title"/>
                                        </i>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </li>
                    </xsl:for-each>
                </ul>
                <a class="link text-white hover-darker mt-5" href="catalogue_home.html">
                    <p class="text-end mt-5">
                        Accueil<i class="bi bi-house-fill px-3 h3"/>
                    </p>
                </a>
            </div>
        </div>
        <!-- contenu de la barre -->
        <nav class="navbar navbar-dark bg-dark">
            <div class="container-fluid" id="nav">
                <!-- bouton pour afficher le menu -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarToggleExternalContent"
                    aria-controls="navbarToggleExternalContent" aria-expanded="false"
                    aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon hover-darker"/>
                </button>
                <div class="text text-white float-left">
                    <h3>Édition en ligne du <i><xsl:value-of select="//biblStruct/monogr/title"
                            /></i></h3>
                    <h5><xsl:value-of select="//biblStruct/monogr/author"/>, <xsl:value-of
                            select="//biblStruct/monogr/imprint/date"/>
                    </h5>
                </div>
                <!-- bouton de retour à l'accueil -->
                <p class="h1 mr-5">
                    <xsl:copy-of select="$return_home"/>
                </p>
            </div>
        </nav>
    </xsl:template>

    <!-- template de la page d'accueil -->
    <xsl:template name="home">
        <xsl:result-document href="./out/{$home}">
            <!-- chemin du document de sortie -->
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <!-- appel du template du header -->
                <body>
                    <xsl:call-template name="nav"/>
                    <!-- appel du template du menu de navigation -->
                    <div class="row mx-1">
                        <div class="col-sm-0 col-md-2 col-lg-3 my-5"/>
                        <div class="col-sm-12 col-md-8 col-lg-6 my-5">
                            <!-- divs permettant de centrer le conteu avec bootstrap -->

                            <!-- paragraphes d'introduction -->
                            <h4 class="text-justify"> Ce site web est une édition en ligne du
                                        <i><xsl:value-of select="//biblStruct/monogr/title"/></i>
                                écrit par <xsl:value-of select="//biblStruct/monogr/author"/> et
                                publié en <xsl:value-of select="//biblStruct/monogr/imprint/date"
                                />.</h4>
                            <p class="my-4 text-justify"> Les pages sont le resultat d'une
                                    <b>transformation XSLT</b> après un encodage en <b>XML-TEI</b>.
                                Ce projet a été réalisé dans le cadre de l'évaluation du cours
                                d'XSLT du M2 "Technologies numériques appliquées à l'histoire" à
                                l'Ecole des chartes. </p>
                            <p class="d-inline">
                                <a href="https://gallica.bnf.fr/ark:/12148/bpt6k6524683j"
                                    class="mr-5">Consulter le texte d'origine</a>
                            </p>
                            <p class="d-inline p-4">
                                <a href="https://github.com/s-marcq/Devoir_TEI">Consulter l'encodage
                                    XML</a>
                            </p>
                            <p class="mt-4 mb-1">Cliquez sur le <b>menu de navigation</b> en haut à
                                gauche pour naviguer entre les artistes.</p>
                            <p>Les tableaux dont les notices sont consultables :</p>

                            <!-- grille contenant les images des tableaux -->
                            <div class="grid-wrapper mb-5 mt- grille-img">
                                <xsl:for-each select="//standOff/listObject/object">
                                    <!-- itération sur la liste des tableaux -->
                                    <xsl:variable name="ref_tableau" select="concat('#', ./@n)"/>
                                    <!-- variable qui va servir à mettre en relation les attributs n des tableaux dans l'encodage (standOff et corps du texte)-->
                                    <div class="card hover-darker img-grille">
                                        <a class="pointer">
                                            <!-- on recrée le nom de la page html à lier dans l'url en allant chercher l'entrée du tableau n puis l'attribut xml:id de l'artiste de ce tableau -->
                                            <!-- on supprime le "#" pour obtenir artiste.html -->
                                            <xsl:attribute name="href"
                                                select="concat(replace(//body//object[@n = $ref_tableau]/ancestor::entryFree/@corresp, '#', ''), '.html')"/>
                                            <!-- vérifier si l'image du tableau est disponible -->
                                            <xsl:if test=".//title/@facs != ''">
                                                <img class="card-img-top pointer img-index">
                                                  <!-- sélection de l'url de l'image -->
                                                  <xsl:attribute name="src" select=".//title/@facs"/>
                                                  <!-- sélection du titre du tableau -->
                                                  <xsl:attribute name="alt" select=".//title"/>
                                                </img>
                                            </xsl:if>
                                            <div class="card-body no-margin-bottom">
                                                <p class="text text-dark">
                                                  <i>
                                                  <xsl:value-of select=".//title"/>
                                                  </i>
                                                  <!-- affichage du titre de l'oeuvre -->
                                                </p>
                                            </div>
                                        </a>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </div>
                        <div class="col-sm-0 col-md-2 col-lg-3 my-5"/>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>


    <!-- template pour les pages de chaque artiste -> un template pour tous grâce à une boucle for -->
    <xsl:template name="pages_artistes">
        <xsl:for-each select="//listPerson/person">
            <!-- itération sur les artistes listés dans le standOff -->
            <xsl:variable name="artiste" select="./@xml:id"/>
            <!-- stockage de l'id de l'artiste -->
            <xsl:variable name="file" select="concat($artiste, '.html')"/>
            <!-- variable : fichier de sortie pour l'artiste en question -->
            <xsl:result-document href="./out/{$file}">
                <!-- déclaration du document de sortie -->
                <html lang="fr">
                    <xsl:copy-of select="$header"/>
                    <!-- reprise du header -->
                    <body>
                        <xsl:call-template name="nav"/>
                        <!-- reprise du menu de navigation -->
                        <div class="container mt-5">
                            <h1 class="my-4">
                                <xsl:value-of select=".[@xml:id = $artiste]/persName"/>
                                <!-- titre : nom de l'artiste dans la balise persName -->
                            </h1>
                            <div>
                                <h2 class="mt-5">Biographie</h2>
                                <p>
                                    <!-- biographie : contenu de l'entryFree correspondant à l'artiste sauf le listObject -->
                                    <xsl:value-of
                                        select="//entryFree[@corresp = concat('#', $artiste)]/node()[not(name() = 'listObject')]"
                                    />
                                </p>
                                <h2 class="mt-5">Oeuvre(s)</h2>


                                <!-- itération sur les oeuvres de l'entryFree correspondant à l'artiste -->
                                <xsl:for-each
                                    select="//entryFree[@corresp = concat('#', $artiste)]/listObject/object">
                                    <xsl:variable name="numero_tableau"
                                        select="replace(./@n, '#', '')"/>
                                    <!-- stockage du numéro du tableau -->
                                    <div class="row my-5">
                                        <div class="col-8">
                                            <!-- partie gauche de l'écran en bootstrap -->

                                            <ul>
                                                <li>
                                                  <!-- affichage structuré de la notice du tableau -->
                                                  <h3 class="my-2">
                                                  <i>
                                                  <xsl:value-of select=".//title"/>
                                                  </i>
                                                  </h3>
                                                  <p>
                                                  <xsl:value-of select=".//material"/>
                                                  <xsl:value-of select=".//height"/>, <xsl:value-of
                                                  select=".//width"/>
                                                  </p>
                                                  <p class="text-justify">
                                                  <xsl:value-of select="./physDesc"/>
                                                  </p>
                                                  <p class="text-justify">
                                                  <xsl:value-of select="./history"/>
                                                  </p>
                                                </li>
                                            </ul>
                                        </div>
                                        <!-- partie droite de l'écran en bootstrap -->
                                        <div class="col-4 px-4">
                                            <!-- l'image du tableau est disponible -->
                                            <xsl:if test="//standOff/listObject/object[@n = $numero_tableau]//title/@facs != ''">
                                                <img class="img-fluid mt-2">
                                                  <!-- affichage de l'image du tableau en allant chercher l'url correspondant au tableau dans le standOff grâce à l'attribut n -->
                                                  <xsl:attribute name="src">
                                                  <xsl:value-of
                                                  select="//standOff/listObject/object[@n = $numero_tableau]//title/@facs"
                                                  />
                                                  </xsl:attribute>
                                                  <xsl:attribute name="alt">
                                                  <xsl:value-of select=".//title"/>
                                                  </xsl:attribute>
                                                </img>
                                            </xsl:if>
                                        </div>
                                    </div>
                                </xsl:for-each>
                                <div class="flex my-5">
                                    <div class="d-inline-block mr-5">
                                        <!-- si l'artiste n'est pas le premier de la liste, donc s'il a un preceding-sibling -->
                                        <xsl:if
                                            test="//person[@xml:id = $artiste]/preceding-sibling::person[1]/@xml:id != ''">
                                            <a class="btn btn-secondary text-light float-right">
                                                <!-- bouton pour passer à l'artiste précédent, donc la page du preceding-sibling de l'artiste, on récupère son id pour obtenir le nom de sa page html -->
                                                <xsl:attribute name="href"
                                                  select="concat(//person[@xml:id = $artiste]/preceding-sibling::person[1]/@xml:id, '.html')"/>
                                                <b>Artiste précédent</b>
                                            </a>
                                        </xsl:if>
                                    </div>
                                    <div class="d-inline-block mx-2">
                                        <!-- si l'artiste n'est pas le dernier de la liste, donc s'il a un following-sibling -->
                                        <xsl:if
                                            test="//person[@xml:id = $artiste]/following-sibling::person[1]/@xml:id != ''">
                                            <a class="btn btn-info text-light float-right">
                                                <!-- bouton pour passer à l'artiste suivant, donc la page du following-sibling de l'artiste, on récupère son id pour obtenir le nom de sa page html -->
                                                <xsl:attribute name="href"
                                                  select="concat(//person[@xml:id = $artiste]/following-sibling::person[1]/@xml:id, '.html')"/>
                                                <b>Artiste suivant</b>
                                            </a>
                                        </xsl:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

    <!--  appeler l'ensemble des templates à partir de la racine pour produire le document  -->
    <xsl:template match="/">
        <xsl:call-template name="pages_artistes"/>
        <xsl:call-template name="home"/>
    </xsl:template>

</xsl:stylesheet>
