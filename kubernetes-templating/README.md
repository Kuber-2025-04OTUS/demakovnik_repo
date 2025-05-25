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


```bash
helm search repo bitnami/kafka --versions
```

```bash
helm show values bitnami/kafka --version 25.3.5 > kafka-values-prod.yaml
```

```bash
helm install kafka-prod bitnami/kafka --version 25.3.5 -n prod -f kafka-values-prod.yaml --create-namespace
```

```bash
helm show values bitnami/kafka --version 25.3.5 > kafka-values-dev.yaml
```

```bash
helm install kafka-prod bitnami/kafka --version 25.3.5 -n prod -f kafka-values-dev.yaml --create-namespace