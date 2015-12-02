# Dopelock

## Todos:
- [ ]Investigate using [self.view subviews] (SBTodayViewController) to get the views for today and tomorrow UILabels and we can extract text from there?
- [ ]Dimming issue:
  -We could either instegate a timer if the page is 3 where it will hold off on returning true until the user doesn't touch the screen or moves to another view
  -Or we could look at sayign something like : - (_Bool)isPasscodeLockVisible to fake the controller out to think it should wait longer to dim because it is an interactive view
- [ ]Getting events for each day keep looking into SBTodayViewController todaySectionInfo. It has some intresting things like snippets and stuff. No idea what I am doing
- [ ]Or look at getting events using apples framework (probably easier) 
- [ ]Fix up iPhone views
- [ ]Use layoutSubviews only to draw stuff that doesn't change (Blur views) and use the update time view to change everything else. (we could detect if it is an hour change for specific changes like the greeting and date changes but for current events and stuff we need to update 'every' minute)
- [ ]Look into glitching back to home view (looks like it is related to dimming issue)
- [ ]Make a button to show up on the main page if you have events coming up. (We still want to do this?)

##D-1: Things to do:

- Get the LPView to work perfectly (If you can)
- Get the BBBuelin thing to work (again :( ) (also, pull down the NC crash my SpringBoard)
- Get the rotation to work too
- Finish the grid view (with the eventBlock and the eventBlockName and the desciption of the event)
- Get the name of the user through the preferences
- Switch to enable or disable the alwaysDarkMode
- Get the dark mode to work dynamically (at 20h and 8h)
- Format the views for iPhones
- In the preferences, tap on the heart bring the Twitter text (I can't do that because I don't see that heart on my iPad)
- ****In the control file, add LockPages as a dependency****

Bonus (only if you have the time, not a big deal)
- A switch in the preferences to switch the text "Today @ Tomorrow", the date and "Calendar" between Black and white
