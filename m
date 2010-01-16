From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 16 Jan 2010 10:20:36 +0000
Subject: Re: [alsa-devel] Audio buffer mmap-ing on sh arch vs.	cache	aliasing	problem
Message-Id: <20100116102036.GA32696@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1220527434.3299.2074.camel@bri1004.bri.st.com> <s5h63owgdk1.wl%tiwai@suse.de> <1222354553.28498.30.camel@bri1004.bri.st.com> <s5hbpybcjfc.wl%tiwai@suse.de> <20100115000417.GF25018@linux-sh.org> <s5haawel607.wl%tiwai@suse.de>
In-Reply-To: <s5haawel607.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pawel MOLL <pawel.moll@st.com>, linux-sh@vger.kernel.org

On Sat, Jan 16, 2010 at 11:05:12AM +0100, Takashi Iwai wrote:
> At Fri, 15 Jan 2010 09:04:17 +0900,
> Paul Mundt wrote:
> > 
> > On Fri, Sep 26, 2008 at 12:04:23PM +0200, Takashi Iwai wrote:
> > > At Thu, 25 Sep 2008 15:55:53 +0100,
> > > Pawel MOLL wrote:
> > > > 
> > > > > One thing we can try is a patch like below.  But, I'm not sure whether
> > > > > this is correct over all architectures, too.  At best, a generic API
> > > > > would be helpful for such a thing...
> > > > > +	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
> > > > 
> > > > Well, it's not enough, because the kernel mapping of buffer is still
> > > > cached... A hack below does the job, but it is not nice as well...
> > > 
> > > Yeah, that's not sexy, but maybe the only working case right now
> > > (better with arch-specific ifdefs).
> > > 
> > > IIRC, a similar buffer handling (via vmalloc) is used in video
> > > drivers.  I suppose they don't work as well, right?
> > > DRM driver uses __vmalloc() with PAGE_KERNEL_NOCACHE, but it's only
> > > for PPC32 non-coherent.
> > > 
> > To come back to this issue, we don't appear to have made any headway on
> > the vmalloc front, but pgprot_noncached() is now a standard interface
> > provided by all architectures, so the ifdef is no longer needed in the
> > snd_pcm_default_mmap() path.
> 
> Thanks for heading up about this.
> 
> It seems, however, that pgprot_noncached() is still dangerous to apply
> unconditionally, according to MIPS guys.  Some MIPS platforms may freeze
> when this is set to invalid pages.
> 
> So, this should be applied still in an arch-dependent manner...
> Oh well.
> 
Then it is something they will have to fix on their own. It's used by the
generic VM code for VMA writenotify (see mm/mmap.c).
