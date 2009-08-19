From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 19 Aug 2009 12:42:07 +0000
Subject: Re: [PATCH 1/3] Add SuperH FSI driver support for ALSA
Message-Id: <20090819124206.GA20838@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <uljlg59ls.wl%morimoto.kuninori@renesas.com>
	<20090819122801.GC20227@rakim.wolfsonmicro.main>
	<s5hvdkkasgl.wl%tiwai@suse.de>
In-Reply-To: <s5hvdkkasgl.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Wed, Aug 19, 2009 at 02:39:06PM +0200, Takashi Iwai wrote:

> Note that it's snd_pcm_lib_malloc_pages(), not the kernel's standard
> one like alloc_pages().  The former frees the old buffer by itself
> when resized, so you don't need to call snd_pcm_lib_free_pages()
> (as long as it's called in hw_free callback).

Oh, so it does - I misread the code as only shrinking an existing
buffer.
