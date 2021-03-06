---
title       : "Interactive Plot New Game Releases by Platform (from Metacritic.com)"
subtitle    : "Developing Data Products: Week 4 - Project"
author      : 
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

First, I will create a Shiny application and deploy it on Rstudio's servers. Second, I will use Slidify or Rstudio Presenter to prepare a reproducible pitch presentation about your application.

--- .class #id 

## Shiny Application

This Shiny application scrapes the data from metacritic.com for top new releases for either PS4, X-Box one or PC games. The plot is interactive, the user can hover on the data point to display title details.

This application is thought to help potential video-game buyers make an educated decision of the quality of game available at any time. 

---

## Background

This work is based on my submission from Week 3. It adds additional Platforms and filter by score (either User Score or Metascore)

---

## Run code in slidify


```r
require(ggplot2)
qplot(wt, mpg, data = mtcars)
```

<img src="figure/simple-plot-1.png" title="plot of chunk simple-plot" alt="plot of chunk simple-plot" style="display: block; margin: auto;" />
