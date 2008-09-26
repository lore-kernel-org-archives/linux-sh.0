From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 26 Sep 2008 12:38:04 +0000
Subject: Re: [alsa-devel] Audio buffer mmap-ing on sh arch vs.	cache	aliasing	problem
Message-Id: <s5hvdwjaxqr.wl%tiwai@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1220527434.3299.2074.camel@bri1004.bri.st.com>
	<s5h63owgdk1.wl%tiwai@suse.de>
	<1222354553.28498.30.camel@bri1004.bri.st.com>
	<s5hbpybcjfc.wl%tiwai@suse.de>
	<20080926103045.GA18874@linux-sh.org>
	<1222428317.28498.74.camel@bri1004.bri.st.com>
In-Reply-To: <1222428317.28498.74.camel@bri1004.bri.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pawel MOLL <pawel.moll@st.com>
Cc: alsa-devel@alsa-project.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

At Fri, 26 Sep 2008 12:25:17 +0100,
Pawel MOLL wrote:
> 
> > > IIRC, a similar buffer handling (via vmalloc) is used in video
> > > drivers.  I suppose they don't work as well, right?
> 
> Well, our FB driver is aware of the problem. I can't say much about
> other ones...

FB driver has some generic API for that, defined in asm/fb.h.

> > > DRM driver uses __vmalloc() with PAGE_KERNEL_NOCACHE, but it's only
> > > for PPC32 non-coherent.
> 
> Hm. PPC with non-coherent cache?
> 
> /*
>  * Only on coherent architectures, we can mmap the status and the control records
>  * for effcient data transfer.  On others, we have to use HWSYNC ioctl...
>  */
> #if defined(CONFIG_X86) || defined(CONFIG_PPC) || defined(CONFIG_ALPHA)
>                                    ^^^^^^^^^^
> /*
>  * mmap status record
>  */
> static struct page * snd_pcm_mmap_status_nopage(struct vm_area_struct *area,
>                                                 unsigned long address, int *type)

Yeah, it's a known problem, and I already have patches.
But, it's still under discussion how to solve it better.
I'm going to post the theme to linux-arch, which James Bottomley and
others suggested in the previous discussions.

> > x86 does it also, via its PAGE_AGP definition.
> > 
> > There are not that many platforms that define PAGE_KERNEL_NOCACHE though,
> > so this gets a bit messy..
> 
> Oh, bloody hell, I haven't realised that!
> 
> > Yeah, that's not sexy, but maybe the only working case right now
> > > (better with arch-specific ifdefs).
> 
> The question is what ifdefs to use ;-) Because the cached/uncached
> decision must be consistent between snd_pcm_default_mmap() and buffer
> allocation...

Right.  Both must have matching ifdefs.  The vmalloc buffer handling
can be in sound/core common part, so that it won't be scattered in
different sub directories.

Or, let's define a common generic API (oh let me dream on)

> What a mess! ;-)

Indeed ;)


Takashi
