From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Date: Mon, 14 Jul 2008 09:25:29 +0000
Subject: Re: [PATCH 03/04] videobuf: Add physically contiguous queue code
Message-Id: <487B1B89.2030109@teltonika.lt>
List-Id: <linux-sh.vger.kernel.org>
References: <20080705025335.27137.98068.sendpatchset@rx1.opensource.se>	
	<20080705025405.27137.16206.sendpatchset@rx1.opensource.se>	
	<48737AA3.3080902@teltonika.lt>	
	<Pine.LNX.4.64.0807112307570.26439@axis700.grange>
	<aec7e5c30807132051r16e51d71w177e410063ccefb@mail.gmail.com>
In-Reply-To: <aec7e5c30807132051r16e51d71w177e410063ccefb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: video4linux-list@redhat.com
Cc: linux-sh@vger.kernel.org

Magnus Damm wrote:
> On Sat, Jul 12, 2008 at 6:33 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
>> On Tue, 8 Jul 2008, Paulius Zaleckas wrote:
>>
>>> Magnus Damm wrote:
>>>> This is V2 of the physically contiguous videobuf queues patch.
>>>> Useful for hardware such as the SuperH Mobile CEU which doesn't
>>>> support scatter gatter bus mastering.
>> [snip]
>>
>>>> +   /* Try to remap memory */
>>>> +
>>>> +   size = vma->vm_end - vma->vm_start;
>>>> +   size = (size < mem->size) ? size : mem->size;
>>>> +
>>>> +   vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>>> +   retval = remap_pfn_range(vma, vma->vm_start,
>>>> +                            __pa(mem->vaddr) >> PAGE_SHIFT,
>>> __pa(mem->vaddr) doesn't work on ARM architecture... It is a long story
>>> about handling memory allocations and mapping for ARM (there is
>>> dma_mmap_coherent to deal with this), but there is a workaround:
>>>
>>> mem->dma_handle >> PAGE_SHIFT,
>>>
>>> It is safe to do it this way and also saves some CPU instructions :)
>> Paulius, even if the story is so long, could you perhaps point us to some
>> ML-threads or elaborate a bit? I did find one example in
>> drivers/media/video/atmel-isi.c (not in mainline), just would be
>> interesting to find out more.
>>
>> Magnus, have you investigated this further?
> 
> Both (__pa(mem->vaddr) >> PAGE_SHIFT) and (mem->dma_handle >>
> PAGE_SHIFT) work well with the current dma_alloc_coherent()
> implementation on SuperH. I do however lean towards using
> __pa(mem->vaddr) over mem->dma_handle, since I suspect that
> mem->dma_handle doesn't have to be a physical address.
> 
> Paul, any thoughts about this? Can we assume that the dma_handle
> returned from dma_alloc_coherent() is a physical address, or is it
> better to use __pa() on the virtual address to get the pfn?

Well dma_alloc_coherent() is supposed to return physically contiguous
memory physical address in dma_handle... Quick look at LXR didn't show
any architecture where it shouldn't work... but it showed that ARM and
possibly FRV(?) won't work with __pa() since these architectures are
allocating from different memory pool than kmalloc()

