From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 14 Apr 2014 22:10:00 +0000
Subject: Re: [PATCH v2 2/9] ARM: shmobile: r8a7790: add dma defines for sys and audio dmacs
Message-Id: <6876261.h1xXmWF0f3@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1397511312-4845-1-git-send-email-ben.dooks@codethink.co.uk> <1397511312-4845-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397511312-4845-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org, vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org

On Monday 14 April 2014 22:35:05 Ben Dooks wrote:
> Add the DMA resource IDs for the R8A7790 Audio and SYS DMA controllers
> for use when specifying DMA handles.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

I really hate these lists in bindings:

> +#define R8A7790_DMA_SCIFA0_TX	(0x21)
> +#define R8A7790_DMA_SCIFA0_RX	(0x22)
> +#define R8A7790_DMA_SCIFA1_TX	(0x25)
> +#define R8A7790_DMA_SCIFA1_RX	(0x26)
> +#define R8A7790_DMA_SCIFA2_TX	(0x27)
> +#define R8A7790_DMA_SCIFA2_RX	(0x28)
> +
> +#define R8A7790_DMA_SCIFB0_TX	(0x3D)
> +#define R8A7790_DMA_SCIFB0_RX	(0x3E)
> +#define R8A7790_DMA_SCIFB1_TX	(0x19)
> +#define R8A7790_DMA_SCIFB1_RX	(0x1A)
> +#define R8A7790_DMA_SCIFB2_TX	(0x1D)
> +#define R8A7790_DMA_SCIFB2_RX	(0x1E)

These are all hardware constants, they should come from the data sheet and
get put into the dtsi file. The driver doesn't care what they are, and
the binding doesn't care, this only serves to make the binding less
generic.

> +#define CHCR_RX_32BIT	SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_32BIT)
> +#define CHCR_TX_32BIT	SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_32BIT)
> +#define CHCR_RX_256BIT	SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_256BIT)
> +#define CHCR_TX_256BIT	SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_256BIT)

For these, it's different: There is nothing wrong putting macros like
these into DT, because they will be the same across all SoCs.

However, as I mentioned in my reply to patch 8, I don't think that information
belongs into DT, and it should be in the device driver instead, because
that already knows the direction and transfer width and has to set it
through the slave config interface anyway.

	Arnd
