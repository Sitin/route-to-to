{exec, spawn} = require 'child_process'


task 'compile', 'Compiles all coffee files', ->
  compile()

task 'watch', 'Watch for all coffee files change', ->
  watch()

task 'doc', 'Document CoffeeScript', ->
  doc()

task 'test', 'Test source code', ->
  compile -> test()

task 'clean', 'Remove compiled files (currently just removes all .js files)', ->
  compile -> clean()


compile = (callback) ->
  exec 'coffee -c .', (err, stdout, stderr) ->
    if not err
      console.log "Compiled coffee files."
      console.log '[compile:] %s%', stdout if stdout
    else
      console.log "Compilation performed with errors."
      console.log '[compile:error:] %s%', stderr if stderr
    callback?()


watch = (callback) ->
  console.log "Watching for coffee files changes:"

  observer = spawn 'coffee', ['-w', '-c', '.'], cwd: process.cwd(), env: process.env
  observer.stdout.on 'data', (data) ->
    console.log '[watch:] %s', data

  observer.stderr.on 'data', (data) ->
    console.log '[watch:error:] %s', data

  observer.on 'exit', (code) ->
    console.log 'Watching complete with code %s.', code

  callback?()


doc = (callback) ->
  exec 'codo', (err, stdout, stderr) ->
    console.log "[Codo:]\n%s", stdout
    throw console.log "[Codo:error:]\n%s", stderr if stderr
    callback?()


clean = (callback) ->
  exec 'find . -name "*.js" -maxdepth 2 -print -delete', (err, stdout, stderr) ->
    console.log "[Clean:]\n%s", stdout
    throw console.log "[Clean:error:]\n%s", stderr if stderr
    callback?()


test = (callback) ->
  console.log "Perform tests:"

  mocha = spawn './node_modules/.bin/mocha', ['test', '-u', 'bdd', '--recursive', '-c', '-R', 'spec'],
    cwd: process.cwd()
    env: process.env
    stdio: 'inherit'

  mocha.on 'exit', (code) ->
    console.log 'Tests performed with code %s.', code

  process.on 'exit', -> mocha.kill 'SIGHUP'

  callback?()