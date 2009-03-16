From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 16 Mar 2009 06:31:53 +0000
Subject: Re: [PATCH] snd: aica - fix annoying compiler warning
Message-Id: <s5htz5urnae.wl%tiwai@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1237154740.6636.4.camel@localhost.localdomain>
In-Reply-To: <1237154740.6636.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

At Sun, 15 Mar 2009 22:05:40 +0000,
Adrian McMenamin wrote:
> 
> Cast pointer to data member of struct firmware as a void to end an
> annoying compiler warning.
> 
> fix annoying compiler warning
> 
> Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> ---
> 
> diff --git a/sound/sh/aica.c b/sound/sh/aica.c
> index 7c920f3..822b119 100644
> --- a/sound/sh/aica.c
> +++ b/sound/sh/aica.c
> @@ -567,7 +567,7 @@ static int load_aica_firmware(void)
>  		return err;
>  	/* write firware into memory */
>  	spu_disable();
> -	spu_memload(0, fw_entry->data, fw_entry->size);
> +	spu_memload(0, (void *)fw_entry->data, fw_entry->size);

IMO, it's better to fix spu_memload() to take const pointer instead of 
cast.


thanks,

Takashi
