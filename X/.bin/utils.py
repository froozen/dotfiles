import subprocess

def call_command(command):
    p = subprocess.Popen(command, stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE)

    out, err = p.communicate()
    if p.returncode == 0:
        return [out.decode().strip(), True]
    else:
        return [err.decode().strip(), False]
