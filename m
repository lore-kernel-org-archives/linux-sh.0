From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 04 Nov 2014 07:07:38 +0000
Subject: Re: [PATCH v3 0/9] R-Car Gen2 DMA Controller driver
Message-Id: <CANqRtoQfAzk+f6L_m8cH_A0H_WGHLU7QrNnziPDzR4tgX+38-w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Oct 29, 2014 at 8:15 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Wednesday 29 October 2014 16:24:11 Magnus Damm wrote:
>> On Mon, Oct 27, 2014 at 2:40 AM, Laurent Pinchart wrote:
>> > Hello,
>> >
>> > This patch sets adds a new driver for the DMA controller found in the
>> > R-Car Gen2 SoCs under the name "Direct Memory Access Controller for System
>> > (SYS-DMAC)". Support for the "Realtime Direct Memory Access Controller
>> > (RT-DMAC)" and "Direct Memory Access Controller for Audio (Audio-DMAC)"
>> > will be added later.
>> >
>> > For the rationale of why a new driver is needed, and performance figures,
>> > please see the cover letter of v1 ("[PATCH 0/7] R-Car Gen2 DMA Controller
>> > driver") [1].
>> >
>> > Support for hardware descriptors lists is not included in this series to
>> > keep it simple and hopefully get it merged in v3.19. I'll post it as a
>> > separate series. No change to the DT bindings will be needed.
>> >
>> > The first three patches should go through the DMA engine tree, while the
>> > last six patches should go through the Renesas tree. Simon, as the DT
>> > bindings have been merged already, I believe you can queue up the arch
>> > patches without waiting for the driver patches to be merged.
>> >
>> > Known issues are
>> >
>> > - Untested cyclic DMA transfers. I've done my best to fix the related
>> >   issues from v2, but I haven't been able to test audio with the R-Car
>> >   platforms (see [2]). Morimoto-san, if you could help me with audio
>> >   testing I'd be grateful.
>> >
>> > - Stub system PM implementation. I'm working on this.
>> >
>> > - Risk of conflict with Maxime's DMA engine rework series.
>> >
>> > I believe the first two issues are not show stoppers. I can rebase the
>> > patches if Maxime's patches get merged first.
>> >
>> > Changes since v2:
>> >
>> > - Replace several occurrences of size_t with unsigned int
>> > - Remove unneeded local variable initialization
>> > - Compute maximum transfer size at runtime
>> > - Typo fixes
>> > - Replace WARN_ON with WARN_ON_ONCE in interrupt handler
>> > - Validate the number of channels
>> > - Reset the device before enabling interrupts
>> > - Use DMA_SLAVE_BUSWIDTH_* constants instead of numerical values
>> > - Use devm_kasprintf
>> > - Update to the new prep_dma_cyclic API
>> > - Filter out channels from unrelated devices
>> > - Fix typo in register definition
>> > - Rename rcar_dmac_hw_desc to rcar_dmac_xfer_chunk
>> > - Ignore the deprecated dma_slave_config direction field
>> > - Allocate memory with GFP_NOWAIT in prep handlers
>> > - Split runtime and system PM
>> > - Move runtime PM to channel alloc/fre
>> >
>> > Changes since v1:
>> >
>> > - Allocate IRQ name strings dynamically
>> > - Only call the callback function if one is supplied
>> > - Don't overallocate sg list entries
>> > - Allocate sg list entries with GFP_KERNEL
>> > - Don't manage function clock manually
>> > - Make channel filter ignore unrelated devices
>> > - Document why the cyclic sg list is kcalloc'ed
>> > - Remove ch15 from interrupt names in DT
>> > - Replace CONFIG_OF with OF in Kconfig
>> >
>> > [1] http://www.spinics.net/lists/linux-sh/msg33768.html
>> > [2] http://www.spinics.net/lists/linux-sh/msg36474.html
>> >
>> > Laurent Pinchart (9):
>> >   dmaengine: Add 16 bytes, 32 bytes and 64 bytes bus widths
>> >   dmaengine: rcar-dmac: Remove duplicate sentence from DT bindings
>> >   dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC)
>> >
>> >     driver
>> >
>> >   ARM: shmobile: r8a7790: Rename mmcif node to mmc
>> >   ARM: shmobile: r8a7791: Add MMCIF0 DT node
>> >   ARM: shmobile: r8a7790: Reference DMA channels in MMCIF DT nodes
>> >   ARM: shmobile: r8a7791: Reference DMA channels in MMCIF DT node
>> >   ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
>> >   ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes
>>
>> Hi Laurent,
>>
>> I've now tested this series briefly together with QSPI on Koelsch, and
>> on top of that I've also done a prototype back port to LTSI-3.14. All
>> seems well except this minor Kconfig adjustment that I needed to do to
>> handle the case when we only enable this driver:
>>
>> --- 0001/drivers/dma/Makefile
>> +++ work/drivers/dma/Makefile 2014-10-29 13:14:24.000000000 +0900
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
>>  obj-$(CONFIG_MX3_IPU) += ipu/
>>  obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
>>  obj-$(CONFIG_SH_DMAE_BASE) += sh/
>> +obj-$(CONFIG_RCAR_DMAC) += sh/
>>  obj-$(CONFIG_COH901318) += coh901318.o coh901318_lli.o
>>  obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
>>  obj-$(CONFIG_IMX_SDMA) += imx-sdma.o
>>
>> Not the prettiest solution, but at least it makes the code compile
>> regardless of SH_DMAE_BASE.
>> Can you please consider folding this hunk into next version of your series?
>
> How about this one instead ?
>
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index cb626c179911..ebbcfdb8493a 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -18,7 +18,7 @@ obj-$(CONFIG_DW_DMAC_CORE) += dw/
>  obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
>  obj-$(CONFIG_MX3_IPU) += ipu/
>  obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
> -obj-$(CONFIG_SH_DMAE_BASE) += sh/
> +obj-$(CONFIG_RENESAS_DMA) += sh/
>  obj-$(CONFIG_COH901318) += coh901318.o coh901318_lli.o
>  obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
>  obj-$(CONFIG_IMX_SDMA) += imx-sdma.o
> diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
> index 6b4d95377bc8..8190ad225a1b 100644
> --- a/drivers/dma/sh/Kconfig
> +++ b/drivers/dma/sh/Kconfig
> @@ -2,6 +2,10 @@
>  # DMA engine configuration for sh
>  #
>
> +config RENESAS_DMA
> +       bool
> +       select DMA_ENGINE
> +
>  #
>  # DMA Engine Helpers
>  #
> @@ -12,7 +16,7 @@ config SH_DMAE_BASE
>         depends on !SUPERH || SH_DMA
>         depends on !SH_DMA_API
>         default y
> -       select DMA_ENGINE
> +       select RENESAS_DMA
>         help
>           Enable support for the Renesas SuperH DMA controllers.
>
> @@ -56,7 +60,7 @@ config RCAR_AUDMAC_PP
>  config RCAR_DMAC
>         tristate "Renesas R-Car Gen2 DMA Controller"
>         depends on ARCH_SHMOBILE || COMPILE_TEST
> -       select DMA_ENGINE
> +       select RENESAS_DMA
>         help
>           This driver supports the general purpose DMA controller found in the
>           Renesas R-Car second generation SoCs.
>

Thanks for this, it of course looks good to me. Acutally I'm fine with
more or less anything as long as we can successfully build each driver
independently. I saw that Wolfram also had a simpler approach which I
don't mind. Please pick by yourself!

Thanks,

/ magnus
