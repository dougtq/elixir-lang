// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

import "phoenix_html"
// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//

import socket from "./socket"
let channel = socket.channel('chat_room:lobby', {})
let list = $('#message-list')
let message = $('#msg')
let name = $('#name')

message.on('keypress', event => {
  if (event.keyCode == 13) {
    channel.push('shout', {
      name: name.val(),
      message: message.val()
    })

    message.val('')
  }
})

channel.on('shout', payload => {
  list.append(`<b>${payload.name || 'new_user'}:</b> ${payload.message}<br>`)
  list.prop({
    scrollTop: list.prop('scrollHeight')
  })
})

channel
  .join()
  .receive('ok', resp => {
    console.log('Joined channel successfully', resp)
  })
  .receive('error', resp => {
    console.log('Unable to join channel', resp)
  })
