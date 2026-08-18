<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Прапорці JVM, налаштовані під продакшн

- @-файл `${B19_HOME}/vm.options` рендериться з `vm.options.j2` під час кожного запуску контейнера і згортається в `JAVA_TOOL_OPTIONS`, тож кожен виклик `java` отримує прапорці автоматично (запускач читає `JAVA_TOOL_OPTIONS` перед аргументами командного рядка; явний `java -Xmx8g` усе одно перемагає).
- @-файл також доступний для явного використання (`java @${B19_HOME}/vm.options`).
- Входять прапорці: ZGC (поколінневий типово з JDK 21), дедуплікація рядків, compressed oops, escape analysis, паралельна обробка посилань, оптимізація конкатенації рядків, AlwaysPreTouch.
- Нижня та верхня межі купи параметризуються через `B19_JAVA_XMS` (типово `512m`) і `B19_JAVA_XMX` (типово `2048m`), інтерпольовані в шаблон під час рендерингу — перезбирання не потрібне.
- Встановіть `JAVA_TOOL_OPTIONS` явно, щоб повністю перевизначити автоматично застосовані прапорці.

<!-- textlint-enable -->
