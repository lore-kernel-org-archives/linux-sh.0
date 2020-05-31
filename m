From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 31 May 2020 09:52:30 +0000
Subject: Re: [PATCH] sh: Implement __get_user_u64() required for 64-bit get_user()
Message-Id: <CAMuHMdWG1wudoBP0EK8FiEj1BMEoL3r5oqJMUEbt2rqRU2gQpw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200529174540.4189874-1-glaubitz@physik.fu-berlin.de> <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Adrian,

On Fri, May 29, 2020 at 7:46 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Trying to build the kernel with CONFIG_INFINIBAND_USER_ACCESS enabled fails
>
>      ERROR: "__get_user_unknown" [drivers/infiniband/core/ib_uverbs.ko] undefined!
>
> with on SH since the kernel misses a 64-bit implementation of get_user().
>
> Implement the missing 64-bit get_user() as __get_user_u64(), matching the
> already existing __put_user_u64() which implements the 64-bit put_user().
>
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks for your patch!

> --- a/arch/sh/include/asm/uaccess_32.h
> +++ b/arch/sh/include/asm/uaccess_32.h
> @@ -26,6 +26,9 @@ do {                                                          \
>         case 4:                                                 \
>                 __get_user_asm(x, ptr, retval, "l");            \
>                 break;                                          \
> +       case 8:                                                 \
> +               __get_user_u64(x, ptr, retval);                 \
> +               break;                                          \
>         default:                                                \
>                 __get_user_unknown();                           \
>                 break;                                          \
> @@ -66,6 +69,52 @@ do {                                                 \
>
>  extern void __get_user_unknown(void);
>
> +#if defined(CONFIG_CPU_LITTLE_ENDIAN)
> +#define __get_user_u64(x, addr, err) \
> +({ \
> +__asm__ __volatile__( \
> +       "1:\n\t" \
> +       "mov.l  %2,%R1\n\t" \
> +       "mov.l  %T2,%S1\n\t" \
> +       "2:\n" \
> +       ".section       .fixup,\"ax\"\n" \
> +       "3:\n\t" \
> +       "mov    #0, %1\n\t" \

As this is the 64-bit variant, I think this single move should be
replaced by a double move:

       "mov  #0,%R1\n\t" \
       "mov  #0,%S1\n\t" \

Same for the big endian version below.

Disclaimer: uncompiled, untested, no SH assembler expert.

> +       "mov.l  4f, %0\n\t" \
> +       "jmp    @%0\n\t" \
> +       " mov   %3, %0\n\t" \
> +       ".balign        4\n" \
> +       "4:     .long   2b\n\t" \
> +       ".previous\n" \
> +       ".section       __ex_table,\"a\"\n\t" \
> +       ".long  1b, 3b\n\t" \
> +       ".previous" \
> +       :"=&r" (err), "=&r" (x) \
> +       :"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
