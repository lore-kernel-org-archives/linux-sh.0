From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 21 Jun 2011 09:01:37 +0000
Subject: Re: [RFC][PATCH 0/5 v3] dmaengine: Add USB-DMAC support
Message-Id: <20110621090130.GI7920@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p8vt0q38g.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p8vt0q38g.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 17, 2011 at 05:19:43PM +0900, Kuninori Morimoto wrote:
> These are v3 of USB-DMAC support prototype for SH7372
> 
> Kuninori Morimoto (6)
>          dmaengine: shdma: add chcr_write/read function
>          dmaengine: shdma: add chcr_ie_bit
>          dmaengine: shdma: add dmaor_is_32bit flag
>          dmaengine: shdma: add is_usbdmac flag

These I've applied to my common/dma topic branch.

>          ARM: mach-shmobile: sh7372: Add USB-DMAC support

This is on rmobile/dma, which is branched off of common/dma.

>          ARM: mach-shmobile: mackerel: Add USB-DMA ID

And this one is pending on the USB merge, so will be pending until then.
