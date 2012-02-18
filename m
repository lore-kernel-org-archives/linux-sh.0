From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 18 Feb 2012 02:20:22 +0000
Subject: Re: [PATCH v2 3/7] mtd: sh_flctl: Expand the READID command to 8 bytes
Message-Id: <5473968.KjMqXsbqus@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
 <1328960705-18699-4-git-send-email-hechtb@gmail.com>
In-Reply-To: <1328960705-18699-4-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Hi Bastian,

Thanks for the patch.

On Saturday 11 February 2012 12:45:01 Bastian Hecht wrote:
> The nand base code wants to read out 8 bytes in the READID command.
> Reflect this in the driver code.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
> ---
> changelog: exactly same as patch v1.
> 
>  drivers/mtd/nand/sh_flctl.c |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
> index 8c97367..407acb5 100644
> --- a/drivers/mtd/nand/sh_flctl.c
> +++ b/drivers/mtd/nand/sh_flctl.c
> @@ -320,6 +320,7 @@ static void set_cmd_regs(struct mtd_info *mtd, uint32_t
> cmd, uint32_t flcmcdr_va break;
>  	case NAND_CMD_READID:
>  		flcmncr_val &= ~SNAND_E;
> +		flcmdcr_val |= CDSRC_E;

this bit is marked as reserved in my SH7372 documentation, and should be set 
to 0. Won't this break compatibility with the SH7372 ?

>  		addr_len_bytes = ADRCNT_1;
>  		break;
>  	case NAND_CMD_STATUS:
> @@ -559,12 +560,18 @@ static void flctl_cmdfunc(struct mtd_info *mtd,
> unsigned int command,
> 
>  	case NAND_CMD_READID:
>  		set_cmd_regs(mtd, command, command);
> -		set_addr(mtd, 0, 0);
> 
> -		flctl->read_bytes = 4;
> +		/* READID is always performed using an 8-bit bus */
> +		if (flctl->chip.options & NAND_BUSWIDTH_16)
> +			column <<= 1;
> +		set_addr(mtd, column, 0);
> +
> +		flctl->read_bytes = 8;
>  		writel(flctl->read_bytes, FLDTCNTR(flctl)); /* set read size */
> +		empty_fifo(flctl);
>  		start_translation(flctl);
> -		read_datareg(flctl, 0);	/* read and end */
> +		read_fiforeg(flctl, flctl->read_bytes, 0);

Not saying it's a bad thing, but why do you switch from read_datareg() to 
read_fiforeg() ?

> +		wait_completion(flctl);
>  		break;
> 
>  	case NAND_CMD_ERASE1:
-- 
Regards,

Laurent Pinchart
