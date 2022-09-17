#include <stdlib.h>
#include <iostream>
int main() {
    char *x = (char*)malloc(10 * sizeof(char*));
    std::cout<<34<<std::endl;
    free(x);
    return x[5];
}
