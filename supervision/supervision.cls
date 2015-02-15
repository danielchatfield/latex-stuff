\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{supervision}
    [2014/11/23 Supervision work class (Daniel Chatfield)]

\RequirePackage{etoolbox} % Provides lots of useful commands, needs to be at
                          % the top as we use several commands

\newtoggle{ShowSolutions}

\newtoggle{InQuestions}
\newtoggle{InParts}
\newtoggle{InSubParts}

\newtoggle{CourseSet}
\newtoggle{TopicsSet}
\newtoggle{SupervisionSet}
\newtoggle{AuthorSet}


%% By default show solutions
\toggletrue{ShowSolutions}
%% Use old mint version by default

%% Keep track of which environments we are in (used by SetQuestionNumber to
%% determine which counter to set)
\AtBeginEnvironment{questions}{\toggletrue{InQuestions}}
\AtBeginEnvironment{parts}{\toggletrue{InParts}}
\AtBeginEnvironment{subparts}{\toggletrue{InSubParts}}


%% Our custom options
\DeclareOption{HideSolutions}{
    \togglefalse{ShowSolutions}
}
\DeclareOption{answers}{
    \ClassWarning{supervision}{Ignoring option 'answers', use `HideSolutions`
    instead}
}

%% Package options
\DeclareOption{sansserif}{
    \PassOptionsToPackage{\CurrentOption}{paxcommands}
}
\DeclareOption{neverindent}{
    \PassOptionsToPackage{\CurrentOption}{paxcommands}
}

%% If we don't know what this option is then pass it to the exam class
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{exam}
}

%% Default options
\ExecuteOptions{12pt}

%% Process passed options
\ProcessOptions\relax

%% Check whether we should show the answers
\iftoggle{ShowSolutions}{%
    \PassOptionsToClass{answers}{exam}
}


%% Load exam class
\LoadClass[a4paper,12pt]{exam}

%% Load additional packages
\RequirePackage[utf8]{inputenc} % converts unicode into latex
\RequirePackage[margin=3cm]{geometry}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{parskip} % Set spacing between paragraphs
\RequirePackage{titling}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{gensymb}
\PassOptionsToPackage{hyphens}{url}
\RequirePackage{hyperref}
\RequirePackage{listings}
\RequirePackage{lstautogobble}
\RequirePackage{courier}
\RequirePackage[load=abbr]{siunitx}
\RequirePackage[sc]{mathpazo}
\RequirePackage[T1]{fontenc}

%% Setup document
\pagestyle{headandfoot}
\runningheader{\theauthor}{\Course \ supervision \Supervision}{\thedate}
\footer{}{Page \thepage}{}
\marksnotpoints
\bracketedpoints
\pointsdroppedatright
\pointsinrightmargin
\linespread{1.05}         % Palatino needs more leading (space between lines)
% Use Courier for source code listings
\lstset{
    basicstyle=\footnotesize\ttfamily,
    breaklines=true
}
\lstloadlanguages{C}
\lstloadlanguages{python}
\lstloadlanguages{ml}

\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{grey}{rgb}{0.5,0.5,0.5}
\definecolor{pink}{rgb}{205,0,205}

\lstdefinestyle{mystyle}{%
    basicstyle=\scriptsize\ttfamily,
    keywordstyle=\bf\color{blue}\ttfamily,
    stringstyle=\color{orange!50!brown}\ttfamily,
    commentstyle=\color{red}\ttfamily,
    morecomment=[l][\color{magenta}]{\#},
    showstringspaces=false,
    numberstyle=\tiny\color{grey},
    tabsize=4,
    breaklines
}

\lstnewenvironment{code}[2][] {
    \lstset{language=#2,
        style=mystyle,
        autogobble,
        escapechar=§,
        #1
    }
}{}

\newcommand{\codefile}[2][python]{
    \lstinputlisting[language=#1,style=mystyle]{#2}
}

% Change range format from "1.2GHz to 1.3GHz" to "1.2-1.3GHz"
\sisetup{range-phrase=--,range-units=single}
\graphicspath{ {./img/} }
\date{\today}

% Remove 'solution' from solution box
\renewcommand{\solutiontitle}{\noindent}


%% Command to set question
\newcommand{\SetQuestionNumber}[1]{
    % Check if in part environment
    \iftoggle{InSubParts}{
        \setcounter{subpart}{#1}
        \addtocounter{subpart}{-1}
    } {
        \iftoggle{InParts}{
            \setcounter{partno}{#1}
            \addtocounter{partno}{-1}
        } {
            \iftoggle{InQuestions}{
                \setcounter{question}{#1}
                \addtocounter{question}{-1}
            } {
                \ClassError{supervision}{Cannot use '\\setquestionnumber' outside questions environment}
            }
        }
    }
}

\newcommand{\@Course}{}
\newcommand{\Course}[1]{
    \ifstrempty{#1}{
        \togglefalse{CourseSet}
    } {
        \toggletrue{CourseSet}
    }
    \renewcommand{\@Course}{#1}
}

\newcommand{\@Topics}{}
\newcommand{\Topics}[1]{
    \ifstrempty{#1}{
        \togglefalse{TopicsSet}
    } {
        \toggletrue{TopicsSet}
    }
    \renewcommand{\@Topics}{#1}
}

\newcommand{\@Supervision}{}
\newcommand{\Supervision}[1]{
    \ifstrempty{#1}{
        \togglefalse{SupervisionSet}
    } {
        \toggletrue{SupervisionSet}
    }
    \renewcommand{\@Supervision}{#1}
}

\AtBeginDocument{
    \renewcommand{\Course}{\@Course}
    \renewcommand{\Topics}{\@Topics}
    \renewcommand{\Supervision}{\@Supervision}

    \iftoggle{TopicsSet} {
        \title{\@Topics}
    } {
        \iftoggle{SupervisionSet} {
            \title{\@Course: \ Supervision \@Supervision}
        }{
            \title{\@Course}
        }
    }

    \maketitle
    \thispagestyle{headandfoot}
}



\endinput
