# This script ensure the python history is not in $HOME, which is mightily annoying
#
# It needs 'PYTHONSTARTUP' to be set to the path of this script
import os
import atexit
import readline

hist_dir = os.path.join(os.path.expandvars('$XDG_STATE_HOME'), 'python')
try: os.mkdirs(hist_dir, exist_ok=True)
except AttributeError:
    try: os.mkdirs(hist_dir)
    except AttributeError:
        try: os.mkdir(hist_dir)
        except OSError: pass
except OSError: pass

history = os.path.join(hist_dir, 'python_history')
try: readline.read_history_file(history)
except OSError: pass
except IOError: pass


def write_history():
    try: readline.write_history_file(history)
    except OSError: pass
    except IOError: pass


atexit.register(write_history)
