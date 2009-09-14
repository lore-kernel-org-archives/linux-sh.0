From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 14 Sep 2009 13:02:01 +0000
Subject: Re: [PATCH 1/2] sh: add kycr2_delay for sh_keysc
Message-Id: <20090914130200.GA21091@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <u1vm9g48g.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u1vm9g48g.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 14, 2009 at 08:22:55PM +0900, Kuninori Morimoto wrote:
> After KYCR2 is set, udelay  might become necessary
> when the connected KEY is few.
> This patch add kycr2_delay for this problem.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/include/asm/sh_keysc.h    |    1 +
>  drivers/input/keyboard/sh_keysc.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sh/include/asm/sh_keysc.h b/arch/sh/include/asm/sh_keysc.h
> index b5a4dd5..4a65b1e 100644
> --- a/arch/sh/include/asm/sh_keysc.h
> +++ b/arch/sh/include/asm/sh_keysc.h
> @@ -7,6 +7,7 @@ struct sh_keysc_info {
>  	enum { SH_KEYSC_MODE_1, SH_KEYSC_MODE_2, SH_KEYSC_MODE_3 } mode;
>  	int scan_timing; /* 0 -> 7, see KYCR1, SCN[2:0] */
>  	int delay;
> +	int kycr2_delay;
>  	int keycodes[SH_KEYSC_MAXKEYS];
>  };
>  
> diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
> index cea70e6..2080f60 100644
> --- a/drivers/input/keyboard/sh_keysc.c
> +++ b/drivers/input/keyboard/sh_keysc.c
> @@ -79,6 +79,7 @@ static irqreturn_t sh_keysc_isr(int irq, void *dev_id)
>  		iowrite16(0, priv->iomem_base + KYOUTDR_OFFS);
>  		iowrite16(KYCR2_IRQ_LEVEL | (keyin_set << 8),
>  			  priv->iomem_base + KYCR2_OFFS);
> +		udelay(pdata->kycr2_delay);
>  
>  		keys ^= ~0;
>  		keys &= (1 << (sh_keysc_mode[pdata->mode].keyin *

Shouldn't this be something like

	if (pdata->kycr2_delay)
		udelay(..)

it doesn't really make much sense to default to a udelay(0) for everyone.
