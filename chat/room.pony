use "collections"

actor Room
  let _out: OutStream
  let topic: String
  let users: Map[String val, User val]
  //         Map[key refcap, value refcap]
  // can lookup users & val makes them immutable & easy to pass around!

  new create(out: OutStream, topic': String) =>
    _out  = out
    topic = topic'
    users = Map[String val, User val]()
    _out.print("Initializing the chat room ...")

  // group management
  be join(user : User val) =>
    if users.contains(user.email) then
      _out.print(user.to_s() + " alread joined " + topic + " chat room")
    else
      users(user.email) = user
      _out.print(user.to_s() + " has joined " + topic + " chat room")
    end

  be leave(user : User val) =>
    // if users.remove(user.email)? then
    //   _out.print(user.name + " has left the room")
    // else
    //   _out.print(user.name + " has ALREADY left")
    // end
    try 
      users.remove(user.email)?
      _out.print(user.to_s() + " has left " + topic + " chat room")
    else
      _out.print(user.to_s() + " has ALREADY " + topic + " chat room")
    end

  // // Messaging Behaviors
  be msg_all(message : Message val) =>
    let sender = message.sender
    if users.contains(sender.email) then

      for receiver in users.values() do
        receiver.post_mesg(message)
        // receiver.session.post_msg(message)
        _out.print(sender.name + " sent broadcast message to " + receiver.name)
      end

    else 
      _out.print("Please join the room before messaging")
    end

  be msg_one(message : Message val, receiver : User val) =>
    let sender   = message.sender
    if users.contains(sender.email) and users.contains(receiver.email) then
      receiver.post_mesg(message) 
      // receiver.session.post_msg(message)
      _out.print(sender.name + " sent direct message to " + receiver.name)
    else 
      _out.print("Please join the room before messaging")
    end
    
  // Messaging Behaviors
  be broadcast(sender : User val, text : String) =>
    let iterators = users.values()

    if users.contains(sender.email) then
      while iterators.has_next() do
        let receiver = try 
                        iterators.next()?
                      else
                        User.anon(_out)
                      end
        receiver.post_topic(sender, text, topic)     
        // receiver.session.post_topic(sender, text, topic)   
        _out.print(sender.name + " send message to " + receiver.name)
      end
    else 
      _out.print("Please join the room before messaging")
    end


  be direct(sender : User val, text : String val, receiver : User val) =>
    let iterators = users.values()

    // check if sender & receiver is in room
    if users.contains(sender.email) and users.contains(receiver.email) then
      if receiver.name == sender.name then
        _out.print(sender.name + " no message to self")
      else
        _out.print(sender.name + " send message to " + receiver.name)
        receiver.post_topic(sender, text, topic)
        // receiver.session.post_topic(sender, text, topic)
      end
    else 
      _out.print("Oops sender and/or reciever no longer involved")
    end

    