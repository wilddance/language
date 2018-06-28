#include <iostream>
#include<stdlib.h>
#include<unistd.h>

using namespace std;

int main(){
    write(1, "123", sizeof(char)*3);
}
