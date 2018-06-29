#include <string>
#include <vector>
#include <algorithm>
#include <iostream>

using namespace std;

class Vars{
    vector<string> vars;

public:
    // set id of variable, if first apperance, add and return the id
    int get(char* desc){
        return get(string(desc));
    }

    int get(string desc){
        int a;
        if(find(vars.begin(), vars.end(), desc) != vars.end()){
            a = static_cast<int>(find(vars.begin(), vars.end(), desc) - vars.begin()) + 1;
            return a;
        } else {
            printf("[V] New variable: %s\n", desc.c_str());
            vars.emplace_back(desc);
            a = static_cast<int>(vars.size());
            return a;
        }
    }

    int getSize(){
        return vars.size();
    }
};

class Code{

public:

    vector<string> nests[100];
    int nestLvl = 0;
    int code_count;
    
    void push(string inst){
        nests[nestLvl].push_back(inst);
        code_count++;
    }

    void nest(){
        nestLvl++;
    }

    void unnest(){

        if(nestLvl == 0){
            printf("Can;t unnest low level!!\n");
        }

        nestLvl--;
    }

    int code_size(){
        return code_count;
    }
        
    int code_size_cur(){
        int ret = 0;
        for(int i=0; i<100; i++){
            ret += nests[i].size();
        }
        return ret;
    }


    void copy_buffer(){
        int size = nests[nestLvl + 1].size();
        for(int i =0; i < size ; i++){
            nests[nestLvl].push_back(nests[nestLvl+1][0]);
            nests[nestLvl+1].erase(nests[nestLvl+1].begin());
        }
    }

    void print(){

        puts("Code:");
        int k = 0;
        for(int i = 0; i < 100; i++){

            vector<string> v = nests[i];

            if(v.size() == 0){
                return;
            }

            int size = v.size();
            for(int j =0; j < size; j++){
                printf("%d. %s%s\n",k++, string(i, '\t').c_str(), v.at(j).c_str());
            }
        }
    }
};
