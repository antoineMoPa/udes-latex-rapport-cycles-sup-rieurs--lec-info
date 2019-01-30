%%
%% This is file `udes-genie-these.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% udes-genie-these.dtx  (with options: `these')
%% 
%% Copyright 2018 Charles-Antoine Brunet
%% Stripped from some logic by @antoineMoPa
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Charles-Antoine Brunet and
%%   can be contacted at Charles-Antoine.Brunet@USherbrooke.ca
%% 
%% This work consists of the files udes-genie-these.dtx and udes-genie-these.ins
%% and the derived file udes-genie-these.cls.
%% 
%% udes-genie-these.dtx
%% Copyright 2018 Charles-Antoine Brunet
%%


\RequirePackage{expl3}

%%-----------------------------------------------------------------------------
%%---   IDENTIFICATION   ------------------------------------------------------
%%-----------------------------------------------------------------------------
\ProvidesExplClass{udes-genie-simple}{2019/01/06}{2.0}
  {Universite de Sherbrooke, Faculte de genie: classe de document simples}
  
\LoadClass[letterpaper,12pt]{article}

\RequirePackage[english,french]{babel}
\RequirePackage{xparse,caption,etoolbox,fancyhdr}
\RequirePackage{flafter,geometry,parskip,setspace}

\setlength{\parskip}{1.0ex plus0.25ex minus0ex}
\setlength{\parindent}{0em}
\clubpenalty=10000
\widowpenalty=10000
\geometry{letterpaper,hmargin={1.0cm,1.0cm},vmargin={0cm,0cm},
  foot=0cm,head=0cm,headsep=0.0cm,bindingoffset=0.0cm}
\captionsetup[table]{labelsep=quad,textformat=simple,font=normal,margin=0ex,position=top,skip=0ex}
\captionsetup[figure]{labelsep=quad,textformat=simple,font=normal,margin=0ex,position=bottom,skip=0ex}
\frenchbsetup{ItemLabels=\textendash}

