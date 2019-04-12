#!/usr/bin/osascript
# iTerm script for SSH to a number of IP addresses 
on run argv
  -- Set variables
  set num_args to count of argv
  set num_cols to round (num_args ^ 0.5)
  set num_lines to round (num_args / num_cols) rounding up
 
  tell application "iTerm2"
    create tab with default profile of current window
 
    -- Prepare horizontal panes
    repeat with i from 1 to num_lines
      tell session 1 of current tab of current window
        if i < num_lines then
          split horizontally with default profile
        end if
      end tell
    end repeat
 
    -- Prepare vertical panes
    set sessid to 1
    repeat with i from 1 to num_lines
      if i is not 1 then set sessid to sessid + num_cols
      if i is not num_lines or num_args is num_cols * num_lines then
        set cols to num_cols - 1
      else
        set cols to (num_args - ((num_lines - 1) * num_cols)) - 1
      end if
      repeat with j from 1 to (cols)
        tell session sessid of current tab of current window
          split vertically with default profile
        end tell
      end repeat
    end repeat
 
    -- Execute actions
    repeat with i from 1 to num_args
      tell session i of current tab of current window
        write text ("ssh " & (item i of argv))
      end tell
    end repeat
 
  end tell
end run