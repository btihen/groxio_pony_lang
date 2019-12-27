class User 

  let _out  : OutStream
  let name  : String
  let email : String 
  let session : Session

  // new val create(out : OutStream, name' : String val, email' : String val) =>
  // default refcap is val -- prime is just to differentiate input variables
  new val create(out : OutStream, name' : String, email' : String) =>
    _out    = out
    name    = name'
    email   = email'
    session = Session(out, name)

  new val anon(out : OutStream) =>
    _out    = out
    name    = "anonymous"
    email   = "unknown@unknown.ch"
    session = Session(out, name)

  fun to_s() : String => 
    name + " <" + email + ">"
    
  fun post_mesg(message : Message val) =>
    session.post_mesg(consume message) 
    
  fun post_text(sender : User val, text : String val) =>
    session.post_text(consume sender, consume text)

  // fun val message(sender : User val, topic : String val, text : String val) =>
  fun post_topic(sender : User val, text : String val, topic : String val) =>
    session.post_topic(consume sender, consume text, consume topic)