%%-----------------------------------------------------------------------------
%%---   MACROS DE DOCUMENT (USAGER)   --------------------------------------
%%-----------------------------------------------------------------------------
\DeclareDocumentCommand \ConfigurationDocument { m }
{ \keys_set:nn { udes-genie-these } { #1 } }

\keys_define:nn {udes-genie-these}
{
  langue .choices:nn = {francais,english}
    {\tl_gset_eq:NN \g_udesgeniethese_langue_tl \l_keys_choice_tl},
  langue .value_required:n = true,
  type .choices:nn = {dprmaitrise,dprdoctorat,essai,memoire,these}
    {\tl_gset_eq:NN \g_udesgeniethese_type_tl \l_keys_choice_tl},
  type .value_required:n = true,
  programme .choices:nn = {electrique,mecanique,aerospatial,chimique,civil}
    {\tl_gset_eq:NN \g_udesgeniethese_programme_tl \l_keys_choice_tl},
  programme .value_required:n = true,
  liste-figures .bool_gset:N = \g_udesgeniethese_listeDesFigures_bool,
  liste-figures .default:n = true,
  liste-tableaux .bool_gset:N = \g_udesgeniethese_listeDesTableaux_bool,
  liste-tableaux .default:n = true,
  lignes .bool_gset:N = \g_udesgeniethese_lignes_bool,
  lignes .default:n = true,
  fichier-resume-francais .tl_gset:N = \g_udesgeniethese_fichier_resume_francais_tl,
  fichier-resume-francais .value_required:n = true,
  fichier-resume-anglais .tl_gset:N = \g_udesgeniethese_fichier_resume_anglais_tl,
  fichier-resume-anglais .value_required:n = true,
  fichier-remerciements .tl_gset:N = \g_udesgeniethese_fichier_remerciements_tl,
  fichier-remerciements .value_required:n = true,
  fichier-lexique .tl_gset:N = \g_udesgeniethese_fichier_lexique_tl,
  fichier-lexique .value_required:n = true,
  fichier-symboles .tl_gset:N = \g_udesgeniethese_fichier_symboles_tl,
  fichier-symboles .value_required:n = true,
  fichier-acronymes .tl_gset:N = \g_udesgeniethese_fichier_acronymes_tl,
  fichier-acronymes .value_required:n = true,
  fichiers-references .tl_gset:N = \g_udesgeniethese_fichiers_references_tl,
  fichiers-references .value_required:n = true,
}

\DeclareDocumentCommand \Auteur {mm}
{
  \tl_gset:Nn \g_udesgeniethese_auteur_prenom_tl {#1}
  \tl_gset:Nn \g_udesgeniethese_auteur_nom_tl {#2}
}

\DeclareDocumentCommand \Date {mm}
{
  \tl_gset:Nn \g_udesgeniethese_date_mois_tl {#1}
  \tl_gset:Nn \g_udesgeniethese_date_annee_tl {#2}
}

\DeclareDocumentCommand \Dedicace {+m}
{ \tl_gset:Nn \g_udesgeniethese_dedicace_tl {#1} }

\DeclareDocumentCommand \Directeur {mm}
{
  \tl_gset:Nn \g_udesgeniethese_jury_directeur_tl {#1\ #2}
  \tl_gset_eq:NN \g_udesgeniethese_jury_directeur_mf_tl \c_udesgeniethese_male_tl
}

\DeclareDocumentCommand \Directrice {mm}
{
  \tl_gset:Nn \g_udesgeniethese_jury_directeur_tl {#1\ #2}
  \tl_gset_eq:NN \g_udesgeniethese_jury_directeur_mf_tl \c_udesgeniethese_female_tl
}

\DeclareDocumentCommand \Codirecteur {mm}
{
  \clist_gput_right:Nn \g_udesgeniethese_jury_codirecteurs_cl {#1\ #2}
  \seq_gput_right:NV \g_udesgeniethese_jury_codirecteurs_mf_seq \c_udesgeniethese_male_tl
}

\DeclareDocumentCommand \Codirectrice {mm}
{
  \clist_gput_right:Nn \g_udesgeniethese_jury_codirecteurs_cl {#1\ #2}
  \seq_gput_right:NV \g_udesgeniethese_jury_codirecteurs_mf_seq \c_udesgeniethese_female_tl
}

\DeclareDocumentCommand \Evaluateur {mm}
{
  \clist_gput_right:Nn \g_udesgeniethese_jury_evaluateurs_cl {#1\ #2}
  \seq_gput_right:NV \g_udesgeniethese_jury_evaluateurs_mf_seq \c_udesgeniethese_male_tl
}

\DeclareDocumentCommand \Evaluatrice {mm}
{
  \clist_gput_right:Nn \g_udesgeniethese_jury_evaluateurs_cl {#1\ #2}
  \seq_gput_right:NV \g_udesgeniethese_jury_evaluateurs_mf_seq \c_udesgeniethese_female_tl
}

\DeclareDocumentCommand \MotsClesAnglais {m}
{ \tl_gset:Nn \g_udesgeniethese_mots_cles_anglais_tl {#1} }

\DeclareDocumentCommand \MotsClesFrancais {m}
{ \tl_gset:Nn \g_udesgeniethese_mots_cles_francais_tl {#1} }

\DeclareDocumentCommand \TitreAnglais {+m}
{ \tl_gset:Nn \g_udesgeniethese_titre_anglais_tl {#1} }

\DeclareDocumentCommand \TitreFrancais {+m}
{ \tl_gset:Nn \g_udesgeniethese_titre_francais_tl {#1} }

%%-----------------------------------------------------------------------------
%%---   MISE EN PAGE   --------------------------------------------------------
%%-----------------------------------------------------------------------------
\setlength{\parskip}{1.5ex plus0.25ex minus0ex}
\setlength{\parindent}{0em}
\clubpenalty=10000
\widowpenalty=10000
\geometry{letterpaper,hmargin={2.5cm,2.5cm},vmargin={1.5cm,1.5cm},
  foot=0.8cm,head=0.9cm,headsep=0.35cm,bindingoffset=0.5cm}
\captionsetup[table]{labelsep=quad,textformat=simple,font=normal,margin=1ex,position=top,skip=0.1ex}
\captionsetup[figure]{labelsep=quad,textformat=simple,font=normal,margin=1ex,position=bottom,skip=1ex}
\frenchbsetup{ItemLabels=\textendash}


\renewcommand*{\subsubsection}{\@startsection{subsubsection}{3}{0pt}
  {-0.3ex plus0.03ex minus0ex}{0.15ex plus 0.015ex minus0ex}{\normalfont\normalsize\sffamily\bfseries}}

\renewcommand*{\subsection}{\@startsection{subsection}{2}{0pt}
  {-0.6ex plus0.06ex minus0ex}{0.3ex plus0.03ex minus0ex}{\normalfont\large\sffamily\bfseries}}

\renewcommand*{\section}{\@startsection{section}{1}{0pt}
  {-1.2ex plus0.12ex minus0ex}{0.6ex plus0.06ex minus0ex}{\normalfont\Large\sffamily\bfseries}}


\addto\captionsfrench
{
  \tl_gset:Nn \contentsname {TABLE~DES~MATI\`ERES}
  \tl_gset:Nn \listfigurename {LISTE~DES~FIGURES}
  \tl_gset:Nn \listtablename {LISTE~DES~TABLEAUX}
  \tl_gset:Nn \chaptername {CHAPITRE}
  \tl_gset:Nn \bibname {LISTE~DES~R\'EF\'ERENCES}
  \tl_gset:Nn \appendixname {ANNEXE}
  \tl_gset:Nn \partname {PARTIE}
  \tl_gset:Nn \figurename {Figure}
  \tl_gset:Nn \tablename {Tableau}
  \tl_gset:Nn \CaptionSeparator {~~}
  \tl_gset:Nn \indexname {INDEX}
  \tl_gset:Nn \glossaryname {LEXIQUE}
  \tl_gset:Nn \abstractname {R\'ESUM\'E}
  \tl_gset:Nn \refname {LISTE~DES~R\'EF\'ERENCES}
  \tl_gset:Nn \prefacename {PR\'EFACE}
  \tl_gset:Nn \enclname {P.~J.~}
  \tl_gset:Nn \ccname {Copie~\`a~}
  \tl_gset:Nn \headtoname {\`A}
  \tl_gset:Nn \pagename {page}
  \tl_gset:Nn \seename {{\emph{voir}}}
  \tl_gset:Nn \alsoname {{\emph{voir~aussi}}}
  \tl_gset:Nn \proofname {D\'emonstration}
  \tl_gset:Nn \g_udesgeniethese_listsymbolsname_tl {LISTE~DES~SYMBOLES}
  \tl_gset:Nn \g_udesgeniethese_listacronymsname_tl {LISTE~DES~ACRONYMES}
  \tl_gset:Nn \g_udesgeniethese_acknowledgementsname_tl {REMERCIEMENTS}
  \tl_gset:Nn \g_udesgeniethese_udesname_tl {UNIVERSIT\'E~DE~SHERBROOKE}
  \tl_gset:Nn \g_udesgeniethese_facultyname_tl {Facult\'e~de~g\'enie}
  \tl_gset:Nn \g_udesgeniethese_specialityname_tl {Sp\'ecialit\'e~:~}
  \tl_gset:Nn \g_udesgeniethese_juryname_tl {MEMBRES~DU~JURY}
  \tl_gset:Nn \g_udesgeniethese_adressname_tl {Sherbrooke~(Qu\'ebec)~Canada}
  \tl_gset:Nn \g_udesgeniethese_motsclesname_tl {Mots-cl\'es~:}
  \tl_gset:Nn \g_udesgeniethese_jury_codirname_tl {Codirecteur}
  \tl_gset:Nn \g_udesgeniethese_jury_codirnamef_tl {Codirectrice}
  \tl_gset:Nn \g_udesgeniethese_jury_dirname_tl {Directeur}
  \tl_gset:Nn \g_udesgeniethese_jury_dirnamef_tl {Directrice}
  \tl_gset:Nn \g_udesgeniethese_jury_evalname_tl {\'Evaluateur}
  \tl_gset:Nn \g_udesgeniethese_jury_evalnamef_tl {\'Evaluatrice}
}

\addto\captionsenglish
{
  \tl_gset:Nn \contentsname {TABLE~OF~CONTENTS}
  \tl_gset:Nn \listfigurename {LIST~OF~FIGURES}
  \tl_gset:Nn \listtablename {LIST~OF~TABLES}
  \tl_gset:Nn \chaptername {CHAPTER}
  \tl_gset:Nn \bibname {LIST~OF~REFERENCES}
  \tl_gset:Nn \appendixname {APPENDIX}
  \tl_gset:Nn \partname {PART}
  \tl_gset:Nn \figurename {Figure}
  \tl_gset:Nn \tablename {Table}
  \tl_gset:Nn \glossaryname {GLOSSARY}
  \tl_gset:Nn \CaptionSeparator {~~}
  \tl_gset:Nn \prefacename {PREFACE}
  \tl_gset:Nn \refname {REFERENCES}
  \tl_gset:Nn \abstractname {ABSTRACT}~
  \tl_gset:Nn \indexname {INDEX}
  \tl_gset:Nn \enclname {encl}
  \tl_gset:Nn \ccname {cc}
  \tl_gset:Nn \headtoname {To}
  \tl_gset:Nn \pagename {Page}
  \tl_gset:Nn \seename {see}
  \tl_gset:Nn \alsoname {see~also}
  \tl_gset:Nn \proofname {Proof}
  \tl_gset:Nn \g_udesgeniethese_listsymbolsname_tl {LIST~OF~SYMBOLS}
  \tl_gset:Nn \g_udesgeniethese_adressname_tl {Sherbrooke~(Qu\'ebec)~Canada}
  \tl_gset:Nn \g_udesgeniethese_listacronymsname_tl {LIST~OF~ACRONYMS}
  \tl_gset:Nn \g_udesgeniethese_acknowledgementsname_tl {ACKNOWLEDGEMENTS}
  \tl_gset:Nn \g_udesgeniethese_udesname_tl {UNIVERSIT\'E~DE~SHERBROOKE}
  \tl_gset:Nn \g_udesgeniethese_facultyname_tl {Facult\'e~de~g\'enie}
  \tl_gset:Nn \g_udesgeniethese_specialityname_tl {Specialit\'e:~}
  \tl_gset:Nn \g_udesgeniethese_juryname_tl {JURY~MEMBERS}
  \tl_gset:Nn \g_udesgeniethese_motsclesname_tl {Keywords:}

  \tl_gset:Nn \g_udesgeniethese_jury_codirname_tl {Co-supervisor}
  \tl_gset:Nn \g_udesgeniethese_jury_codirnamef_tl {Co-supervisor}
  \tl_gset:Nn \g_udesgeniethese_jury_dirname_tl {Supervisor}
  \tl_gset:Nn \g_udesgeniethese_jury_dirnamef_tl {Supervisor}%Directress
  \tl_gset:Nn \g_udesgeniethese_jury_evalname_tl {Examiner} %Internal et external
  \tl_gset:Nn \g_udesgeniethese_jury_evalnamef_tl {Examiner} %Internal et external
}
%%-----------------------------------------------------------------------------
%%---   MESSAGES D'ERREURS   --------------------------------------------------
%%-----------------------------------------------------------------------------
\msg_new:nnnn {udesgeniethese}{auteur_nom_vide}{Le~nom~de~l'auteur~du~document~n'est~pas~specifie.~Specifiez-le~avec~la~macro~\Auteur~dans~le~preambule.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{auteur_prenom_vide}{Le~prenom~de~l'auteur~du~document~n'est~pas~specifie.~Specifiez-le~avec~la~macro~\Auteur~dans~le~preambule.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{config_fichier_vide}{Le~fichier~pour~#1~n'est~pas~specifie.~Specifiez-le~avec~la~cle~'#2'~dans~la~configuration~du~document.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{config_fichiers_vides}{Les~fichiers~pour~#1~ne~sont~pas~specifies.~Specifiez-les~avec~la~cle~'#2'~dans~la~configuration~du~document.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{config_langue_vide}{La~langue~principale~du~document~n'est~pas~specifiee.~Specifiez-la~avec~la~cle~'langue'~dans~la~configuration~du~document.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{config_programme_vide}{Le~programme~du~document~n'est~pas~specifie.~Specifiez-le~avec~la~cle~'programme'~dans~la~configuration~du~document.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{config_type_vide}{Le~type~du~document~n'est~pas~specifie.~Specifiez-le~avec~la~cle~'type'~dans~la~configuration~du~document.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{date_annee_vide}{L'annee~de~la~date~du~document~n'est~pas~specifiee.~Specifiez-la~avec~la~macro~\Date~dans~le~preambule.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{date_mois_vide}{Le~mois~de~la~date~du~document~n'est~pas~specifie.~Specifiez-le~avec~la~macro~\Date~dans~le~preambule.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{dprdoctorat_max_pages}{La~DPR~de~doctorat~semble~longue.~Le~protocole~suggere~de~25~a~40~pages.}{Consultez~le~protocole~de~redaction.}

\msg_new:nnnn {udesgeniethese}{dprmaitrise_max_pages}{La~DPR~de~maitrise~semble~longue.~Le~protocole~suggere~de~20~a~30~pages.}{Consultez~le~protocole~de~redaction.}

\msg_new:nnnn {udesgeniethese}{essai_max_pages}{L'essai~semble~long.~Le~protocole~exige~un~maximum~de~70~pages.}{Consultez~le~protocole~de~redaction.}

\msg_new:nnnn {udesgeniethese}{memoire_max_pages}{Le~memoire~semble~long.~Le~protocole~exige~un~maximum~de~120~pages.}{Consultez~le~protocole~de~redaction.}

\msg_new:nnnn {udesgeniethese}{mots_cles_anglais_vide}{Les~mots-cles~anglais~ne~sont~pas~specifies.~Specifiez-les~avec~la~macro~\MotsClesAnglais~dans~le~preambule.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{mots_cles_francais_vide}{Les~mots-cles~francais~ne~sont~pas~specifies.~Specifiez-les~avec~la~macro~\MotsClesFrancais~dans~le~preambule.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{remerciements_longs}{Les~remerciements~doivent~etre~d'une~page~maximum.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{resume_anglais_long}{Le~resume~anglais~doit~etre~d'une~page~maximum,~incluant~les~mots-cles.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{titre_resume_mots_cles_anglais}{Le~titre,~le~resume~et~les~mots-cles~anglais~doivent~etre~donnes.~On~ne~peut~donner~l'un~sans~les~autres.}{Consultez~la~documentation.}

\msg_new:nnnn {udesgeniethese}{resume_francais_long}{Le~resume~francais~doit~etre~d'une~page~maximum,~incluant~les~mots-cles.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{these_max_pages}{La~these~semble~longue.~Le~protocole~exige~un~maximum~de~250~pages}{Consultez~le~protocole~de~redaction.}

\msg_new:nnnn {udesgeniethese}{titre_anglais_vide}{Le~titre~anglais~du~document~n'est~pas~specifie.~Specifiez-le~avec~la~macro~\TitreAnglais~dans~le~preambule.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{titre_francais_vide}{Le~titre~francais~du~document~n'est~pas~specifie.~Specifiez-le~avec~la~macro~\TitreFrancais~dans~le~preambule.}{Consultez~la~documentation~de~la~classe.}

\msg_new:nnnn {udesgeniethese}{aerospatial}{Le~type~du~document~doit~etre~essai~si~le~programme~est~aerospatial.~Specifiez-le~~bon~type~dans~la~configuration~du~document.}{Consultez~la~documentation~de~la~classe.}

%%-----------------------------------------------------------------------------
%%---   MACROS INTERNES   --------------------------------------------------
%%-----------------------------------------------------------------------------
\fancypagestyle{chapitre}
{\fancyhf{} \cfoot{\thepage} \renewcommand{\headrulewidth}{0pt}}

\newcommand*{\__udesgeniethese_chapter}[2][default]
{
  \ifnum \c@secnumdepth >\m@ne
  \if@mainmatter
  \refstepcounter{chapter}
  \typeout{\chaptername\space\thechapter.}
  \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}
  \else
  \addcontentsline{toc}{chapter}{\protect\numberline#1}
  \fi
  \else
  \addcontentsline{toc}{chapter}{\protect\numberline#1}
  \fi
  \chaptermark{#1}
  \addtocontents{lof}{\protect\addvspace{10\p@}}
  \addtocontents{lot}{\protect\addvspace{10\p@}}
  \if@twocolumn
  \@topnewpage[\__udesgeniethese_makechapterhead{#2}]
  \else
  \__udesgeniethese_makechapterhead{#2}
  \@afterheading
  \fi
}

\newcommand*{\__udesgeniethese_makechapterhead}[1]
{
  {
    \parindent \z@ \normalfont % \raggedright
    \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
    \LARGE\sffamily\bfseries \chaptername\space \thechapter
    \par\nobreak
    \vskip 0\p@
    \fi
    \fi
    \interlinepenalty\@M
    \LARGE\sffamily\bfseries #1 \par\nobreak
    \vskip 30\p@
  }
}

\newcommand*{\__udesgeniethese_schapter}[1]
{
  \if@twocolumn
  \@topnewpage[\__udesgeniethese_makeschapterhead{#1}]
  \else
  \__udesgeniethese_makeschapterhead{#1}
  \@afterheading
  \fi
}

\newcommand*{\__udesgeniethese_makeschapterhead}[1]
{
  {
    \parindent \z@ \normalfont %\raggedright
    \vskip 0\p@
    \interlinepenalty\@M
    \LARGE\sffamily\bfseries #1 \par\nobreak
    \vskip 30\p@
  }
} 


%% 
%%
%% End of file `udes-genie-these.cls'.
