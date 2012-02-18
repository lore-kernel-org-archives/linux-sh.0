From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 18 Feb 2012 02:22:40 +0000
Subject: Re: [PATCH v2 1/7] mtd: sh_flctl: Expand FLCMNCR register bit field
Message-Id: <1554023.Gzzuis43Tg@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
 <1328960705-18699-2-git-send-email-hechtb@gmail.com>
In-Reply-To: <1328960705-18699-2-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Hi Bastian,

Thanks for the patch.

On Saturday 11 February 2012 12:44:59 Bastian Hecht wrote:
> Add support for a new hardware generation. The meaning of some bits
> of the FLCMNCR register changed, so some new defines are added
> parallel to the existing ones to keep backward compatibility.
> 
> The defines allow to choose an appropriate clocking scheme.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> changelog: code stays the same, just the description is slightly corrected.
> 
>  include/linux/mtd/sh_flctl.h |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
> index 9cf4c4c..e66c393 100644
> --- a/include/linux/mtd/sh_flctl.h
> +++ b/include/linux/mtd/sh_flctl.h
> @@ -67,6 +67,30 @@
>  #define	CE0_ENABLE	(0x1 << 3)	/* Chip Enable 0 */
>  #define	TYPESEL_SET	(0x1 << 0)
> 
> +/*
> + * Clock settings using the PULSEx registers from FLCMNCR
> + *
> + * Some hardware uses bits called PULSEx instead of FCKSEL_E and QTSEL_E
> + * to control the clock divider used between the High-Speed Peripheral
> Clock + * and the FLCTL internal clock. If so, use CLK_8_BIT_xxx for
> connecting 8 bit + * and CLK_16_BIT_xxx for connecting 16 bit bus bandwith
> NAND chips. For the 16 + * bit version the divider is seperate for the
> pulse width of high and low + * signals.
> + */
> +#define PULSE3	(0x1 << 27)
> +#define PULSE2	(0x1 << 17)
> +#define PULSE1	(0x1 << 15)
> +#define PULSE0	(0x1 << 9)
> +#define CLK_8_BIT_0_5HP			PULSE1
> +#define CLK_8_BIT_1HP			0x0
> +#define CLK_8_BIT_1_5HP			(PULSE1 | PULSE2)
> +#define CLK_8_BIT_2HP			PULSE0
> +#define CLK_8_BIT_3HP			(PULSE0 | PULSE1 | PULSE2)
> +#define CLK_8_BIT_4HP			(PULSE0 | PULSE2)
> +#define CLK_16_BIT_6HP_LOW_2HP_HIGH	PULSE0
> +#define CLK_16_BIT_9HP_LOW_3HP_HIGH	(PULSE0 | PULSE1 | PULSE2)
> +#define CLK_16_BIT_12HP_LOW_4HP_HIGH	(PULSE0 | PULSE2)
> +

This is nitpicking, but you could shorten the names to something like 
CLK_16B_12L_4P (at the expense of readability though). Feel free to ignore 
this.

>  /* FLCMDCR control bits */
>  #define ADRCNT2_E	(0x1 << 31)	/* 5byte address enable */
>  #define ADRMD_E		(0x1 << 26)	/* Sector address access */
-- 
Regards,

Laurent Pinchart
