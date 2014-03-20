From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Mar 2014 12:18:01 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: Enable drivers/sh/pm_runtime.c on multi-platform
Message-Id: <CAMuHMdUPtmfV+bQP1tkBssOcD05h8ucJTESPyzfcYqzMnXDKrg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 20, 2014 at 1:13 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>> I think Ben's point is that drivers/sh/intc might be completely unneeded for
>> ARM.
>
> http://www.spinics.net/lists/linux-sh/msg30067.html
>
> "Furthermore, the core intc parts are used by sh7372/mackerel and
>  sh73a0/kzm9g (and arch/sh) only, so I'm gonna restrict it to
>  ARCH_SHMOBILE_LEGACY and SUPERH only."
>
> Despite the names, sh7372 and sh73a0 are ARM.

Hmm, I think the inclusion of drivers/sh/intc could depend on a new
SH_INTC symbol, to be selected by legacy sh, and ARM sh7372/sh73a0?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
