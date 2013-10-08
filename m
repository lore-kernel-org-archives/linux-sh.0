From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Oct 2013 03:27:59 +0000
Subject: Re: [PATCH 2/3] arm: shmobile: r8a7790: Add USBHS clock support
Message-Id: <87bo30xwzo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Valentine

> @@ -296,6 +298,8 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
>  	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
>  	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
> +	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP704]),
> +	CLKDEV_ICK_ID("usbhs", "usb_phy_rcar_gen2", &mstp_clks[MSTP704]),

This case, you can use

	CLKDEV_DEV_ID("usb_phy_rcar_gen2", &mstp_clks[MSTP704]),

and no clk_get() is needed.
