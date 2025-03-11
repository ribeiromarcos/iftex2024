\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{iftex2024}[2024 Classe IFTeX2024 para trabalhos academicos por Marcos Roberto Ribeiro]%

% --------------------------------------------------
% Pacotes essenciais para inicialização
% --------------------------------------------------
% Testes condicionais
\RequirePackage{ifthen}%
% Opções chave-valor
\RequirePackage{xkeyval}%

% --------------------------------------------------
% Tipos de documentos
% --------------------------------------------------
\newcommand{\tipodoc}{tcc}%
% Incluir elementos pré-textuais
\newcommand{\pretextual}{TRUE}%
\DeclareOptionX{artigo}{%
  \renewcommand{\tipodoc}{artigo}%
  \renewcommand{\pretextual}{FALSE}%
}%
\DeclareOptionX{atividade}{%
  \renewcommand{\tipodoc}{atividade}%
}%
\DeclareOptionX{dissertacao}{%
  \renewcommand{\tipodoc}{dissertacao}%
}%
\DeclareOptionX{estagio}{%
  \renewcommand{\tipodoc}{estagio}%
}%
\DeclareOptionX{tcc}{%
  \renewcommand{\tipodoc}{tcc}%
}%
\DeclareOptionX{tese}{%
  \renewcommand{\tipodoc}{tese}%
}%
\DeclareOptionX{capa}{%
  \renewcommand{\pretextual}{TRUE}%
}%

% --------------------------------------------------
% Tipos de fontes
% --------------------------------------------------
\newcommand{\tipofonte}{arial}%
\DeclareOptionX{times}{%
 \renewcommand{\tipofonte}{times}%
}%

