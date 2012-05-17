From: MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
Date: Thu, 17 May 2012 08:31:58 +0000
Subject: Re: ALSA dma_area not utilizing D-cahce
Message-Id: <20120517173158.3b823fb5c58b90cc97368fb9@kanno.co.jp>
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
I am afraid to misunderstand your advice cause my poor english.
I will wait for an answer of Morimoto-san. Is it OK? 


---------- 

MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
KANNO WORKS CO., LTD. JAPAN
TEL 093-436-2330
