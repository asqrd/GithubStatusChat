# GithubStatusChat

Phoenix Application Demo for a technical interview that does the following:

1. Checks every github status every 1 - 5 minutes
2. Saves the response in database with columns: HTTP Status Code, Message, Time request happened upon success
3. Broadcasts Status to a channel, updating only upon status change.
4. Channel that broadcasts to all channels data entered by user.

Notes: 

For brevity Javascript for channels will be global, as their will only be one endpoint for both channels.
Testing will be minimal (again for brevity)
PhantomJS is required in order to run tests, as I am using Wallaby. Please see Wallaby documentation for details:
https://github.com/keathley/wallaby