\newcommand{\recuosum}{1.25cm}%
\DeclareOptionX{recuosum}{\renewcommand{\recuosum}{#1}}%

% --------------------------------------------------
% Repassa demais opções para a classe herdada
% --------------------------------------------------
\ProcessOptionsX\relax%

% --------------------------------------------------
% Herança da classe article
% --------------------------------------------------

\ifthenelse{\equal{\tipodoc}{artigo}}{%
  \LoadClass[12pt]{article}%
}{%
  \LoadClass[12pt]{report}%
}%

% --------------------------------------------------
% Pacotes Usados
% --------------------------------------------------
% Personalização do formato página
\RequirePackage[a4paper,margin=3cm,right=2cm,bottom=2cm]{geometry}%
% Cabeçalho de páginas
\RequirePackage{fancyhdr}%
% Codificação de caracteres
\RequirePackage[T1]{fontenc}%
\RequirePackage[utf8]{inputenc}%
% Definição da fonte
\ifthenelse{\equal{\tipofonte}{times}}{%
  % Times New Roman
  \RequirePackage{times}%
  \renewcommand{\familydefault}{\rmdefault}%
}{%
  % Arial
  \RequirePackage{helvet}%
  \renewcommand{\familydefault}{\sfdefault}%
}%
% Indenta primeiro parágrafo
\RequirePackage{indentfirst}%
% Espaçamento entre linhas
\RequirePackage{setspace}%
% Idioma português
\RequirePackage[main=brazil,english]{babel}%
% Referências bibliográficas
\RequirePackage{biblatexfix}%
% Metadados
\RequirePackage{titling}%
% Formatação de títulos
\RequirePackage[explicit]{titlesec}%
% Formatação de entradas de sumário
\RequirePackage[titles]{tocloft}%
% Flutuantes personalizados
\RequirePackage{newfloat}%
% Gráficos
\RequirePackage{graphicx}%
% Rótulos de flutuantes
\RequirePackage[labelsep=endash,skip=0pt]{caption}%
% Alinhamento de legendas a esquerda em flutuantes
\RequirePackage{varwidth}%
% Tabelas
\RequirePackage{tabularx}%
% Ambientes mono espaçados
\RequirePackage{fvextra}%
% Citações
\RequirePackage[threshold=3]{csquotes}%
% Pacotes matemáticos
\RequirePackage{amsmath,amsfonts}%
\RequirePackage{amssymb,amsthm}%
% Inclusão de PDFs
\RequirePackage{pdfpages}%
% Personalização de listas
\RequirePackage{enumitem}%
% Nota de rodapé
\RequirePackage[hang]{footmisc}%
% PDF com hyperlinks
\RequirePackage[hypertexnames=false]{hyperref}%
\RequirePackage{bookmark}%
% Manipulação de strings
\RequirePackage{xstring}%
% Geração de índice
\RequirePackage{imakeidx}%

% -------------------------------------------------------
% Metadados
% -------------------------------------------------------
% Título
\newcommand{\theTitulo}{}%
\newcommand{\titulo}[1]{%
  \renewcommand{\theTitulo}{#1}}%
\renewcommand{\title}{\titulo}%
\newcommand{\theTituloEstrangeiro}{}%
\newcommand{\tituloestrangeiro}[1]{%
  \renewcommand{\theTituloEstrangeiro}{#1}}%
% Autor
\newcommand{\theAutor}{}%
\newcommand{\autor}[1]{%
  \renewcommand{\theAutor}{#1}}%
\renewcommand{\author}{\autor}%
% E-mail
\newcommand{\theEmail}{}%
\newcommand{\email}[1]{%
  \renewcommand{\theEmail}{#1}}%
% Data (AAAA-MM-DD, AAAA-MM ou AAAA)
\newcommand{\theData}{}%
\newcommand{\theAno}{}%
\newcommand{\nomeMes}[1]{%
  \ifcase #1%
  \or Janeiro \or Fevereiro \or Março \or Abril%
  \or Maio \or Junho \or Julho \or Agosto%
  \or Setembro \or Outubro \or Novembro \or Dezembro%
  \else {}%
  \fi%
}%
\newcommand{\tempAno}{}%
\newcommand{\tempNumMes}{}%
\newcommand{\tempDia}{}%
\newcommand{\tempMes}{}%
\newcommand{\processaData}[1]{%
  \StrBefore{#1}{-}[\tempAno]% AAAA
  \StrBehind{#1}{-}[\tempNumMes]% MM-DD ou MM
  \StrCount{\tempNumMes}{-}[\numHyfens]% Posição do hífen
  \ifthenelse{\equal{\numHyfens}{1}}{% Testa se é MM-DD
    \StrBehind{\tempNumMes}{-}[\tempDia]% DD
    \StrBefore{\tempNumMes}{-}[\tempNumMes]% MM
  }{}%
  \IfInteger{\tempNumMes}{% Testa se MM é numérico
    \renewcommand{\tempMes}{\nomeMes{\tempNumMes}}%
  }{%
    \renewcommand{\tempMes}{}%
    \renewcommand{\tempDia}{}%
  }%
  \ifthenelse{\equal{\tempAno}{}}{%
    \renewcommand{\tempAno}{#1}%
  }{}%
}%
\newcommand{\data}[1]{%
  \processaData{#1}%
  \ifthenelse{\equal{\tempDia}{}}{%
    \ifthenelse{\equal{\tempMes}{}}{%
      \renewcommand{\theData}{\tempAno}%
    }{%
      \renewcommand{\theData}{{\tempMes} de {\tempAno}}%
    }%
  }{%
    \renewcommand{\theData}{{\tempDia} de {\tempMes} de {\tempAno}}%
  }%
  \renewcommand{\theAno}{\tempAno}%
}%
% Data de submissão (para artigos)
\newcommand{\theDataSub}{}%
\newcommand{\submissao}[1]{%
  \processaData{#1}%
  \ifthenelse{\equal{\tempDia}{}}{%
    \ifthenelse{\equal{\tempMes}{}}{%
      \renewcommand{\theDataSub}{\tempAno}%
    }{%
      \renewcommand{\theDataSub}{{\tempMes} de {\tempAno}}%
    }%
  }{%
    \renewcommand{\theDataSub}{{\tempDia} de {\tempMes} de {\tempAno}}%
  }%
}%
% Local
\newcommand{\theLocal}{}%
\newcommand{\local}[1]{%
  \renewcommand{\theLocal}{#1}%
}%
% Instituição
\newcommand{\theInstituicaoSigla}{IFMG}%
\newcommand{\theInstituicao}{Instituto Federal de Educação, Ciência e Tecnologia de Minas Gerais}%
\newcommand{\theInstituicaoCompleto}{{\theInstituicao} ({\theInstituicaoSigla})}%
\newcommand{\instituicao}[2][IFMG]{%
  \renewcommand{\theInstituicaoSigla}{#1}%
  \renewcommand{\theInstituicao}{#2}%
  \ifthenelse{\equal{\theInstituicaoSigla}{}}{%
    \renewcommand{\theInstituicaoCompleto}{\theInstituicao}%
  }{%
    \renewcommand{\theInstituicaoCompleto}{{\theInstituicao} ({\theInstituicaoSigla})}%
  }%
}%
% Campus
\newcommand{\theCampus}{}%
\newcommand{\campus}[1]{%
  \renewcommand{\theCampus}{#1}%
}%
% Curso
\newcommand{\theCurso}{}%
\newcommand{\theCursoTitulo}{}%
\newcommand{\theCursoTipo}{}%
\newcommand{\titulacao}[1]{%
  \renewcommand{\theCursoTitulo}{#1}%
}%
\newcommand{\curso}[2]{%
%   \renewcommand{\theCursoTitulo}{#1}%
  \renewcommand{\theCursoTipo}{#1}%
  \renewcommand{\theCurso}{#2}%
}%
% Disciplina
\newcommand{\theDisciplina}{}%
\newcommand{\disciplina}[1]{%
  \renewcommand{\theDisciplina}{#1}%
}%
% Professor
\newcommand{\theProfessorRotulo}{Professor}%
\newcommand{\theProfessor}{}%
\newcommand{\professor}[2][M]{%
  \renewcommand{\theProfessor}{#2}%
  \ifthenelse{\equal{#1}{F}}{%
    \renewcommand{\theProfessorRotulo}{Professora}%
  }{}%
}%
% Linha de pesquisa e área de concentração para mestrado e doutorado
\newcommand{\theLinhaPesquisa}{}%
\newcommand{\linhapesquisa}[1]{%
  \renewcommand{\theLinhaPesquisa}{#1}%
}%
\newcommand{\theAreaConcentracao}{}%
\newcommand{\areaconcentracao}[1]{%
  \renewcommand{\theAreaConcentracao}{#1}%
}%
% Empresa e horas para estágio
\newcommand{\theEmpresa}{}%
\newcommand{\empresa}[1]{%
  \renewcommand{\theEmpresa}{#1}%
}%
\newcommand{\theHoras}{}%
\newcommand{\horas}[1]{%
  \renewcommand{\theHoras}{#1}%
}%
% Orientador
\newcommand{\theOrientadorArtigo}{o}%
\newcommand{\theOrientadorRotulo}{Orientador}%
\newcommand{\theOrientador}{}%
\newcommand{\orientador}[2][M]{%
  \renewcommand{\theOrientador}{#2}%
  \ifthenelse{\equal{#1}{M}}{%
    \renewcommand{\theOrientadorArtigo}{o}%
    \renewcommand{\theOrientadorRotulo}{Orientador}%
  }{%
    \renewcommand{\theOrientadorArtigo}{a}%
    \renewcommand{\theOrientadorRotulo}{Orientadora}%
  }%
}%
\newcommand{\theOrientadorInstituicao}{%
  \ifthenelse{\equal{\theInstituicaoSigla}{}}{%
    \theInstituicao%
  }{%
    \theInstituicaoSigla%
  }%
  \ifthenelse{\equal{\theCampus}{}}{}{%
    \space -- {\theCampus}%
  }%
}%
% Coorientador
\newcommand{\theCoorientadorArtigo}{o}%
\newcommand{\theCoorientadorRotulo}{Coorientador}%
\newcommand{\theCoorientador}{}%
\newcommand{\coorientador}[2][M]{%
  \renewcommand{\theCoorientador}{#2}%
  \ifthenelse{\equal{#1}{M}}{%
    \renewcommand{\theCoorientadorArtigo}{o}%
    \renewcommand{\theCoorientadorRotulo}{Coorientador}%
  }{%
    \renewcommand{\theCoorientadorArtigo}{a}%
    \renewcommand{\theCoorientadorRotulo}{Coorientadora}%
  }%
}%
\newcommand{\theCoorientadorInstituicao}{\theOrientadorInstituicao}%
\newcommand{\instituicaocoorientador}[1]{%
  \renewcommand{\theCoorientadorInstituicao}{#1}%
}%

% Membros banca
\newcount\contMembroBanca\contMembroBanca0%
\newcommand\membrobanca[2]{%
  \global\@namedef{NomeMembroBanca:\expandafter\the\contMembroBanca}{#1}%
  \global\@namedef{LocalMembroBanca:\expandafter\the\contMembroBanca}{#2}%
  \global\advance\contMembroBanca by 1%
}%

% Alguns comandos personalizados
\newcommand{\comando}[1]{\textbf{$\backslash$#1}}%
\newcommand{\iftex}{IF\TeX2024}%
\newcommand{\latex}{\LaTeX}%

% -------------------------------------------------------
% Preâmbulos
% -------------------------------------------------------
% Estágio
\newcommand{\thePreambuloEstagio}{%
  Relatório de estágio apresentado ao Curso de {\theCursoTipo} em {\theCurso} do {\theInstituicaoCompleto} -- {\theCampus} para obtenção do grau de {\theCursoTitulo} em {\theCurso}.%
}%
% TCC
\newcommand{\thePreambuloTCC}{%
  Trabalho de conclusão de curso apresentado ao Curso de {\theCursoTipo} em {\theCurso} do {\theInstituicaoCompleto} -- {\theCampus} para obtenção do grau de {\theCursoTitulo} em {\theCurso}.%
}%
% Dissertação
\newcommand{\thePreambuloDissetacao}{%
  Dissertação de mestrado apresentada ao Curso de {\theCursoTipo} em {\theCurso} do {\theInstituicaoCompleto} -- {\theCampus} para obtenção do título de {\theCursoTitulo} em {\theCurso}.%
}%
% Tese
\newcommand{\thePreambuloTese}{%
  Tese de doutorado apresentada ao Curso de {\theCursoTipo} em {\theCurso} do {\theInstituicaoCompleto} -- {\theCampus} para obtenção do título de {\theCursoTitulo} em {\theCurso}.%
}%
% Definição de preâmbulo de acordo com tipo de documento
\newcommand{\thePreambulo}{%
  \ifthenelse{\equal{\tipodoc}{artigo}}{%
    \ifthenelse{\equal{\pretextual}{TRUE}}{%
      \thePreambuloTCC%
    }{}%
  }{%
    \ifthenelse{\equal{\tipodoc}{dissertacao}}{%
      \thePreambuloDissetacao%
    }{}%
    \ifthenelse{\equal{\tipodoc}{estagio}}{%
      \thePreambuloEstagio%
    }{}%
    \ifthenelse{\equal{\tipodoc}{tcc}}{%
      \thePreambuloTCC%
    }{}%
    \ifthenelse{\equal{\tipodoc}{tese}}{%
      \thePreambuloTese%
    }{}%
  }%
}%

% Preâmbulo personalizado
\newcommand{\preambulo}[1]{%
  \renewcommand{\thePreambulo}{#1}%
}%

% -------------------------------------------------------
% Formatação de títulos
% -------------------------------------------------------
% Capítulos
\titleformat{name=\chapter}{\normalfont\bfseries}{\thechapter\space}{0pt}{\MakeUppercase{#1}}%
\titleformat{name=\chapter,numberless}{\normalfont\bfseries\filcenter}{}{0pt}{\bookmarksetup{startatroot}\addcontentsline{toc}{chapter}{#1}\MakeUppercase{#1}}%
\titlespacing{\chapter}{0pt}{-\baselineskip}{1.5em}[0em]%
\titlespacing{\section}{0pt}{1.5em}{1.5em}%
\titlespacing{\subsection}{0pt}{1.5em}{1.5em}%
\titlespacing{\subsubsection}{0pt}{1.5em}{1.5em}%
\titlespacing{\paragraph}{0pt}{1.5em}{1.5em}%
% Seções
\ifthenelse{\equal{\tipodoc}{artigo}}{%
    \titleformat{name=\section}{\normalfont\bfseries}{\thesection\space}{0pt}{\MakeUppercase{#1}}%
    \titleformat{name=\section,numberless}{\normalfont\bfseries\filcenter}{}{0pt}{\addcontentsline{toc}{section}{#1}\MakeUppercase{#1}}%
    \titleformat{name=\subsection}{\normalfont\bfseries}{\thesubsection\space}{0pt}{#1}%
    \titleformat{name=\subsubsection}{\normalfont\bfseries\itshape}{\thesubsubsection\space}{0pt}{#1}%
    \titleformat{name=\paragraph}{\normalfont}{\thesubsubsection\space}{0pt}{#1}%
}{%
    \titleformat{name=\section}{\normalfont\bfseries}{\thesection\space}{0pt}{#1}%
    \titleformat{name=\subsection}{\normalfont\bfseries\itshape}{\thesubsection\space}{0pt}{#1}%
    \titleformat{name=\subsubsection}{\normalfont}{\thesubsubsection\space}{0pt}{#1}%
    \titleformat{name=\paragraph}{\normalfont\itshape}{\thesubsubsection\space}{0pt}{#1}%
}%

% -------------------------------------------------------
% Formatação de sumários
% -------------------------------------------------------
% Profundidade de seções a serem numeradas
\setcounter{tocdepth}{4}%
\setcounter{secnumdepth}{4}%
% Endentação na lista de figuras
\setlength{\cftfigindent}{0em}%
% Configurações para capítulos (não presentes em artigos)
\ifthenelse{\equal{\tipodoc}{artigo}}{}{%
  % Entrelinhas
  \setlength{\cftbeforechapskip}{1em}%
  % Recuo depois da numeração
  \setlength{\cftchapnumwidth}{\recuosum}%
  % Linhas de pontos entre conteúdo e página
  \renewcommand{\cftchapdotsep}{\cftdotsep}%
}%
% Entrelinhas
\setlength{\cftbeforepartskip}{1em}%
\setlength{\cftbeforesecskip}{1em}%
\setlength{\cftbeforesubsecskip}{1em}%
\setlength{\cftbeforesubsubsecskip}{1em}%
\setlength{\cftbeforeparaskip}{1em}%
% Endentação de seções em diante
\setlength{\cftsecindent}{0em}%
\setlength{\cftsubsecindent}{0em}%
\setlength{\cftsubsubsecindent}{0em}%
\setlength{\cftparaindent}{0em}%
% Recuo depois da numeração
\setlength{\cftpartnumwidth}{\recuosum}%
\setlength{\cftsecnumwidth}{\recuosum}%
\setlength{\cftsubsecnumwidth}{\recuosum}%
\setlength{\cftsubsubsecnumwidth}{\recuosum}%
\setlength{\cftparanumwidth}{\recuosum}%
% Fonte para partes
\renewcommand{\cftpartfont}{\normalfont\bfseries}%
\renewcommand{\cftpartpagefont}{\normalfont\bfseries}%
\renewcommand{\cftpartleader}{\bfseries\cftdotfill{\cftsecdotsep}}%
% Fonte para seções
\renewcommand{\cftsecfont}{\normalfont\bfseries}%
\renewcommand{\cftsecpagefont}{\normalfont\bfseries}%
\renewcommand{\cftsecleader}{\bfseries\cftdotfill{\cftsecdotsep}}%
% Fonte para subseções
\renewcommand{\cftsubsecfont}{\normalfont\bfseries\itshape}%
\renewcommand{\cftsubsecpagefont}{\normalfont\bfseries\itshape}%
\renewcommand{\cftsubsecleader}{\normalfont\bfseries\itshape\cftdotfill{\cftsecdotsep}}%
% Fonte para subsubseções
\renewcommand{\cftsubsubsecfont}{\normalfont}%
\renewcommand{\cftsubsubsecpagefont}{\normalfont}%
\renewcommand{\cftsubsubsecleader}{\normalfont\cftdotfill{\cftsecdotsep}}%
% Fonte para paragrafos
\renewcommand{\cftparafont}{\normalfont\itshape}%
\renewcommand{\cftparapagefont}{\normalfont\itshape}%
\renewcommand{\cftparaleader}{\normalfont\itshape\cftdotfill{\cftsecdotsep}}%
% Linhas de pontos entre conteúdo e página
\renewcommand{\cftsecdotsep}{\cftdotsep}%
\renewcommand{\cftsubsecdotsep}{\cftdotsep}%
\renewcommand{\cftsubsubsecdotsep}{\cftdotsep}%

% --------------------------------------------------
% Resumo e abstract
% --------------------------------------------------
\newcommand{\thePalavrasChave}{}%
\newcommand{\resumo}[1]{%
  \newcommand{\theResumo}{#1}%
}%
\newcommand{\palavraschave}[1]{%
  \renewcommand{\thePalavrasChave}{#1}%
}%

\newcommand{\theKeywords}{}%
\renewcommand{\abstract}[1]{%
  \newcommand{\theAbstract}{#1}%
}%
\newcommand{\keywords}[1]{%
  \renewcommand{\theKeywords}{#1}%
}%

% --------------------------------------------------
% Formatações em parágrafos
% --------------------------------------------------
% Endentação de parágrafos
\setlength{\parindent}{2cm}%

% Espaçamento em tabelas
\renewcommand{\arraystretch}{1.25}%

% Alíneas
\newlength{\recuoalinea}%
\setlength{\recuoalinea}{2cm}%
\setlist{nosep}%
\setlist[enumerate]{labelindent=\recuoalinea, leftmargin=*, label=\alph*)}%
\setlist[itemize]{labelindent=\recuoalinea, leftmargin=*, label=-}%

% Nota de rodapé
\setlength{\footnotemargin}{10pt}%
\renewcommand{\footnoterule}{%
  \kern -3pt%
  \hrule width 5cm height 1pt%
  \kern 2pt%
}%

% --------------------------------------------------
% Estilo de página
% --------------------------------------------------
% Ajustes para inclusão do cabeçalho
\setlength{\topmargin}{2cm}%
\addtolength{\topmargin}{-1in}%
\setlength{\headheight}{15pt}%
\setlength{\headsep}{1cm}%
\addtolength{\headsep}{-15pt}%
\fancypagestyle{plain}{%
  \fancyhf{} %
  \fancyhead[R]{\thepage} %
  \renewcommand{\headrulewidth}{0pt}%
}%

% --------------------------------------------------
% Evita violação de margens
% --------------------------------------------------
\sloppy%

% --------------------------------------------------
% Fontes de figuras, tabelas, etc.
% --------------------------------------------------
\newcommand{\legend}[1]{%
  \begingroup%
    \parskip=3pt%
    \par\footnotesize%
     Fonte: #1\par%
  \endgroup%
}%

% --------------------------------------------------
% Citações
% --------------------------------------------------
\renewcommand{\mkcitation}[1]{\space#1}%
\renewenvironment*{quote}{%
  \begin{spacing}{1}%
  \list{}%
  \small%
  \setlength{\leftskip}{3cm}%
  \item[]%
}{%
  \endlist%
  \end{spacing}%
}%

% -----------------------------------------------
% Cabeçalho artigo
% -----------------------------------------------
\newcommand{\geraCabecalhoArtigo}{%
  \thispagestyle{empty}%
  \begin{center}%
    \textbf{\theTitulo}%
    \ifthenelse{\equal{\theTituloEstrangeiro}{}}{}{%
      \par\vspace{1em}%
      \textbf{\theTituloEstrangeiro}%
    }%
    \vspace{2em}%
    \par%
    \theAutor%
    \ifthenelse{\equal{\theEmail}{}}{}{%
      \par%
      {\theEmail}%
    }%
    \par%
    \ifthenelse{\equal{\theInstituicao}{}}{}{%
      \theInstituicaoCompleto%
      \ifthenelse{\equal{\theCampus}{}}{}{%
        \par\theCampus%
      }%
    }%
    \ifthenelse{\equal{\theCurso}{}}{}{%
      \par{\theCursoTipo} em {\theCurso}%
    }%
    \ifthenelse{\equal{\theOrientador}{}}{}{%
      \par%
      {\theOrientadorRotulo}: {\theOrientador}\\%
    }%
    \ifthenelse{\equal{\theCoorientador}{}}{}{%
      \par%
      {\theCoorientadorRotulo}: {\theCoorientador}\\%
    }%
    \ifthenelse{\equal{\theDisciplina}{}}{}{%
      \vspace{1em}%
      \par Disciplina: {\theDisciplina}%
    }%
    \ifthenelse{\equal{\theProfessor}{}}{}{%
      \par {\theProfessorRotulo}: {\theProfessor}%
    }%
    \ifthenelse{\equal{\theData}{}}{}{%
      \vspace{1em}%
      \par%
      \ifthenelse{\equal{\theDataSub}{}}{%
        \theData%
      }{%
        Data de submissão: {\theDataSub}\par%
        Data de aprovação: {\theData}%
      }%
    }%
  \end{center}%
  \par%
  \vspace{0.5em}%
}%

% -----------------------------------------------
% Capa
% -----------------------------------------------
\newcommand{\geraCapa}{%
  \ifthenelse{\equal{\tipodoc}{artigo}}{%
    \pdfbookmark[1]{CAPA}{capa}%
  }{%
    \pdfbookmark{CAPA}{capa}%
  }%
  \noindent%
  \begin{center}%
    {%
      \begin{minipage}{0.8\textwidth} \centering%
        \MakeUppercase{\theInstituicaoCompleto}%
        \par%
        \MakeUppercase{\theCampus}%
        \par%
        \MakeUppercase{{\theCursoTipo} em {\theCurso}}%
      \end{minipage}%
      \par%
      \vspace*{3em}%
      \theAutor%
    }%
    \vfill%
    {\textbf{\MakeUppercase{\theTitulo}}}%
    \vfill%
    {\theLocal}\par%
    {\theAno}%
  \end{center}%
}%

\newcommand{\geraCapaAtividade}{%
  \noindent%
  \begin{center}%
    {%
      \begin{minipage}{0.8\textwidth} \centering%
        \MakeUppercase{\theInstituicaoCompleto}%
        \par%
        \MakeUppercase{\theCampus}%
        \par%
        \MakeUppercase{{\theCursoTipo} em {\theCurso}}%
      \end{minipage}%
      \par%
      \vspace*{3em}%
      Disciplina: {\theDisciplina}\par%
      {\theProfessorRotulo}: {\theProfessor}%
      \par%
      \vspace*{3em}%
      \theAutor%
    }%
  \vfill%
  {\textbf{\MakeUppercase{\theTitulo}}}%
  \end{center}%
  \vfill%
  \begin{center}%
    {\theLocal}\par%
    {\theAno}%
  \end{center}%
}%

% -----------------------------------------------
% Folha de Rosto
% -----------------------------------------------
\newcommand{\theArquivoFicha}{}%
\newcommand{\fichacatalografica}[1]{%
  \renewcommand{\theArquivoFicha}{#1}%
}%

\newcommand{\folhaRostoAnverso}{%
  \cleardoublepage%
  \begin{center}%
    {\MakeUppercase{\theAutor}}%
    \vfill%
    \textbf{\MakeUppercase{\theTitulo}}%
    \vspace*{5em}\par%
    \hspace{.5\textwidth}%
    \begin{minipage}{.5\textwidth}%
      \begin{spacing}{1}%
        \thePreambulo%
      \end{spacing}%
      \par\vspace*{0.25em}%
      \ifthenelse{\equal{\theOrientador}{}}{}{%
        {\theOrientadorRotulo}: {\theOrientador}\\%
      }%
      \ifthenelse{\equal{\theCoorientador}{}}{}{%
        {\theCoorientadorRotulo}: {\theCoorientador}\\%
      }%
      \ifthenelse{\equal{\theLinhaPesquisa}{}}{}{%
        Linha de pesquisa: {\theLinhaPesquisa}\\%
      }%
      \ifthenelse{\equal{\theAreaConcentracao}{}}{}{%
        Área de concentração: {\theAreaConcentracao}\\%
      }%
    \end{minipage}%
    \vfill%
    {\theLocal}\par%
    {\theAno}%
  \end{center}%
  \setcounter{page}{0}%
}%

\newcommand{\geraFolhaRosto}{%
  \ifthenelse{\equal{\theArquivoFicha}{}}{%
    \folhaRostoAnverso%
  }{%
    \folhaRostoAnverso%
    \includepdf[pages={1}]{\theArquivoFicha}%
  }%
}%

% -----------------------------------------------
% Folha de Aprovação
% -----------------------------------------------
\newcommand{\theAssinaturasAprovacao}{}%
\newcommand{\assinaturas}[1]{%
  \renewcommand{\theAssinaturasAprovacao}{#1}%
}%

% Folha de aprovação impressa para assinatura%
\newcommand{\geraFolhaAprovacao}{%
  \cleardoublepage%
  \ifthenelse{\equal{\tipodoc}{artigo}}{%
    \pdfbookmark[1]{FOLHA DE APROVAÇÃO}{folha_aprovacao}%
  }{%
    \pdfbookmark{FOLHA DE APROVAÇÃO}{folha_aprovacao}%
  }%
  \begin{center}%
    {\theAutor}%
    \vfill%
    {\textbf{\MakeUppercase{\theTitulo}}}%
    \vfill%
    \hspace{.5\textwidth}%
    \begin{minipage}{.5\textwidth}%
      \begin{spacing}{1}%
        \thePreambulo%
      \end{spacing}%
      \par\vspace*{0.25em}%
      \ifthenelse{\equal{\theLinhaPesquisa}{}}{}{%
        Linha de pesquisa: {\theLinhaPesquisa}\\%
      }%
      \ifthenelse{\equal{\theAreaConcentracao}{}}{}{%
        Área de concentração: {\theAreaConcentracao}\\%
      }%
    \end{minipage}%
    \vspace*{3em}%
    \par{Aprovado em {\theData} pela banca examinadora:}%
    \par%
    \vspace*{1em}%
    \ifthenelse{\equal{\theOrientador}{}}{}{%
      {\theOrientador} -- {\theOrientadorInstituicao} -- ({\theOrientadorRotulo})\\%
    }%
    \ifthenelse{\equal{\theCoorientador}{}}{}{%
      {\theCoorientador} -- {\theCoorientadorInstituicao} -- ({\theCoorientadorRotulo})\\%
    }%
    \makeatletter%
    \count1=0%
    \@whilenum \count1<\contMembroBanca \do {%
        {\csname NomeMembroBanca:\the\count1 \endcsname} %
        -- {\csname LocalMembroBanca:\the\count1 \endcsname} \\%
      \advance\count1 by 1%
    }%
    \makeatother%
    \vspace*{1em}%
    \ifthenelse{\equal{\theAssinaturasAprovacao}{}}{}{%
      \includegraphics[width=\linewidth]{\theAssinaturasAprovacao}%
    }%
    \vfill%
  \end{center}%
%   \cleardoublepage%
}%

% -----------------------------------------------
% Dedicatória
% -----------------------------------------------
\newcommand{\dedicatoria}[1]{%
  \newcommand{\theDedicatoria}{#1}%
}%

\newcommand{\geraDedicatoria}{%
  \ifthenelse{\isundefined{\theDedicatoria}}{}{%
    \cleardoublepage%
    ~\vfill%
    \noindent%
    \begin{flushright}%
      \theDedicatoria%
    \end{flushright}%
  }%
}%

% -----------------------------------------------
% Agradecimentos
% -----------------------------------------------
\newcommand{\agradecimentos}[1]{%
  \newcommand{\theAgradecimentos}{#1}%
}%

\newcommand{\geraAgradecimentos}{%
  \ifthenelse{\isundefined{\theAgradecimentos}}{}{%
    \cleardoublepage%
    \begin{center}%
      \bfseries AGRADECIMENTOS%
    \end{center}%
    {\par%
     \theAgradecimentos%
    }%
  }%
}%

% -----------------------------------------------
% Agradecimentos
% -----------------------------------------------
\newcommand{\epigrafe}[2]{%
  \newcommand{\theEpigrafe}{#1}%
  \newcommand{\theAutorEpigrafe}{#2}%
}%

\newcommand{\geraEpigrafe}{%
  \ifthenelse{\isundefined{\theEpigrafe}}{}{%
    \cleardoublepage%
    ~\vfill%
    \begin{flushright}%
      \noindent%
      \enquote{\theEpigrafe}%
      \par%
      \theAutorEpigrafe%
    \end{flushright}%
  }%
}%

% --------------------------------------------------
% Capítulos pré-textuais
% --------------------------------------------------
\newcommand{\prechapter}[1]{%
  \ifthenelse{\equal{\tipodoc}{artigo}}{%
    \ifthenelse{\equal{\pretextual}{TRUE}}{%
      \cleardoublepage%
      \pdfbookmark{#1}{b\thepage}%
    }{%
      \par%
    }%
  }{%
    \cleardoublepage%
    \pdfbookmark{#1}{b\thepage}%
  }%
  \begin{center}%
    \bfseries #1%
  \end{center}%
  \vspace{0.5em}%
  \par%
}%

% --------------------------------------------------
% Resumo
% --------------------------------------------------

\newcommand{\geraResumo}{%
  \ifthenelse{\isundefined{\theResumo}}{}{%
    \ifthenelse{\equal{\tipodoc}{artigo}}{%
      \par%
    }{%
      \cleardoublepage%
      \pdfbookmark{RESUMO}{b\thepage}%
    }%
    \begin{center}%
    \bfseries RESUMO%
    \end{center}%
    \vspace{0.5em}%
    \par%
    {%
      \theResumo%
      \ifthenelse{\equal{\thePalavrasChave}{}}{}{%
        \par%
        \vspace{0.25em}%
        \noindent\textbf{Palavras-chave:} \thePalavrasChave%
      }%
    }%
  }%
}%
\newcommand{\geraAbstract}{%
  \ifthenelse{\isundefined{\theAbstract}}{}{%
    \ifthenelse{\equal{\tipodoc}{artigo}}{%
      \par%
    }{%
      \cleardoublepage%
      \pdfbookmark{ABSTRACT}{b\thepage}%
    }%
    \begin{center}%
    \bfseries ABSTRACT%
    \end{center}%
    \vspace{0.5em}%
    \par%
    {%
      \theAbstract%
      \ifthenelse{\equal{\theKeywords}{}}{}{%
        \par%
        \vspace{0.25em}%
        \noindent\textbf{Keywords:} \theKeywords%
      }%
    }%
  }%
}%

% -----------------------------------------------
% Lista de figuras
% -----------------------------------------------
\SetupFloatingEnvironment{figure}{within=none}%
\renewcommand{\cftfigpresnum}{Figura~}%
\renewcommand{\cftfigaftersnum}{~-}%
\setlength{\cftfignumwidth}{2cm}%

\newcommand{\incluiListaFiguras}{}%
\newcommand{\listafiguras}{%
  \renewcommand{\incluiListaFiguras}{SIM}%
}%

\newcommand{\geraListaFiguras}{%
  \ifthenelse{\equal{\incluiListaFiguras}{}}{}{%
    \prechapter{LISTA DE FIGURAS}%
    \makeatletter%
    \@starttoc{lof}%
    \makeatother%
    \cleardoublepage%
   }%
}%

% --------------------------------------------------
% Lista de quadros
% --------------------------------------------------
\newlistof{board}{lob}{LISTA DE QUADROS}%
\DeclareFloatingEnvironment[%
  fileext=lob,%
  name=Quadro,%
  placement=ht,%
  within=none,%
]{board}%
\renewcommand{\cftboardpresnum}{Quadro~}%
\renewcommand{\cftboardaftersnum}{~-}%
\setlength{\cftboardnumwidth}{2.2cm}%

\newcommand{\incluiListaQuadros}{}%
\newcommand{\listaquadros}{%
  \renewcommand{\incluiListaQuadros}{TRUE}%
}%

\newcommand{\geraListaQuadros}{%
  \ifthenelse{\equal{\incluiListaQuadros}{TRUE}}{%
    \prechapter{LISTA DE QUADROS}%
    \makeatletter%
    \@starttoc{lob}%
    \makeatother%
    \cleardoublepage%
   }{}%
}%

% -----------------------------------------------
% Lista de tabelas
% -----------------------------------------------
\SetupFloatingEnvironment{table}{within=none}%
\renewcommand{\cfttabpresnum}{Tabela~}%
\renewcommand{\cfttabaftersnum}{~-}%
\setlength{\cfttabnumwidth}{2cm}%

\newcommand{\incluiListaTabelas}{}%
\newcommand{\listatabelas}{%
  \renewcommand{\incluiListaTabelas}{SIM}%
}%

\newcommand{\geraListaTabelas}{%
  \ifthenelse{\equal{\incluiListaTabelas}{}}{}{%
    \prechapter{LISTA DE TABELAS}%
    \makeatletter%
    \@starttoc{lot}%
    \makeatother%
    \cleardoublepage%
   }%
}%

% --------------------------------------------------
% Lista de siglas
% --------------------------------------------------
\newcommand{\listasiglas}[1]{%
  \newcommand{\incluiListaSiglas}{#1}%
}%

\newcommand{\geraListaSiglas}{%
  \ifthenelse{\isundefined{\incluiListaSiglas}}{}{%
    \prechapter{LISTA DE SIGLAS}%%
    \incluiListaSiglas%
    \cleardoublepage%
  }%
}%

% --------------------------------------------------
% Lista de símbolos
% --------------------------------------------------
\newcommand{\listasimbolos}[1]{%
  \newcommand{\incluiListaSimbolos}{#1}%
}%

\newcommand{\geraListaSimbolos}{%
  \ifthenelse{\isundefined{\incluiListaSimbolos}}{}{%
    \prechapter{LISTA DE SÍMBOLOS}%%
    \incluiListaSimbolos%
    \cleardoublepage%
  }%
}%

% --------------------------------------------------
% Sumário
% --------------------------------------------------
\newcommand{\geraSumario}{%
  \prechapter{SUMÁRIO}%
  \par%
  \makeatletter%
  \@starttoc{toc}%
  \makeatother%
  \cleardoublepage%
}%

% --------------------------------------------------
% Capítulos pós-textuais
% --------------------------------------------------
\newcommand{\poschapter}[1]{%
    \cleardoublepage%
    \begin{center}%
      \bfseries #1%
    \end{center}%
    \vspace{1.5em}%
    \par%
}%

\renewcommand{\appendix}{%
  \ifthenelse{\equal{\tipodoc}{artigo}}{%
    % Reinicia contagem nos capítulos
    \setcounter{section}{0}%
    % Numeração de capítulos com letras
    \renewcommand{\thesection}{\Alph{section}}%
    % Modifica entradas no sumário
    \addtocontents{toc}{\setlength{\cftsecnumwidth}{7em}}%
    \addtocontents{toc}{\protect\renewcommand{\protect\cftsecpresnum}{APÊNDICE~}}%
    \addtocontents{toc}{\protect\renewcommand{\protect\cftsecaftersnum}{\protect~-}}%
    % Formatação do título de capítulos
    \titleformat{name=\section}{\normalfont\bfseries\filcenter}{APÊNDICE\space\thesection\space-\space}{0pt}{\MakeUppercase{##1}}%
  }{%
    \bookmarksetup{startatroot}%
    \phantomsection%
    \poschapter{APÊNDICES}%
    \addcontentsline{toc}{part}{APÊNDICES}%
    \cleardoublepage%
    % Reinicia contagem nos capítulos
    \setcounter{chapter}{0}%
    % Numeração de capítulos com letras
    \renewcommand{\thechapter}{\Alph{chapter}}%
    % Modifica entradas no sumário
    \addtocontents{toc}{\setlength{\cftchapnumwidth}{7em}}%
    \addtocontents{toc}{\protect\renewcommand{\protect\cftchappresnum}{APÊNDICE~}}%
    \addtocontents{toc}{\protect\renewcommand{\protect\cftchapaftersnum}{\protect~-}}%
    % Formatação do título de capítulos
    \titleformat{name=\chapter}{\normalfont\bfseries\filcenter}{APÊNDICE~\thechapter\space-\space}{0pt}{\MakeUppercase{##1}}%
  }%
}%

\newcommand{\attachment}{%
  \ifthenelse{\equal{\tipodoc}{artigo}}{%
    % Reinicia contagem nos capítulos
    \setcounter{section}{0}%
    % Numeração de capítulos com letras
    \renewcommand{\thesection}{\Alph{section}}%
    % Formatação do título de capítulos
    \addtocontents{toc}{\setlength{\cftsecnumwidth}{7em}}%
    \addtocontents{toc}{\protect\renewcommand{\protect\cftsecpresnum}{ANEXO~}}%
    \addtocontents{toc}{\protect\renewcommand{\protect\cftsecaftersnum}{\protect~-}}%
    \titleformat{name=\section}{\normalfont\bfseries\filcenter}{ANEXO\space\thesection\space-\space}{0pt}{\MakeUppercase{##1}}%
  }{%
    \bookmarksetup{startatroot}%
    \phantomsection%
    \poschapter{ANEXOS}%
    \addcontentsline{toc}{part}{ANEXOS}%
    % Reinicia contagem nos capítulos
    \setcounter{chapter}{0}%
    % Numeração de capítulos com letras
    \renewcommand{\thechapter}{\Alph{chapter}}%
    % Modifica entradas no sumário
    \addtocontents{toc}{\setlength{\cftchapnumwidth}{5.5em}}%
    \addtocontents{toc}{\protect\renewcommand{\protect\cftchappresnum}{ANEXO~}}%
    \addtocontents{toc}{\protect\renewcommand{\protect\cftchapaftersnum}{\protect~-}}%
    % Formatação do título de capítulos
    \titleformat{name=\chapter}{\normalfont\bfseries\filcenter}{ANEXO~\thechapter\space-\space}{0pt}{\MakeUppercase{##1}}%
  }%
}%

% --------------------------------------------------
% Configurações do índice
% --------------------------------------------------
\makeindex[columns=1,title={}]%
\indexsetup{level={},toclevel={},noclearpage}%

% --------------------------------------------------
% Redefinição do \maketitle
% --------------------------------------------------
\newcommand{\maketitlearticle}{%
  \ifthenelse{\equal{\pretextual}{TRUE}}{%
    \geraCapa %
    \geraFolhaRosto %
    \geraFolhaAprovacao %
    \geraDedicatoria %
    \geraAgradecimentos%
    \geraEpigrafe%
    \cleardoublepage%
  }{}%
  \geraCabecalhoArtigo%
  \geraResumo%
  \geraAbstract%
}%

\newcommand{\maketitlereport}{%
  \ifthenelse{\equal{\tipodoc}{atividade}}{%
    \geraCapaAtividade%
  }{%
    \geraCapa %
    \geraFolhaRosto %
    \geraFolhaAprovacao %
    \geraDedicatoria %
    \geraAgradecimentos%
    \geraEpigrafe%
  }%
  \geraResumo%
  \ifthenelse{\not\equal{\tipodoc}{estagio}}{%
    \geraAbstract%
  }{}%
  \geraListaFiguras%
  \geraListaQuadros%
  \geraListaTabelas%
  \geraListaSiglas%
  \geraListaSimbolos%
  \geraSumario%
}%

\renewcommand{\maketitle}{%
  \pagestyle{empty}%
  \onehalfspacing%
  \ifthenelse{\equal{\tipodoc}{artigo}}{%
    \maketitlearticle%
  }{%
    \maketitlereport%
  }%
  \pagestyle{plain}%
}%

% --------------------------------------------------
% Configurações para o PDF
% --------------------------------------------------
\AtBeginDocument{%
  \hypersetup{%
    pdftitle={\theTitulo},%
    pdfauthor={\theAutor},%
    pdfkeywords={\thePalavrasChave},%
  }%
}%
