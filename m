From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 16 Feb 2010 21:51:46 +0000
Subject: Re: [PATCH] tmio_mmc: keep card-detect interrupts enabled
Message-Id: <20100216135146.beacf701.akpm@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0911061127240.4389@axis700.grange>
	<c09aa50a0911090242l35d0dfb2vec0cdeff8b86d33e@mail.gmail.com>
	<Pine.LNX.4.64.0911091530030.4289@axis700.grange>
	<c09aa50a0911091218i681449e0r5cb96b9db3e0def6@mail.gmail.com>
	<Pine.LNX.4.64.0911092134440.4289@axis700.grange>
	<c09aa50a0911091736k27d66483t9012e296bfbf578a@mail.gmail.com>
	<Pine.LNX.4.64.0911282002490.3696@axis700.grange>
	<Pine.LNX.4.64.0912162223170.5283@axis700.grange>
	<Pine.LNX.4.64.0912172113510.5991@axis700.grange>
	<20091217131239.0dfd5534.akpm@linux-foundation.org>
	<Pine.LNX.4.64.1002161028200.4778@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002161028200.4778@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <damm@opensource.se>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, 16 Feb 2010 10:34:55 +0100 (CET)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> On SuperH platforms the SDHI controller does not produce any command IRQs after
> a completed IO. This leads to card-detect interrupts staying disabled. Do not
> disable card-detect interrupts on DATA IRQs.
> 

Why is the current code disabling card-detect interrupts on DATA IRQs? 
Was that just a bug?

What effect will this change have for current users of this driver?


> ---
> On Thu, 17 Dec 2009, Andrew Morton wrote:
> 
> > On Thu, 17 Dec 2009 21:25:52 +0100 (CET)
> > Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > 
> > > I originally submitted this [1] patch on the 6th of November, then 
> > > accidentally the MMC list got dropped from CC and the discussion moved to 
> > > another irrelevant list, Ian's last reply is at [2]. Unfortunately, Ian 
> > > hasn't replied to my reminders since then, and I don't see this patch 
> > > anywhere upstream. Is there any way we could get it into 2.6.33?
> > 
> > Please redo and retest it against curent mainline and do a full resend.
> 
> Re-testing this patch has again become possible now, after Magnus has 
> posted his INTC and the "tmio_mmc: use 100ms mmc_detect_change() delay" 
> patches. Successfully tested on Migo-R (sh7722) and MS7724SE (sh7724). 
> Andrew, please apply.
> 
>  drivers/mmc/host/tmio_mmc.h |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 692dc23..dafecfb 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -55,10 +55,8 @@
>  /* Define some IRQ masks */
>  /* This is the mask used at reset by the chip */
>  #define TMIO_MASK_ALL           0x837f031d
> -#define TMIO_MASK_READOP  (TMIO_STAT_RXRDY | TMIO_STAT_DATAEND | \
> -		TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT)
> -#define TMIO_MASK_WRITEOP (TMIO_STAT_TXRQ | TMIO_STAT_DATAEND | \
> -		TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT)
> +#define TMIO_MASK_READOP  (TMIO_STAT_RXRDY | TMIO_STAT_DATAEND)
> +#define TMIO_MASK_WRITEOP (TMIO_STAT_TXRQ | TMIO_STAT_DATAEND)
>  #define TMIO_MASK_CMD     (TMIO_STAT_CMDRESPEND | TMIO_STAT_CMDTIMEOUT | \
>  		TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT)
>  #define TMIO_MASK_IRQ     (TMIO_MASK_READOP | TMIO_MASK_WRITEOP | TMIO_MASK_CMD)
> -- 
> 1.6.2.4
