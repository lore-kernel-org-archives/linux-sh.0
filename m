From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Mar 2013 00:57:08 +0000
Subject: Re: [PATCH 03/10] ARM: shmobile: r8a7779: add USB EHCI clock support
Message-Id: <87hake4x3y.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1352446165-19298-1-git-send-email-horms@verge.net.au>
 <1352446165-19298-4-git-send-email-horms@verge.net.au>
 <5141156C.4010909@cogentembedded.com>
In-Reply-To: <5141156C.4010909@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Sergei

> >   	/* MSTP32 clocks */
> > +	CLKDEV_DEV_ID("ehci-platform.1", &mstp_clks[MSTP101]), /* USB EHCI port2 */
> > +	CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
> 
>     But how are those used? I don't see clk API support in ehci-platform.c.
> Are they used via runtime PM? I'm just not familiar enough with it...

Yes exactry

    - board-marzen.c :: usb_power_on()
    - clock-r8a7779.c :: mstp_clks[]

Best regards
---
Kuninori Morimoto
