class Ball
  var kind: String = "Nerf"

actor Catcher
  // can't revieve a type ref (must be tag, val, or iso)
  new create(partner: Main, ball: Ball val) =>
    partner.display("Cool - lets play")

actor Main
  var _env: Env

  new create(env: Env) =>
    _env = env
    var ball: Ball ref = Ball

    display("Lets play Catch")
    
    // can no longer send the ball when type ref
    // var catcher: Catcher = Catcher(this, ball) // auto-invokes new create
    // this parameter must be sendable (iso, val or tag)

    // can still read ball
    display(ball.kind)

    // can alias ball too
    var copied_ball: Ball ref = ball

    // but can't change the kind
    ball.kind = "Wilson"
    // not safe to write right side to left side

    display(copied_ball.kind)  // has same reference as ball so they are both changed!


  be display(message: String) =>
    _env.out.print(message)
