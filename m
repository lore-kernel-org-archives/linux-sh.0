From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 30 Mar 2009 23:10:43 +0000
Subject: Re: [PATCH] snd: aica - fix annoying compiler warning
Message-Id: <20090330231043.GF19535@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1237154740.6636.4.camel@localhost.localdomain> <s5htz5urnae.wl%tiwai@suse.de> <1237190049.6513.3.camel@localhost.localdomain> <s5hd4chsxt3.wl%tiwai@suse.de>
In-Reply-To: <s5hd4chsxt3.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian McMenamin <adrian@newgolddream.dyndns.info>, Alsa-devel <alsa-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Mon, Mar 16, 2009 at 08:59:20AM +0100, Takashi Iwai wrote:
> At Mon, 16 Mar 2009 07:54:09 +0000,
> Adrian McMenamin wrote:
> > 
> > On Mon, 2009-03-16 at 07:31 +0100, Takashi Iwai wrote:
> > > At Sun, 15 Mar 2009 22:05:40 +0000,
> > > Adrian McMenamin wrote:
> > > > 
> > > > Cast pointer to data member of struct firmware as a void to end an
> > > > annoying compiler warning.
> > > > 
> > > > fix annoying compiler warning
> > > > 
> > > > Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> > > > ---
> > > > 
> > > > diff --git a/sound/sh/aica.c b/sound/sh/aica.c
> > > > index 7c920f3..822b119 100644
> > > > --- a/sound/sh/aica.c
> > > > +++ b/sound/sh/aica.c
> > > > @@ -567,7 +567,7 @@ static int load_aica_firmware(void)
> > > >  		return err;
> > > >  	/* write firware into memory */
> > > >  	spu_disable();
> > > > -	spu_memload(0, fw_entry->data, fw_entry->size);
> > > > +	spu_memload(0, (void *)fw_entry->data, fw_entry->size);
> > > 
> > > IMO, it's better to fix spu_memload() to take const pointer instead of 
> > > cast.
> > > 
> > 
> > If that's what you want I can do that but it adds to kernel bloat by
> > having two functions essentially do the same thing.
> 
> I meant a fix like below...
> 
Is anything happening with this, or should I just ignore it? 

> ---
> diff --git a/sound/sh/aica.c b/sound/sh/aica.c
> index f551233..fad0c47 100644
> --- a/sound/sh/aica.c
> +++ b/sound/sh/aica.c
> @@ -119,10 +119,10 @@ static void spu_memset(u32 toi, u32 what, int length)
>  }
>  
>  /* spu_memload - write to SPU address space */
> -static void spu_memload(u32 toi, void *from, int length)
> +static void spu_memload(u32 toi, const void *from, int length)
>  {
>  	unsigned long flags;
> -	u32 *froml = from;
> +	const u32 *froml = from;
>  	u32 __iomem *to = (u32 __iomem *) (SPU_MEMORY_BASE + toi);
>  	int i;
>  	u32 val;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
