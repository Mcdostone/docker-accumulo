# Docker image with latex and inkscape

Try this 3.11GB docker to build some awesome latex documents!
See more details in the [Dockerfile](https://github.com/Mcdostone/dockerfiles/blob/master/latex-inkscape-pygmentize/Dockerfile).

This image contains:
 - textlive-full
 - inkscape (for SVGs)
 - fonts-roboto
 - pygmentize for syntax hightlighting

## Quick start

```bash
docker run --rm -it mcdostone/latex-inkscape-pygmentize:latest
```