namespace ValaGL.Core {
    
    /**
     * Error domain for the ValaGL core OpenGL support.
     */
    public errordomain CoreError {
        /**
         * Indicates a vertex or fragment shader initialization error.
         */
        SHADER_INIT,
        /**
         * Indicates a vertex buffer object initialization error.
         */
        VBO_INIT,
        /**
         * Indicates an index buffer object initialization error.
         */
        IBO_INIT
    }
}
