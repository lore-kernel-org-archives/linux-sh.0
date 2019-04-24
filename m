From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2019 06:27:43 +0000
Subject: Re: [PATCH] sh: require --Wl,--hash-style=sysv
Message-Id: <CAMuHMdX9hKQHitf3b8861dnTt+aJOaOiytxqBzgprBdCPnL18Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190423202907.234180-1-ndesaulniers@google.com>
In-Reply-To: <20190423202907.234180-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Lutomirsky <luto@kernel.org>, clang-built-linux@googlegroups.com, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Nick,

On Tue, Apr 23, 2019 at 10:31 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Towards the goal of removing cc-ldoption, prefer ld-option, or better
> yet, require --Wl,--hash-style=sysv since the selftest for vdso's
> requires DT_HASH.
>
> Cc: Andy Lutomirsky <luto@kernel.org>
> Cc: clang-built-linux@googlegroups.com
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for your patch!

> --- a/arch/sh/kernel/vsyscall/Makefile
> +++ b/arch/sh/kernel/vsyscall/Makefile
> @@ -15,8 +15,7 @@ quiet_cmd_syscall = SYSCALL $@
>
>  export CPPFLAGS_vsyscall.lds += -P -C -Ush
>
> -vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 \
> -               $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> +vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 -Wl,--hash-style=sysv
>
>  SYSCFLAGS_vsyscall-trapa.so    = $(vsyscall-flags)

What impact does this have on the minimum binutils version needed to
compile the kernel?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
