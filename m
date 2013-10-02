From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 00:08:48 +0000
Subject: Re: [PATCH 1/6] arm: shmobile: r8a7790: Add USBHS clock support
Message-Id: <87a9is1qm0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Valentine

> This adds USBHS clock support.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
(snip)
> @@ -296,6 +298,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
>  	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
>  	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
> +	CLKDEV_CON_ID("hsusb", &mstp_clks[MSTP704]),
>  };

you can use "renesas_usbhs" for MSTP704.
and see [2/6] comment from me

Best regards
---
Kuninori Morimoto
