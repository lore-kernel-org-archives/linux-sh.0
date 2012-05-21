From: MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
Date: Mon, 21 May 2012 02:40:05 +0000
Subject: Re: ALSA dma_area not utilizing D-cahce
Message-Id: <20120521114005.2372877b4b9ccf62c2f69768@kanno.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20120516095123.73abdf103d1ca64996d9c23c@kanno.co.jp>
In-Reply-To: <20120516095123.73abdf103d1ca64996d9c23c@kanno.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Mon, 21 May 2012 11:10:04 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Mon, May 21, 2012 at 10:44:14AM +0900, MASAO TAKAHASHI wrote:
> > diff -Nru a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
> > --- a/arch/sh/include/asm/page.h	2012-05-21 09:05:58.556556493 +0900
> > +++ b/arch/sh/include/asm/page.h	2012-05-21 09:14:44.649922912 +0900
> > @@ -136,6 +136,11 @@
> >  #define __pa(x)	((unsigned long)(x)-PAGE_OFFSET)
> >  #define __va(x)	((void *)((unsigned long)(x)+PAGE_OFFSET))
> >  #endif
> > +/* add 2012/5/21 */
> > +#if defined(CONFIG_29BIT)
> > +#define UNCAC_ADDR(addr)	P2SEGADDR(addr)
> > +#define CAC_ADDR(addr)		P1SEGADDR(addr)
> > +#endif
> >  
> >  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
> >  #define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
> 
> Are you using an old kernel? UNCAC_ADDR/CAC_ADDR should already be
> defined in page.h, and do the P2/P1 wrapping for the 29-bit phys case.
Yes, I am using sh-linux-2.6.29.
UNCAC_ADDR/CAC_ADDR is not defined yet.
> 
> > +static int	sh7764_pcm_mmap(struct snd_pcm_substream *substream,
> > +				struct vm_area_struct *area)
> > +{
> ..
> > +#ifdef pgprot_noncached
> > +	/*
> > + 	 * disable non-chahe attribute cause
> > + 	 */ 
> > +	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
> > +#endif
> 
> You don't want the ifdef here. pgprot_noncached() is now part of the
> generic API, so you can always rely on it. It's worse if you don't have
> it defined and suddenly end up with a cached attribute for the VMA that
> you weren't expecting.
I understand. I remove ifdef.
> 
> > +	offset = area->vm_pgoff << PAGE_SHIFT;
> > +	runtime = substream->runtime;
> > +	map_size = runtime->dma_bytes;
> > +	mp = (unsigned long)runtime->dma_addr;
> > +	map = virt_to_page(mp);
> > +	mapend = virt_to_page(mp+map_size - 1);
> > +	for (ip = map; ip <= mapend; ip++){
> > +		SetPageReserved(ip);
> > +	}
> > +	area->vm_ops = &sh7764_pcm_vm_ops_data;
> > +	area->vm_private_data = substream;
> > +	area->vm_flags |= VM_IO;
> > +	ret = io_remap_pfn_range(area, area->vm_start, mp>>PAGE_SHIFT, 
> > +						area->vm_end - area->vm_start,
> > area->vm_page_prot);
> > +	if (ret ){
> > +		pr_debug("sh7764-pcm.c:remap_pfn_range returned EAGAIN\n");
> > +		return -EAGAIN;
> > +	}
> > +	atomic_inc(&substream->mmap_count);
> > +	return 0;
> > +}
> > +
> Do you really need this? It looks like you could just use
> snd_pcm_lib_mmap_iomem() directly.
Is SetPageReserved() not needed ?
 


---------- 
高橋 正雄
MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
KANNO WORKS CO., LTD. JAPAN
TEL 093-436-2330
