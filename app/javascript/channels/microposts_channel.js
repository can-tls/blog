import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {

  const element = document.getElementById('micropost-id')
  const micropost_id = element.getAttribute('data-micropost-id')

  consumer.subscriptions.create({ channel: "MicropostsChannel", micropost_id: micropost_id}, {
    connected() {
      console.log("connected to microposts channel " + micropost_id)
      consumer.subscriptions.remove({channel:"MicropostIndexChannel"},{})
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      console.log("disconnected to microposts channel " + micropost_id)
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log(data);
      console.log("jnlk");
      var titel = document.getElementsById("titel") ;
      titel.innerHTML = titel.innerHTML.replace( "@micropost.titel",'data.titel') ;
      // Called when there's incoming data on the websocket for this channel
    }
  });
})
