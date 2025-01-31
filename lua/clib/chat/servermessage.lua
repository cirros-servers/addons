CLib.Chat.ServerMessage = function (message, options)
    message = "[&#cba6f7](Server) " .. message

    options = options or {}
    options.formatColor = true

    CLib.Chat.GenericMessage(message, options)
end