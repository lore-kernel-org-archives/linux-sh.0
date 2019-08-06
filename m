From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 06 Aug 2019 06:00:11 +0000
Subject: Re: [PATCH 4/7] ALSA: pcm: use dma_can_mmap() to check if a device supports dma_mmap_*
Message-Id: <s5h5znaq1ec.wl-tiwai@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190805091159.7826-5-hch@lst.de>
In-Reply-To: <20190805091159.7826-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 06 Aug 2019 07:29:49 +0200,
Christoph Hellwig wrote:
> 
> On Mon, Aug 05, 2019 at 11:22:03AM +0200, Takashi Iwai wrote:
> > This won't work as expected, unfortunately.  It's a bit tricky check,
> > since the driver may have its own mmap implementation via
> > substream->ops->mmap, and the dma_buffer.dev.dev might point to
> > another object depending on the dma_buffer.dev.type.
> > 
> > So please replace with something like below:
> 
> >From my gut feeling I'd reorder it a bit to make it more clear like
> this:
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/958fccf54d00c16740522f818d23f9350498e911
> 
> if this is fine it'll be in the next version, waiting for a little more
> feedback on the other patches.

Yes, the new one looks good.
Reviewed-by: Takashi Iwai <tiwai@suse.de>


Thanks!

Takashi
