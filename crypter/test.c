#include <stdio.h>
#include <string.h>
#include <stdlib.h> // malloc (warning)
#include "crypto.h"

int tests_run = 0;

#define mu_assert(message, test) do { if (!(test)) return message; } while (0)
#define mu_run_test(test) do { char *message = test(); tests_run++; \
                                if (message) return message; } while (0)

static char* test1() {
  KEY k = {1, "TPERULESTPERULESTPERULESTP"};
  const char* input = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);

  mu_assert("Meldung", strcmp(output, "URFVPJB[]ZN^XBJCEBVF@ZRKMJ") == 0);
  return 0;
}

static char* test2() {
  KEY k = {1, "TPERULES"};
  const char* input = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);

  mu_assert("Meldung2", strcmp(output, "URFVPJB[]ZN^XBJCEBVF@ZRKMJ") == 0);
  return 0;
}

static char* test3() {
  KEY k = {1, "TPERULES"};
  const char* input = "ABC";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);

  mu_assert("Meldung3", strcmp(output, "URF") == 0);
  return 0;
}

static char* test4() {
  KEY k = {1, "TT"};
  const char* input = "A";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);

  mu_assert("Meldung4", strcmp(output, "U") == 0);
  return 0;
}

static char* test5() {
  KEY k = {1, "TT"};
  const char* input = "AA";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);

  mu_assert("Meldung5", strcmp(output, "UU") == 0);
  return 0;
}

static char* test6() {
  KEY k = {1, "TT"};
  const char* input = "AAA";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);

  mu_assert("Meldung6", strcmp(output, "UUU") == 0);
  return 0;
}

// decrypt test
static char* test7() {
  KEY k = {1, "TPERULESTPERULESTPERULESTP"};
  const char* input = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));
  char* output2 = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);
  decrypt(k, output, output2);

  mu_assert("Meldung7", strcmp(output2, "ABCDEFGHIJKLMNOPQRSTUVWXYZ") == 0);
  return 0;
}

static char* test8() {
  KEY k = {1, "TPERULES"};
  const char* input = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));
  char* output2 = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);
  decrypt(k, output, output2);

  mu_assert("Meldung8", strcmp(output2, "ABCDEFGHIJKLMNOPQRSTUVWXYZ") == 0);
  return 0;
}

static char* test9() {
  KEY k = {1, "TPERULES"};
  const char* input = "ABC";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));
  char* output2 = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);
  decrypt(k, output, output2);

  mu_assert("Meldung9", strcmp(output2, "ABC") == 0);
  return 0;
}

static char* test10() {
  KEY k = {1, "TT"};
  const char* input = "A";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));
  char* output2 = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);
  decrypt(k, output, output2);

  mu_assert("Meldung10", strcmp(output2, "A") == 0);
  return 0;
}

static char* test11() {
  KEY k = {1, "TT"};
  const char* input = "AA";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));
  char* output2 = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);
  decrypt(k, output, output2);

  mu_assert("Meldung11", strcmp(output2, "AA") == 0);
  return 0;
}

static char* test12() {
  KEY k = {1, "TT"};
  const char* input = "AAA";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));
  char* output2 = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);
  decrypt(k, output, output2);

  mu_assert("Meldung12", strcmp(output2, "AAA") == 0);
  return 0;
}

// 
static char* test13() {
  KEY k = {1, "MYKEY"};
  const char* input = "HALLO";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);

  mu_assert("Meldung13", strcmp(output, "EXGIV") == 0);
  return 0;
}

static char* test14() {
  KEY k = {1, "MYKEY"};
  const char* input = "HALLO";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));
  char* output2 = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);
  decrypt(k, output, output2);

  mu_assert("Meldung14", strcmp(output2, "HALLO") == 0);
  return 0;
}

