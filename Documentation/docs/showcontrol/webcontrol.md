# WebControl

SeamLess ShowControl offers a web interface. It resembles what is possible with the
OSC interface but has also a user management system.

## initialize DB after installation

Before using the ShowControl software, the user management database must be
created:

```bash
export FLASK_APP=webcontrol
cd /usr/local/share/seamless/ShowControl
flask init-db
```
