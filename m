From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Date: Thu, 18 Mar 2010 06:41:13 +0000
Subject: Build error at v2.6.33 of sh-2.6.git
Message-Id: <4BA1CB09.8060908@dcl.info.waseda.ac.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi SuperH folks,

I'm working on porting new board support to sh.

And I suffered build error when building the branch
specified the tag v2.6.33 at
sh-2.6.git ( 
http://git.kernel.org/?p=linux/kernel/git/lethal/sh-2.6.git;a=summary ).

Error message is like this:
% make ARCH=sh CROSS_COMPILE=sh-linux- arch/sh/kernel/cpu/sh3/entry.o

...

arch/sh/kernel/cpu/sh3/entry.S: Assembler messages:
arch/sh/kernel/cpu/sh3/entry.S:260: Error: offset out of range
arch/sh/kernel/cpu/sh3/entry.S:260: Error: value of 4294967280 too large 
for field of 2 bytes at 196
arch/sh/kernel/cpu/sh3/../../entry-common.S:60: Error: offset out of range
arch/sh/kernel/cpu/sh3/../../entry-common.S:60: Error: value of 
4294967280 too large for field of 2 bytes at 236
arch/sh/kernel/cpu/sh3/../../entry-common.S:178: Error: offset out of range
arch/sh/kernel/cpu/sh3/../../entry-common.S:178: Error: value of 
4294967280 too large for field of 2 bytes at 422
arch/sh/kernel/cpu/sh3/../../entry-common.S:326: Error: offset out of range
arch/sh/kernel/cpu/sh3/../../entry-common.S:326: Error: value of 
4294967280 too large for field of 2 bytes at 578

...

But I'm suspecting that the problem is the version of my cross compiler 
for sh.
The version of it is 3.4.5, quite old.
-v output of my cross compiler is this:

% sh-linux-gcc -v
Reading specs from 
/opt/crosstool/gcc-3.4.5-glibc-2.3.5/sh4-unknown-linux-gnu/lib/gcc/sh4-unknown-linux-gnu/3.4.5/specs
Configured with: 
/home/mitake/tool/crosstool-0.43-sh4a/build/sh4-unknown-linux-gnu/gcc-3.4.5-glibc-2.3.5/gcc-3.4.5/configure 
--target=sh4-unknown-linux-gnu --host=x86_64-host_unknown-linux-gnu 
--prefix=/opt/crosstool/gcc-3.4.5-glibc-2.3.5/sh4-unknown-linux-gnu 
--with-multilib-list=m4,m4-nofpu 
--with-headers=/opt/crosstool/gcc-3.4.5-glibc-2.3.5/sh4-unknown-linux-gnu/sh4-unknown-linux-gnu/include 
--with-local-prefix=/opt/crosstool/gcc-3.4.5-glibc-2.3.5/sh4-unknown-linux-gnu/sh4-unknown-linux-gnu 
--disable-nls --enable-threads=posix --enable-symvers=gnu 
--enable-__cxa_atexit --enable-languages=c,c++ --enable-shared 
--enable-c99 --enable-long-long
Thread model: posix
gcc version 3.4.5

I obtained this cross compiler with this project: 
http://kegel.com/crosstool/

So I have a question, is there the de fact standard of corss compiler 
building kit for SuperH arch?
If there is, could you tell me?

Thanks,
	Hitoshi
