From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 May 2017 08:57:56 +0000
Subject: Re: [PATCH] sh: use pr_cont in code dump
Message-Id: <CAMuHMdUZnMNkDgwF46TdY+aNwJ6KPEgY6dZG4tUiuiPmYvDVzw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170516223522.19094-1-aurelien@aurel32.net>
In-Reply-To: <20170516223522.19094-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Aurelien,

On Wed, May 17, 2017 at 12:35 AM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> Using using printk to continue logging messages now produces multiple
> line logging output unless the continuations use KERN_CONT. This causes
> the code dump on SH do be unreadable:
>
> [   40.036000] Code:
> [   40.036000]   8c0128f0:
> [   40.036000] stc
> [   40.036000] r6_bank
> [   40.036000] ,
> [   40.036000] r1
> [   40.036000]
> [   40.036000]   8c0128f2:
> [   40.036000] or
> [   40.036000] r1
> [   40.036000] ,
> [   40.036000] r2
> [   40.036000]
> [   40.036000]   8c0128f4:
> [   40.036000] ldc
> [   40.036000] r2
> [   40.036000] ,
> [   40.036000] sr
> [   40.036000]
>
> Convert the calls to printk but the first one to pr_cont. This makes the
> code dump readable again.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

> --- a/arch/sh/kernel/disassemble.c
> +++ b/arch/sh/kernel/disassemble.c

> @@ -562,14 +562,14 @@ void show_code(struct pt_regs *regs)
>                 unsigned short insn;
>
>                 if (__get_user(insn, pc + i)) {
> -                       printk(" (Bad address in pc)\n");
> +                       pr_cont(" (Bad address in pc)\n");

This is always the start of a new line, so printk() is fine (or use
pr_info(), even better).

>                         break;
>                 }
>
> -               printk("%s%08lx:  ", (i ? "  ": "->"), (unsigned long)(pc + i));
> +               pr_cont("%s%08lx:  ", (i ? "  ": "->"), (unsigned long)(pc + i));

Likewise

>                 print_sh_insn((unsigned long)(pc + i), insn);
> -               printk("\n");
> +               pr_cont("\n");
>         }
>
> -       printk("\n");
> +       pr_cont("\n");
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
