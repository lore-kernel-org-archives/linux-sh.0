From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 Nov 2015 11:06:51 +0000
Subject: Re: [PATCH] i2c: rcar: Revert the latest refactoring series
Message-Id: <CAMuHMdU9ozDLRvTKOHgA8tKJeLnbd9aMWmPFrjO7pWEgDursTA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446204606-25541-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1446204606-25541-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Fri, Oct 30, 2015 at 12:30 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> This whole series caused sometimes timeouts and even OOPSes on some
> r8a7791 Koelsch boards. We need to understand and fix those first.
>
> Revert "i2c: rcar: clean up after refactoring"
> Revert "i2c: rcar: revoke START request early"
> Revert "i2c: rcar: check master irqs before slave irqs"
> Revert "i2c: rcar: don't issue stop when HW does it automatically"
> Revert "i2c: rcar: init new messages in irq"
> Revert "i2c: rcar: refactor setup of a msg"
> Revert "i2c: rcar: remove spinlock"
> Revert "i2c: rcar: remove unused IOERROR state"
> Revert "i2c: rcar: rework hw init"

I can confirm this gets rid of the following error messages on koelsch:

-i2c-rcar e6530000.i2c: error -16 : 0
-adv7511: probe of 2-0039 failed with error -16

(2-0039 = adv7511)

-i2c-rcar e6530000.i2c: error -16 : 0
-i2c-rcar e6530000.i2c: error -16 : 0
-i2c-rcar e6530000.i2c: pm_clk_suspend()
-i2c-rcar e6530000.i2c: pm_clk_resume()
-i2c-rcar e6530000.i2c: error -16 : 0
-adv7180: probe of 2-0020 failed with error -16

(2-0020 = adv7180)

-i2c-rcar e6530000.i2c: pm_clk_resume()
-i2c-rcar e6530000.i2c: error -16 : 0
-i2c-rcar e6530000.i2c: error -16 : 0
-i2c-rcar e6530000.i2c: error -16 : 0
-i2c-rcar e6530000.i2c: error -16 : 0
-i2c-rcar e6530000.i2c: error -16 : 0
-i2c-rcar e6530000.i2c: error -16 : 0

-i2c-rcar e6530000.i2c: error -16 : 0
-i2c-rcar e6530000.i2c: error -16 : 0
-i2c-rcar e6530000.i2c: error -16 : 0
-i2c-rcar e6530000.i2c: error -16 : 0
-i2c-rcar e6530000.i2c: error -16 : 0
-i2c-rcar e6530000.i2c: error -16 : 0

(related to ak4642, I think)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
