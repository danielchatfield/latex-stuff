# Latex stuff

This repo contains some of my latex stuff.

## Supervision Document Class

This is the document class I use for my supervision work, it is an extension of
the `exam` latex class and is well suited for setting questions and submitting
work.

### Features

 - Supports unicode characters in the source (automatically converts them into appropriate latex)
 - By default shows the answers

### Options
 - **hidesolutions** - Hides the solutions from the compiled PDF

### Commands

#### `\SetQuestionNumber{3}`

Sets the next question (or part) number to the specified value.
