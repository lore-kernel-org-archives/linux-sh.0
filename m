From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 21 Sep 2008 01:13:10 +0000
Subject: Re: [alsa-devel] Audio buffer mmap-ing on sh arch vs. cache aliasing	problem
Message-Id: <20080921011310.GB2522@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1220527434.3299.2074.camel@bri1004.bri.st.com> <s5h63owgdk1.wl%tiwai@suse.de>
In-Reply-To: <s5h63owgdk1.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: Pawel MOLL <pawel.moll@st.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org

On Tue, Sep 16, 2008 at 08:18:06PM +0200, Takashi Iwai wrote:
> At Thu, 04 Sep 2008 12:23:54 +0100,
> Pawel MOLL wrote:
> > As a quick-and-dirty work-around I have modified
> > snd_pcm_alloc_vmalloc_buffer() to allocate always 12kB more and then use
> > 16k-aligned pointer:
> > 
> > static int snd_pcm_alloc_vmalloc_buffer(struct snd_pcm_substream *subs, size_t size)
> > {
> >         struct snd_pcm_runtime *runtime = subs->runtime;
> >         if (runtime->dma_addr) {
> >                 if (runtime->dma_bytes >= size)
> >                         return 0; /* already large enough */
> >                 vfree((void *)runtime->dma_addr);
> >         }
> >         runtime->dma_addr = (unsigned long)vmalloc(size + 12 * 1024);
> >         if (!runtime->dma_addr)
> >                 return -ENOMEM;
> >         runtime->dma_area = (void *)ALIGN(runtime->dma_addr, 16 * 1024);
> >         runtime->dma_bytes = size;
> >         return 0;
> > }
> > 
> > Of course it cannot be regarded as anything more as a hack. And
> > definitely not as a solution... So my question is:
> > 
> > Any idea how the "proper solution" should look like? I see no obvious
> > method to get an arch-independent "mmap-compliant" buffer. This problem
> > was found on a sh arch, using an USB Audio Class device, however out
> > there some other architectures are suffering from this MMU "feature" as
> > well (ie. see http://docs.hp.com/en/B3906-90006/ch07s09.html) and
> > possibly other drivers could behave "wrongly" (quoted as the driver is
> > actually innocent...)
> 
> Currently, it's PITA on Linux to get a non-cached mmap properly in a
> generic way.  Especially together with coherent memory allocations,
> there is no API for that.  But, in the case of usb-audio, the problem
> is the vmaloc'ed intermediate buffer, and this could be a bit easier.
> 
> One thing we can try is a patch like below.  But, I'm not sure whether
> this is correct over all architectures, too.  At best, a generic API
> would be helpful for such a thing...
> 
pgprot_noncached() is the closest you will get to a generic API, but it's
true that not every architecture implements it. Given that, you will have
to toss up an #ifdef pgprot_noncached() around it, as seems to already be
the case for snd_pcm_lib_mmap_iomem(). Any sane platform that has
problems in this regard will have to define pgprot_noncached(), and
that's already true for things like /dev/mem today.
