class Message
  let sender : User val
  let _topic : String
  let _text  : String

  new val create(sender' : User val, text' : String val) =>
    sender   = sender'
    _text    = text'
    _topic   = ""

  new val topic(sender' : User val, text' : String val, topic' : String val) =>
    sender   = sender'
    _topic   = topic'
    _text    = text'

  fun to_s() : String => 
    var output : String 
    output = "----------\nFrom: " + sender.to_s()
    if _topic != "" then
      output = output + "\nTopic: " + _topic
    end
    output + "\n" + _text + "\n----------"
