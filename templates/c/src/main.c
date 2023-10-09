// C standard library -- no OS-dependent headers.
#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <inttypes.h>
#include <limits.h>
#include <math.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

// POSIX.
#include <unistd.h>

typedef int8_t    i8;
typedef uint8_t   u8;
typedef int32_t   i32;
typedef uint32_t  u32;
typedef int64_t   i64;
typedef uint64_t  u64;
typedef float     f32;
typedef double    f64;
typedef ptrdiff_t isize;
typedef size_t    usize;

int main(int argc, char** argv) {
    printf("hello world!\n");
    return 0;
}
