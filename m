From: Simon Horman <horms@verge.net.au>
Date: Tue, 10 Mar 2015 07:55:39 +0000
Subject: Possible regression in next-20150310 due to pinctrl: sh-pfc: r8a7790: Remove non existing GPIO pins
Message-Id: <20150310075538.GA20709@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>

Hi,

I have observed what appears to be a regression in next-20150310.  Using
the shmobile_defconfig the lager board does not produce console output
whatsoever. If I revert bfb6698fad74e7ba2 ("pinctrl: sh-pfc: r8a7790:
Remove non existing GPIO pins") then the problem seems to be resolved.

Likewise for the koelsh board and 896498d439cec6ff0 ("pinctrl: sh-pfc:
r8a7791: Remove non existing GPIO pins").


N.B.: In order to boot all the way to user-space I also need to revert
5da0e63e268dc5120 ("mmc: tmio: Fix PIO mode with CONFIG_HIGHMEM"), a
problem that I have reported separately[1].

[1] Possible regression in next-20150306 due to "mmc: tmio: Fix PIO mode
with CONFIG_HIGHMEM"
    http://www.spinics.net/lists/linux-sh/msg40804.html

> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Patch applied with Geert's ACK.
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
