From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Aug 2013 00:20:24 +0000
Subject: Re: [PATCH v2 1/9] ARM: shmobile: r8a7779: Add DU support
Message-Id: <87li4dt4my.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375916192-22647-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375916192-22647-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

I didn't notice this v2 patch :P
I had sent comment mail to your v1 patch, please check it for detail

> Add a function to register the DU device with board-specific platform
> data. The DU device is named rcar-du-r8a7779, fix the clock entry
> accordingly.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
(snip)
> +void __init r8a7779_add_du_device(const struct rcar_du_platform_data *pdata)
> +{
> +	struct platform_device_info info = {
> +		.name = "rcar-du-r8a7779",
> +		.id = -1,
> +		.res = du_resources,
> +		.num_res = ARRAY_SIZE(du_resources),
> +		.data = pdata,
> +		.size_data = sizeof(*pdata),
> +		.dma_mask = DMA_BIT_MASK(32),
> +	};
> +
> +	platform_device_register_full(&info);
> +}

Please call above register function from board.c directly.
Same comment to [4/9]


Best regards
---
Kuninori Morimoto
