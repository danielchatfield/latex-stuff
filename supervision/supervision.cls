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

%% Keep track of which environments we are in (used by setnumber to determine
%% which counter to set)
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

%% Packade options
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
\RequirePackage{gensymb}
\RequirePackage{hyperref}
\RequirePackage{listings} % Legacy source code
\RequirePackage{courier}
\RequirePackage[outputdir=.texpadtmp,cache]{minted} % Use pygments for source code highlighting

%% Setup document
\pagestyle{headandfoot}
\runningheader{\theauthor}{\Course \ Supervision \Supervision}{\thedate}
\firstpageheader{}{\Course}{}
\firstpagefooter{}{\thepage}{}
\runningfooter{}{\thepage}{}
% Use Courier for source code listings
\lstset{
    basicstyle=\footnotesize\ttfamily,
    breaklines=true
}
\setminted{autogobble,tabsize=4,fontsize=\footnotesize}
\graphicspath{ {./img/} }
\date{\today}

% Remove 'solution' from solution box
\renewcommand{\solutiontitle}{\noindent\textbf{Answer:}\par\noindent}


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
                \ClassError{supervision}{Cannot use '\\setquestionno' outside questions environment}
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
}



\endinput
