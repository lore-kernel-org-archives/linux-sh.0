From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 10 Mar 2009 07:23:52 +0000
Subject: Re: [PATCH v2] sh: Update dma-sh api
Message-Id: <20090310072352.GG10393@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49B5D5E4.4060801@renesas.com>
In-Reply-To: <49B5D5E4.4060801@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 10, 2009 at 04:22:37PM +0900, Nobuhiro Iwamatsu wrote:
> Paul Mundt wrote:
> >On Tue, Mar 10, 2009 at 01:48:14PM +0900, Nobuhiro Iwamatsu wrote:
> >>diff --git a/arch/sh/include/asm/dma.h b/arch/sh/include/asm/dma.h
> >>index beca712..085e05a 100644
> >>--- a/arch/sh/include/asm/dma.h
> >>+++ b/arch/sh/include/asm/dma.h
> >>@@ -23,12 +23,8 @@
> >> /* But... */
> >> /* XXX: This is not applicable to SuperH, just needed for alloc_bootmem 
> >> */
> >> #define MAX_DMA_ADDRESS		(PAGE_OFFSET+0x10000000)
> >>-
> >>-#ifdef CONFIG_NR_DMA_CHANNELS
> >>-#  define MAX_DMA_CHANNELS	(CONFIG_NR_DMA_CHANNELS)
> >>-#else
> >>-#  define MAX_DMA_CHANNELS	(CONFIG_NR_ONCHIP_DMA_CHANNELS)
> >>-#endif
> >>+/* MAX DMA Channel */
> >>+#define MAX_DMA_CHANNELS	(CONFIG_NR_ONCHIP_DMA_CHANNELS)
> 
> Thank you for your comments.
> 
> 
> >>
> >This breaks the Dreamcast, which contains multiple DMACs and needs more
> >than the on-chip channels managed by the DMA API. As the Dreamcast is the
> >primary user of this code, please make sure you do not break its use of
> >the API. It would also be good if someone can verify whether the G2 and
> >PVR2 DMA still work after this patch is applied.
> 
> OK. I will fix this point.
> >
> >On the other hand, I don't know how much we really want to be doing here
> >in the first place. All new development should be happening on the
> >dmaengine API instead, this code is mostly for keeping the existing users
> >limping along, and not much else. Matt Fleming was doing some work there,
> >it would be preferable to see that code updated and merged rather than
> >work spent on the old DMA API.
> >
> 
> I see.
> I have already been writing the driver of DMAengine, and I am testing.
> To make old DMA-API coexist with dma engine in these patches, I wrote.
> 
Ah, ok, I wasn't aware that that was what your intention was. In that
case, once the Dreamcast fallout is fixed, I'll merge these.
