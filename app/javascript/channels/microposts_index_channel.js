import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {

  const element = document.getElementById('microposts-index')
  const microposts_index = element.getAttribute('data-microposts-index')

  var subscription = consumer.subscriptions.create({ channel: "MicropostsIndexChannel", microposts_index: microposts_index}, {
    connected() {
      console.log("connected to microposts channel " + microposts_index)
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      console.log("disconnected to microposts channel " + microposts_index)
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log(data)
      console.log("jnlhi")
      // Called when there's incoming data on the websocket for this channel
    }
  });
  
  $(window).unload(function() {
    consumer.subscriptions.remove("MicropostIndexChannel")
  });
  
  //consumer.subscriptions.remove(subscription);
})
