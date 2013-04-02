From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 02 Apr 2013 00:17:38 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: R8A7779: add Ether support
Message-Id: <87y5d16b1d.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Sergei

> +void __init r8a7779_add_ether_device(void *pdata)
> +{
> +	ether_device.dev.platform_data = pdata;
> +
> +	platform_device_register(&ether_device);
> +}

Current ARM SoC is trying to not use platform_device_register()
Please use platform_device_register_xxx()
Same comment for [2/2]

Best regards
---
Kuninori Morimoto
