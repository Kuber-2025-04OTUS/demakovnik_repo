# Домашнее задание 7
## Задание 1. Создание Helm-чарта для развертывания приложения

Необходимо создать Helm-чарт для развертывания приложения, которое вы получили при выполнении ДЗ 1-5. При этом нужно учесть следующие требования:

### Основные требования

- Основные параметры в манифестах (имена объектов, имена контейнеров, используемые образы, хосты, порты, количество запускаемых реплик) должны быть заданы как переменные в шаблонах и конфигурироваться через:
  - `values.yaml`
  - Параметры при установке релиза

- Репозиторий и тег образа должны быть раздельными параметрами

- Пробы должны быть включаемыми/отключаемыми через конфигурацию

- В `NOTES.txt` должно быть описано сообщение после установки релиза, отображающее адрес для доступа к сервису

- При именовании объектов в шаблонах следует придерживаться best practices из лекции

### Дополнительные требования

- Добавьте в свой чарт сервис-зависимость из доступных community-чартов (например, MySQL или Redis)

Перед установкой чарта необходимо установить longhorn:
```bash
helm repo add longhorn https://charts.longhorn.io
helm install longhorn longhorn/longhorn -n longhorn-system --create-namespace --version 1.5.1
```
Helm-чарт находится в папке homework-chart. Для установки нужно выполнить команды:  
```bash
helm repo update
helm dependency build homework-chart
helm install homework homework-chart -n homework --create-namespace
```


## Установка Kafka из Bitnami Helm-чарта

### Продакшен-конфигурация (prod)
Релиз должен иметь следующие параметры:
- Установлен в namespace `prod`
- Должно быть развернуто 5 брокеров
- Должна быть установлена Kafka версии 3.5.2
- Для клиентских и межброкерных взаимодействий должен использоваться протокол `SASL_PLAINTEXT`


Смотрим доступные чарты с нужной версией Kafka:
```bash
helm search repo bitnami/kafka --versions
```
Получаем файл с values версии `kafka 3.5.2`

```bash
helm show values bitnami/kafka --version 25.3.5 > kafka-values-prod.yaml
```
Устанавливаем в файле `kafka-values-prod.yaml` значения: `broker.replicaCount=5`, `listeners.client.protocol=SASL_PLAINTEXT`, `listeners.interBroker.protocol=SASL_PLAINTEXT`

Далее, устанавливаем чарт с нужными переменными в namespace `prod`:
```bash
helm install kafka-prod bitnami/kafka --version 25.3.5 -n prod -f kafka-values-prod.yaml --create-namespace
```



### Dev-конфигурация (dev)
Релиз должен иметь следующие параметры:
- Установлен в namespace `dev`
- Должно быть развернут 1 брокер
- Должна быть установлена последняя доступная версия Kafka
- Для клиентских и межброкерных взаимодействий должен использоваться протокол `PLAINTEXT`
- Авторизация для подключения к кластеру отключена

Получаем файл с values последней версии `kafka`
```bash
helm show values bitnami/kafka > kafka-values-dev.yaml
```
Устанавливаем в файле `kafka-values-dev.yaml` значения: `broker.replicaCount=1`, `listeners.client.protocol=PLAINTEXT`, `listeners.interBroker.protocol=PLAINTEXT`

Далее, устанавливаем чарт с нужными переменными в namespace `prod`:
```bash
helm install kafka-prod bitnami/kafka -n prod -f kafka-values-prod.yaml --create-namespace
```

```bash
helm show values bitnami/kafka --version 25.3.5 > kafka-values-dev.yaml
```

```bash
helm install kafka-prod bitnami/kafka --version 25.3.5 -n prod -f kafka-values-dev.yaml --create-namespace