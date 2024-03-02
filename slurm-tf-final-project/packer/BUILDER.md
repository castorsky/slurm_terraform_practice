# Создание образа загрузочного диска

## Начало работы с Packer

Подробное руководство есть [на сайте Яндекса](https://cloud.yandex.ru/ru/docs/tutorials/infrastructure-management/packer-quickstart). После установки самого приложения нужно инициализировать рабочее окружение и установить требуемые плагины:

    packer init config.pkr.hcl

Для настройки образов с помощью Ansible он должен быть установлен на машине, с которой производится выполнение работ. С целью отладки или быстрого старта можно использовать следующие шаги:

    cd slurm_terraform_practice
    python3 -m venv .venv
    source .venv/bin/activate
    pip install ansible

## Создание образа

На этом этапе должны быть известны [параметры подключения к облаку](/slurm-tf-final-project/PREPARE.md#параметры).

### Переменные

Могут быть определены следующие переменные:

|Переменная|Дефолт|Описание|
|---|---|---|
|token|`""`| Токен авторизации в Яндекс.Облаке. По умолчанию берется из переменной окружения YC_TOKEN.|
|folder_id|`""`| Идентификатор каталога в облаке. По умолчанию берется из переменной окружения YC_FOLDER_ID. |
|subnet_id|`""`| Идентификатор подсети, в которой будут производиться работы по сборке образа. Если используется вспомогательный скрипт, то в окружении будет соответствующая переменная `PKR_VAR_subnet_id`. |
|image_name|`"nginx-v"`| Имя собираемого образа (рекомендуется не менять внутри одного проекта) |
|image_version|`1`| Версия собираемого образа (рекомендутся повышать при каждой попытке) |


### Выполнение

Перед непосредственным выполнением желательно проверить корректность конфигурации и внести правки. Для этого используется команда `validate`:

    cd slurm_terraform_practice/slurm-tf-final-project/packer/nginx
    packer validate -var 'image_version=2' nginx.pkr.hcl

Команда для сборки образа `build`:

    cd slurm_terraform_practice/slurm-tf-final-project/packer/nginx
    packer build -var 'image_version=2' nginx.pkr.hcl

## Удаление образа

После того, как образ становится ненужным, его можно удалить из облака с помощью утилиты `yc` (с фильтрацией по семейству и без):

    # Remove only `centos` family
    yc compute image list | awk '/centos/ {print $2}' | xargs -L1 yc compute image delete
    # Remove all personal images
    yc compute image list | awk '{print $2}' | xargs -L1 yc compute image delete
