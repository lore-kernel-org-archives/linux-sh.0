From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 15 Aug 2019 09:25:52 +0000
Subject: Re: [PATCH 7/8] parisc: don't set ARCH_NO_COHERENT_DMA_MMAP
Message-Id: <1565861152.2963.7.camel@HansenPartnership.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190808160005.10325-1-hch@lst.de>
 <20190808160005.10325-8-hch@lst.de>
In-Reply-To: <20190808160005.10325-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vladimir Murzin <vladimir.murzin@arm.com>, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org

On Thu, 2019-08-08 at 19:00 +0300, Christoph Hellwig wrote:
> parisc is the only architecture that sets ARCH_NO_COHERENT_DMA_MMAP
> when an MMU is enabled.  AFAIK this is because parisc CPUs use VIVT
> caches,

We're actually VIPT but the same principle applies.

>  which means exporting normally cachable memory to userspace is
> relatively dangrous due to cache aliasing.
> 
> But normally cachable memory is only allocated by dma_alloc_coherent
> on parisc when using the sba_iommu or ccio_iommu drivers, so just
> remove the .mmap implementation for them so that we don't have to set
> ARCH_NO_COHERENT_DMA_MMAP, which I plan to get rid of.

So I don't think this is quite right.  We have three architectural
variants essentially (hidden behind about 12 cpu types):

   1. pa70xx: These can't turn off page caching, so they were the non
      coherent problem case
   2. pa71xx: These can manufacture coherent memory simply by turning off
      the cache on a per page basis
   3. pa8xxx: these have a full cache flush coherence mechanism.

(I might have this slightly wrong: I vaguely remember the pa71xxlc
variants have some weird cache quirks for DMA as well)

So I think pa70xx we can't mmap.  pa71xx we can provided we mark the
page as uncached ... which should already have happened in the allocate
and pa8xxx which can always mmap dma memory without any special tricks.

James
