From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 May 2012 07:22:41 +0000
Subject: Re: ALSA dma_area not utilizing D-cahce
Message-Id: <20120517072241.GB11623@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20120516095123.73abdf103d1ca64996d9c23c@kanno.co.jp>
In-Reply-To: <20120516095123.73abdf103d1ca64996d9c23c@kanno.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 17, 2012 at 02:16:21PM +0900, MASAO TAKAHASHI wrote:
> On Wed, 16 May 2012 14:38:57 +0900
> Paul Mundt <lethal@linux-sh.org> wrote:
> > There are a couple of places that need to be fixed. At a quick glance:
> > 
> > 	- snd_pcm_default_page_ops()
> > 	- snd_pcm_lib_default_mmap()
> > 
> > Both are in need of fixing up.
> > 
> > The snd_pcm_default_page_ops() case is easy, as we can use the same
> > approach that MIPS does (sh also provides a CAC_ADDR definition).
> > 
> > The snd_pcm_lib_default_mmap() case is a bit more involved. The last time
> > this topic came up a generic pgprot_noncached() solution was stalled as
> > pgprot_noncached() wasn't available on all of the platforms. That's been
> > addressed now, so it may be worth revisiting.
> > 
> > At present the biggest problem with fixing up the default mmap behaviour
> > is that we don't have any easy way for working out the coherence model on
> > a struct device level. ie, we may have snooping enabled on the PCI side
> > for device<->memory coherence while at the same time being non-coherent
> > for the L1 D-cache case at the platform device level.
> > 
> > There also exists a snd_pcm_lib_mmap_iomem() now that handles the
> > pgprot_noncached() case which you might be able to use with your driver.
> > 
> > That being said, P2SEGADDR is non-portable legacy garbage -- drivers
> > should never use it directly. Unfortunately we don't have any easy way to
> > use it in the headers while forcibly blowing up the build for anything
> > else.
> 
> Do you advice to use snd_pcm_mmap_writei() call?
> I think that the mmap method is used when dmix or snd_pcm_mmap_writei()
>  or dsnoop/snd_pcm_mmap_readi().
> I am using snd_pcm_writei() call.
> Then I could not use these  functions as below.
>   - snd_pcm_default_page_ops()
>   - snd_pcm_lib_default_mmap()
> 
I have no idea how the userspace library works, so you'll need to ask
ALSA folks about that.

> Please advice me another one.
> 
> I think that runtime->dma_area address accesses into D-cache.
> Is it right?
> Is the runtime->dma_area address is a paging object ?
>  
This is going to depend entirely on your driver. If your driver is
deciding to use a vmalloc backed area, then yes, it will be cached. If
you are obtaining your memory from vmalloc then that's going to reside in
P3SEG on legacy paltforms anyways, so P2SEGADDR isn't going to help you
regardless.

If you need a consistent DMA mapping in your driver make sure you are
using SNDRV_DMA_TYPE_DEV. I notice the fsi driver has this comment:

        /*
         * dont use SNDRV_DMA_TYPE_DEV, since it will oops the SH kernel
         * in MMAP mode (i.e. aplay -M)
         */

which suggests that someone was lazy and trying to avoid fixing up the
aforementioned snd_pcm_default_page_ops/snd_pcm_lib_default_mmap cases.

I've added Morimoto-san to the Cc, as I'm definitely the wrong person to ask
about anything involving alsa drivers.
