import Foundation
import TelegramBot

print("Hello, world!")

let token = readToken(from: "HELLO_BOT_TOKEN")
print(token)
let bot = TelegramBot(token: token)

while let update = bot.nextUpdateSync() {
    if let message = update.message, let from = message.from, let text = message.text {
        bot.sendMessageAsync(chat_id: from.id,
                             text: "Hi \(from.first_name)! You said: \(text).\n")
    }
}

let defaultError = "Unknow Error!"
fatalError("Server stopped due to error: \(String(describing: bot.lastError))")

