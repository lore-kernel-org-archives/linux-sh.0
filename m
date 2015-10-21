From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Oct 2015 10:18:00 +0000
Subject: Re: [PATCH 14/19] ARM: dts: shmobile/r8a7xxx: replace gpio-key,wakeup with wakeup-source property
Message-Id: <CAMuHMdXpY7gSOPAGxh9Z_LurpL392y7Vx0pBe-FqfauXjVnMFQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-15-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1445422216-29375-15-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Oct 21, 2015 at 12:10 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
> check for/support the legacy "gpio-key,wakeup" boolean property to
> enable gpio buttons as wakeup source, "wakeup-source" is the new
> standard binding.
>
> This patch replaces the legacy "gpio-key,wakeup" with the unified
> "wakeup-source" property in order to avoid any futher copy-paste
> duplication.

Thanks!

I made the same changes to my local tree a few weeks ago, but never found
time to send them out...

> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
