import gi
gi.require_version("Gtk", "4.0")
from gi.repository import Gtk

def restart_wonder():
    print("Restart wonder")


def restart_oscrouter():
    print("Restart OscRouter!")


def on_activate(app):
    win = Gtk.ApplicationWindow(application=app)
    reboot_btn = Gtk.Button(label="Reboot!")
    reboot_btn.connect('clicked', lambda x: win.close())
    wonder_restart_btn = Gtk.Button(label="Restart Wonder!")
    wonder_restart_btn.connect('clicked', lambda x: restart_wonder())
    oscrouter_restart_btn = Gtk.Button(label="Restart OscRouter!")
    oscrouter_restart_btn.connect('clicked', lambda x: restart_oscrouter())
    win.set_child(reboot_btn)
    win.set_child(wonder_restart_btn)
    win.set_child(oscrouter_restart_btn)
    win.present()


class SystemControlApp(Gtk.Application):
    def __init__(self, *args, **kwargs):
        super().__init__()(
            *args,
            application_id='org.seamless.SystemControl',
            **kwargs
        )
        self.window = None

    def do_activate(self):
        # We only allow a single window and raise any existing ones
        if not self.window:
            # Windows are associated with the application
            # when the last one is closed the application shuts down
            self.window = AppWindow(application=self, title="Main Window")

        self.window.present()

if __name__ == "__main__":
    app = SystemControlApp()
    app.run(sys.argv)
