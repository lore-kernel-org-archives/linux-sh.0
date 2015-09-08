From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 08 Sep 2015 17:09:54 +0000
Subject: Re: renesas-drivers-2015-09-08-v4.2
Message-Id: <CAMuHMdVWOpytz3_YWROX9NP1SKetypWZPnZVd6f70WGcmL15CQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441716260-10795-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441716260-10795-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 8, 2015 at 2:44 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> I've pushed renesas-drivers-2015-09-08-v4.2 to
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git

> Included fixes:
>   - Revert "irqchip/gic: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND"

I've been a bit to eager to revert this: what looked like a regression on
several boards, turned out to be a bug in 2 irqchip drivers, cfr.
"[PATCH 0/2] irqchip: renesas: Propagate wake-up settings to parent"
(http://marc.info/?l=linux-sh&m4173164123429&w=2).

Anyway, the revert is more or less harmless.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
