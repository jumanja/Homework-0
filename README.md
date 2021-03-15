README
================

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax
for authoring HTML, PDF, and MS Word documents. For more details on
using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that
includes both content as well as the output of any embedded R code
chunks within the document. You can embed an R code chunk like this:

``` r
summary(cars)
```

    ##      speed           dist       
    ##  Min.   : 4.0   Min.   :  2.00  
    ##  1st Qu.:12.0   1st Qu.: 26.00  
    ##  Median :15.0   Median : 36.00  
    ##  Mean   :15.4   Mean   : 42.98  
    ##  3rd Qu.:19.0   3rd Qu.: 56.00  
    ##  Max.   :25.0   Max.   :120.00

## Including Plots

You can also embed plots, for example:

![](README_files/figure-gfm/pressure-1.png)<!-- -->

Note that the `echo = FALSE` parameter was added to the code chunk to
prevent printing of the R code that generated the plot.

## Git Info

Key points Recap: there are four stages: working directory, staging
area, local repository, and upstream repository Clone an existing
upstream repository (copy repo url from clone button, and type “git
clone <url>”), and all three local stages are the same as upstream
remote. The working directory is the same as the working directory in
Rstudio. When we edit files we only change the files in this place. git
status: tells how the files in the working directory are related to the
files in other stages edits in the staging area are not tracked by the
version control system by default - we add a file to the staging area by
git add command git commit: to commit files from the staging area to
local repository, we need to add a message stating what we are doing by
git commit -m “something” git log: keeps track of all the changes we
have made to the local repository git push: allows moving from the local
repository to upstream repository, only if you have the permission
(e.g. if it is yours) git fetch: update local repository to be like the
upstream repository, from upstream to local git merge: make the updated
local sync with the working directory and staging area To change
everything in one shot (from upstream to working dir), use git pull
(equivalent to combining git fetch + git merge) Code pwd mkdir
git-example cd git-example git clone
<https://github.com/rairizarry/murders.git> cd murders ls git status
echo “test” \>\> new-file.txt echo “temporary” \>\> tmp.txt git add
new-file.txt git status git commit -m “adding a new file” git status
echo “adding a second line” \>\> new-file.txt git commit -m “minor
change to new-file” new-file.txt git status git add git log new-file.txt
git push git fetch git merge
