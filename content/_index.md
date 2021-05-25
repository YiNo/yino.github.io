---
title: 简介
type: docs
---

# Hugo Wiki

{{< columns >}}
## 简单

Hugo 是由 Go 语言实现的静态网站生成器。简单、易用、高效、易扩展、快速部署。
hugo提供了通过主题构建网站的机制。hugo生态已经提供了300+的主题可以用。

<--->

## 易用


主题类似一种前端框架，可以帮助我们快速建站。 此项目是基于 [Hugo-book](https://github.com/alex-shpak/hugo-book) 进行的二次开发，此 hugo 主题
主要用户网站建设和文档建设。
只需导入作为 hugo themes 即可生效, 使用非常简单。

{{< /columns >}}

## Quick Start

```bash
mkdir -p ${project}/themes
cd ${project}

git init
git submodule add --force  https://github.com/airdb-wiki/hugo-book  themes/book

cp -pr themes/book/exampleSite/ .

git add  .
git commit -a -m"first commit"

hugo server --minify --theme book
```

## Makefile

```bash
.PHONY: test

all: run
run:
        hugo server --minify --theme book
sub:
        git submodule update --init
        git submodule update --remote
build:
        hugo -D --minify
```
