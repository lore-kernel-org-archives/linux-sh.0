From: Christoph Hellwig <hch@lst.de>
Date: Sun, 28 Jun 2020 07:24:46 +0000
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Message-Id: <20200628072446.GB16344@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200626080717.1999041-1-hch@lst.de> <20200626080717.1999041-10-hch@lst.de> <e908f620-62b8-f106-a1a8-9887f50216fd@landley.net>
In-Reply-To: <e908f620-62b8-f106-a1a8-9887f50216fd@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 08:01:17PM -0500, Rob Landley wrote:
> On 6/26/20 3:07 AM, Christoph Hellwig wrote:
> > The code handling non-coherent DMA depends on being able to remap code
> > as non-cached.  But that can't be done without an MMU, so using this
> > option on NOMMU builds is broken.
> 
> I'm working on a nommu j-core board that's doing DMA behind the OS's back at the
> moment, which I have a todo item to teach the kernel about. The DMA does not go
> through the cache, there's currently a cache flush before looking at the result
> instead.
> 
> How should this be wired up after your patch?

The problem with nommu and non-coherent dma is the dma_alloc_coherent
calls.  Most platforms with an mmu set a nocache bit through the page
tables (including sh), but that option obviously doesn't exist for
nommu.  Some hardware has an uncached window where access is uncached
automatically if access through specific kernel virtual addresses,
for that the architecture needs to impement the arch_dma_set_uncached
helper and select CONFIG_ARCH_HAS_DMA_SET_UNCACHED.  If that also
doesn't exist you'll need some sort of pool of always uncached
memory (set by the firmware or early startup code).  That currently
doesn't exist in generic code, but we have a bunch of architectures
implementing that in arch_dma_alloc.  I plan to have a common
implementation of the pool soon hopefully.

Streaming DMA just works if you reuse the existing
arch_sync_dma_for_device implementation.
