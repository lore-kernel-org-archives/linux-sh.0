From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 31 May 2020 10:43:11 +0000
Subject: Re: [PATCH] sh: Implement __get_user_u64() required for 64-bit get_user()
Message-Id: <CAMuHMdXzje-qFH=pGoouSuXTZYf4NvnzbaYxTm_boMek-DbWMg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200529174540.4189874-1-glaubitz@physik.fu-berlin.de>
 <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de> <CAMuHMdWG1wudoBP0EK8FiEj1BMEoL3r5oqJMUEbt2rqRU2gQpw@mail.gmail.com>
 <ba354e30-82ab-68c2-0771-2489463c9279@physik.fu-berlin.de> <2ad089c1-75cf-0986-c40f-c7f3f8fd6ead@physik.fu-berlin.de>
In-Reply-To: <2ad089c1-75cf-0986-c40f-c7f3f8fd6ead@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Adrian,

On Sun, May 31, 2020 at 11:59 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 5/31/20 11:54 AM, John Paul Adrian Glaubitz wrote:
> > On 5/31/20 11:52 AM, Geert Uytterhoeven wrote:
> >> As this is the 64-bit variant, I think this single move should be
> >> replaced by a double move:
> >>
> >>        "mov  #0,%R1\n\t" \
> >>        "mov  #0,%S1\n\t" \
> >>
> >> Same for the big endian version below.
> >>
> >> Disclaimer: uncompiled, untested, no SH assembler expert.
> >
> > Right, this makes sense. I'll send a new patch shortly.
>
> Hmm, this change is not the case for __put_user_asm() vs. __put_user_u64().
> But I have to admit, I don't know what the part below "3:\n\t" is for.

It's part of the exception handling, in case the passed (userspace) pointer
points to an inaccessible address, and triggers an exception.

For an invalid store, nothing is done, besides returning -EFAULT.
Hence there's no "mov #0, %1\n\t" in the put_user case.
For an invalid load, the data is replaced by zero, and -EFAULT is returned.

> +__asm__ __volatile__( \
> +       "1:\n\t" \
> +       "mov.l  %2,%R1\n\t" \
> +       "mov.l  %T2,%S1\n\t" \
> +       "2:\n" \

(reordering the two sections for easier explanation)

> +       ".section       __ex_table,\"a\"\n\t" \
> +       ".long  1b, 3b\n\t" \

In case an exception happens for the instruction at 1b, jump to 3b.

Note that the m68k version has two entries here: one for each half of
the 64-bit access[*].
I don't know if that is really needed (and thus SH needs it, too), or if
the exception code handles subsequent instructions automatically.

> +       ".section       .fixup,\"ax\"\n" \
> +       "3:\n\t" \
> +       "mov    #0, %1\n\t" \

Return zero instead of the data at the (invalid) address.

> +       "mov.l  4f, %0\n\t" \
> +       "jmp    @%0\n\t" \

Resume at 2b.
Remember: branch delay slot, so the instruction below is executed first!

> +       " mov   %3, %0\n\t" \

Set err to -EFAULT.

> +       ".balign        4\n" \
> +       "4:     .long   2b\n\t" \
> +       ".previous\n" \

> +       ".previous" \
> +       :"=&r" (err), "=&r" (x) \
> +       :"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })

[*] arch/m68k/include/asm/uaccess_mm.h

                        "1:     "MOVES".l       (%2)+,%1\n"             \
                        "2:     "MOVES".l       (%2),%R1\n"             \

                        "       .section __ex_table,\"a\"\n"            \
                        "       .align  4\n"                            \
                        "       .long   1b,10b\n"                       \
                        "       .long   2b,10b\n"                       \

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
