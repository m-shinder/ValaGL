using GL;

namespace ValaGL.Core {
    
    /**
     * Encapsulation of an OpenGL vertex buffer object.
     * 
     * The underlying OpenGL buffer is destroyed when this object is finally unreferenced.
     */
    public class VBO : Object {
        private GLuint id;
        
        /**
         * Creates a vertex buffer object.
         * 
         * @param data Array to bind to the OpenGL buffer
         */
        public VBO(GLfloat[] data) throws CoreError {
            GLuint id_array[1];
            glGenBuffers(1, id_array);
            id = id_array[0];
            
            if (id == 0) {
                throw new CoreError.VBO_INIT("Cannot allocate vertex buffer object");
            }
            
            glBindBuffer(ARRAY_BUFFER, id);
            glBufferData(ARRAY_BUFFER, data.length * sizeof(GLfloat), (GLvoid[]) data, STATIC_DRAW);
            glBindBuffer(ARRAY_BUFFER, 0);
        }
        
        /**
         * Makes this VBO current for future drawing operations in the OpenGL context.
         */
        public void make_current() {
            glBindBuffer(ARRAY_BUFFER, id);
        }
        
        /**
         * Makes this VBO current for future drawing operations in the OpenGL context,
         * and sets it up as the source of vertex data for the given shader attribute.
         * 
         * For the meaning of ``attribute`` and ``stride``, see ``glVertexAttribPointer``.
         * 
         * @param attribute The index of the generic vertex attribute to be modified.
         * @param stride The byte offset between consecutive generic vertex attributes.
         */
        public void apply_as_vertex_array(GLint attribute, GLsizei stride) {
            make_current();
            glVertexAttribPointer(attribute, stride, FLOAT, false, 0, null);
        }
        
        ~VBO() {
            if (id != 0) {
                GLuint[] id_array = { id };
                glDeleteBuffers(1, id_array);
            }
        }
    }
}
