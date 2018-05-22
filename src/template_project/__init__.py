import os

import psutil


def get_run_type():
    """
    Get type of django instance

    :return: server | <manage command> | <celery command>
    """
    p = psutil.Process(os.getpid())
    cmdline = p.cmdline()
    if cmdline[0].endswith("wsgi"):
        return "server"
    if cmdline[1].endswith("manage.py"):
        if cmdline[2] == "runserver":
            return "server"
        return cmdline[2].strip()
    if cmdline[1].endswith("celery"):
        return cmdline[2]
    return None
