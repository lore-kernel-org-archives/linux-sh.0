From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 12 May 2019 04:29:56 +0000
Subject: Re: [PATCH v2] sh: vsyscall: drop unnecessary cc-ldoption
Message-Id: <87tve0qoqj.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <CAK7LNASLBQ=w9YFBD80s7dit1bd_Tr+ggVyRNms0jf1pR9k=ZA@mail.gmail.com>
        <20190424180223.253025-1-ndesaulniers@google.com>
In-Reply-To: <20190424180223.253025-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: dalias@libc.org, geert@linux-m68k.org, luto@kernel.org, clang-built-linux@googlegroups.com, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 03:02:21 +0900,
Nick Desaulniers wrote:
> 
> Towards the goal of removing cc-ldoption, it seems that --hash-style> was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> of binutils for the kernel according to
> Documentation/process/changes.rst is 2.20.
> 
> Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> Cc: clang-built-linux@googlegroups.com
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> ---
> Changes V1 -> V2:
> * update commit subject and message as per Masahiro/Geert.
> 
> To Geert's question about minimum binutils versions; no change needed to
> binutils.
> 
> 
>  arch/sh/kernel/vsyscall/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/sh/kernel/vsyscall/Makefile b/arch/sh/kernel/vsyscall/Makefile
> index 5db6579bc44c..6e8664448048 100644
> --- a/arch/sh/kernel/vsyscall/Makefile
> +++ b/arch/sh/kernel/vsyscall/Makefile
> @@ -15,8 +15,7 @@ quiet_cmd_syscall = SYSCALL $@
>  
>  export CPPFLAGS_vsyscall.lds += -P -C -Ush
>  
> -vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 \
> -		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> +vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 -Wl,--hash-style=sysv
>  
>  SYSCFLAGS_vsyscall-trapa.so	= $(vsyscall-flags)
>  
> -- 
> 2.21.0.593.g511ec345e18-goog
> 

-- 
Yosinori Sato
