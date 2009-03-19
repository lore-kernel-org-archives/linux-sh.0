From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 19 Mar 2009 06:18:29 +0000
Subject: Re: [PATCH] dmaengine: sh: Add support DMA-Engine driver for DMA of
Message-Id: <49C1E3B5.9050008@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49B8AF67.8080309@renesas.com>
 <e9c3a7c20903161546i5de80305r1b0df1605c7718d8@mail.gmail.com>
In-Reply-To: <e9c3a7c20903161546i5de80305r1b0df1605c7718d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux-sh <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, maciej.sosnowski@intel.com, Paul Mundt <lethal@linux-sh.org>

Hi, Dan.

Thank you for your comments.

2009/3/17 Dan Williams <dan.j.williams@intel.com>:
 > On Wed, Mar 11, 2009 at 11:44 PM, Nobuhiro Iwamatsu
 > <iwamatsu.nobuhiro@renesas.com> wrote:
 >> This supports DMA-Engine driver for DMA of SuperH.
 >> This supported all DMA channels, and it was tested in SH7722/SH7780.
 >> This can not use with SH DMA API and can control this in Kconfig.
 >>
 >> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
 >> Cc: Paul Mundt <lethal@linux-sh.org>
 >> Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
 >> Cc: Maciej Sosnowski <maciej.sosnowski@intel.com>
 >> Cc: Dan Williams <dan.j.williams@intel.com>
 >> ---
 >>  arch/sh/drivers/dma/Kconfig  |   12 +-
 >>  arch/sh/drivers/dma/Makefile |    3 +-
 >>  arch/sh/include/asm/dma-sh.h |   11 +
 >>  drivers/dma/Kconfig          |    9 +
 >>  drivers/dma/Makefile         |    2 +
 >>  drivers/dma/shdma.c          |  743 ++++++++++++++++++++++++++++++++++++++++++
 >>  drivers/dma/shdma.h          |   65 ++++
 >>  7 files changed, 840 insertions(+), 5 deletions(-)
 >>  create mode 100644 drivers/dma/shdma.c
 >>  create mode 100644 drivers/dma/shdma.h
 >
 > Hi,
 >
 > I have not finished a full review but one problem jumps out, the use
 > of spin_lock_irqsave to protect against channel/descriptor
 > manipulations.  The highest level of protection that net_dma and
 > async_tx assume is spin_lock_bh.  It seems like the pieces of
 > sh_dmae_interrupt() that touch the descriptor can be moved to the
 > tasklet, then the locks can be downgraded.

Because a dmaengine core is not equivalent to the interrupt that is
severer than spin_lock_bh, is this to rearrange it in tasklet?

 >
 > Your other patch, to set the alignment in dmatest, makes me wonder if
 > this engine can handle unaligned accesses?  If it can not then set the
 > DMA_PRIVATE capability bit at device registration time to prevent
 > net_dma and other "public" clients from using these channels.  Public
 > clients assume that there are no alignment constraints.
 >

I thought to add it because the patch wanted to measure the
transaction speed with the thing which
was not considered to be aligned address / data size.
Depending on a device using DMA, there is the thing forcing aligning
it of forwarded data.
DMAC of SH has a register appointing transfer data size.
I control it by the following functions.

+struct sh_dmae_chan {
+	dma_cookie_t completed_cookie;	/* The maximum cookie completed */
+	spinlock_t desc_lock;			/* Descriptor operation lock */
+	struct list_head ld_queue;		/* Link descriptors queue */
+	struct dma_chan common;			/* DMA common channel */
+	struct device *dev;				/* Channel device */
+	struct resource reg;			/* Resource for register */
+	struct tasklet_struct tasklet;
+	int id;	/* Raw id of this channel */
+	char dev_id[16];	/* unique name per DMAC of channel */
+
+	/* Set chcr */
+	int (*set_chcr)(struct sh_dmae_chan *sh_chan, u32 regs);

This set up call from a device using dmaengine, and data appoint aligning it.

Best regards,
  Nobuhiro
-- 
Nobuhiro Iwamatsu

