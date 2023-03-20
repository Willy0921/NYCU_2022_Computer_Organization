#include "direct_mapped_cache.h"
#include "string"
#include <fstream>
#include <bitset>
#include <unordered_map>

using namespace std;

string ToBinary(string& str) {
    string binary;
    int len = str.size();
    for (int i = 0; i < len; ++i) {
        if (str[i] >= 'a' && str[i] <= 'f') {
            binary += bitset<4>((str[i] - 'a' + 10)).to_string();
        } else {
            binary += bitset<4>((str[i] - '0')).to_string();
        }
    }
    if (binary.size() == 28) {
        binary = "0000" + binary;
    }
    return binary;
}

int BitNum(int num) {
    int n = 0;
    while (num >= 2) {
        num /= 2;
        n++;
    }
    return n;
}

float direct_mapped(string filename, int block_size, int cache_size) {
    int total_num = 0;
    int hit_num = 0;

    /*write your code HERE*/
    ifstream file;
    string str;
    int byte_offset = BitNum(block_size);
    int index = BitNum((cache_size / block_size));
    int tag = 32 - byte_offset - index;
    unordered_map<string, string> cache;
    file.open(filename);
    while (file >> str) {
        if (file.eof()) {
            break;
        }
        string bit_str = ToBinary(str);
        string tag_str(bit_str, 0, tag);
        string index_str(bit_str, tag, index);
        if (cache.count(index_str)) {
            if (cache[index_str] == tag_str) {
                hit_num++;
            } else {
                cache[index_str] = tag_str;
            }
        } else {
            cache[index_str] = tag_str;
        }
        total_num++;
    }
    file.close();
    return (float)hit_num / total_num;
}
