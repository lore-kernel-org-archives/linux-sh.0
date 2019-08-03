From: Christoph Hellwig <hch@lst.de>
Date: Sat, 03 Aug 2019 10:30:24 +0000
Subject: Re: [PATCH 5/5] dma-mapping: remove ARCH_NO_COHERENT_DMA_MMAP
Message-Id: <20190803103024.GA32624@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190725063401.29904-1-hch@lst.de>
 <20190725063401.29904-6-hch@lst.de> <20190802070354.GA8280@lst.de>
 <s5hh870rn4t.wl-tiwai@suse.de>
In-Reply-To: <s5hh870rn4t.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Robin Murphy <robin.murphy@arm.com>, x86@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>

On Fri, Aug 02, 2019 at 10:24:02AM +0200, Takashi Iwai wrote:
> I wasn't careful enough to look at that change, sorry.
> 
> The code there tries to check whether dma_mmap_coherent() would always
> fail on some platforms.  Then the driver clears the mmap capability
> flag at the device open time and notifies user-space to fall back to
> the dumb read/write mode.
> 
> So I'm afraid that simply dropping the check would cause the behavior
> regression, e.g. on PARISC.
> 
> Is there any simple way to test whether dma_mmap_coherent() would work
> or not in general on the target platform?  It's not necessarily in an
> ifdef at all.

This isn't really a platform, but a per-device question.  I can add a
"bool dma_can_mmap(struct device *dev)" helper to check that.  But how
do I get at a suitable struct device in hw_support_mmap()?
