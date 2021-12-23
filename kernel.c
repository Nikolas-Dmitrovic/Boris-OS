// this will force us to create a kernal entery fucntion insted of jumping to kernel.c:0x00 
void dummy_test_entrypoint(){

}

void start(){
    char* video_memory = (char*) 0xb8000;
    *video_memory = 'X';
}