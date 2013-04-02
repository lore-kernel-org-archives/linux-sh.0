From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 02 Apr 2013 00:27:13 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: R8A7779: add Ether support
Message-Id: <87wqsl6ale.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Sergei again

> +void __init r8a7779_add_ether_device(void *pdata)
> +{
> +	ether_device.dev.platform_data = pdata;
> +
> +	platform_device_register(&ether_device);
> +}

We didn't use this style of registration before,
but, it is OK.
Then, this (void *pdata) should be
(struct sh_eth_plat_data *pdata) IMO

Best regards
---
Kuninori Morimoto
