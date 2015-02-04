From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 04 Feb 2015 18:12:08 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7794: alt: Enable ethernet controller
Message-Id: <CAMuHMdUsjx2k4a0wuuZ8CF84w_bUuQUohz2=kgF04PxX-MPWhQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 4, 2015 at 6:38 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> I've double-checked the block
>> diagram and it mentions "GP1_24(IRQ)"
>
>    GP1_24 is connected to the PHY's RST# pin, according to the hardware
> manual. Which seems bad to me -- we hardly needed such kind of reset with

My (I guess the same as Laurent's) diagram says:
    GP3_22 (RESET)
    GP1_24 (IRQ)

> the device tree. :-/ Hopefully, U-Boot leaves it high...

Can we describe that in DT?
Not describing everything will bite us one day (cfr. clocks, PM domains, ...)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
