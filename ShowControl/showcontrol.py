#!/usr/bin/env python3

import webcontrol


def main():
    webapp = webcontrol.create_app()
    webapp.run()

if __name__ == "__main__":
    main()
