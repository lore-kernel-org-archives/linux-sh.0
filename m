From: Christoph Hellwig <hch@lst.de>
Date: Tue, 30 Jul 2019 06:26:51 +0000
Subject: Re: [PATCH 4/5] dma-mapping: provide a better default ->get_required_mask
Message-Id: <20190730062651.GA29518@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190725063401.29904-1-hch@lst.de>
 <20190725063401.29904-5-hch@lst.de>
 <CAMuHMdUBPj8AVSuDwaBB_4gRD6k7vzo0WAFJEkTUbxSw31bzUg@mail.gmail.com>
In-Reply-To: <CAMuHMdUBPj8AVSuDwaBB_4gRD6k7vzo0WAFJEkTUbxSw31bzUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Parisc List <linux-parisc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, the arch/x86 maintainers <x86@kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>

On Mon, Jul 29, 2019 at 11:57:19AM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Thu, Jul 25, 2019 at 8:35 AM Christoph Hellwig <hch@lst.de> wrote:
> > Most dma_map_ops instances are IOMMUs that work perfectly fine in 32-bits
> > of IOVA space, and the generic direct mapping code already provides its
> > own routines that is intelligent based on the amount of memory actually
> > present.  Wire up the dma-direct routine for the ARM direct mapping code
> > as well, and otherwise default to the constant 32-bit mask.  This way
> > we only need to override it for the occasional odd IOMMU that requires
> > 64-bit IOVA support, or IOMMU drivers that are more efficient if they
> > can fall back to the direct mapping.
> 
> As I know you like diving into cans of worms ;-)
> 
> Does 64-bit IOVA support actually work in general? Or only on 64-bit
> platforms, due to dma_addr_t to unsigned long truncation on 32-bit?

Most IOMMUs use 32-bit IOVAs, and thus we default to the 32-bit mask
because it is common and failsafe vs the normal linux assumptions.
However the ia64 SGI SN2 platform, and the powerpc IBM ebus
implementations seem to require a 64-bit mask already, so we keep that
behavior as is.
