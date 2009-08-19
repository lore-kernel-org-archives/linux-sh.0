From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 19 Aug 2009 12:39:06 +0000
Subject: Re: [PATCH 1/3] Add SuperH FSI driver support for ALSA
Message-Id: <s5hvdkkasgl.wl%tiwai@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <uljlg59ls.wl%morimoto.kuninori@renesas.com>
	<20090819122801.GC20227@rakim.wolfsonmicro.main>
In-Reply-To: <20090819122801.GC20227@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

At Wed, 19 Aug 2009 13:28:01 +0100,
Mark Brown wrote:
> 
> > +			 struct snd_pcm_hw_params *hw_params)
> > +{
> > +	return snd_pcm_lib_malloc_pages(substream,
> > +					params_buffer_bytes(hw_params));
> > +}
> 
> hw_params() may be called multiple times per stream, especially if OSS
> emulation is used.  This would lead to memory leaks since if more pages
> need to be allocaeted the old buffer won't be freed.  Simply calling
> free_pages() before malloc_pages() should plug this leak - free_pages()
> will check to see if anything was allocated.

Note that it's snd_pcm_lib_malloc_pages(), not the kernel's standard
one like alloc_pages().  The former frees the old buffer by itself
when resized, so you don't need to call snd_pcm_lib_free_pages()
(as long as it's called in hw_free callback).


thanks,

Takashi
