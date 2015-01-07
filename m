From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 07 Jan 2015 14:22:01 +0000
Subject: Re: [PATCH] dma: rcar-hpbdma: add dma_dev->directions
Message-Id: <54AD4109.8050903@metafoo.de>
List-Id: <linux-sh.vger.kernel.org>
References: <87r3v8uy5p.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r3v8uy5p.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/06/2015 09:10 AM, Kuninori Morimoto wrote:
[...]
>   	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> +	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);

You should also set the other capabilities: src_addr_widths, dst_addr_widths 
and residue_granularity.

- Lars

