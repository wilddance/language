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
            vars.emplace_back(desc);
            a = static_cast<int>(vars.size());
            return a;
        }
    }

    int getSize(){
        return vars.size();
    }
};
