require 'telegram/bot'

token = '5416661403:AAHQvrfsUWdsAMLH_2HnVoKsPMhy-X1LIYM'

loop do
  begin 
Telegram::Bot::Client.run(token, logger: Logger.new($stderr)) do |bot|    
  bot.logger.info('Бот стартовал')
  bot.listen do |message|  
    Thread.start(message) do |message|
      begin

        # переменные разделов

        step_one = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Настройка Нового', 'Неисправности', 'Консультации', 'Партнёрский Портал', 'Интеграции с...'], one_time_keyboard: true)
        errors = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Принтер', 'Дополнения(defect)', 'Webkassa(defect)', '<-Назад'], one_time_keyboard: true)
        new_setup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Дополнения', '<-Назад'], one_time_keyboard: true)
        consultation = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['В доработке...', '<-Назад'], one_time_keyboard: true)
        partner_portal = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Создание нового клиента', 'Проверка оплаты', '<-Назад'], one_time_keyboard: true)
        integration = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['В доработке...', '<-Назад'], one_time_keyboard: true)
        
        # переменные клавиатур по принтерам
        # usb block
        
        printer = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['USB', 'LAN', 'WiFi', 'Bluetooth', '<-Назад'], one_time_keyboard: true)
        usb_check = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, принтер определяется', 'Нет, принтер не определяется', '<-Назад'], one_time_keyboard: true)
        usb1_check = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, проверили(usb)', 'Нет (usb)', '<-Назад'], one_time_keyboard: true)
        usb2_check = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, помогло', 'Нет, не помогло(usb)', '<-Назад'], one_time_keyboard: true)
        port_check = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, помогло', 'Нет, не помогло(порт)', 'В Windows печатает, но чеки из Айки не выходит', '<-Назад'], one_time_keyboard: true)
        
        # переменные клавиатур по принтерам
        # lan block
        
        lan_check = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, IP адрес есть', 'Нет, IP адреса нету', '<-Назад'], one_time_keyboard: true)
        ping_check = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, пинг есть', 'Нет, пинга нету', '<-Назад'], one_time_keyboard: true)
        ping_check1 = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, совпадает', 'Нет, не совпадает', '<-Назад'], one_time_keyboard: true)
        ping_check2 = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, помогло', 'Нет, не помогло(4)', '<-Назад'], one_time_keyboard: true)
        test_print = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Печать из Windows и Айки есть', 'Печать из Windows есть, из Айки нету', 'Печати из Windows нету.', '<-Назад'], one_time_keyboard: true)
        test_print1 = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, помогло', 'Нет, не помогло(1)', '<-Назад'], one_time_keyboard: true)
        test_print2 = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, помогло', 'Нет, не помогло(2)', '<-Назад'], one_time_keyboard: true)
        shop_mode = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Фастфуд', 'Ресторан', '<-Назад'], one_time_keyboard: true)
        shop_mode1 = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, помогло', 'Нет, не помогло(3)', '<-Назад'], one_time_keyboard: true)

        step_bye = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)  

        # Дополнения
        add_dop = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Arrivals', 'Waiter-new', '<-Назад'], one_time_keyboard: true)
        waiter_check = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да есть лицензия', 'Нет лицензии', '<-Назад'], one_time_keyboard: true)
        defect_dop = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Waiter-defect', '<-Назад'], one_time_keyboard: true)
        waiter_defect = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Не заходит в Вейтер, ошибка сервера', 'Системная ошибка (есть цифры и буквы кода)', 'Не хватает лицензий', '<-Назад'], one_time_keyboard: true)
        waiter_defect1 = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, помогло', 'Нет, не помогло(5)'], one_time_keyboard: true)
        waiter_defect2 = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, помогло', 'Нет, не помогло(6)'], one_time_keyboard: true)
      
        # webkassa
        webk_defect = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Не запущено устройство', 'Истекли 24ч', 'Заказ отменен, сумма заказа изменилась на 0'], one_time_keyboard: true)
        webk_defect1 = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, помогло', 'Не помогло'], one_time_keyboard: true)
        ofd_check = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['ОФД оплачен', 'ОФД не оплачен'], one_time_keyboard: true)
        ofd_check1 = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['больше 24ч', 'меньше 24ч'], one_time_keyboard: true)
        
        # переменные партнерпортала
      partner_portal_check = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Да, помогло', 'Нет, счет оплачен, но лицензии на портале нету'], one_time_keyboard: true)
      
      
        #rescue
    
        case message
        when Telegram::Bot::Types::Message
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Привет, #{message.from.first_name}. Это бот по стандартным проблемам")
          bot.api.send_message(chat_id: message.chat.id, text: 'Выберите раздел', reply_markup: step_one)

          # Главное меню 
        when 'Настройка Нового'
          bot.api.send_message(chat_id: message.chat.id, text: 'Выберите из списка', reply_markup: new_setup)
        when 'Неисправности'
          bot.api.send_message(chat_id: message.chat.id, text: 'Выберите из списка', reply_markup: errors)
        when 'Консультации'
          bot.api.send_message(chat_id: message.chat.id, text: 'Выберите из списка', reply_markup: consultation)
        when 'Партнёрский Портал'
          bot.api.send_message(chat_id: message.chat.id, text: 'Выберите из списка', reply_markup: partner_portal)
        when 'Интеграции с...'
          bot.api.send_message(chat_id: message.chat.id, text: 'Выберите из списка', reply_markup: integration)

          # Printer
          # usb block
        when 'Принтер'
          bot.api.send_message(chat_id: message.chat.id, text: 'Выбери тип подключения. Уточни у клиента какой принтер не печатает - касса, кухня (если Кухня, то какой именно), официантский', reply_markup: printer)  
        when 'USB'
          bot.api.send_message(chat_id: message.chat.id, text: 'Проверьте Диспетчер устройств, Принтер определяется или нет?', reply_markup: usb_check)
        when 'Да, принтер определяется'
          bot.api.send_message(chat_id: message.chat.id, text: 'Проверьте выбранный порт, выберите правильный номер USB порта, снимите с очереди печати галочку “Работать автономно”.', reply_markup: port_check)
        when 'Нет, принтер не определяется'
          bot.api.send_message(chat_id: message.chat.id, text: 'Проверьте с клиентом включен ли принтер, горит ли индикация на принтере. Проверьте с клиентом подключение USB кабеля, попросите вытащить и подключить снова кабель. При необходимости созвониться по видео, проверить правильность подключения.', reply_markup: usb1_check)
        when 'Да, проверили(usb)'
          bot.api.send_message(chat_id: message.chat.id, text: 'Уточнить наличие DEEP переключателей на дне принтера, некоторые модели могут работать в режиме либо COM либо USB подключения (Posiflex). Обновить Windows драйвера на USB. Проверить работоспособность USB порта в кассе, попросить подключить флешку или мышку.', reply_markup: usb2_check)
        
        when 'Нет, не помогло(usb)'
          bot.api.send_message(chat_id: message.chat.id, text: 'Поменяйте USB кабель. Если не поможет - Предложить клиенту сдать принтер в ремонт, либо сменить тип подключения на LAN или COM', reply_markup: step_one)
        
        when 'Нет, не помогло(порт)'
          bot.api.send_message(chat_id: message.chat.id, text: 'Переустановите драйвера принтера, уточнить модель принтера, попросить фото наклейки принтера.', reply_markup: step_one)
        when 'В Windows печатает, но чеки из Айки не выходит'

          # Printer
          # lan block
        when 'LAN'
          bot.api.send_message(chat_id: message.chat.id, text: 'Подключись на кассу, проверь IP адрес принтера в свойствах принтера.', reply_markup: lan_check)
        when 'Да, IP адрес есть'
          bot.api.send_message(chat_id: message.chat.id, text: 'Пропингуй принтер', reply_markup: ping_check)
        when 'Да, пинг есть'
          bot.api.send_message(chat_id: message.chat.id, text: 'Отправь пробную печать из Windows и Айки (Настройки оборудования-тестовая печать из принтера)', reply_markup: test_print)
        when 'Нет, пинга нету'
          bot.api.send_message(chat_id: message.chat.id, text: 'Просим кассира распечатать Селф тест принтера. И сверяем IP адрес с имеющимся', reply_markup: ping_check1)
        when 'Да, совпадает'
          bot.api.send_message(chat_id: message.chat.id, text: 'Просим кассира проверить подключение сетевого кабеля на принтере, на сетевом оборудовании, проверить индикацию сзади принтера, перегрузить свитч/роутер. При необходимости созвониться по видео, перепроверить кабеля', reply_markup: ping_check2)
        when 'Нет, не совпадает'
          bot.api.send_message(chat_id: message.chat.id, text: 'Добавь Новый ip адрес с свойствах принтера. При необходимости добавь вторую подсетку в свойствах LAN подключения', reply_markup: ping_check2)
        when 'Нет, не помогло(4)'
          bot.api.send_message(chat_id: message.chat.id, text: 'Предложить выездного техника для проверки ЛВС', reply_markup: step_one)
        
        when 'Печать из Windows и Айки есть'
          bot.api.send_message(chat_id: message.chat.id, text: 'Проверь настройку оборудования, чтобы не стояла настройка принтера как IP адрес, выбери через Windows драйвер. Попроси сотрудника проверить печать.', reply_markup: test_print1)
        
        when 'Нет, не помогло(1)'
          bot.api.send_message(chat_id: message.chat.id, text: 'Уточни точные наименования блюд, проверь привязку принтера к отделению, отделения к месту приготовления, в карточке блюда чтобы правильно был выставлен Тип места приготовления.', reply_markup: test_print2)
        
        when 'Нет, не помогло(2)'
          bot.api.send_message(chat_id: message.chat.id, text: 'Проверь режим работы заведения', reply_markup: shop_mode)
        when 'Фастфуд'
          bot.api.send_message(chat_id: message.chat.id, text: 'Проверь настройки отделения Касса (или того отделения, из которого указан Стол по умолчанию в Группе), должна стоять настройка “Автоматическая сервисная печать после оплаты”', reply_markup: shop_mode1)
        
        when 'Нет, не помогло(3)'
          bot.api.send_message(chat_id: message.chat.id, text: 'Проверьте наличие Кухонного экрана, если активирован, то в в статусе надо поставить “Печать чека окончания приготовления”', reply_markup: step_one)
        when 'Ресторан'
          bot.api.send_message(chat_id: message.chat.id, text: 'Проверьте наличие Кухонного экрана, если активирован, то в в статусе надо поставить “Печать чека окончания приготовления”', reply_markup: step_one)

        when 'Печать из Windows есть, из Айки нету'
          bot.api.send_message(chat_id: message.chat.id, text: '', reply_markup: )
        when 'Печати из Windows нету.'
          bot.api.send_message(chat_id: message.chat.id, text: '', reply_markup: )
        
        
        # webkassa defect
        when 'Webkassa(defect)'
          bot.api.send_message(chat_id: message.chat.id, text: 'Выберите вариант', reply_markup: webk_defect)
        when 'Не запущено устройство'
          bot.api.send_message(chat_id: message.chat.id, text: 'Проверяем запуск МП
            Проверяем запуск кассы в МП
            В свойствах папки МП на вкладке Безопасность разрешаем все действия
            ', reply_markup: step_one)
        when 'Истекли 24ч'
          bot.api.send_message(chat_id: message.chat.id, text: 'Проверьте работу интернета на кассе. Перезапустите МП', reply_markup: webk_defect1)
        when 'Не помогло'
          bot.api.send_message(chat_id: message.chat.id, text: 'Проверяем логи, смотри ошибку оплаты ОФД', reply_markup: ofd_check)
        when 'ОФД не оплачен'
          bot.api.send_message(chat_id: message.chat.id, text: 'Предлагаем вариант оплаты через приложение Каспи - услуги ОФД - ОФД Казахтелеком - оплата по БИНу
            Срок продления от 15 мин до 3, зависит от ОФД (бывают редкие случаи до недели)
            При необходимости советовать обратиться в бот поддержки на сайте https://org.oofd.kz/#/landing
            При необходимости (если клиент негативит) самому написать в бот поддержки
            ', reply_markup: step_one)
        when 'ОФД оплачен'
          bot.api.send_message(chat_id: message.chat.id, text: 'Проверяем когда была открыта кассовая смена в Айке и в личном кабинете веб кассы', reply_markup: ofd_check1)
        when 'больше 24ч'
          bot.api.send_message(chat_id: message.chat.id, text: 'Закрываем кассовую смену на фронте
            Открываем кассовую смену', reply_markup: step_one)
          when 'меньше 24ч'
            bot.api.send_message(chat_id: message.chat.id, text: 'Закрыть фронт, зайти в тест драйвера Штриха, Свойства, проверить связь с устройством, раздел Отчеты, снять отчет с гашением. Запустить фронт', reply_markup: step_one)





        when 'WiFi'
          bot.api.send_message(chat_id: message.chat.id, text: 'В утилите проверьте правильность SSID и Password', reply_markup: step_one)
        when 'Bluetooth'
          bot.api.send_message(chat_id: message.chat.id, text: 'В настройках забыть устройство и заново подключиться', reply_markup: step_one)
    
        # Defect -> Waiter
        when 'Дополнения(defect)'
          bot.api.send_message(chat_id: message.chat.id, text: 'Выберите из списка', reply_markup: defect_dop)
        when 'Waiter-defect'
          bot.api.send_message(chat_id: message.chat.id, text: 'Выберите вариант', reply_markup: waiter_defect)
        when 'Не заходит в Вейтер, ошибка сервера'
          bot.api.send_message(chat_id: message.chat.id, text: 'Проверяем на кассе запущен ли плагин вейтера - заходим в браузер locahost:8105', reply_markup: waiter_defect1)
        when 'Нет, не помогло(5)'
          bot.api.send_message(chat_id: message.chat.id, text: 'Перезапустите Фронт, проверьте запуск плагина', reply_markup: waiter_defect2)
        when 'Нет, не помогло(6)'
          bot.api.send_message(chat_id: message.chat.id, text: 'Обновляем плагин согласно инструкции. Выберите вариант Да, есть лицензия', reply_markup: waiter_check)



        when 'Дополнения'
          bot.api.send_message(chat_id: message.chat.id, text: 'Выберите из списка', reply_markup: add_dop)
        when 'Arrivals'
          bot.api.send_message(chat_id: message.chat.id, text: ' Заходим на роутер, закрепляем IP кассы по мак адресу (пример статьи )
          https://f1comp.ru/internet/kak-v-nastrojkax-routera-prisvoit-staticheskij-ip-adres-ustrojstvu-po-mac-adresu 
          
            https://ru.iiko.help/articles/#!special-iiko/iikoarrivals 
            iikoArrivals
            Вход на ftp://ftp.iiko.ru
            partners
            partners#iiko
            1) Скачиваем дистрибьютив Arrivals в удобное место. (Всегда качаем Arrivals ftp://ftp.iiko.ru/release_iiko/НОМЕР_ВЕРСИИ/Plugins/External/ из самого последнего релиза, не имеет значение версия iiko)
            
            2) Скачиваем с ФТП (ftp://ftp.iiko.ru/release_iiko/НОМЕР_ВЕРСИИ/Plugins/Front/Resto.Front.Api.WebServer/ (всегда качаем по релизу версии фронта)
            
            3) В конфиге плагина web.front.api ставим порт не выше 8999 (Для примера 8102).
            4) Запуска фронт от админа (в свойствах ярлыка, указываем запуск всегда от администратора)
            5) Убеждаемся, что в фронтовом логе plugin-Resto.Front.Api.WebServer.log все хорошо, т.е присутствует строка: 
            [2018-02-10 22:09:10,945]  INFO [ 7] - Web server started. http://127.0.0.1:8102/
            6) Открываем браузер, вводим: http://127.0.0.1:8102/api/login/2050, убеждаемся, что веб-сервер нам отдал что-то кроме error 500 (должен быть guid в идеале).
            7) правим порт на 8102 в папке Arrivals config.json
            и в строчке "deliveryScheme":меняем на значение "KDS",
            8 ) Запускаем Mongoose. 
            ', reply_markup: step_one)
          
          when 'Waiter-new'
            bot.api.send_message(chat_id: message.chat.id, text: 'Проверить лицензию Вейтер в на портале', reply_markup: waiter_check)
          when 'Нет лицензии'
            bot.api.send_message(chat_id: message.chat.id, text: 'Добавьте saas лицензию Waiter на Партнерском портале. При наличии ЦО, то необходимо добавить через ЦО и потом распределить на нужную точку. Устанавливаем лицензию в офисе', reply_markup: step_one)
          when 'Да есть лицензия'
            bot.api.send_message(chat_id: message.chat.id, text: 'Скачать плагин https://disk.iiko.pro/plugins/WaiterServer/
              Закрыть фронт, распаковать плагин с конфигом на главную кассу в C:\program files\iiko\front.net\plugins\
              Зайти в свойства ДЛЛ правой кнопкой. Если внизу справа кнопка “Разблокировать”, то скопировать ДЛЛ на рабочий стол, нажать разблокировать, скопировать обратно в папку с плагинами.
              Отключить брэндмауэр
              Открыть фронт, зайти в браузер по адресу http://localhost:8105 если всё ок, будет страничка iikoWaiter is Working!
              На мобильном указать айпи главной кассы и всё работает. Пин - это пин сотрудника из айко офис.
              Фронт закрываем. Заходим в %appdata%, где делаем настройки фронта. Папка PluginConfigs
              Находим конфиг Waiter и меняем руру на kk-KZ
              ', reply_markup: step_one)
        
        
        
        # Partner Portal
        when 'Проверка оплаты'
          bot.api.send_message(chat_id: message.chat.id, text: 'Заходим в Счета
            Нажимаем “Показать счета от iiko к филиалу”
            Ждем, потом нажимаем “Показать все счета филиала”. Ждем
            Потом в Поиске пишем имя клиента, как записано на Партнерском портале
            Ждем, портал может обновлять информацию до пары минут, ждать!!!
            Кнопка Далее, нажимаем и
Смотрим счет за какой период есть счета
Неоплаченный счет висит обозначен Крестиком
Запрашиваем у клиента фотографию платежного поручения, тегаем в заявке Отдел учета для продления', reply_markup: partner_portal_check)

          when 'Нет, счет оплачен, но лицензии на портале нету'
            bot.api.send_message(chat_id: message.chat.id, text: 'Если сегодня 1-2 число, то лицензия активируется только после 12ч мск
              Если это рмс в ЦО, то Зайди в кабинет ЦО, распределение лицензий, убери с любой точки 1 лицензию, сохрани, верни как было, подождать 5-10 минут. (Сбойнул сервер лицензирования.
              ', reply_markup: step_one)
        
        
        
        
          # частые
        when 'В доработке...'
          bot.api.send_message(chat_id: message.chat.id, text: 'Пока что идем назад. Находится в доработке...', reply_markup: step_one)
        when '<-Назад'
          bot.api.send_message(chat_id: message.chat.id, text: 'Возвращаемся к первому шагу', reply_markup: step_one)
        when 'Да, помогло'
          bot.api.send_message(chat_id: message.chat.id, text: 'Обращайся', reply_markup: step_one)
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: 'ты меня остановил', reply_markup: step_bye)
        else 
          bot.api.send_message(chat_id: message.chat.id, text: 'Не пиши такое. Начни заново', reply_markup: step_one)
        end
      end
    rescue 
    end
  end
end
end
end
end