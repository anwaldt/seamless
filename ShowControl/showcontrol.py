#!/usr/bin/env python3

import webcontrol


def main():
    webapp = webcontrol.create_app()
    webapp.run(host="0.0.0.0", port=8080)

if __name__ == "__main__":
    main()
