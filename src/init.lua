local self=function(r)
  if r:wsupgrade() then
    -- Then, we'll write something to the client:
    r:wswrite("Hello, world! Please send me something.")

    -- Receive a line (frame) from the client:
    local line = r:wsread() or "nothing"

    -- Echo that line back to the client
    r:wswrite("You wrote: " .. line)

    -- Close up the connection
    r:wswrite("Goodbye!")
    r:wsclose()
  else
    r.status=405
    r:puts("405 error - Please use webhooks.  The main page is under construction.")
  end
  return apache2.DONE
end
return self
