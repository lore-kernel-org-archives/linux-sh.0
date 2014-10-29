From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Oct 2014 07:24:11 +0000
Subject: Re: [PATCH v3 0/9] R-Car Gen2 DMA Controller driver
Message-Id: <CANqRtoTuoOZ7GbDWHpx1EcEriPL8ODjd4M1B7Z7rzL-G2rMzKA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 27, 2014 at 2:40 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Hello,
>
> This patch sets adds a new driver for the DMA controller found in the R-Car
> Gen2 SoCs under the name "Direct Memory Access Controller for System
> (SYS-DMAC)". Support for the "Realtime Direct Memory Access Controller
> (RT-DMAC)" and "Direct Memory Access Controller for Audio (Audio-DMAC)" will
> be added later.
>
> For the rationale of why a new driver is needed, and performance figures,
> please see the cover letter of v1 ("[PATCH 0/7] R-Car Gen2 DMA Controller
> driver") [1].
>
> Support for hardware descriptors lists is not included in this series to keep
> it simple and hopefully get it merged in v3.19. I'll post it as a separate
> series. No change to the DT bindings will be needed.
>
> The first three patches should go through the DMA engine tree, while the last
> six patches should go through the Renesas tree. Simon, as the DT bindings have
> been merged already, I believe you can queue up the arch patches without
> waiting for the driver patches to be merged.
>
> Known issues are
>
> - Untested cyclic DMA transfers. I've done my best to fix the related issues
>   from v2, but I haven't been able to test audio with the R-Car platforms (see
>   [2]). Morimoto-san, if you could help me with audio testing I'd be grateful.
>
> - Stub system PM implementation. I'm working on this.
>
> - Risk of conflict with Maxime's DMA engine rework series.
>
> I believe the first two issues are not show stoppers. I can rebase the patches
> if Maxime's patches get merged first.
>
> Changes since v2:
>
> - Replace several occurrences of size_t with unsigned int
> - Remove unneeded local variable initialization
> - Compute maximum transfer size at runtime
> - Typo fixes
> - Replace WARN_ON with WARN_ON_ONCE in interrupt handler
> - Validate the number of channels
> - Reset the device before enabling interrupts
> - Use DMA_SLAVE_BUSWIDTH_* constants instead of numerical values
> - Use devm_kasprintf
> - Update to the new prep_dma_cyclic API
> - Filter out channels from unrelated devices
> - Fix typo in register definition
> - Rename rcar_dmac_hw_desc to rcar_dmac_xfer_chunk
> - Ignore the deprecated dma_slave_config direction field
> - Allocate memory with GFP_NOWAIT in prep handlers
> - Split runtime and system PM
> - Move runtime PM to channel alloc/fre
>
> Changes since v1:
>
> - Allocate IRQ name strings dynamically
> - Only call the callback function if one is supplied
> - Don't overallocate sg list entries
> - Allocate sg list entries with GFP_KERNEL
> - Don't manage function clock manually
> - Make channel filter ignore unrelated devices
> - Document why the cyclic sg list is kcalloc'ed
> - Remove ch15 from interrupt names in DT
> - Replace CONFIG_OF with OF in Kconfig
>
> [1] http://www.spinics.net/lists/linux-sh/msg33768.html
> [2] http://www.spinics.net/lists/linux-sh/msg36474.html
>
> Laurent Pinchart (9):
>   dmaengine: Add 16 bytes, 32 bytes and 64 bytes bus widths
>   dmaengine: rcar-dmac: Remove duplicate sentence from DT bindings
>   dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC)
>     driver
>   ARM: shmobile: r8a7790: Rename mmcif node to mmc
>   ARM: shmobile: r8a7791: Add MMCIF0 DT node
>   ARM: shmobile: r8a7790: Reference DMA channels in MMCIF DT nodes
>   ARM: shmobile: r8a7791: Reference DMA channels in MMCIF DT node
>   ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
>   ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes

Hi Laurent,

I've now tested this series briefly together with QSPI on Koelsch, and
on top of that I've also done a prototype back port to LTSI-3.14. All
seems well except this minor Kconfig adjustment that I needed to do to
handle the case when we only enable this driver:

--- 0001/drivers/dma/Makefile
+++ work/drivers/dma/Makefile 2014-10-29 13:14:24.000000000 +0900
@@ -20,6 +20,7 @@ obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
 obj-$(CONFIG_MX3_IPU) += ipu/
 obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
 obj-$(CONFIG_SH_DMAE_BASE) += sh/
+obj-$(CONFIG_RCAR_DMAC) += sh/
 obj-$(CONFIG_COH901318) += coh901318.o coh901318_lli.o
 obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
 obj-$(CONFIG_IMX_SDMA) += imx-sdma.o

Not the prettiest solution, but at least it makes the code compile
regardless of SH_DMAE_BASE.
Can you please consider folding this hunk into next version of your series?

Thanks,

/ magnus
