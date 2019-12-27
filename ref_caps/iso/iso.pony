class Ball
  var kind: String = "Nerf"

actor Catcher
  new create(partner: Main, ball: Ball iso) =>
    partner.display("Cool - lets play")

actor Main
  var _env: Env

  new create(env: Env) =>
    _env = env
    var ball: Ball iso = Ball

    display("Lets play Catch")
    var catcher: Catcher = Catcher(this, consume ball) // auto-invokes new create

    // can't access ball anymore - it's isolated and was consumed when passed
    // ball.kind 
    // can't use a consumed local or field in an expression

  be display(message: String) =>
    _env.out.print(message)
