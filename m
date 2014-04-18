From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Apr 2014 01:32:54 +0000
Subject: Re: [PATCH v2 9/9] DMA: shdma: wire r8a7790
Message-Id: <87zjjjbewr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397511312-4845-1-git-send-email-ben.dooks@codethink.co.uk>
	<1397511312-4845-10-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397511312-4845-10-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org, vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, devicetree@vger.kernel.org


Hi Ben

Thank you for your patch

> Add support for R8A7790 with new device tree code.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
(snip)
>  static const struct of_device_id sh_dmae_of_match[] = {
> -	{.compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid,},
> +	{ .compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid },
> +	{ .compatible = "renesas,dma-r8a7790", .data = &shdma_arm_info },
>  	{}
>  };

Here, new compatible name is "renesas,dma-r8a7790"
                                      ~~~

> +		sysdma0: dma-controller@e6700000 {
> +			compatible = "renesas,shdma-r8a7790";
..
> +		sysdma1: dma-controller@e6720000 {
> +			compatible = "renesas,shdma-r8a7790";

your [PATCH v2 3/9] ARM: shmobile: r8a7790: add dmac0 dmac1 nodes
is using "renesas,shdma-r8a7790"
                  ~~~~~

Is it miss/typo ?

