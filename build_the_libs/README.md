

# Build RUM

See https://github.com/datlowe/rum/blob/datlowe/Dockerfile

# Build Czech Snowball

Create docker image `rum_build` using the same Dockerfile as above. (You can use the same image.)

Run in docker:
```bash
docker run --rm -it -v //c/Workspace/postgres_snowball_czech://pg_new -v //c/Workspace/datlowe_snowball://datlowe_snowball rum_build bash
```

Compile create snowball files (.sbl -> .c .h)

```bash

#see changes in git repo https://github.com/datlowe/snowball/tree/datlowe_czech 
# commit: https://github.com/datlowe/snowball/commit/d2a290ee37b82350db8397958f1b59143b709708
cd /datlowe_snowball

make
```

Compile postgres snowball lib (.so)

```bash
cp /datlowe_snowball/src_c/stem_UTF_8_czech.h /pg_new/src/include/snowball/libstemmer/
cp /datlowe_snowball/src_c/stem_UTF_8_czech.c /pg_new/src/backend/snowball/libstemmer/
#see changes in git repo https://github.com/datlowe/postgres_snowball_czech/tree/REL_14_1_snow 
# commit: https://github.com/datlowe/postgres_snowball_czech/commit/5a7685c2de475da252bb51d8ce7e257c2db75d30

# Correct header file in stem_UTF_8_czech.c
# commit: https://github.com/datlowe/postgres_snowball_czech/commit/605c8548eca6105d456553db1095705303f58660

cd /pg_new
make

```

The .so file is located in `./src/backend/snowball/dict_snowball.so`