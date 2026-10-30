<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
pf-cli-managed: yes
-->

<!-- textlint-disable terminology,common-misspellings -->

[English](../../README.md) · [Español](../es/README.md)

# B19 / Java

JDK від Oracle та Temurin у серіях 25 і 27, з увімкненим ZGC, легкими jlink-середовищами для похідних образів і опційними JMX-метриками.

[![Stand with Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://damian-buho.github.io/support-ukraine/) [![Projectfile inside](https://badges.kiota.ch/static/v1?label=projectfile&message=inside&labelColor=0d0d0d&color=8c6723&style=flat-square)](https://projectfile.org) [![License](https://badges.kiota.ch/static/v1?label=license&message=MIT&color=1e5913&style=flat-square)](LICENSE) [![PRs welcome](https://badges.kiota.ch/static/v1?label=PRs&message=welcome&color=1e5913&style=flat-square)](CONTRIBUTING.md) [![REUSE compliance](https://api.reuse.software/badge/github.com/damian-buho/b19-java)](https://api.reuse.software/info/github.com/damian-buho/b19-java)

![Project status](https://badges.kiota.ch/static/v1?label=status&message=maintained&color=1d63ed&style=flat-square) [![Last commit on GitHub](https://badges.kiota.ch/github/last-commit/damian-buho/b19-java?label=last%20commit%20on%20GitHub&style=flat-square)](https://github.com/damian-buho/b19-java) [![Last commit on kiota.ch](https://badges.kiota.ch/gitea/last-commit/b19/java?gitea_url=https://kiota.ch&label=last%20commit%20on%20kiota.ch&style=flat-square)](https://kiota.ch/b19/java)

[![Publish pipeline on GitHub](https://github.com/damian-buho/b19-java/actions/workflows/published.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/b19-java/actions) [![Vulnerability audit on GitHub](https://github.com/damian-buho/b19-java/actions/workflows/audited.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/b19-java/actions) [![Dependency freshness on GitHub](https://github.com/damian-buho/b19-java/actions/workflows/check-outdated.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/b19-java/actions) [![Analysis sweep on GitHub](https://github.com/damian-buho/b19-java/actions/workflows/analyzed.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/b19-java/actions)

[![Publish pipeline on kiota.ch](https://kiota.ch/b19/java/badges/workflows/published.yaml/badge.svg?style=flat-square)](https://kiota.ch/b19/java/actions) [![Vulnerability audit on kiota.ch](https://kiota.ch/b19/java/badges/workflows/audited.yaml/badge.svg?style=flat-square)](https://kiota.ch/b19/java/actions) [![Dependency freshness on kiota.ch](https://kiota.ch/b19/java/badges/workflows/check-outdated.yaml/badge.svg?style=flat-square)](https://kiota.ch/b19/java/actions) [![Analysis sweep on kiota.ch](https://kiota.ch/b19/java/badges/workflows/analyzed.yaml/badge.svg?style=flat-square)](https://kiota.ch/b19/java/actions)

## Першоджерело

Цей проєкт пакує [Eclipse Temurin](https://adoptium.net) (`GPL-2.0-only WITH Classpath-exception-2.0`).
Дякуємо: Eclipse Adoptium

Цей проєкт пакує [Oracle JDK](https://www.oracle.com/java/) (власна ліцензія).
Дякуємо: Oracle

Цей проєкт пакує [Prometheus JMX Exporter](https://github.com/prometheus/jmx_exporter) (`Apache-2.0`).
Дякуємо: Doug Hoard та Fabian Stäber (супровідники), Brian Brazil (початковий автор)

## Можливості

- Імпорт CA-сертифікатів під час виконання
- Скомпрометовані центри сертифікації вилучено зі сховища довіри JDK
- JDK з upstream-тарбола з вибором дистрибутива
- Опційні метрики Prometheus через JMX
- Прапорці JVM, налаштовані під продакшн
- Полегшене середовище виконання Java для образів застосунків

Також успадковує можливості B19 / Ubuntu — повний перелік див. у [Можливості](FEATURES.md).

## Що надає цей проєкт

- **Образ контейнера** `ghcr.io/damian-buho/b19/java:oracle-25`
- **Образ контейнера** `ghcr.io/damian-buho/b19/java:oracle-27`
- **Образ контейнера** `ghcr.io/damian-buho/b19/java:temurin-25`
- **Образ контейнера** `ghcr.io/damian-buho/b19/java:temurin-27`
- **Образ контейнера** `damianbuho/b19-java:oracle-25`
- **Образ контейнера** `damianbuho/b19-java:oracle-27`
- **Образ контейнера** `damianbuho/b19-java:temurin-25`
- **Образ контейнера** `damianbuho/b19-java:temurin-27`

## Встановлення

Завантажте опублікований образ контейнера:

### Завантажити з GHCR — linux/amd64, linux/arm64, linux/riscv64

```sh
docker pull ghcr.io/damian-buho/b19/java:oracle-25
```

### Завантажити з DockerHub — linux/amd64

```sh
docker pull damianbuho/b19-java:oracle-25
```

Дистрибутив: `oracle` | `temurin`

Серія: `25` | `27`

Стабільні випуски також публікують теґи `X.Y.Z`, `X.Y` і `X` — завантажте той рівень точності, який хочете зафіксувати.

Якщо наведені вище реєстри недоступні, завантажте з джерела:

### Завантажити з Kiota — linux/amd64

```sh
docker pull kiota.ch/b19/java:oracle-25
```

Дистрибутив: `oracle` | `temurin`

Серія: `25` | `27`

## Використання

Побудуйте на основі цього образу:

### З GHCR

```dockerfile
FROM ghcr.io/damian-buho/b19/java:oracle-25
```

### З DockerHub

```dockerfile
FROM damianbuho/b19-java:oracle-25
```

Дистрибутив: `oracle` | `temurin`

Серія: `25` | `27`

Для рекомендованого багатоетапного шаблону та системи хуків збірки (build.d) створіть похідний проєкт за допомогою `b19/scripts/scaffold.sh` з [m6e/b19](https://kiota.ch/m6e/b19).

## Збирання

Клонуйте репозиторій разом із підмодулями:

```sh
git clone --recurse-submodules https://github.com/damian-buho/b19-java java && cd java
```

Зберіть образ контейнера локально:

```sh
make container-build
```

- [Довідник із Makefile](../how-to/MAKEFILE.md)

Виконайте `make` без аргументів для типової цілі; виконайте `make help`, щоб переглянути всі цілі.

Для локального циклу розробки `make dev-container` піднімає dev-container.

Точки входу конвеєра:

- `make analyzed` — Запускає важкий аналіз (мутаційне тестування, бенчмарки)
- `make audited` — Повторно сканує закріплені залежності й опубліковані артефакти на нові вразливості
- `make check-outdated` — Звітує про кожну закріплену залежність, що відстає від upstream
- `make release-is-ready` — Запускає псевдо-CI локально — збирає, тестує й сканує без публікації

## Документація

- [Ship a slim Java runtime](../how-to/use-export.md)

## Політики

- [Як зробити внесок](CONTRIBUTING.md)
- [Політика безпеки](SECURITY.md)
- [Як отримати підтримку](SUPPORT.md)
- [Кодекс поведінки](CODE_OF_CONDUCT.md)
- [Політика щодо ШІ та LLM](AI_POLICY.md)

## Посилання

- [Специфікація Projectfile](https://projectfile.org)

## Ліцензія

Пакування в цьому репозиторії ліцензовано на умовах MIT — див. файл [LICENSE](LICENSE) для подробиць.

<!-- textlint-enable -->
