# Overview

Unlike most programming languages, in Erlang, variables are immutable. I rely on variables in other languages, so I wanted to create a program that would act like it was saving a variable even though it technically was creating a new instance of it each time. This led me to create a list modification program, in which the user can add, remove, sort, and do more to a list, as if it was a mutable variable. Being my first foray into Erlang, this was a good introduction to its syntax and processes. Its crash messages are quite helpful!

[Software Demo Video](https://youtu.be/Vhe7_s0XUJ0)

# Development Environment

I used VS Code for the entirety of this project.

# Useful Websites

{Make a list of websites that you found helpful in this project}
* [Erlang Documentation](https://www.erlang.org/)
* [YouTube](https://www.youtube.com/)

# Future Work

* There isn't much in the way of legitimate error checking, though it doesn't crash with invalid inputs from the user. It would be wise to implement more error checking and clear explanatory messages for such.
* User-input values are always stored as strings, even  if they are numbers, so if the user wanted a list of numbers, it would technically be stored as strings anyways. This could be changed in the future.