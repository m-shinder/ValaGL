namespace ValaGL {
    
    
    [GtkTemplate (ui = "/valagl/ui/window.ui")]
    public class MainWindow : Adw.ApplicationWindow {
        [GtkChild]
        public unowned Gtk.GLArea area;
        [GtkChild]
        public unowned Gtk.Switch autorender;
        
        private Canvas canvas;
        private bool rotating;
        
        public MainWindow(Gtk.Application app) {
            Object(application: app);
            
            area.add_tick_callback(() => {
                if (autorender.active)
                    area.queue_render();
                
                return true;
            });
        }
        
        [GtkCallback]
        public void on_rotate(double x, double y) {
            if (rotating) {
                canvas.arc_camera.current_pos.x = (float) ((x - (area.get_width() / 2) ) / (area.get_width()/2)) * 1;
                canvas.arc_camera.current_pos.y = (float) (((area.get_height()/2) - y) / (area.get_height()/2)) * 1;
                canvas.arc_camera.current_pos.z = canvas.arc_camera.z_axis(canvas.arc_camera.current_pos.x, canvas.arc_camera.current_pos.y);
                canvas.arc_camera.rotation();
            }
        }
        
        [GtkCallback]
        public void on_start_rotate(int n_clicks, double x, double y) {
            canvas.arc_camera.start_pos.x = (float) ((x - (area.get_width() / 2) ) / (area.get_width() / 2)) * 1;
		    canvas.arc_camera.start_pos.y = (float) (((area.get_height() / 2) - y) / (area.get_height() / 2)) * 1;
		    canvas.arc_camera.start_pos.z = canvas.arc_camera.z_axis(canvas.arc_camera.start_pos.x, canvas.arc_camera.start_pos.y);
            rotating = true;
        }
        
        [GtkCallback]
        public void on_stop_rotate(int n_clicks, double x, double y) {
            canvas.arc_camera.replace();
            rotating = false;
        }
        
        [GtkCallback]
        public bool on_render(Gtk.GLArea area, Gdk.GLContext ctx) {
            area.make_current();
            
            canvas.paint_gl();
            return true;
        }
        
        [GtkCallback]
        public void on_realize(Gtk.Widget area) {
            (area as Gtk.GLArea)?.make_current();
            try {
                canvas = new Canvas();
            } catch (AppError e) {
                print("error %s", e.message);
            }
        }
        
        [GtkCallback]
        public void on_resize(int width, int height) {
            canvas.resize_gl(width, height);
        }
    }
}
