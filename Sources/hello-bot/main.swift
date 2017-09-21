import Foundation
import TelegramBot


let token = readToken(from: "HELLO_BOT_TOKEN")
//print(token)
let bot = TelegramBot(token: token)

let router = Router(bot: bot)

router["help", .slashRequired] = { context in
    guard let from = context.message?.from else { return false }
    let helpText = "Usage: /greet"
    context.respondPrivatelyAsync(helpText, groupText: "\(from.first_name), please find usage instructions in a personal message.")
    return true
}

router["greet", .slashRequired] = { context in
    guard let from = context.message?.from else { return false }
    context.respondAsync("Hello, \(from.first_name)!")
    return true
}

print("Ready to accept commands")

while let update = bot.nextUpdateSync() {
    print("--- update: \(update.debugDescription)")
    try router.process(update: update)
    if let message = update.message, let from = message.from, let text = message.text {
        bot.sendMessageAsync(chat_id: from.id,
                             text: "Hi \(from.first_name)! You said: \(text).\n")
    }
}

let defaultError = "Unknow Error!"
fatalError("Server stopped due to error: \(bot.lastError.unwrapOptional)")



