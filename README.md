# PubNubTest
This project is a working example of the PubNub API, and Swift (iOS).
I am using it as a baseline to build a more elaborate mobile app.

This program subscribes to the PubNub service using the demo API keys, and on channel "a".
Once a second, a message is sent on this channel. I have created
a simple messaging app, where you can send and receive messages.

The API is written in Objective-C, so you will need a bridging header
file in order to use the commands in Swift. This process is documented
fairly well on the PubNub site.

Under the hood, the messages are sent in JSON format.  The API handles all aspects
of packing/unpacking the messages.
