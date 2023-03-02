#!/bin/sh
gcc -shared -Wl,-soname,midi-wildmidi.so -o midi-wildmidi.so -fpic -fvisibility=hidden -m32 -O2 -Wall midi-wildmidi.c -I`pwd`/include -lWildMidi -L`pwd`/lib/x86
gcc -shared -Wl,-soname,midi-bassmidi.so -o midi-bassmidi.so -fpic -fvisibility=hidden -m32 -O2 -Wall midi-bassmidi.c -I`pwd`/include -lbassmidi -lbass -L`pwd`/lib/x86
gcc -shared -Wl,-soname,midi-adlmidi.so -o midi-adlmidi.so -fpic -fvisibility=hidden -m32 -O2 -Wall midi-adlmidi.c -I`pwd`/include -lADLMIDI -lstdc++ -L`pwd`/lib/x86
gcc -shared -Wl,-soname,midi2-windows.so -o midi2-windows.so -fpic -fvisibility=hidden -m32 -O2 -Wall midi2-windows.c
gcc -shared -Wl,-soname,midi2-alsa.so -o midi2-alsa.so -fpic -fvisibility=hidden -m32 -O2 -Wall midi2-alsa.c -lasound -lpthread

cd albion

gcc -shared -Wl,-soname,midiA-wildmidi.so -o midiA-wildmidi.so -fpic -fvisibility=hidden -m32 -O2 -Wall midiA-wildmidi.c -I`pwd`/.. -I`pwd`/include -lWildMidiA -L`pwd`/lib/x86 -lm

cd ..

cd xcom12

CURDIR=`pwd`
gcc -c -fpic -fvisibility=hidden -m32 -O2 -Wall mpsmusic-driver.c -I$CURDIR/include -I../
cd src
gcc -c -fpic -fvisibility=hidden -m32 -O3 -Wall -Wno-maybe-uninitialized -DDRIVER=ADLIB emu_x86.c -I$CURDIR/include
g++ -c -fpic -fvisibility=hidden -m32 -O2 -Wall -fno-exceptions emu_opl2.cpp
cd dosbox_opl
g++ -c -fpic -fvisibility=hidden -m32 -O3 -Wall -fno-exceptions opl.cpp
cd ../..
gcc -shared -Wl,-soname,adlib-dosbox_opl.so -o adlib-dosbox_opl.so -m32 *.o src/*.o src/dosbox_opl/*.o -lm

rm src/*.o
rm src/dosbox_opl/*.o

cd src
gcc -c -fpic -fvisibility=hidden -m32 -O3 -Wall -Wno-maybe-uninitialized -DDRIVER=ROLAND emu_x86.c -I$CURDIR/include
g++ -c -fpic -fvisibility=hidden -m32 -O2 -Wall -fno-exceptions emu_mt32.cpp -I$CURDIR/src/munt-2.7.0
cd munt-2.7.0/mt32emu
g++ -c -fpic -fvisibility=hidden -m32 -O3 -Wall -fno-exceptions *.cpp
cd sha1
g++ -c -fpic -fvisibility=hidden -m32 -O3 -Wall -fno-exceptions sha1.cpp
cd ../../../..
gcc -shared -Wl,-soname,mt32-munt.so -o mt32-munt.so -m32 *.o src/*.o src/munt-2.7.0/mt32emu/*.o src/munt-2.7.0/mt32emu/sha1/*.o -lm -lstdc++

rm *.o
rm src/*.o
rm src/munt-2.7.0/mt32emu/*.o
rm src/munt-2.7.0/mt32emu/sha1/*.o

cd ..