static char* test15() {
  KEY k = {1, "MYKEY"};
  const char* input = "IPNVADJ_]\\DWSQ\\UMS_L@A_@JY\\E";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  decrypt(k, input, output);

  mu_assert("Meldung15", strcmp(output, "DIESXISTXEINXTEXTXZUMXTESTEN") == 0);
  return 0;
}

static char* test16() {
  KEY k = {1, "MYKEY"};
  const char* input = "I\\Y]OHKXFQALNVJHR^K^";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  decrypt(k, input, output);

  mu_assert("Meldung16", strcmp(output, "DERXVERSCHLUESSEKUNG") == 0);
  return 0;
}

static char* test17() {
  KEY k = {1, "MYKEY"};
  const char* input = "@P_]THQY@KHWS_\\DUNK";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  decrypt(k, input, output);

  mu_assert("Meldung17", strcmp(output, "MITXMEHRERENXZEILEN") == 0);
  return 0;
}

static char* test18() {
  KEY k = {1, "TPERULES"};
  const char* input = "ABCDEFGHIJKLMNOPQRSTUVWXYZGGGGGGABC";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);

  mu_assert("Meldung18", strcmp(output, "URFVPJB[]ZN^XBJCEBVF@ZRKMJBURKBTURF") == 0);
  return 0;
}

static char* test19() {
  KEY k = {1, "MYKEY"};
  const char* input = "HALLO";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);

  mu_assert("Meldung19", strcmp(output, "EXGIV") == 0);
  return 0;
}

static char* test20() {
  KEY k = {1, "MYKEY"};
  const char* input = "HALLOHBLLON";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  encrypt(k, input, output);

  mu_assert("Meldung20", strcmp(output, "EXGIVE[GIVC") == 0);
  return 0;
}

// error
static char* test21() {
  KEY k = {1, "m"};
  const char* input = "HALLOHBLLON";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  int error = encrypt(k, input, output);

  mu_assert("Meldung21", error == E_KEY_ILLEGAL_CHAR);
  return 0;
}

static char* test22() {
  KEY k = {1, "m"};
  const char* input = "HALLOHBLLON";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  int error = decrypt(k, input, output);

  mu_assert("Meldung22", error == E_KEY_ILLEGAL_CHAR);
  return 0;
}

static char* test23() {
  KEY k = {1, "MYKEY"};
  const char* input = "a";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  int error = encrypt(k, input, output);

  mu_assert("Meldung23", error == E_MESSAGE_ILLEGAL_CHAR);
  return 0;
}

static char* test24() {
  KEY k = {1, "MYKEY"};
  const char* input = "a";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  int error = decrypt(k, input, output);

  mu_assert("Meldung24", error == E_CYPHER_ILLEGAL_CHAR);
  return 0;
}

static char* test25() {
  KEY k = {1, ""};
  const char* input = "A";
  char* output = (char*) malloc(sizeof(char) * (strlen(input) + 1));

  int error = encrypt(k, input, output);

  mu_assert("Meldung25", error == E_KEY_TOO_SHORT);
  return 0;
}

static char* allTests() {
  mu_run_test(test1);
  mu_run_test(test2);
  mu_run_test(test3);
  mu_run_test(test4);
  mu_run_test(test5);
  mu_run_test(test6);
  mu_run_test(test7);
  mu_run_test(test8);
  mu_run_test(test9);
  mu_run_test(test10);
  mu_run_test(test11);
  mu_run_test(test12);
  mu_run_test(test13);
  mu_run_test(test14);
  mu_run_test(test15);
  mu_run_test(test16);
  mu_run_test(test17);
  mu_run_test(test18);
  mu_run_test(test19);
  mu_run_test(test20);
  mu_run_test(test21);
  mu_run_test(test22);
  mu_run_test(test23);
  mu_run_test(test24);
  mu_run_test(test25);
  return 0;
}

int main() {
  char *result = allTests();

  if (result != 0) printf("%s\n", result);
  else             printf("ALL TESTS PASSED\n");

  printf("Tests run: %d\n", tests_run);

  return result != 0;
}


