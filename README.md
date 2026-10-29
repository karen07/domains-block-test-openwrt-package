# Domains Block Test OpenWrt Package

OpenWrt packaging for [domains-block-test](https://github.com/karen07/domains-block-test),
a low-level TLS/SNI probe. It installs the utility and declares its packet-capture
dependency.

Пакет OpenWrt для [domains-block-test](https://github.com/karen07/domains-block-test) -
низкоуровневой утилиты проверки TLS/SNI. Устанавливает утилиту и объявляет зависимость для
захвата сетевых пакетов.

## Описание

Пакет устанавливает бинарный файл `domains-block-test` в `/usr/bin` и зависит от `libpcap`. Утилита выполняет захват и отправку пакетов, поэтому при запуске действуют обычные требования OpenWrt к привилегиям.

При разработке Makefile может собирать исходники из соседнего каталога `../domains-block-test`. Если такого каталога нет, OpenWrt загружает версию исходников по тегу, заданному в `PKG_VERSION`.

## Разработка и проверка изменений

**Основные точки изменения:**

- `domains-block-test/Makefile` - зависимости, версия и правила установки (TLS/SNI-тестер);
- `openwrt-build.env` - параметры сборки для общего CI;
- `.github/workflows/openwrt-build.yml` - вызов переиспользуемого OpenWrt workflow.

**Выбор исходников и артефакт пакета:** `domains-block-test/Makefile` берёт соседний каталог `domains-block-test` при наличии его `CMakeLists.txt`; иначе получает Git-тег `v$(PKG_VERSION)` основного проекта. Пакет устанавливает бинарник в `/usr/bin/domains-block-test`. При проверке релиза отличайте сборку локальных исходников от сборки по тегу и сверяйте `PKG_VERSION` с нужной ревизией. Проверьте наличие `libpcap` в зависимостях и доступ к сетевому интерфейсу на роутере.

**Проверка изменений:** Изменения функциональности: сетевые пакеты создаёт отдельный `domains-block-test`. Для упаковки проверяйте `Makefile`, `openwrt-build.env` и CI вместе; тестируйте итоговый пакет на нужной версии OpenWrt, поскольку сборка приложения сама по себе не проверяет установку и зависимости.

## Сборка

Сборка выполняется через GitHub Actions. Workflow этого репозитория вызывает общий reusable workflow из [openwrt-package-ci](https://github.com/karen07/openwrt-package-ci).

CI можно запустить:

- push тега вида `vX.Y.Z` - значение тега используется как версия OpenWrt;
- вручную через `workflow_dispatch`, указав версию OpenWrt и при необходимости фильтры target/subtarget.

Параметры этого пакета хранятся в `openwrt-build.env`. Общие `openwrt-build.sh`, `openwrt-matrix.py` и логика сборки через OpenWrt SDK находятся в `openwrt-package-ci`.

Для ручной сборки каталог `domains-block-test/` можно использовать как обычный package directory внутри OpenWrt buildroot/SDK.

## Структура проекта

- `domains-block-test/Makefile` - описание OpenWrt package;
- `openwrt-build.env` - параметры пакета для общего CI;
- `.github/workflows/openwrt-build.yml` - вызов общего reusable workflow.

## Связанные проекты

- [domains-block-test](https://github.com/karen07/domains-block-test) - основной проект, формат входных файлов и логика probing.

## Лицензия

Проект распространяется под лицензией GNU Affero General Public License v3.0. Подробности см. в файле [LICENSE](LICENSE).
