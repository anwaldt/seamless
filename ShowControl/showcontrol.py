#!/usr/bin/env python3

import webcontrol
from schedcontrol import SchedControl

def main():
    schedctr = SchedControl()
    webapp = webcontrol.create_app()
    webapp.run()

if __name__ == "__main__":
    main()
