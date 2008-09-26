From: Pawel MOLL <pawel.moll@st.com>
Date: Fri, 26 Sep 2008 11:25:17 +0000
Subject: Re: [alsa-devel] Audio buffer mmap-ing on sh arch vs.
Message-Id: <1222428317.28498.74.camel@bri1004.bri.st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1220527434.3299.2074.camel@bri1004.bri.st.com>
	<s5h63owgdk1.wl%tiwai@suse.de>
	<1222354553.28498.30.camel@bri1004.bri.st.com>
	<s5hbpybcjfc.wl%tiwai@suse.de>  <20080926103045.GA18874@linux-sh.org>
In-Reply-To: <20080926103045.GA18874@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal@linux-sh.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org

> > IIRC, a similar buffer handling (via vmalloc) is used in video
> > drivers.  I suppose they don't work as well, right?

Well, our FB driver is aware of the problem. I can't say much about
other ones...

> > DRM driver uses __vmalloc() with PAGE_KERNEL_NOCACHE, but it's only
> > for PPC32 non-coherent.

Hm. PPC with non-coherent cache?

/*
 * Only on coherent architectures, we can mmap the status and the control r=
ecords
 * for effcient data transfer.  On others, we have to use HWSYNC ioctl...
 */
#if defined(CONFIG_X86) || defined(CONFIG_PPC) || defined(CONFIG_ALPHA)
                                   ^^^^^^^^^^
/*
 * mmap status record
 */
static struct page * snd_pcm_mmap_status_nopage(struct vm_area_struct *area,
                                                unsigned long address, int =
*type)

> x86 does it also, via its PAGE_AGP definition.
>=20
> There are not that many platforms that define PAGE_KERNEL_NOCACHE though,
> so this gets a bit messy..

Oh, bloody hell, I haven't realised that!

> Yeah, that's not sexy, but maybe the only working case right now
> > (better with arch-specific ifdefs).

The question is what ifdefs to use ;-) Because the cached/uncached
decision must be consistent between snd_pcm_default_mmap() and buffer
allocation...

What a mess! ;-)

Pawe=C5=82

