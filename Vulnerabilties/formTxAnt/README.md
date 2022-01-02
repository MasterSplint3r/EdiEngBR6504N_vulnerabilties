# formTxAnt
This folder contains a simple interactive shell utilizing the vulneravility discoverd in the HTTP form handler for the 'formTxAnt' endpoint.

This form seems to be unreachable from any of the published client side HTML files located in the web root.
The form has several vulnerabilities including at least two command injections, a buffer overflow caused by an unsafe call to strcpy and a format string vulnerability. At this time, i chose to implement an exploit only for the command injection for simplicity. Since the commands are executed without any output returned i abused another hidden 'debug' endpoint to read the commands output.

Honestly, calling this a 'command injection' is a little offensive to people who actually discoverd command injection vulnerabilities, this seems to be more of a backdoor command execution endpoint which was left in production for some unkonw reason.

The exploit was successfully tested on a real router which executed the given commands as root (since the webserver runs as root).