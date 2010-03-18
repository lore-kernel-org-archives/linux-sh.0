From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 18 Mar 2010 07:10:32 +0000
Subject: Re: Build error at v2.6.33 of sh-2.6.git
Message-Id: <20100318071031.GA25308@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4BA1CB09.8060908@dcl.info.waseda.ac.jp>
In-Reply-To: <4BA1CB09.8060908@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 18, 2010 at 03:41:13PM +0900, Hitoshi Mitake wrote:
> But I'm suspecting that the problem is the version of my cross compiler 
> for sh.
> The version of it is 3.4.5, quite old.
> -v output of my cross compiler is this:
> 
> % sh-linux-gcc -v
> Reading specs from 
> /opt/crosstool/gcc-3.4.5-glibc-2.3.5/sh4-unknown-linux-gnu/lib/gcc/sh4-unknown-linux-gnu/3.4.5/specs
> Configured with: 
> /home/mitake/tool/crosstool-0.43-sh4a/build/sh4-unknown-linux-gnu/gcc-3.4.5-glibc-2.3.5/gcc-3.4.5/configure 
> --target=sh4-unknown-linux-gnu --host=x86_64-host_unknown-linux-gnu 
> --prefix=/opt/crosstool/gcc-3.4.5-glibc-2.3.5/sh4-unknown-linux-gnu 
> --with-multilib-list=m4,m4-nofpu 
> --with-headers=/opt/crosstool/gcc-3.4.5-glibc-2.3.5/sh4-unknown-linux-gnu/sh4-unknown-linux-gnu/include 
> --with-local-prefix=/opt/crosstool/gcc-3.4.5-glibc-2.3.5/sh4-unknown-linux-gnu/sh4-unknown-linux-gnu 
> --disable-nls --enable-threads=posix --enable-symvers=gnu 
> --enable-__cxa_atexit --enable-languages=c,c++ --enable-shared --enable-c99 
> --enable-long-long
> Thread model: posix
> gcc version 3.4.5
> 
> I obtained this cross compiler with this project: 
> http://kegel.com/crosstool/
> 
> So I have a question, is there the de fact standard of corss compiler 
> building kit for SuperH arch?
> If there is, could you tell me?
> 
As Magnus pointed out, the CodeSourcery one is the officially recommended
one to use. Note that this problem you are having is an issue with old
binutils versions on 64-bit hosts, which has been corrected in newer
versions of binutils. You can find more info about it in the archives, or
just use a newer toolchain.
