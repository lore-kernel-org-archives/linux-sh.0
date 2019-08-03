From: Takashi Iwai <tiwai@suse.de>
Date: Sat, 03 Aug 2019 11:22:09 +0000
Subject: Re: [PATCH 5/5] dma-mapping: remove ARCH_NO_COHERENT_DMA_MMAP
Message-Id: <s5himreqyse.wl-tiwai@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190725063401.29904-1-hch@lst.de>
 <20190725063401.29904-6-hch@lst.de> <20190802070354.GA8280@lst.de>
 <s5hh870rn4t.wl-tiwai@suse.de> <20190803103024.GA32624@lst.de>
In-Reply-To: <20190803103024.GA32624@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Robin Murphy <robin.murphy@arm.com>, x86@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>

On Sat, 03 Aug 2019 12:30:24 +0200,
Christoph Hellwig wrote:
> 
> On Fri, Aug 02, 2019 at 10:24:02AM +0200, Takashi Iwai wrote:
> > I wasn't careful enough to look at that change, sorry.
> > 
> > The code there tries to check whether dma_mmap_coherent() would always
> > fail on some platforms.  Then the driver clears the mmap capability
> > flag at the device open time and notifies user-space to fall back to
> > the dumb read/write mode.
> > 
> > So I'm afraid that simply dropping the check would cause the behavior
> > regression, e.g. on PARISC.
> > 
> > Is there any simple way to test whether dma_mmap_coherent() would work
> > or not in general on the target platform?  It's not necessarily in an
> > ifdef at all.
> 
> This isn't really a platform, but a per-device question.  I can add a
> "bool dma_can_mmap(struct device *dev)" helper to check that.

Yes, this would fit perfect.

> But how
> do I get at a suitable struct device in hw_support_mmap()?

substream->dma_buffer.dev.dev can be that, which is used in the mmap
helper side, snd_pcm_lib_default_mmap().


Thanks!

Takashi
