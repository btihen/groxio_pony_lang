actor Session
  let _out  : OutStream
  let owner_name : String

  new create(out: OutStream, owner_name' : String) =>
    _out   = out 
    owner_name = owner_name'

  be post_mesg(message : Message val) =>
    _out.print(message.to_s())

  be post_text(sender : User val, text : String val) =>
    _out.print("From: " + sender.name + 
                "\nTo: " + owner_name + 
                "\n" + text + "\n----------")

  be post_topic(sender : User val, text : String val, topic : String val) =>
    _out.print("From: " + sender.name + 
                "\nTo: " + owner_name + 
                "\nTopic: " + topic + 
                "\n" + text + "\n----------")