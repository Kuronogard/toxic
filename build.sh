CC="cc"
TOXCORE=${TOXCORE_FILES:-"-ltoxcore"}
TOXAV=${TOXAV_FILES:-"-ltoxav"}
CRYPTO_LIB=${CRYPTO_LIB_FILES:-"-lsodium"}
PREFIX=${PREFIX:-"/usr/local"}
TOXIC_VERSION="0.3.1"
REV=`git rev-list HEAD --count`
VERSION="\"${TOXIC_VERSION}_r${REV}\""


(${CC} $CFLAGS -o toxic -D HAVE_WIDECHAR -DTOXICVER="${VERSION}" -D _SUPPORT_AUDIO ./src/*.c  -L"$PREFIX/lib/" -I"$PREFIX/include/" -lpthread -lopenal $TOXCORE $TOXAV $CRYPTO_LIB -lvpx -lncursesw -lopus && echo build with audio and widechar suceeded) || (${CC} $CFLAGS -o toxic -D _SUPPORT_AUDIO -DTOXICVER="${VERSION}" ./src/*.c  -L"$PREFIX/lib/" -I"$PREFIX/include/" -lpthread -lopenal $TOXCORE $TOXAV_FILES $CRYPTO_LIB -lvpx -lncurses -lopus && echo build with audio suceeded) || (${CC} $CFLAGS -o toxic -D HAVE_WIDECHAR -DTOXICVER="${VERSION}" ./src/{c,e,f,g,l,m,p,t,w}*.c  -L"$PREFIX/lib/" -I"$PREFIX/include/" -lpthread $TOXCORE $CRYPTO_LIB -lncursesw && echo build with widechar suceeded) || (${CC} $CFLAGS -o toxic -DTOXICVER="${VERSION}" ./src/{c,e,f,g,l,m,p,t,w}*.c  -L"$PREFIX/lib/" -I"$PREFIX/include/" -lpthread $TOXCORE $CRYPTO_LIB -lncurses && echo build suceeded) || echo build failed
