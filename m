From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 May 2014 10:46:03 +0000
Subject: Re: [PATCH v2 2/9] ARM: shmobile: r8a7790: add dma defines for sys and audio dmacs
Message-Id: <CAMuHMdUsRSGuGgnAgjKtOWmx3C_PWUxAU=2XTvPE1M9o13S1uA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397511312-4845-1-git-send-email-ben.dooks@codethink.co.uk>
	<1397511312-4845-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397511312-4845-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, magnus.damm@opensource.se, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Ben,

On Mon, Apr 14, 2014 at 11:35 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> +*/
> +
> +/* System DMAC */

Missing include guards.

> +#define R8A7790_DMA_MSIOF0_TX  (0x81)
> +#define R8A7790_DMA_MSIOF0_RX  (0x82)
> +#define R8A7790_DMA_MSIOF1_TX  (0x85)
> +#define R8A7790_DMA_MSIOF1_RX  (0x86)

These are the only ones that se different for r8a7791 (0x51 etc.
compared to 0x81).
Wondering whether someone mixed up decimal and hexadecimal...

Are the System DMAC and Audio DMAC ID spaces separate
or unified? We also have in the audio section:

#define R8A7790_DMA_SSCI92_TX   (0x81)
#define R8A7790_DMA_SSCI92_RX   (0x82)
#define R8A7790_DMA_SCU0        (0x85)

> +#define R8A7790_DMA_IIC3_TX    (0x77)
> +#define R8A7790_DMA_IIC3_RX    (0x78)

In all other places, we call this "IICDVFS" instead of "IIC3".
The docs aren't always that consistent, though.

> +#define R8A7790_DMA_AXISTATR   (0xA6)
> +#define R8A7790_DMA_AXISTATS0  (0xAC)
> +#define R8A7790_DMA_AXISTATS1  (0xAA)
> +#define R8A7790_DMA_AXISTATS2  (0xA8)
> +#define R8A7790_DMA_AXISTATS3  (0xA4)

R8A7790_DMA_AXISTATS3C, to match the docs?

> +#define R8A7790_DMA_MMCIF0_TX  (0xD1)
> +#define R8A7790_DMA_MMCIF0_RX  (0xD2)
> +#define R8A7790_DMA_MMCIF1_TX  (0xE1)
> +#define R8A7790_DMA_MMCIF1_RX  (0xE2)

AXSTM is missing at the end:

#define R8A7790_DMA_AXSTM      (0xAE)

> +#define R8A7790_DMA_SSCI20_TX  (0x63)
> +#define R8A7790_DMA_SSCI20_RX  (0x64)
> +#define R8A7790_DMA_SSCI21_TX  (0x67)
> +#define R8A7790_DMA_SSCI21_RX  (0x68)
> +#define R8A7790_DMA_SSCI22_TX  (0x6B)
> +#define R8A7790_DMA_SSCI22_RX  (0x6C)
> +#define R8A7790_DMA_SSCI23_TX  (0x6D)
> +#define R8A7790_DMA_SSCI23_RX  (0x6E)
> +
> +#define R8A7790_DMA_SSCI20_TX  (0x63)
> +#define R8A7790_DMA_SSCI20_RX  (0x64)
> +#define R8A7790_DMA_SSCI21_TX  (0x67)
> +#define R8A7790_DMA_SSCI21_RX  (0x68)
> +#define R8A7790_DMA_SSCI22_TX  (0x6B)
> +#define R8A7790_DMA_SSCI22_RX  (0x6C)
> +#define R8A7790_DMA_SSCI23_TX  (0x6D)
> +#define R8A7790_DMA_SSCI23_RX  (0x6E)

This section is duplicated.

> +#define CHCR_RX_32BIT  SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_32BIT)
> +#define CHCR_TX_32BIT  SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_32BIT)
> +#define CHCR_RX_256BIT SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_256BIT)
> +#define CHCR_TX_256BIT SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_256BIT)

From my (still-limited) understanding of the shdma driver, these look like
pure register values, not descriptions of the hardware?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
