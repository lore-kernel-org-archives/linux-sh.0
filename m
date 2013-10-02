From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 00:13:53 +0000
Subject: Re: [PATCH 3/6] arm: shmobile: Add internal PCI support to RCAR Gen2
Message-Id: <877gdw1qdd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-4-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-4-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Valentine

> This adds internal PCI controller support to RCAR Gen2 platform.
> There are 3 PCI controllers available with only a EHCI/OHCI
> device present on each one. The controllers do not support
> I/O port space mapping and it is not needed here.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>
>  arch/arm/mach-shmobile/Kconfig         |   1 +
>  arch/arm/mach-shmobile/Makefile        |   4 +
>  arch/arm/mach-shmobile/pci-rcar-gen2.c | 339 +++++++++++++++++++++++++++++++++
>  3 files changed, 344 insertions(+)
(snip)
> +static struct platform_driver rcar_pci_driver = {
> +	.driver = {
> +		.name = "pci-rcar-gen2",
> +	},
> +};
> +
> +static int __init rcar_pci_init(void)
> +{
> +	return platform_driver_probe(&rcar_pci_driver, rcar_pci_probe);
> +}

driver should exist under ${LINUX}/driver, not ${LINUX}/arch/arm/

Best regards
---
Kuninori Morimoto
