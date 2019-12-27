actor Main
  let _out: OutStream
  let room: Room

  new create(env: Env) =>
    _out = env.out

    // test = Room(_out)
    room = Room(_out, "work")

    // user1 = User.create(_out, "Bill", "btihen@gmail.com")
    let bill : User val = User(_out, "Bill", "bill@gmail.com")
    let dani : User val = User(_out, "Dani", "dani@gmail.com")

    // direct message from Dani an Bill
    bill.post_text(dani, "Gruesse user")
    bill.post_topic(dani, "Mags du user ein Kaffee?", "Pause")

    bill.session.post_text(dani, "Gruesse session")
    bill.session.post_topic(dani, "Mags du session ein Kaffee?", "Pause")

    // direct message from Dani an Bill
    var mesg : Message val = Message(dani, "Message user")
    bill.post_mesg(mesg)
    bill.post_mesg(Message.topic(dani, "Message du user ein Kaffee?", "Pause"))

    bill.session.post_mesg(Message(dani, "Message session"))
    bill.session.post_mesg(Message.topic(dani, "Message du session ein Kaffee?", "Pause"))

    room.join(bill)    
    room.join(dani)

    // send from dani an everyone
    room.broadcast(dani, "Morgen")
    room.direct(dani, "Guete Morge", bill)

    room.msg_all(Message(dani, "Morgen"))
    room.msg_one(Message(bill, "Hoi"), dani) 
    room.msg_one(Message.topic(dani, "Guete Morge", "test"), bill)

    room.leave(bill) 
    // send to bill   
    room.broadcast(bill, "Nope") 
    room.msg_all(Message(bill, "Nope"))  
    room.leave(dani) 
    room.leave(dani)
