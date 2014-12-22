function handle(r)
  r:puts("Uh oh!  The page you were looking for was not found!")
  return apache2.OK
end
