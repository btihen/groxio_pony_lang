class Ball
  var kind: String = "Nerf"

actor Catcher
  // its a tag hereS
  new create(partner: Main, ball: Ball tag) =>
    partner.display("Cool - lets play")

actor Main
  var _env: Env

  new create(env: Env) =>
    _env = env
    // must tag here too
    var ball: Ball tag = Ball

    display("Lets play Catch")
    var catcher: Catcher = Catcher(this, ball) // auto-invokes new create

    // can't access type tag
    // ball.kind
    // can't read a field through Ball tag

    // can alias of ball should work
    var copied_ball: Ball tag = ball
    // but can't read it
    // display(copied_ball.kind)
    // can't read a field through Ball tag

  be display(message: String) =>
    _env.out.print(message)
