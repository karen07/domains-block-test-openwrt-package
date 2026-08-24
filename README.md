# domains-block-test OpenWrt package

This repository contains the OpenWrt package definition for [domains-block-test](https://github.com/karen07/domains-block-test), a low-level TLS/SNI probing utility.

The package installs the `domains-block-test` binary into `/usr/bin` and depends on `libpcap`. The tool performs packet capture and injection, so normal OpenWrt privilege requirements apply when it is executed.

For development, the Makefile can build from a sibling `../domains-block-test` checkout. Otherwise OpenWrt fetches the tagged upstream source specified by `PKG_VERSION`.

## Описание

Этот репозиторий содержит описание пакета OpenWrt для [domains-block-test](https://github.com/karen07/domains-block-test), низкоуровневой утилиты для проверки TLS/SNI.

Пакет устанавливает бинарный файл `domains-block-test` в `/usr/bin` и зависит от `libpcap`. Утилита выполняет захват и отправку пакетов, поэтому при запуске действуют обычные требования OpenWrt к привилегиям.

При разработке Makefile может собирать исходники из соседнего каталога `../domains-block-test`. Если такого каталога нет, OpenWrt загружает версию исходников по тегу, заданному в `PKG_VERSION`.

## Что находится в репозитории

- `domains-block-test/Makefile` - описание OpenWrt package;
- `openwrt-build.env` - параметры пакета для общего CI;
- `.github/workflows/openwrt-build.yml` - вызов общего reusable workflow.

## Сборка

Сборка выполняется через GitHub Actions. Workflow этого репозитория вызывает общий reusable workflow из [openwrt-package-ci](https://github.com/karen07/openwrt-package-ci).

CI можно запустить:

- push тега вида `vX.Y.Z` - значение тега используется как версия OpenWrt;
- вручную через `workflow_dispatch`, указав версию OpenWrt и при необходимости фильтры target/subtarget.

Параметры этого пакета хранятся в `openwrt-build.env`. Общие `openwrt-build.sh`, `openwrt-matrix.py` и логика сборки через OpenWrt SDK находятся в `openwrt-package-ci`.

Для ручной сборки каталог `domains-block-test/` можно использовать как обычный package directory внутри OpenWrt buildroot/SDK.

## Связанные проекты

- [domains-block-test](https://github.com/karen07/domains-block-test) - основной проект, формат входных файлов и логика probing.
