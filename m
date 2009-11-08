From: Takashi Iwai <tiwai@suse.de>
Date: Sun, 08 Nov 2009 08:14:57 +0000
Subject: Re: [PATCH 75/75] snd-aica: declare MODULE_FIRMWARE
Message-Id: <s5haayxtou6.wl%tiwai@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1257632019.15927.512.camel@localhost>
In-Reply-To: <1257632019.15927.512.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Hutchings <ben@decadent.org.uk>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org

At Sat, 07 Nov 2009 22:13:39 +0000,
Ben Hutchings wrote:
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Applied now.  Thanks.


Takashi

> ---
>  sound/sh/aica.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/sh/aica.c b/sound/sh/aica.c
> index 583a369..a0df401 100644
> --- a/sound/sh/aica.c
> +++ b/sound/sh/aica.c
> @@ -49,6 +49,7 @@ MODULE_AUTHOR("Adrian McMenamin <adrian@mcmen.demon.co.uk>");
>  MODULE_DESCRIPTION("Dreamcast AICA sound (pcm) driver");
>  MODULE_LICENSE("GPL");
>  MODULE_SUPPORTED_DEVICE("{{Yamaha/SEGA, AICA}}");
> +MODULE_FIRMWARE("aica_firmware.bin");
>  
>  /* module parameters */
>  #define CARD_NAME "AICA"
> -- 
> 1.6.5.2
> 
> 
