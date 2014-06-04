From: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 04 Jun 2014 04:12:35 +0000
Subject: Re: [net-next:master 182/183] filter.c:undefined reference to `__fpscr_values'
Message-Id: <20140604041235.GB10379@thor.bakeyournoodle.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="s9fJI615cBHmzTOP"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2014 at 11:03:40AM +0800, Fengguang Wu wrote:

> Got it, thanks! I use Tony's pre-built gcc binaries here:
>=20
>         https://www.kernel.org/pub/tools/crosstool/
>=20
> CC tony. Hopefully he can add the "--with-multilib-list=3Dm2a,m2a-nofpu"
> configure option in future crosstool builds.

So I updated the mutlilib-list as requested however now I'm getting:

---
Adding multilib support to Makefile in /home/tony/buildall/src/gcc/libgcc
multidirs=3Dm2a m2a-nofpu
with_multisubdir=3D
Running configure in multilib subdirs m2a m2a-nofpu
pwd: /home/tony/buildall/sh4/gcc0/sh4-linux/libgcc
Running configure in multilib subdir m2a
pwd: /home/tony/buildall/sh4/gcc0/sh4-linux
mkdir m2a
configure: creating cache ./config.cache
checking build system type... x86_64-pc-linux-gnu
checking host system type... sh4-unknown-linux-gnu
checking for --enable-version-specific-runtime-libs... no
checking for a BSD-compatible install... /usr/bin/install -c
checking for gawk... gawk
xgcc: error: SH2a does not support little-endian
checking for sh4-linux-ar... /opt/cross/gcc-4.9.0-nolibc/sh4-linux/sh4-linu=
x/bin/ar
checking for sh4-linux-lipo... sh4-linux-lipo
checking for sh4-linux-nm... /home/tony/buildall/sh4/gcc0/./gcc/nm
checking for sh4-linux-ranlib... /opt/cross/gcc-4.9.0-nolibc/sh4-linux/sh4-=
linux/bin/ranlib
checking for sh4-linux-strip... /opt/cross/gcc-4.9.0-nolibc/sh4-linux/sh4-l=
inux/bin/strip
checking whether ln -s works... yes
checking for sh4-linux-gcc... /home/tony/buildall/sh4/gcc0/./gcc/xgcc -B/ho=
me/tony/buildall/sh4/gcc0/./gcc/ -B/opt/cross/gcc-4.9.0-nolibc/sh4-linux/sh=
4-linux/bin/ -B/opt/cross/gcc-4.9.0-nolibc/sh4-linux/sh4-linux/lib/ -isyste=
m /opt/cross/gcc-4.9.0-nolibc/sh4-linux/sh4-linux/include -isystem /opt/cro=
ss/gcc-4.9.0-nolibc/sh4-linux/sh4-linux/sys-include  -m2a
checking for suffix of object files... configure: error: in `/home/tony/bui=
ldall/sh4/gcc0/sh4-linux/m2a/libgcc':
configure: error: cannot compute suffix of object files: cannot compile
See `config.log' for more details.
---

I think the "xgcc: error: SH2a does not support little-endian" is a
pretty string indication I'm doign something silly.

Here are my binutils and gcc configures (binutils 2.24 and gcc 4.9.0)

=3D=3D> log-binutils-configure <=3D=3D
/home/tony/buildall/src/binutils/configure --host=3Dx86_64-linux-gnu --buil=
d=3Dx86_64-linux-gnu --target=3Dsh4-linux --prefix=3D/opt/cross/gcc-4.9.0-n=
olibc/sh4-linux/ --enable-64-bit-bfd --disable-nls --disable-werror --with-=
sysroot=3D/opt/cross/gcc-4.9.0-nolibc/sh4-linux/=20

=3D=3D> log-gcc0-configure <=3D=3D
/home/tony/buildall/src/gcc/configure --target=3Dsh4-linux --host=3Dx86_64-=
linux-gnu --build=3Dx86_64-linux-gnu --enable-targets=3Dall --prefix=3D/opt=
/cross/gcc-4.9.0-nolibc/sh4-linux/ --enable-languages=3Dc --with-newlib --w=
ithout-headers --disable-nls --disable-threads --disable-shared --disable-l=
ibmudflap --disable-libssp --disable-libgomp --disable-decimal-float --enab=
le-checking=3Drelease --with-multilib-list=3Dm2a,m2a-nofpu --with-mpfr=3D/h=
ome/tony/buildall/src/sys-x86_64 --with-gmp=3D/home/tony/buildall/src/sys-x=
86_64 --disable-bootstrap --disable-libquadmath --disable-libatomic=20

I did a little googling and found https://gcc.gnu.org/bugzilla/show_bug.cgi=
?id=3D40428
but that doesn't seem to help.

Help?

Yours Tony

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJTjpyyAAoJEPvNNsFAAoTB+wsQANLhTAoHemWeNQd0F3yBFm3Q
hn7Y4kX2dINISqIWpvogDU416FEPEEG/3l+BYK8ssU1Mbtm1QfT4uIKY+Dw7GPAg
8EaSMyx+3IrwGnOee09sCKpqh4yXDQh7xiv9435YZxWIKwCuxQrCHRpH1fYj4oIc
Su9ZWoaNKkpOl53jIXXygV92VgvofpauQiPx0XLJq7xLWu2rZMyqf95F+VukOZJZ
9zRB0w0ZWKszZVLrXr7dBsAQHCYj101Xelf2LxnwgRDOH2/dAU/DsCbmz68aF084
wZSmYsDRsURrjlWuAUbVv1ck5dVW+LaGS5tbmcekByUS8vvd7/nVg35Jcf8jCtQ2
Ex8xFIaX8UL9FcKsyXjWfvb+P2jfhwhd13Xym/5sCf7z2cFdmz9KffLV5KyR0HWK
JKxfppvhAtumZDoOa64/pQrDpmDApJ7mRPXSODZLVhkT3nF6DrNJgMiSJotUHjn9
8WlMnxxzViOfC7itqdUsYdC8KA4/NxTEWsGPgoXlEEMjXGLhniSUKPIQPWAkeoQ6
U2V19WnXa6LBgTeAo5M22iOno69IWVAUMf0RPCrAlDwnNwtWMLLUInN982dWgrKc
eXfkGzDNcgGgXN8Juf21fCwW6UBisp11+46zp4zNySCruSw9NEElpkGDBbwVcsuY
ghTv16uYSL5UZFzCf6GG
=/CkU
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
