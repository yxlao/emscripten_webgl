#pragma once

#include <GLES2/gl2.h>

GLuint loadShader(GLenum type, const char *source);
GLuint buildProgram(GLuint vertexShader, GLuint fragmentShader,
                    const char *vertexPositionName);
