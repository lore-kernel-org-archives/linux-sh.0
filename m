From: MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
Date: Mon, 21 May 2012 01:07:19 +0000
Subject: Re: ALSA dma_area not utilizing D-cahce
Message-Id: <20120521100719.f0fd467eb79a90f007bf5673@kanno.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20120516095123.73abdf103d1ca64996d9c23c@kanno.co.jp>
In-Reply-To: <20120516095123.73abdf103d1ca64996d9c23c@kanno.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 17 May 2012 17:03:09 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Thu, May 17, 2012 at 04:51:06PM +0900, MASAO TAKAHASHI wrote:
> > On Thu, 17 May 2012 16:22:41 +0900
> > Paul Mundt <lethal@linux-sh.org> wrote:
> > > On Thu, May 17, 2012 at 02:16:21PM +0900, MASAO TAKAHASHI wrote:
> > > > Is the runtime->dma_area address is a paging object ?
> > > >  
> > > This is going to depend entirely on your driver. If your driver is
> > > deciding to use a vmalloc backed area, then yes, it will be cached. If
> > > you are obtaining your memory from vmalloc then that's going to reside in
> > > P3SEG on legacy paltforms anyways, so P2SEGADDR isn't going to help you
> > > regardless.
> > > 
> > > If you need a consistent DMA mapping in your driver make sure you are
> > > using SNDRV_DMA_TYPE_DEV. I notice the fsi driver has this comment:
> > > 
> > >         /*
> > >          * dont use SNDRV_DMA_TYPE_DEV, since it will oops the SH kernel
> > >          * in MMAP mode (i.e. aplay -M)
> > >          */
> > > 
> > > which suggests that someone was lazy and trying to avoid fixing up the
> > > aforementioned snd_pcm_default_page_ops/snd_pcm_lib_default_mmap cases.
> > > 
> > > I've added Morimoto-san to the Cc, as I'm definitely the wrong person to ask
> > > about anything involving alsa drivers.
> > My driver assigns DMA area as follows.
> > 
> >  snd_pcm_lib_preallocate_pages_for_all(
> >     pcm,
> >     SNDRV_DMA_TYPE_CONTINUOUS,
> >     snd_dma_continuous_data(GFP_KERNEL),
> >     64*1024, 64*1024);
> > So , it does not have SNDRV_DMA_TYPE_DEV type as you said.
> > I have an another idea to use ioremap_nocache as follows.
> >  In xxx_prepare() function in the driver
> >  to add the next codes.
> >       runtime->dma_area = ioremap_nocache
> > 			(virt_to_phys(runtime->dma_area), 64*1024);
> >  Is it good?
> > 
> No, you are basically just duplicating the behaviour of SNDRV_DMA_TYPE_DEV.
> You really want dma_alloc_coherent(), which is what SNDRV_DMA_TYPE_DEV
> gets you. This will map to dma_generic_alloc_coherent() in
> arch/sh/mm/consistent.c, which does what you are trying to do, only
> correctly.
> 
> Your implementation fails to take in to account extant cachelines for
> pages obtained from the page allocator prior to DMA, which is about as
> fun to debug as it sounds.
> 
> Any time you decide to start fighting the API and roll your own thing it
> is going to end badly. The FSI driver gets away with it because it does
> streaming DMA and uses the dma-mapping API correctly.
> 
> Rather than trying to hack around SNDRV_DMA_TYPE_DEV and inventing your
> own interface, your cycles would be better spent trying to figure out
> where SNDRV_DMA_TYPE_DEV goes wrong in the mmap case and sending patches.
> You already have several places to look at to get you started.
I made some changes from the original ALSA driver.
And made a patch as follows.
Is it right ?
Please help me.

diff -Nru a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
--- a/arch/sh/include/asm/page.h	2012-05-21 09:05:58.556556493 +0900
+++ b/arch/sh/include/asm/page.h	2012-05-21 09:14:44.649922912 +0900
@@ -136,6 +136,11 @@
 #define __pa(x)	((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)	((void *)((unsigned long)(x)+PAGE_OFFSET))
 #endif
