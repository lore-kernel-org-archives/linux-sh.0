From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Dec 2019 08:02:00 +0000
Subject: Re: [PATCH] sh: use generic strncpy()
Message-Id: <CAMuHMdUq6U0i_+Dg57jVNYM4iephuZ8k3QC6AyQ--W_qY5=q9w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878snajjh2.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878snajjh2.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Karl Nasrallah <knnspeed@aol.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>

Hi Morimoto-san, Karl,

On Wed, Dec 18, 2019 at 6:22 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current SH will get below warning at strncpy()
>
> In file included from ${LINUX}/arch/sh/include/asm/string.h:3,
>                  from ${LINUX}/include/linux/string.h:20,
>                  from ${LINUX}/include/linux/bitmap.h:9,
>                  from ${LINUX}/include/linux/nodemask.h:95,
>                  from ${LINUX}/include/linux/mmzone.h:17,
>                  from ${LINUX}/include/linux/gfp.h:6,
>                  from ${LINUX}/innclude/linux/slab.h:15,
>                  from ${LINUX}/linux/drivers/mmc/host/vub300.c:38:
> ${LINUX}/drivers/mmc/host/vub300.c: In function 'new_system_port_status':
> ${LINUX}/arch/sh/include/asm/string_32.h:51:42: warning: array subscript\
>   80 is above array bounds of 'char[26]' [-Warray-bounds]
>    : "0" (__dest), "1" (__src), "r" (__src+__n)
>                                      ~~~~~^~~~
>
> In general, strncpy() should behave like below.
>
>         char dest[10];
>         char *src = "12345";
>
>         strncpy(dest, src, 10);
>         // dest = {'1', '2', '3', '4', '5',
>                    '\0','\0','\0','\0','\0'}
>
> But, current SH strnpy() has 2 issues.
> 1st is it will access to out-of-memory (= src + 10).

I believe this is not correct: the code does not really access memory
beyond the end of the source string.  (Recent) gcc just thinks so,
because "__src+__n" is used as a parameter to the routine.

> 2nd is it needs big fixup for it, and maintenance __asm__
> code is difficult.

Yeah, the padding is missing.

> To solve these issues, this patch simply uses generic strncpy()
> instead of architecture specific one.

That will definitely fix the issue, as we assume the generic
implementation is correct ;-)

Now, I've just tried, naively, to enable CONFIG_STRING_SELFTEST=y in my
rts7751r2d build (without your patch), and boot it in qemu:

    String selftests succeeded

Woops, turns out lib/test_string.c does not have any testcases for
strncpy()...

So adding test code for the corner cases may be a valuable contribution.
Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
