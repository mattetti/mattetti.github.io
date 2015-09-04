---
layout: post
title: "Automate iTunes with JS to wake up in music"
date: 2015-09-02 20:46
comments: true
categories:
- JavaScript
- Automation
- JXA
---

Last week, my daughter started Kindergarten. I'm very happy for her,
especially because she's going to an [awesome public school](http://www.edison.smmusd.org/).
As someone who didn't grow up in the US, I heard a lot of stories about the American school
system but one thing I didn't know is that kids start so early. My
daughter starts at 8:10am! We had to find a way to turn our
sleeping-in family members into morning people.

I found a solution to help us: coding and music!

My goal: to wake up my daughter with a custom music playlist starting a
few minutes before I go see her.

We have an old Mac Mini at home that I recently upgraded it to run Yosemite.
This recent version of OS X added JavaScript as an alternative to [AppleScript](https://en.wikipedia.org/wiki/AppleScript).
My goal is to write a little script that will play a given playlist and
then I want to schedule this script to play every school morning. The
Mac Mini is connected to an Airport Express with usb speakers located in
my daughter's bedroom.

## JavaScript for Automation

Apple has some [documentation](https://developer.apple.com/library/mac/releasenotes/InterapplicationCommunication/RN-JavaScriptForAutomation/) about how to use JS to automate different tasks. To be honest the documentation isn't really good in comparison to their usual doc.
Also, the technical implementation is pretty hacky/buggy but that won't
prevent us to have a bit of fun.

The code to start iTunes and play our playlist if very straight forward:

```javascript
app = Application('iTunes')
app.activate()
app.stop()
playlist = app.sources["Library"].userPlaylists["morning"]
try {
	playlist.play()
}
catch(err) {
	console.log("The playlist probably doesn't exist", err)
}
```

As you probably guessed, this script loads iTunes and then uses its
scripting API to load the main library and look for a playlist called
"morning".
I'm not proud of the ugly try/catch, but playlist is an instance of
`ObjectSpecifier` which isn't evaluated until a method is called on it.
You can think of it as a lazy container. The problem is that if we try
to call `play()` on a playlist we didn't find, then an error is thrown.
I didn't find a way to check if the underlying value is null so I had to
catch the error.

Once we have the above code, we have two options, put it in a script or
convert it into an app. When developing your automation, it's highly
recommended to use `Script Editor.app` which ships with the OS.
From within the app, you can run your script and test / "debug" it.
Script Editor also allows you to export your script as script, script
bundle and app. The easiest way is to export our code as an app:

![Export JS as an app](/images/jxa_app.jpg)

Note that you can also write a script and create a `osascript` shebang,
or even evalute your automation JS in the terminal:

```
$ say "you are listening to" `osascript -l JavaScript -e 'Application("iTunes").currentTrack.name()'`
```

So we have a script to start iTunes if needed and play our morning
playlist. Now we need to schedule our app to start every school day:

## Launchctl

OS X has a builtin scheduling system called [launchd](http://launchd.info/). It's kind of like a cron scheduler but with more options.
Unfortunately figuring something as simple as scheduling a recurring
script is much harder than it should. So here is my plist file:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>morning.playlist.itunes</string>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/bin/open</string>
		<string>-a</string>
		<string>wakeup.app</string>
	</array>
	<key>RunAtLoad</key>
	<false/>
	<key>StandardErrorPath</key>
	<string>/tmp/morning.playlist.itunes.stderr</string>
	<key>StandardOutPath</key>
	<string>/tmp/morning.playlist.itunes.stdout</string>
	<key>StartCalendarInterval</key>
	<array>
		<dict>
			<key>Hour</key>
			<integer>6</integer>
			<key>Minute</key>
			<integer>55</integer>
			<key>Weekday</key>
			<integer>1</integer>
		</dict>
		<dict>
			<key>Hour</key>
			<integer>6</integer>
			<key>Minute</key>
			<integer>55</integer>
			<key>Weekday</key>
			<integer>2</integer>
		</dict>
		<dict>
			<key>Hour</key>
			<integer>6</integer>
			<key>Minute</key>
			<integer>55</integer>
			<key>Weekday</key>
			<integer>3</integer>
		</dict>
		<dict>
			<key>Hour</key>
			<integer>6</integer>
			<key>Minute</key>
			<integer>55</integer>
			<key>Weekday</key>
			<integer>4</integer>
		</dict>
		<dict>
			<key>Hour</key>
			<integer>6</integer>
			<key>Minute</key>
			<integer>55</integer>
			<key>Weekday</key>
			<integer>5</integer>
		</dict>
	</array>
</dict>
</plist>
```

[Gist](https://gist.github.com/mattetti/75fd52c653b9144f303e)

Note that I called my app `wakeup.app` and I put it in my Applications
folder. My launch agent starts the app when it's called, but it doesn't
do that when the system loads the service (`RunAtLoad` is set to false).
I'm also logging out stdout and stderr to tmp files so I can debug if
something goes wrong. Finally the schedule is defined in the `StartCalendarInterval`
key with a daily entry Monday to Friday at 6:55am.

Save the plist file as `wakeup.playlist.itunes.plist` and drop it in `~/Library/LaunchAgents/`
and load it via `launchctl`:

```
$ launchctl load -w ~/Library/LaunchAgents/wakeup.playlist.itunes.plist
```

That's it, everything should work fine, however if you want to make sure
it will, you might want to unload the plist, edit it so `RunAtLoad` is
set to true and reload it. At this point, your playlist should play. If
it doesn't, then check the log files to see what happened.
When everything is good, unload, go back to the original version and
reload.

There is plenty more you can do with JS Automation for Mac, if like me
you are listening to a lot of music while coding, you might be
interested in knowing that **Spotify** and **VLC** are scriptable (and
so are most browsers).
