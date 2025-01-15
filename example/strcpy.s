    .text
    .balign 4
    .global strcpy
  # char* strcpy(char *dst, const char* src)
strcpy:
    vsetvli a2, x0, e8, m8, ta, ma  # Max length vectors of bytes
loop:
    vle8ff.v v8, (a1)       # Get src bytes
      add a1, a1, a2        # Bump pointer
    vmseq.vi v1, v8, 0      # Flag zero bytes
    vfirst.m a3, v1         # Zero found?
    vmsif.m v0, v1          # Set mask up to and including zero byte.
    vse8.v v8, (a0), v0.t   # Write out bytes
      add a0, a0, a2        # Bump pointer
    bltz a3, loop           # Zero byte not found, so loop

    ret
