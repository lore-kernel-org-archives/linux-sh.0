From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 11 Jul 2008 21:33:36 +0000
Subject: Re: [PATCH 03/04] videobuf: Add physically contiguous queue code V2
Message-Id: <Pine.LNX.4.64.0807112307570.26439@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20080705025335.27137.98068.sendpatchset@rx1.opensource.se>
	<20080705025405.27137.16206.sendpatchset@rx1.opensource.se>
	<48737AA3.3080902@teltonika.lt>
In-Reply-To: <48737AA3.3080902@teltonika.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Cc: video4linux-list@redhat.com, linux-sh@vger.kernel.org

On Tue, 8 Jul 2008, Paulius Zaleckas wrote:

> Magnus Damm wrote:
> > This is V2 of the physically contiguous videobuf queues patch.
> > Useful for hardware such as the SuperH Mobile CEU which doesn't
> > support scatter gatter bus mastering.

[snip]

> > +	/* Try to remap memory */
> > +
> > +	size = vma->vm_end - vma->vm_start;
> > +	size = (size < mem->size) ? size : mem->size;
> > +
> > +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > +	retval = remap_pfn_range(vma, vma->vm_start,
> > +				 __pa(mem->vaddr) >> PAGE_SHIFT,
> 
> __pa(mem->vaddr) doesn't work on ARM architecture... It is a long story
> about handling memory allocations and mapping for ARM (there is
> dma_mmap_coherent to deal with this), but there is a workaround:
> 
> mem->dma_handle >> PAGE_SHIFT,
> 
> It is safe to do it this way and also saves some CPU instructions :)

Paulius, even if the story is so long, could you perhaps point us to some 
ML-threads or elaborate a bit? I did find one example in 
drivers/media/video/atmel-isi.c (not in mainline), just would be 
interesting to find out more.

Magnus, have you investigated this further?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
