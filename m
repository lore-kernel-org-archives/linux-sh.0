From: MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
Date: Mon, 21 May 2012 03:50:15 +0000
Subject: Re: ALSA dma_area not utilizing D-cahce
Message-Id: <20120521125015.7560b668fd8ef2630d233460@kanno.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20120516095123.73abdf103d1ca64996d9c23c@kanno.co.jp>
In-Reply-To: <20120516095123.73abdf103d1ca64996d9c23c@kanno.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org



On Mon, 21 May 2012 12:21:22 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Mon, May 21, 2012 at 11:40:05AM +0900, MASAO TAKAHASHI wrote:
> > 
> > On Mon, 21 May 2012 11:10:04 +0900
> > Paul Mundt <lethal@linux-sh.org> wrote:
> > > > +	offset = area->vm_pgoff << PAGE_SHIFT;
> > > > +	runtime = substream->runtime;
> > > > +	map_size = runtime->dma_bytes;
> > > > +	mp = (unsigned long)runtime->dma_addr;
> > > > +	map = virt_to_page(mp);
> > > > +	mapend = virt_to_page(mp+map_size - 1);
> > > > +	for (ip = map; ip <= mapend; ip++){
> > > > +		SetPageReserved(ip);
> > > > +	}
> > > > +	area->vm_ops = &sh7764_pcm_vm_ops_data;
> > > > +	area->vm_private_data = substream;
> > > > +	area->vm_flags |= VM_IO;
> > > > +	ret = io_remap_pfn_range(area, area->vm_start, mp>>PAGE_SHIFT, 
> > > > +						area->vm_end - area->vm_start,
> > > > area->vm_page_prot);
> > > > +	if (ret ){
> > > > +		pr_debug("sh7764-pcm.c:remap_pfn_range returned EAGAIN\n");
> > > > +		return -EAGAIN;
> > > > +	}
> > > > +	atomic_inc(&substream->mmap_count);
> > > > +	return 0;
> > > > +}
> > > > +
> > > Do you really need this? It looks like you could just use
> > > snd_pcm_lib_mmap_iomem() directly.
> > Is SetPageReserved() not needed ?
> >  
> No, VM_IO on the VMA ensures that no one's going to touch the pages. If
> we switch to using our own VMA for consistent mapping the consistent DMA
> allocator then we would need to take care of it, but this is nothing your
> mmap routine needs to worry about.
OK, I understand
Thanks a lot for you advice.
I'll test my patch.



---------- 

MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
KANNO WORKS CO., LTD. JAPAN
TEL 093-436-2330
