From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Jul 2008 03:48:50 +0000
Subject: Re: [PATCH 03/04] videobuf: Add physically contiguous queue code V2
Message-Id: <20080715034850.GA3722@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080705025405.27137.16206.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080705025405.27137.16206.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 14, 2008 at 12:51:55PM +0900, Magnus Damm wrote:
> Both (__pa(mem->vaddr) >> PAGE_SHIFT) and (mem->dma_handle >>
> PAGE_SHIFT) work well with the current dma_alloc_coherent()
> implementation on SuperH. I do however lean towards using
> __pa(mem->vaddr) over mem->dma_handle, since I suspect that
> mem->dma_handle doesn't have to be a physical address.
> 
> Paul, any thoughts about this? Can we assume that the dma_handle
> returned from dma_alloc_coherent() is a physical address, or is it
> better to use __pa() on the virtual address to get the pfn?
> 
It's a physical address as far as the dma_handle users are concerned, how
that actually translates across the bus is another matter. (The corner
cases end up being things like Cell that DMA in to virtual addresses via
IOMMU translations).

Documentation/DMA-API.txt simply states:

	This routine allocates a region of <size> bytes of consistent memory.
	It also returns a <dma_handle> which may be cast to an unsigned
	integer the same width as the bus and used as the physical address
	base of the region.

so as far as we are concerned, using dma_handle is saner than going the __pa()
route.