+/* add 2012/5/21 */
+#if defined(CONFIG_29BIT)
+#define UNCAC_ADDR(addr)	P2SEGADDR(addr)
+#define CAC_ADDR(addr)		P1SEGADDR(addr)
+#endif
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 #define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
diff -Nru a/sound/soc/sh/sh7764-pcm.c b/sound/soc/sh/sh7764-pcm.c
--- a/sound/soc/sh/sh7764-pcm.c	2012-05-21 09:35:51.720808534 +0900
+++ b/sound/soc/sh/sh7764-pcm.c	2012-05-21 09:45:36.027357354 +0900
@@ -639,6 +639,89 @@
 
 	return frames;
 }
+/*
+ * fault callback for mmapping a RAM page
+ */
+static int sh7764_mmap_data_fault(struct vm_area_struct *area,
+						struct vm_fault *vmf)
+{
+	struct snd_pcm_substream *substream = area->vm_private_data;
+	struct snd_pcm_runtime *runtime;
+	unsigned long offset;
+	struct page * page;
+	void *vaddr;
+	size_t dma_bytes;
+	
+	pr_debug("mmap_data_fault\n");
+	if (substream = NULL)
+		return VM_FAULT_SIGBUS;
+	runtime = substream->runtime;
+	offset = vmf->pgoff << PAGE_SHIFT;
+	dma_bytes = PAGE_ALIGN(runtime->dma_bytes);
+	if (offset > dma_bytes - PAGE_SIZE)
+		return VM_FAULT_SIGBUS;
+	if (substream->ops->page) {
+		page = substream->ops->page(substream, offset);
+		if (!page)
+			return VM_FAULT_SIGBUS;
+	} else {
+		vaddr = CAC_ADDR(runtime->dma_area + offset);
+		page = virt_to_page(vaddr);
+	}
+	get_page(page);
+	vmf->page = page;
+	pr_debug("mmap_data_fault:page = %x\n", (unsigned int)page);
+	return 0;
+}
+
+static struct vm_operations_struct sh7764_pcm_vm_ops_data +{
+	.fault =	sh7764_mmap_data_fault,
+};
+
+/****************************************************
+ * 	Title :sh7764_pcm_mmap			*
+ ****************************************************/
+static int	sh7764_pcm_mmap(struct snd_pcm_substream *substream,
+				struct vm_area_struct *area)
+{
+	unsigned long	offset;
+	unsigned long	mp;
+	unsigned long	virt;
+	int				map_size;
+	struct page *map, *mapend, *ip;
+	struct snd_pcm_runtime *runtime;
+	int	ret;
+
+	
+#ifdef pgprot_noncached
+	/*
+ 	 * disable non-chahe attribute cause
+ 	 */ 
+	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
+#endif
+	offset = area->vm_pgoff << PAGE_SHIFT;
+	runtime = substream->runtime;
+	map_size = runtime->dma_bytes;
+	mp = (unsigned long)runtime->dma_addr;
+	map = virt_to_page(mp);
+	mapend = virt_to_page(mp+map_size - 1);
+	for (ip = map; ip <= mapend; ip++){
+		SetPageReserved(ip);
+	}
+	area->vm_ops = &sh7764_pcm_vm_ops_data;
+	area->vm_private_data = substream;
+	area->vm_flags |= VM_IO;
+	ret = io_remap_pfn_range(area, area->vm_start, mp>>PAGE_SHIFT, 
+						area->vm_end - area->vm_start, area->vm_page_prot);
+	if (ret ){
+		pr_debug("sh7764-pcm.c:remap_pfn_range returned EAGAIN\n");
+		return -EAGAIN;
+	}
+	atomic_inc(&substream->mmap_count);
+	return 0;
+}
+
 static struct snd_pcm_ops sh7764_ssidma_ops = {
 	.open		= sh7764_ssidma_open,
 	.close		= sh7764_ssidma_close,
@@ -648,6 +731,7 @@
 	.prepare	= sh7764_prepare,
 	.trigger	= sh7764_trigger,
 	.pointer	= sh7764_pos,
+	.mmap		= sh7764_pcm_mmap,	
 };
 
 static void sh7764_ssidma_free(struct snd_pcm *pcm)


Thanks in advance
---------- 

MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
KANNO WORKS CO., LTD. JAPAN
TEL 093-436-2330
