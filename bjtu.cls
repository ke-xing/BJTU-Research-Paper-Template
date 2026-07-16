%%==============================================================================
%% bjtu.cls  --  Beijing Jiaotong University Modern Paper Template
%% -----------------------------------------------------------------------------
%% A modern, minimalist LaTeX class for BJTU technical reports & research papers.
%% Design language inspired by official BJTU identity + modern technical reports.
%% Primary color: BJTU Blue  #003690  (official: C100 M85 Y0 K5 / R0 G54 B144)
%% Emblem assets: official PNG resources from BJTU visual identity website
%%
%% Author : BJTU Template Project
%% Version: 1.0  (2026-07)
%% License: MIT
%%==============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bjtu}[2026/07/15 v1.0 BJTU Modern Paper Template]

%------------------------------------------------------------------------------
% Class options
%------------------------------------------------------------------------------
\newif\ifbjtu@chinese      \bjtu@chinesefalse
\newif\ifbjtu@twocolumn    \bjtu@twocolumnfalse
\newif\ifbjtu@preprint     \bjtu@preprinttrue

\DeclareOption{chinese}{\bjtu@chinesetrue}
\DeclareOption{english}{\bjtu@chinesefalse}
\DeclareOption{twocolumn}{\bjtu@twocolumntrue}
\DeclareOption{onecolumn}{\bjtu@twocolumnfalse}
\DeclareOption{preprint}{\bjtu@preprinttrue}
\DeclareOption{final}{\bjtu@preprintfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[11pt,a4paper]{article}

%------------------------------------------------------------------------------
% Required packages
%------------------------------------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{lmodern}
\RequirePackage{microtype}
\RequirePackage{geometry}
\RequirePackage[table]{xcolor}   % 'table' loads colortbl (\arrayrulecolor)
\RequirePackage{tikz}
\RequirePackage{graphicx}
% Default figure search paths (project convention: figures/ and tables/)
\graphicspath{{figures/}{./figures/}{tables/}{./tables/}}
\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{mathtools}
\RequirePackage{bm}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{enumitem}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{fancyhdr}
\RequirePackage{hyperref}
\RequirePackage{url}
\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage[most]{tcolorbox}
\RequirePackage{listings}
\RequirePackage{fontawesome5}
\RequirePackage{orcidlink}
\RequirePackage{authblk}
\RequirePackage{lastpage}
\RequirePackage{ragged2e}
\RequirePackage{setspace}
\RequirePackage{etoolbox}
% ---- Algorithms & pseudocode (essential for AI/CS papers) ----
\RequirePackage[ruled,linesnumbered,vlined]{algorithm2e}
% NOTE: do NOT load algpseudocode/algorithmicx here -- it conflicts with
% algorithm2e (different \For/\If macro families) and breaks \tcp, \KwIn, etc.
% ---- Additional math for ML/AI ----
% (nicematrix intentionally omitted: not used by the template and is not
%  present in the minimal BasicTeX distribution. Remove this line if you
%  actually need nicematrix environments in your paper.)
\RequirePackage{siunitx}
\sisetup{detect-all, group-separator={,}, group-minimum-digits=4}

\usetikzlibrary{calc,positioning,shapes.geometric,shadows.blur,arrows.meta,fit,backgrounds}

% Chinese support (optional)
\ifbjtu@chinese
    \RequirePackage{ctex}
\fi

%------------------------------------------------------------------------------
% BJTU Official Visual System
%------------------------------------------------------------------------------
% Official BJTU standard color: C100 M85 Y0 K5 / R0 G54 B144, named "BJTU Blue".
% Source: https://www.bjtu.edu.cn/xxgk/xxbz/index.htm
\definecolor{bjtublue}{HTML}{003690}       % Official BJTU Blue
\definecolor{bjtublue-dark}{HTML}{00245F}  % Deep BJTU Blue for text / titles
\definecolor{bjtublue-mid}{HTML}{1B56A6}   % Link / secondary blue
\definecolor{bjtublue-light}{HTML}{EAF1FB} % Blue-tinted card surface
\definecolor{bjtublue-mist}{HTML}{F5F8FD}  % Hero background tint
\definecolor{bjtured}{HTML}{A50034}        % Restrained auxiliary red
\definecolor{bjtured-light}{HTML}{FFF0F4}  % Soft red surface
\definecolor{bjtugold}{HTML}{C8A96A}       % Subtle heritage accent
\definecolor{bjtucyan}{HTML}{5D8ED6}       % Tonal blue highlight accent

\definecolor{ink}{HTML}{162033}            % Body text
\definecolor{ink-soft}{HTML}{475569}       % Secondary text
\definecolor{ink-mute}{HTML}{7A8494}       % Muted / captions
\definecolor{rule-gray}{HTML}{D7E0EC}      % Hairlines
\definecolor{bg-soft}{HTML}{F8FAFD}        % Soft background

%------------------------------------------------------------------------------
% Page geometry  --  generous margins, DeepMind-like breathing room
%------------------------------------------------------------------------------
\geometry{
    a4paper,
    top=2.5cm,
    bottom=2.6cm,
    left=2.3cm,
    right=2.3cm,
    headheight=14pt,
    headsep=14pt,
    footskip=1.2cm
}

\ifbjtu@twocolumn
    \geometry{left=1.8cm,right=1.8cm}
    \AtBeginDocument{\twocolumn\setlength{\columnsep}{0.7cm}}
\fi

\setlength{\parindent}{0pt}
\setlength{\parskip}{0.55em}
\linespread{1.12}

%------------------------------------------------------------------------------
% Hyperref configuration
%------------------------------------------------------------------------------
\hypersetup{
    colorlinks=true,
    linkcolor=bjtublue,
    citecolor=bjtublue-mid,
    urlcolor=bjtured,
    filecolor=bjtublue,
    pdfborder={0 0 0},
    breaklinks=true
}

%------------------------------------------------------------------------------
% Fancy header / footer   (NVIDIA / DeepMind style: minimal, colored rule)
%------------------------------------------------------------------------------
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\fancyhead[L]{%
    \begingroup
    \color{ink-mute}\footnotesize\sffamily
    \ifdefempty{\bjtu@runningtitle}{\bjtu@shorttitle}{\bjtu@runningtitle}%
    \endgroup
}
\fancyhead[R]{%
    \begingroup
    \color{bjtublue}\footnotesize\sffamily\bfseries
    Beijing Jiaotong University
    \endgroup
}
\fancyfoot[L]{%
    \begingroup
    \footnotesize\sffamily\color{ink-mute}%
    \ifbjtu@preprint Preprint\else \bjtu@venue\fi
    \endgroup
}
\fancyfoot[R]{%
    \begingroup
    \footnotesize\sffamily\color{ink-mute}%
    \thepage\, / \,\pageref{LastPage}
    \endgroup
}

% Custom rule under header -- official BJTU-blue brand rail
\renewcommand{\headrule}{%
    \hbox to\headwidth{%
        \textcolor{bjtublue-dark}{\rule{2.0cm}{0.7pt}}%
        \textcolor{bjtublue}{\rule{\dimexpr\headwidth-2.0cm\relax}{0.7pt}}%
    }%
}
\renewcommand{\headrulewidth}{0.7pt}

%------------------------------------------------------------------------------
% Title metadata storage
%------------------------------------------------------------------------------
\def\bjtu@title{Paper Title}
\def\bjtu@subtitle{}
\def\bjtu@shorttitle{BJTU Preprint}
\def\bjtu@runningtitle{}
\def\bjtu@venue{Beijing Jiaotong University Technical Report}
\def\bjtu@date{\today}
\def\bjtu@keywords{}

\renewcommand{\title}[2][]{%
    \def\bjtu@title{#2}%
    \ifstrempty{#1}{\def\bjtu@shorttitle{#2}}{\def\bjtu@shorttitle{#1}}%
}
\newcommand{\subtitle}[1]{\def\bjtu@subtitle{#1}}
\newcommand{\runningtitle}[1]{\def\bjtu@runningtitle{#1}}
\newcommand{\venue}[1]{\def\bjtu@venue{#1}}
\newcommand{\keywords}[1]{\def\bjtu@keywords{#1}}

%------------------------------------------------------------------------------
% Author block  (Meta / DeepMind style: names with affiliation superscripts)
%------------------------------------------------------------------------------
\renewcommand\Authfont{\normalsize\sffamily\bfseries\color{ink}}
\renewcommand\Affilfont{\footnotesize\sffamily\color{ink-soft}\normalfont\itshape}
\setlength{\affilsep}{0.4em}

% Corresponding author marker
\newcommand{\corresp}[1]{%
    \textsuperscript{\textcolor{bjtured}{\faEnvelope[regular]}}\,#1%
}
\newcommand{\equalcontrib}{\textsuperscript{\textcolor{bjtublue}{$\ast$}}}

%------------------------------------------------------------------------------
% BJTU Emblem and wordmark  (official PNG assets)
%------------------------------------------------------------------------------
% Official files are stored under figures/ with English filenames for portability.
% They come from BJTU's visual identity page:
% https://www.bjtu.edu.cn/xxgk/xxbz/index.htm
\newcommand{\bjtuemblem}[1][1.6cm]{%
    \includegraphics[width=#1]{bjtu-emblem-color.png}%
}
\newcommand{\bjtuwordmark}[1][4.5cm]{%
    \includegraphics[width=#1]{bjtu-lockup-horizontal.png}%
}

% Small inline mark version
\newcommand{\bjtumark}[1][0.55cm]{\raisebox{-0.28\height}{\bjtuemblem[#1]}}

%------------------------------------------------------------------------------
% Title page  (\maketitle)  --  official BJTU identity + modern report layout
%------------------------------------------------------------------------------
\renewcommand{\maketitle}{%
    \begingroup
    \thispagestyle{empty}
    \noindent
    \begin{tikzpicture}[remember picture, overlay]
        % Balanced official BJTU-blue brand panel
        \fill[bjtublue-mist]
            ([yshift=-0.65cm]current page.north west)
            rectangle
            ([yshift=-3.18cm]current page.north east);
        \fill[bjtublue!4!white]
            ([xshift=9.4cm,yshift=-0.65cm]current page.north west)
            rectangle
            ([yshift=-3.18cm]current page.north east);
        \draw[rule-gray, line width=0.35pt]
            ([yshift=-3.18cm]current page.north west) --
            ([yshift=-3.18cm]current page.north east);
        % Official BJTU-blue brand rail
        \fill[bjtublue]
            ([yshift=-0.68cm]current page.north west)
            rectangle
            ([yshift=-0.82cm]current page.north east);
        \fill[bjtublue-dark]
            ([xshift=2.3cm,yshift=-0.68cm]current page.north west)
            rectangle
            ([xshift=5.25cm,yshift=-0.82cm]current page.north west);
        % Official wordmark lockup from BJTU visual identity resources
        \node[anchor=north west, inner sep=0pt, outer sep=0pt]
             at ([xshift=2.3cm, yshift=-1.36cm]current page.north west)
             {\bjtuwordmark[4.9cm]};
        % Report metadata chip on the right
        \node[anchor=north east, inner xsep=8pt, inner ysep=4pt,
              rounded corners=8pt, fill=white, draw=rule-gray, line width=0.35pt,
              font=\sffamily\bfseries\scriptsize, text=bjtublue-dark]
             at ([xshift=-2.3cm, yshift=-1.42cm]current page.north east)
             {\ifbjtu@preprint PREPRINT\else FINAL\fi\quad\textcolor{ink-mute}{\bjtu@date}};
        \node[anchor=north east, font=\sffamily\footnotesize, text=ink-mute]
             at ([xshift=-2.3cm, yshift=-2.05cm]current page.north east)
             {\ifbjtu@preprint Beijing Jiaotong University Technical Report\else \bjtu@venue\fi};
    \end{tikzpicture}

    \vspace*{1.08cm}

    % ---- Main title block ----
    {\RaggedRight
     \hyphenpenalty=10000\exhyphenpenalty=10000\sloppy
     \sffamily\bfseries\color{ink}%
     \fontsize{24.5pt}{30pt}\selectfont
     \bjtu@title\par}

    \ifdefempty{\bjtu@subtitle}{}{%
        \vspace{0.55em}
        {\RaggedRight
         \sffamily\color{ink-soft}%
         \fontsize{13.5pt}{17pt}\selectfont
         \bjtu@subtitle\par}
    }

    % Official BJTU-blue signature under title
    \vspace{1.0em}
    \noindent\textcolor{bjtublue}{\rule{3.6cm}{2.4pt}}%
    \textcolor{bjtublue-mid}{\rule{1.2cm}{2.4pt}}%
    \textcolor{bjtublue-dark}{\rule{0.7cm}{2.4pt}}
    \vspace{1.05em}

    % ---- Authors  (rendered by authblk via \AB@authlist) ----
    {\@author\par}

    \vspace{1.1em}
    \endgroup
}

%------------------------------------------------------------------------------
% Abstract environment  (ByteDance Seed / DeepMind style card)
%------------------------------------------------------------------------------
\renewenvironment{abstract}{%
    \begin{tcolorbox}[
        enhanced,
        colback=bjtublue-mist,
        colframe=rule-gray,
        boxrule=0.35pt,
        arc=5pt,
        left=16pt, right=16pt, top=13pt, bottom=13pt,
        borderline west={3.5pt}{0pt}{bjtublue},
        before skip=0.7em, after skip=1.2em,
        drop fuzzy shadow={black!8!white}
    ]
    \tikz[baseline=(abstract-title.base)]\node[
        fill=bjtublue, text=white,
        font=\sffamily\bfseries\large,
        rounded corners=3pt,
        inner xsep=7pt, inner ysep=2.2pt
    ] (abstract-title) {Abstract};\par
    \vspace{0.45em}
    \small\color{ink}%
}{%
    \ifdefempty{\bjtu@keywords}{}{%
        \par\vspace{0.75em}
        {\sffamily\bfseries\footnotesize\color{bjtublue}Keywords\,---\,}%
        {\footnotesize\color{ink-soft}\bjtu@keywords}%
    }
    \end{tcolorbox}
}

%------------------------------------------------------------------------------
% Section headings  (Meta AI / NVIDIA style: numbered chips)
%------------------------------------------------------------------------------
\titleformat{\section}
    {\sffamily\bfseries\Large\color{ink}}
    {\tikz[baseline=(n.base)]\node[fill=bjtublue, text=white,
        font=\sffamily\bfseries\small, rounded corners=3pt,
        inner xsep=6pt, inner ysep=2pt] (n) {\thesection};\hspace{0.62em}}
    {0pt}
    {}
\titlespacing*{\section}{0pt}{2.05em}{0.78em}

\titleformat{\subsection}
    {\sffamily\bfseries\large\color{bjtublue-dark}}
    {\textcolor{bjtublue-mid}{\thesubsection}}
    {0.75em}
    {}
\titlespacing*{\subsection}{0pt}{1.35em}{0.48em}

\titleformat{\subsubsection}
    {\sffamily\bfseries\normalsize\color{ink-soft}}
    {\textcolor{bjtublue-mid}{\thesubsubsection}}
    {0.65em}
    {}
\titlespacing*{\subsubsection}{0pt}{1.0em}{0.35em}

\titleformat{\paragraph}[runin]
    {\sffamily\bfseries\normalsize\color{bjtublue}}
    {}
    {0pt}
    {}[.]
\titlespacing*{\paragraph}{0pt}{0.6em}{0.6em}

%------------------------------------------------------------------------------
% Captions
%------------------------------------------------------------------------------
\captionsetup{
    font={small,sf},
    labelfont={bf,color=bjtublue},
    labelsep=period,
    justification=raggedright,
    singlelinecheck=false,
    skip=6pt
}
\captionsetup[sub]{font=footnotesize, labelfont={bf,color=bjtublue-mid}}

%------------------------------------------------------------------------------
% List style
%------------------------------------------------------------------------------
\setlist[itemize,1]{leftmargin=1.3em, label={\color{bjtublue}\small\textbullet}, itemsep=2pt, topsep=3pt}
\setlist[itemize,2]{leftmargin=1.3em, label={\color{bjtublue-mid}\footnotesize\textendash}, itemsep=2pt}
\setlist[enumerate,1]{leftmargin=1.6em, label={\color{bjtublue}\bfseries\arabic*.}, itemsep=2pt, topsep=3pt}

%------------------------------------------------------------------------------
% Tables
%------------------------------------------------------------------------------
\renewcommand{\arraystretch}{1.15}
\arrayrulecolor{bjtublue}

%------------------------------------------------------------------------------
% Theorem-like environments  (colored side-bar boxes)
%------------------------------------------------------------------------------
\newtcbtheorem[number within=section]{bjtutheorem}{Theorem}{%
    enhanced, colback=white, colframe=bjtublue,
    fonttitle=\sffamily\bfseries,
    coltitle=white,
    attach boxed title to top left={xshift=6pt, yshift=-\tcboxedtitleheight/2},
    boxed title style={colback=bjtublue, boxrule=0pt, arc=2pt,
        left=5pt, right=5pt, top=1.5pt, bottom=1.5pt},
    boxrule=0.6pt, arc=2pt,
    left=10pt, right=10pt, top=10pt, bottom=10pt
}{thm}

\newtcbtheorem[use counter from=bjtutheorem]{bjtulemma}{Lemma}{%
    enhanced, colback=white, colframe=bjtublue-mid,
    fonttitle=\sffamily\bfseries,
    coltitle=white,
    attach boxed title to top left={xshift=6pt, yshift=-\tcboxedtitleheight/2},
    boxed title style={colback=bjtublue-mid, boxrule=0pt, arc=2pt,
        left=5pt, right=5pt, top=1.5pt, bottom=1.5pt},
    boxrule=0.5pt, arc=2pt,
    left=10pt, right=10pt, top=10pt, bottom=10pt
}{lem}

\newtcbtheorem[use counter from=bjtutheorem]{bjtudefinition}{Definition}{%
    enhanced, colback=bjtublue-light, colframe=bjtublue-light,
    fonttitle=\sffamily\bfseries,
    coltitle=white,
    attach boxed title to top left={xshift=6pt, yshift=-\tcboxedtitleheight/2},
    boxed title style={colback=bjtublue, boxrule=0pt, arc=2pt,
        left=5pt, right=5pt, top=1.5pt, bottom=1.5pt},
    boxrule=0pt, arc=2pt,
    borderline west={3pt}{0pt}{bjtublue},
    left=10pt, right=10pt, top=10pt, bottom=10pt
}{def}

% Convenient user-facing commands
\newenvironment{theorem}[2][]{\begin{bjtutheorem}{#2}{#1}}{\end{bjtutheorem}}
\newenvironment{lemma}[2][]{\begin{bjtulemma}{#2}{#1}}{\end{bjtulemma}}
\newenvironment{definition}[2][]{\begin{bjtudefinition}{#2}{#1}}{\end{bjtudefinition}}

% Highlight / note boxes  (DeepMind info card style)
\newtcolorbox{highlight}[1][]{%
    enhanced, colback=bjtured-light, colframe=rule-gray,
    boxrule=0.3pt, arc=5pt,
    borderline west={3.2pt}{0pt}{bjtured},
    coltitle=white,
    fonttitle=\sffamily\bfseries\footnotesize,
    attach boxed title to top left={xshift=8pt, yshift=-\tcboxedtitleheight/2},
    boxed title style={colback=bjtured, boxrule=0pt, arc=3pt,
        left=5pt, right=5pt, top=1.5pt, bottom=1.5pt},
    left=12pt, right=12pt, top=9pt, bottom=9pt,
    fontupper=\small, drop fuzzy shadow={black!6!white}, #1
}
\newtcolorbox{keypoint}[1][]{%
    enhanced, colback=white, colframe=rule-gray,
    boxrule=0.35pt, arc=5pt,
    borderline west={3.2pt}{0pt}{bjtugold},
    coltitle=white,
    fonttitle=\sffamily\bfseries\footnotesize,
    attach boxed title to top left={xshift=8pt, yshift=-\tcboxedtitleheight/2},
    boxed title style={colback=bjtugold!70!black, boxrule=0pt, arc=3pt,
        left=5pt, right=5pt, top=1.5pt, bottom=1.5pt},
    left=12pt, right=12pt, top=9pt, bottom=9pt,
    fontupper=\small, drop fuzzy shadow={black!5!white}, #1
}

%------------------------------------------------------------------------------
% Code listings  (monochromatic, minimal, dark-on-light like DeepMind)
%------------------------------------------------------------------------------
\lstdefinestyle{bjtucode}{
    backgroundcolor=\color{bg-soft},
    basicstyle=\ttfamily\footnotesize\color{ink},
    keywordstyle=\color{bjtublue}\bfseries,
    commentstyle=\color{ink-mute}\itshape,
    stringstyle=\color{bjtured},
    numberstyle=\tiny\color{ink-mute},
    numbers=left,
    numbersep=8pt,
    frame=leftline,
    rulecolor=\color{bjtublue},
    framerule=2pt,
    xleftmargin=14pt,
    xrightmargin=6pt,
    aboveskip=0.8em,
    belowskip=0.8em,
    showstringspaces=false,
    breaklines=true,
    tabsize=2,
    captionpos=b
}
\lstset{style=bjtucode}

%------------------------------------------------------------------------------
% Bibliography styling  (natbib author-year like NeurIPS/ICML/ICLR)
%------------------------------------------------------------------------------
\bibliographystyle{plainnat}
\renewcommand{\bibsection}{\section*{\normalfont References}\vspace{-0.5em}}
\setlength{\bibsep}{4pt}
\renewcommand{\bibfont}{\small\sffamily}

%------------------------------------------------------------------------------
% Handy commands
%------------------------------------------------------------------------------
% Contribution tag (Meta AI style small colored chip)
\newcommand{\contribtag}[2][bjtublue]{%
    \tikz[baseline=(x.base)]\node[fill=#1, text=white, font=\sffamily\bfseries\scriptsize,
        rounded corners=2pt, inner xsep=4pt, inner ysep=1.5pt] (x) {#2};%
}

% TL;DR box  (DeepMind style)
\newtcolorbox{tldr}{%
    enhanced,
    colback=white, colframe=rule-gray,
    boxrule=0.35pt, arc=5pt,
    title={\sffamily\bfseries TL;DR},
    coltitle=white,
    attach boxed title to top left={xshift=10pt, yshift=-\tcboxedtitleheight/2},
    boxed title style={colback=bjtublue-dark, boxrule=0pt, arc=3pt,
        left=6pt, right=6pt, top=2pt, bottom=2pt},
    borderline west={3.2pt}{0pt}{bjtublue},
    left=12pt, right=12pt, top=11pt, bottom=10pt,
    fontupper=\small,
    drop fuzzy shadow={black!6!white}
}

%==============================================================================
%  AI / CS PAPER EXTENSIONS
%  ---------------------------------------------------------------------------
%  The following section adds environments and commands specifically tailored
%  for machine-learning / artificial-intelligence papers, aligned with the
%  conventions of NeurIPS, ICML, ICLR, CVPR, ACL, and industry technical
%  reports (LLaMA, Gemini, Seed, GPT-4 tech report, etc.).
%==============================================================================

%------------------------------------------------------------------------------
% Standard AI paper math notation macros
%------------------------------------------------------------------------------
% Sets & spaces
\newcommand{\R}{\mathbb{R}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\E}{\mathbb{E}}
\newcommand{\Prob}{\mathbb{P}}
\newcommand{\Var}{\mathrm{Var}}
\newcommand{\Cov}{\mathrm{Cov}}
% Vectors, matrices, tensors
\newcommand{\vect}[1]{\bm{#1}}
\newcommand{\mat}[1]{\bm{#1}}
\newcommand{\tens}[1]{\bm{\mathsf{#1}}}
% Common ML operators
\DeclareMathOperator*{\argmin}{arg\,min}
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator{\softmax}{softmax}
\DeclareMathOperator{\sigmoid}{sigmoid}
\DeclareMathOperator{\ReLU}{ReLU}
\DeclareMathOperator{\GELU}{GELU}
\DeclareMathOperator{\KL}{KL}
\DeclareMathOperator{\MI}{I}
\DeclareMathOperator{\Ent}{H}
\DeclareMathOperator{\Tr}{Tr}
\DeclareMathOperator{\diag}{diag}
% Norms & inner products
\newcommand{\norm}[1]{\left\lVert#1\right\rVert}
\newcommand{\abs}[1]{\left\lvert#1\right\rvert}
\newcommand{\inner}[2]{\left\langle #1,\, #2 \right\rangle}
% Loss & data notation
\newcommand{\Loss}{\mathcal{L}}
\newcommand{\Data}{\mathcal{D}}
\newcommand{\Model}{\mathcal{M}}
\newcommand{\params}{\bm{\theta}}
\newcommand{\pdata}{p_{\mathrm{data}}}
\newcommand{\pmodel}{p_{\params}}

%------------------------------------------------------------------------------
% Algorithm environment styling  (algorithm2e)
%------------------------------------------------------------------------------
\SetAlFnt{\small\sffamily}
\SetAlCapFnt{\bfseries\color{bjtublue}}
\SetAlCapNameFnt{\color{ink}}
\SetKwSty{textbf}
\SetProcNameSty{textbf}
\SetProcArgSty{texttt}
% NOTE: the default 'ruled' style already draws the frame/rules. We do NOT
% redefine internal \algocf@* macros here (they require \makeatletter and
% would break \tcp / \KwIn / \For). The BJTU blue caption color above is
% enough to brand the algorithm blocks.

%------------------------------------------------------------------------------
% Proof environment styling  (mathematically-oriented AI papers)
%------------------------------------------------------------------------------
\renewenvironment{proof}[1][\proofname]{%
    \par\pushQED{\qed}\normalfont\topsep6\p@\@plus6\p@\relax
    \trivlist
    \item[\hskip\labelsep
          \sffamily\bfseries\color{bjtublue-mid}#1\@addpunct{.}]\ignorespaces
}{\popQED\endtrivlist\@endpefalse}

%------------------------------------------------------------------------------
% AI-specific colored callout boxes
%------------------------------------------------------------------------------
% Contribution list box  (Meta / LLaMA style)
\newtcolorbox{contributions}{%
    enhanced,
    colback=white, colframe=rule-gray,
    boxrule=0.35pt, arc=5pt,
    title={\sffamily\bfseries Our Contributions},
    coltitle=white,
    attach boxed title to top left={xshift=10pt, yshift=-\tcboxedtitleheight/2},
    boxed title style={colback=bjtublue, boxrule=0pt, arc=3pt,
        left=6pt, right=6pt, top=2pt, bottom=2pt},
    borderline west={3.2pt}{0pt}{bjtucyan},
    left=12pt, right=12pt, top=11pt, bottom=10pt,
    fontupper=\small,
    drop fuzzy shadow={black!6!white}
}
% Limitations statement (NeurIPS checklist item)
\newtcolorbox{limitations}{%
    enhanced,
    colback=bjtured-light, colframe=rule-gray,
    boxrule=0.3pt, arc=5pt,
    borderline west={3.2pt}{0pt}{bjtured},
    title={\sffamily\bfseries Limitations},
    coltitle=white,
    attach boxed title to top left={xshift=10pt, yshift=-\tcboxedtitleheight/2},
    boxed title style={colback=bjtured, boxrule=0pt, arc=3pt,
        left=6pt, right=6pt, top=2pt, bottom=2pt},
    left=12pt, right=12pt, top=11pt, bottom=10pt,
    fontupper=\small,
    drop fuzzy shadow={black!5!white}
}
% Broader Impact statement (NeurIPS mandatory)
\newtcolorbox{broaderimpact}{%
    enhanced,
    colback=white, colframe=rule-gray,
    boxrule=0.3pt, arc=5pt,
    borderline west={3.2pt}{0pt}{bjtugold},
    title={\sffamily\bfseries Broader Impact},
    coltitle=white,
    attach boxed title to top left={xshift=10pt, yshift=-\tcboxedtitleheight/2},
    boxed title style={colback=bjtublue-dark, boxrule=0pt, arc=3pt,
        left=6pt, right=6pt, top=2pt, bottom=2pt},
    left=12pt, right=12pt, top=11pt, bottom=10pt,
    fontupper=\small,
    drop fuzzy shadow={black!5!white}
}
% Reproducibility statement
\newtcolorbox{reproducibility}{%
    enhanced,
    colback=bjtublue-mist, colframe=rule-gray,
    boxrule=0.3pt, arc=5pt,
    borderline west={3.2pt}{0pt}{bjtublue-mid},
    title={\sffamily\bfseries Reproducibility Statement},
    coltitle=white,
    attach boxed title to top left={xshift=10pt, yshift=-\tcboxedtitleheight/2},
    boxed title style={colback=bjtublue-mid, boxrule=0pt, arc=3pt,
        left=6pt, right=6pt, top=2pt, bottom=2pt},
    left=12pt, right=12pt, top=11pt, bottom=10pt,
    fontupper=\small,
    drop fuzzy shadow={black!5!white}
}
% Prompt / model I/O display box  (LLM papers)
\newtcolorbox{prompt}[1][User Prompt]{%
    enhanced,
    colback=white, colframe=rule-gray,
    boxrule=0.35pt, arc=5pt,
    title={\sffamily\bfseries #1},
    coltitle=white,
    fonttitle=\sffamily\bfseries\footnotesize,
    attach boxed title to top left={xshift=8pt, yshift=-\tcboxedtitleheight/2},
    boxed title style={colback=bjtublue-mid, boxrule=0pt, arc=3pt,
        left=5pt, right=5pt, top=1.5pt, bottom=1.5pt},
    left=12pt, right=12pt, top=9pt, bottom=9pt,
    fontupper=\ttfamily\footnotesize,
    drop fuzzy shadow={black!5!white},
    breakable
}
\newtcolorbox{response}[1][Model Response]{%
    enhanced,
    colback=bjtublue-mist, colframe=rule-gray,
    boxrule=0.35pt, arc=5pt,
    borderline west={3.2pt}{0pt}{bjtublue},
    title={\sffamily\bfseries #1},
    coltitle=white,
    fonttitle=\sffamily\bfseries\footnotesize,
    attach boxed title to top left={xshift=8pt, yshift=-\tcboxedtitleheight/2},
    boxed title style={colback=bjtublue, boxrule=0pt, arc=3pt,
        left=5pt, right=5pt, top=1.5pt, bottom=1.5pt},
    left=12pt, right=12pt, top=9pt, bottom=9pt,
    fontupper=\ttfamily\footnotesize,
    drop fuzzy shadow={black!5!white},
    breakable
}

%------------------------------------------------------------------------------
% Author-contribution role tags  (CRediT taxonomy, Meta-style chips)
%------------------------------------------------------------------------------
% Usage: \role{Conceptualization}\ Alice, Bob
\newcommand{\role}[1]{%
    \tikz[baseline=(x.base)]\node[fill=bjtublue-light, text=bjtublue,
        font=\sffamily\bfseries\scriptsize,
        rounded corners=2pt, inner xsep=4pt, inner ysep=1.5pt] (x) {#1};%
}

%------------------------------------------------------------------------------
% Appendix support  (Appendix A / B / C ...)
%------------------------------------------------------------------------------
\newcommand{\appendixsection}{%
    \setcounter{section}{0}%
    \renewcommand{\thesection}{\Alph{section}}%
    \renewcommand{\thesubsection}{\Alph{section}.\arabic{subsection}}%
    \titleformat{\section}
        {\sffamily\bfseries\Large\color{ink}}
        {\tikz[baseline=(n.base)]\node[fill=bjtured, text=white,
            font=\sffamily\bfseries\small, rounded corners=3pt,
            inner xsep=6pt, inner ysep=2pt] (n) {\thesection};\hspace{0.62em}Appendix~\thesection~---~}
        {0pt}
        {}%
}
% Convenience command: \startappendix
\newcommand{\startappendix}{%
    \clearpage
    \appendixsection
    \section*{\normalfont\color{bjtured}\Large Appendix}%
    \addcontentsline{toc}{section}{Appendix}%
    \vspace{0.4em}
    \noindent\textcolor{bjtured}{\rule{\linewidth}{1.2pt}}\par
    \vspace{0.6em}%
}

%------------------------------------------------------------------------------
% Convenience commands for common AI-paper items
%------------------------------------------------------------------------------
% Placeholder for TODO notes during drafting
\newcommand{\todo}[1]{{\sffamily\bfseries\color{bjtured}[TODO: #1]}}
\newcommand{\note}[1]{{\sffamily\color{bjtublue-mid}[Note: #1]}}
% Improvement arrows in tables
\newcommand{\up}[1]{{\color{bjtublue}\footnotesize$\uparrow$#1}}
\newcommand{\dn}[1]{{\color{bjtured}\footnotesize$\downarrow$#1}}
% Best / second-best in tables
\newcommand{\best}[1]{\textbf{\color{bjtublue}#1}}
\newcommand{\second}[1]{\underline{#1}}

\endinput
