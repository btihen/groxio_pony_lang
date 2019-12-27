class Ball
  var kind: String = "Nerf"

actor Catcher
  new create(partner: Main, ball: Ball val) =>
    partner.display("Cool - lets play")

actor Main
  var _env: Env

  new create(env: Env) =>
    _env = env
    var ball: Ball val = Ball

    display("Lets play Catch")
    var catcher: Catcher = Catcher(this, ball) // auto-invokes new create

    // can still read ball
    display(ball.kind)

    // can alias ball too
    var copied_ball: Ball val = ball
    display(copied_ball.kind)

    // but can't change the kind
    // ball.kind = "Wilson"
    // not safe to write right side to left side


  be display(message: String) =>
    _env.out.print(message)
