namespace ValaGL {
    
    public class Application : Adw.Application {
        public Application () {
            Object (
                application_id: "me.paladin.ValaGL",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }
        
        public override void activate () {
            base.activate ();
            var win = active_window ?? new ValaGL.Window (this);
            
            win.present ();
        }
    }
    
    [GtkTemplate (ui = "/valagl/ui/window.ui")]
    public class Window : Adw.ApplicationWindow {
        [GtkChild]
        public unowned Gtk.GLArea area;
        [GtkChild]
        public unowned Gtk.Switch autorender;
        private Canvas canvas;
        private uint initial_rotation_angle = 30;
        private uint timer_ticks;
        
        public Window (Gtk.Application app) {
            Object (application: app);
            
            area.add_tick_callback(() => {
                if (autorender.active)
                    area.queue_render();
                
                return true;
            });
        }
        
        [GtkCallback]
        public bool on_render(Gtk.GLArea area, Gdk.GLContext ctx) {
            area.make_current();
            
            canvas.paint_gl();
            timer_ticks = (timer_ticks + 1) % 1800;
            canvas.update_scene_data(initial_rotation_angle + timer_ticks / 5.0f);
            return true;
        }
        
        [GtkCallback]
        public void on_realize(Gtk.Widget area) {
            (area as Gtk.GLArea)?.make_current();
            try {
                canvas = new Canvas();
                
                canvas.update_scene_data(initial_rotation_angle);
            } catch (AppError e) {
                print("error %s", e.message);
            }
        }
        
        [GtkCallback]
        public void on_resize(int width, int height) {
            canvas.resize_gl(width, height);
        }
    }
    
    int main (string[] args) {
        var app = new ValaGL.Application();
        return app.run(args);
    }
}

