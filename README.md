# Дипломный практикум в Yandex.Cloud

1. Репозиторий с конфигурационными файлами Terraform.
   - [Ссылка на конфигурацию бэкенда для Terrafrom](https://github.com/vladmgb/diplom/tree/main/backend)
   - [Ссылка на основную конфигурацию Terrafrom](https://github.com/vladmgb/diplom/tree/main/infra)
      
2. Снимки экрана из вашего CI-CD-terraform pipeline.

- Ссылка на паплайн(workflow) в Github Actions: https://github.com/vladmgb/diplom/blob/main/.github/workflows/terraform.yml
- Скрины выполнения workflow при коммите в основную ветку:
<img width="1106" height="504" alt="image" src="https://github.com/user-attachments/assets/f01b7e89-07f7-4937-8f66-51152bf97d72" />

<img width="1280" height="622" alt="image" src="https://github.com/user-attachments/assets/ff9f3829-4db1-46d0-b610-32b5b78a2c87" />

3. Репозиторий с Dockerfile тестового приложения и ссылка на собранный docker image.

   - [Репозиторий с Dockerfile тестового приложения](https://github.com/vladmgb/docker_app)
   - [Ccылка на собранный docker image](https://hub.docker.com/r/vladmgb/docker-app)
   - Скрины [пайплайна(workflow)](https://github.com/vladmgb/docker_app/blob/main/.github/workflows/docker-build.yml) из Github Actions:
  
     - <img width="1213" height="379" alt="image" src="https://github.com/user-attachments/assets/5abca8f8-61bd-448d-b613-98246a7968a4" />

     - Коммит в основную ветку:

       <img width="1279" height="530" alt="image" src="https://github.com/user-attachments/assets/ee23c494-e122-44f5-b87d-94efa1914430" />

     - С установкой тега на коммит:
    
       <img width="1275" height="567" alt="image" src="https://github.com/user-attachments/assets/2e65cd98-36dd-4959-acd1-d6a6d4529e6c" />
  


5. Репозиторий с конфигурацией Kubernetes кластера: https://github.com/vladmgb/kuber_config
   - [Манифест деплоймента приложения](https://github.com/vladmgb/kuber_config/blob/main/application/deployment-app.yaml)
   - [Манифесты дополнительной настройки графаны](https://github.com/vladmgb/kuber_config/tree/main/monitoring)

  Скрины развернутого приложения в кластере:   

 - <img width="629" height="53" alt="image" src="https://github.com/user-attachments/assets/7d8676c9-2e7f-4b8d-9d47-de1a627e9496" />

 -  <img width="622" height="88" alt="image" src="https://github.com/user-attachments/assets/7cb2ea61-5dda-4cae-8529-0ed5c323e317" />
 
   
 Скрины развернутого мониторинга в кластере:

 - <img width="647" height="103" alt="image" src="https://github.com/user-attachments/assets/e503fd34-ac06-4149-adda-562578b3c29b" />

 - <img width="641" height="241" alt="image" src="https://github.com/user-attachments/assets/f720e651-3ff9-437f-b4bf-3e6ed900a2a6" />

6. Ссылка на тестовое приложение и веб интерфейс Grafana с данными доступа.
   - [Тестовое приложение](http://158.160.209.253/)
   - [Grafana](http://158.160.202.43/)
     Login: User, Pass: Qq123456

