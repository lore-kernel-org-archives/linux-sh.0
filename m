From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 01 Aug 2008 22:22:17 +0000
Subject: Re: [2.6 patch] sh: fix LIBGCC
Message-Id: <20080801222217.GD13448@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080801221344.GI19682@cs181140183.pp.htv.fi>
In-Reply-To: <20080801221344.GI19682@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 02, 2008 at 01:13:44AM +0300, Adrian Bunk wrote:
> Commit f15cbe6f1a4b4d9df59142fc8e4abb973302cf44
> (sh: migrate to arch/sh/include/) moved KBUILD_CFLAGS
> (which is used by LIBGCC) below LIBGCC, causing build
> errors like the following:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> arch/sh/kernel/built-in.o: In function `module_clk_recalc':
> clock-sh4.c:(.text+0x80f0): undefined reference to `__udivsi3_i4i'
> ...
> make[1]: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
That's interesting, none of my compilers had difficulty with it, whereas
it seems your toolchain couldn't report the libgcc location at all.

Anyways, applied, thanks.
