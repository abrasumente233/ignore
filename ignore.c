#include <stdio.h>
#include <string.h>

#include "ignore_files.h"
#include "ignore_table.h"

void find_gitignore_entry(const char *ignore_name) {
    int i = 0;
    for (i = 0; i < ignore_table_size; i++) {
        if (strcmp(ignore_table[i].name, ignore_name) == 0) {
            for (int j = 0; j < ignore_table[i].size; j++) {
                char c = ignore_table[i].data[j];
                printf("%c", c);
            }
            return;
        }
    }
    printf("%s\n", "Not found");
}

int main(int argc, const char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <ignore-type>\n", argv[0]);
        return 1;
    }

    const char *ignore_name = argv[1];
    find_gitignore_entry(ignore_name);
}
