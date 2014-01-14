game_longest_streak
===================

A simple ruby file to maintain longest streak in Github.

###Usage
Make sure you are able to push commits to your github account normally. Fork this repository to your github account and clone it locally. Then go into the folder and run this command.

```sh
ruby game_longest_streak.rb
```

###How It Works
It creates a cron task that executes no sooner than the minimum time and no later than the maximum time set in the config file. The task creates a random number of commits that is between the maximum number and minimum number defined in the config file. The commits are then pushed to the remote, which is github.
Options can be specified in the config file.
