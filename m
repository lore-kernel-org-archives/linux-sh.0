From: Alexei Starovoitov <ast@plumgrid.com>
Date: Wed, 04 Jun 2014 05:09:09 +0000
Subject: Re: [net-next:master 182/183] filter.c:undefined reference to `__fpscr_values'
Message-Id: <CAMEtUuw7-OCj_kn3PY6PjL3ntsU14U+iBObt+CuYEtR0gErDCg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140604041235.GB10379@thor.bakeyournoodle.com>
In-Reply-To: <20140604041235.GB10379@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 3, 2014 at 9:12 PM, Tony Breeds <tony@bakeyournoodle.com> wrote:
> On Thu, May 22, 2014 at 11:03:40AM +0800, Fengguang Wu wrote:
>
>> Got it, thanks! I use Tony's pre-built gcc binaries here:
>>
>>         https://www.kernel.org/pub/tools/crosstool/
>>
>> CC tony. Hopefully he can add the "--with-multilib-list=m2a,m2a-nofpu"
>> configure option in future crosstool builds.
>
> So I updated the mutlilib-list as requested however now I'm getting:

adding Kaz who suggested these gcc flags.

> ---
> Adding multilib support to Makefile in /home/tony/buildall/src/gcc/libgcc
> multidirs=m2a m2a-nofpu
> with_multisubdir> Running configure in multilib subdirs m2a m2a-nofpu
> pwd: /home/tony/buildall/sh4/gcc0/sh4-linux/libgcc
> Running configure in multilib subdir m2a
> pwd: /home/tony/buildall/sh4/gcc0/sh4-linux
> mkdir m2a
> configure: creating cache ./config.cache
> checking build system type... x86_64-pc-linux-gnu
> checking host system type... sh4-unknown-linux-gnu
> checking for --enable-version-specific-runtime-libs... no
> checking for a BSD-compatible install... /usr/bin/install -c
> checking for gawk... gawk
> xgcc: error: SH2a does not support little-endian
> checking for sh4-linux-ar... /opt/cross/gcc-4.9.0-nolibc/sh4-linux/sh4-linux/bin/ar
> checking for sh4-linux-lipo... sh4-linux-lipo
> checking for sh4-linux-nm... /home/tony/buildall/sh4/gcc0/./gcc/nm
> checking for sh4-linux-ranlib... /opt/cross/gcc-4.9.0-nolibc/sh4-linux/sh4-linux/bin/ranlib
> checking for sh4-linux-strip... /opt/cross/gcc-4.9.0-nolibc/sh4-linux/sh4-linux/bin/strip
> checking whether ln -s works... yes
> checking for sh4-linux-gcc... /home/tony/buildall/sh4/gcc0/./gcc/xgcc -B/home/tony/buildall/sh4/gcc0/./gcc/ -B/opt/cross/gcc-4.9.0-nolibc/sh4-linux/sh4-linux/bin/ -B/opt/cross/gcc-4.9.0-nolibc/sh4-linux/sh4-linux/lib/ -isystem /opt/cross/gcc-4.9.0-nolibc/sh4-linux/sh4-linux/include -isystem /opt/cross/gcc-4.9.0-nolibc/sh4-linux/sh4-linux/sys-include  -m2a
> checking for suffix of object files... configure: error: in `/home/tony/buildall/sh4/gcc0/sh4-linux/m2a/libgcc':
> configure: error: cannot compute suffix of object files: cannot compile
> See `config.log' for more details.
> ---
>
> I think the "xgcc: error: SH2a does not support little-endian" is a
> pretty string indication I'm doign something silly.
>
> Here are my binutils and gcc configures (binutils 2.24 and gcc 4.9.0)
>
> => log-binutils-configure <=
> /home/tony/buildall/src/binutils/configure --host=x86_64-linux-gnu --build=x86_64-linux-gnu --target=sh4-linux --prefix=/opt/cross/gcc-4.9.0-nolibc/sh4-linux/ --enable-64-bit-bfd --disable-nls --disable-werror --with-sysroot=/opt/cross/gcc-4.9.0-nolibc/sh4-linux/
>
> => log-gcc0-configure <=
> /home/tony/buildall/src/gcc/configure --target=sh4-linux --host=x86_64-linux-gnu --build=x86_64-linux-gnu --enable-targets=all --prefix=/opt/cross/gcc-4.9.0-nolibc/sh4-linux/ --enable-languages=c --with-newlib --without-headers --disable-nls --disable-threads --disable-shared --disable-libmudflap --disable-libssp --disable-libgomp --disable-decimal-float --enable-checking=release --with-multilib-list=m2a,m2a-nofpu --with-mpfr=/home/tony/buildall/src/sys-x86_64 --with-gmp=/home/tony/buildall/src/sys-x86_64 --disable-bootstrap --disable-libquadmath --disable-libatomic
>
> I did a little googling and found https://gcc.gnu.org/bugzilla/show_bug.cgi?id@428
> but that doesn't seem to help.
>
> Help?
>
> Yours Tony
