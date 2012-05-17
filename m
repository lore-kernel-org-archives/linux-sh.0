From: MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
Date: Thu, 17 May 2012 05:16:21 +0000
Subject: Re: ALSA dma_area not utilizing D-cahce
Message-Id: <20120517141621.ec10f16744396632a13add10@kanno.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20120516095123.73abdf103d1ca64996d9c23c@kanno.co.jp>
In-Reply-To: <20120516095123.73abdf103d1ca64996d9c23c@kanno.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Wed, 16 May 2012 14:38:57 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Wed, May 16, 2012 at 09:51:23AM +0900, MASAO TAKAHASHI wrote:
> > Hi everybody. 
> > Please advice me to resolve my problem.
> > 1.  My environment
> >     Hardware	Alpha-project MS104-SH4AG with SH7764
> > 	kernel		sh-linux-2.6.29
> > 2. My problem
> > 	I am ussing a proprietary ALSA driver for SH7764 SSI.
> > 	I have found runtime->dma_area address refers DMA area
> > 	via D-cache.
> > 	So, playback is too late after executing snd_pcm_writei().
> > 	Until D-cache writeback is done, sound data stays in D-cache.
> > 	I want to read and write from/to main memory 
> > 	without D-cache.
> > 
> > 3. My idea to solve this problem
> > 	add some codes in xxx_prepare() routine as follows
> > 	
> > 	save_playback_area = runtime->dma_area;
> > 	runtime->dma_area = P2SEGADDR(runtime->dma_area);
> > 
> > Is my idea right?
> > 
> There are a couple of places that need to be fixed. At a quick glance:
> 
> 	- snd_pcm_default_page_ops()
> 	- snd_pcm_lib_default_mmap()
> 
> Both are in need of fixing up.
> 
> The snd_pcm_default_page_ops() case is easy, as we can use the same
> approach that MIPS does (sh also provides a CAC_ADDR definition).
> 
> The snd_pcm_lib_default_mmap() case is a bit more involved. The last time
> this topic came up a generic pgprot_noncached() solution was stalled as
> pgprot_noncached() wasn't available on all of the platforms. That's been
> addressed now, so it may be worth revisiting.
> 
> At present the biggest problem with fixing up the default mmap behaviour
> is that we don't have any easy way for working out the coherence model on
> a struct device level. ie, we may have snooping enabled on the PCI side
> for device<->memory coherence while at the same time being non-coherent
> for the L1 D-cache case at the platform device level.
> 
> There also exists a snd_pcm_lib_mmap_iomem() now that handles the
> pgprot_noncached() case which you might be able to use with your driver.
> 
> That being said, P2SEGADDR is non-portable legacy garbage -- drivers
> should never use it directly. Unfortunately we don't have any easy way to
> use it in the headers while forcibly blowing up the build for anything
> else.

Do you advice to use snd_pcm_mmap_writei() call?
I think that the mmap method is used when dmix or snd_pcm_mmap_writei()
 or dsnoop/snd_pcm_mmap_readi().
I am using snd_pcm_writei() call.
Then I could not use these  functions as below.
  - snd_pcm_default_page_ops()
  - snd_pcm_lib_default_mmap()

Please advice me another one.

I think that runtime->dma_area address accesses into D-cache.
Is it right?
Is the runtime->dma_area address is a paging object ?
 
Regards
 
   

---------- 
MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
KANNO WORKS CO., LTD. JAPAN
TEL 093-436-2330
