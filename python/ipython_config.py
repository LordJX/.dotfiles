def install(name):
    """Install package with subprocess."""
    import subprocess
    subprocess.call(['pip', 'install', name])

try:
    import pygments_solarized_style
except ImportError:
    #install('pygments-solarized-style')
    print('pygments-solarized-style')

## The name or class of a Pygments style to use for syntax                      
#  highlighting:                                                         
#  borland, paraiso-light, bw, emacs, igor, vs, rainbow_dash, perldoc, paraiso-dark, algol, arduino, native, murphy, friendl    y, rrt, pastie, autumn, trac, default, tango, monokai, lovelace, abap, colorful, xcode, algol_nu, manni, vim, fruity
c.TerminalInteractiveShell.highlighting_style = "solarizeddark"

## Use 24bit colors instead of 256 colors in prompt highlighting. If your
#  terminal supports true color, the following command should print 'TRUECOLOR'
#  in orange: printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
c.TerminalInteractiveShell.true_color = True

## Set the color scheme (NoColor, Neutral, Linux, or LightBG).
c.InteractiveShell.colors = 'Linux'
