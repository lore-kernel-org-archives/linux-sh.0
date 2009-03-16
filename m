From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 16 Mar 2009 07:54:09 +0000
Subject: Re: [PATCH] snd: aica - fix annoying compiler warning
Message-Id: <1237190049.6513.3.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1237154740.6636.4.camel@localhost.localdomain>
	 <s5htz5urnae.wl%tiwai@suse.de>
In-Reply-To: <s5htz5urnae.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Mon, 2009-03-16 at 07:31 +0100, Takashi Iwai wrote:
> At Sun, 15 Mar 2009 22:05:40 +0000,
> Adrian McMenamin wrote:
> > 
> > Cast pointer to data member of struct firmware as a void to end an
> > annoying compiler warning.
> > 
> > fix annoying compiler warning
> > 
> > Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> > ---
> > 
> > diff --git a/sound/sh/aica.c b/sound/sh/aica.c
> > index 7c920f3..822b119 100644
> > --- a/sound/sh/aica.c
> > +++ b/sound/sh/aica.c
> > @@ -567,7 +567,7 @@ static int load_aica_firmware(void)
> >  		return err;
> >  	/* write firware into memory */
> >  	spu_disable();
> > -	spu_memload(0, fw_entry->data, fw_entry->size);
> > +	spu_memload(0, (void *)fw_entry->data, fw_entry->size);
> 
> IMO, it's better to fix spu_memload() to take const pointer instead of 
> cast.
> 

If that's what you want I can do that but it adds to kernel bloat by
having two functions essentially do the same thing.

