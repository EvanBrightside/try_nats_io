# Установка

Для поднятия на локальной машине необходимы установленый `docker`.
Для запуска скриптов необходимо склонировать проект в нужную директорию и в ней выполнить:

```bash
docker run -p 4222:4222 -p 8223:8223 nats-streaming -m 8223
```

Далее в новом окне терминала можно выполнять запуск скриптов из списка ниже

## Скрипты и их описание

1. `ruby connect.rb` - подключение к `NATS`
2. `ruby init_subscribers.rb` - инициализация группы подписчиков
3. `ruby request_reply.rb` - эмуляция синхронного режима
4. `ruby sub_down.rb` - эмуляция падение подписчика (проверка успешной обработки сообщения)
5. `ruby subscribe_by_time.rb` - подписка на более ранние сообщения (Nats Streamer)
6. `ruby acknowledgements.rb` - подтверждение сообщений и повторная доставка
7. `ruby close.rb` - отключение от `NATS`
