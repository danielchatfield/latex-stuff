# Latex stuff

This repo contains some of my latex stuff.

## Installation

Different depending on distribution. You can just put the `.cls` file next to your source file for simplicity. You will need `Pygments` installed for syntax highlighting and the document compiled with `--shell-escape`.

## Supervision Document Class

This is the document class I use for my supervision work, it is an extension of
the `exam` latex class and is well suited for setting questions and submitting
work.

### Features

 - Supports unicode characters in the source (automatically converts them into appropriate latex)
 - By default answers are shown
 - Sensible header
 - Intelligent default title
 - Pretty syntax source code highlighting
 - Support for SI units e.g. (`\SI{2.4}{\GHz}`)

### Package Options
 - **HideSolutions** - Hides the solutions from the compiled PDF
 - **NewMint** - Indicates that the system has version 2 of minted (which is required for some IDE support).

### Macros

#### `\SetQuestionNumber{3}`

Sets the next question (or part) number to the specified value.

### \Topics{This & That}`

Sets the work topics (optional) - if they are set then the title of the work
will be the topics, if it is not then the title will be the course name.
