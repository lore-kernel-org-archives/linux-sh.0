From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 20 Feb 2013 11:55:57 +0000
Subject: Re: [PATCH 1/3] serial: sh-sci: Add Device Tree probing
Message-Id: <20130220115555.GA3833@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1361298586-30357-2-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1361298586-30357-2-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 19, 2013 at 12:29:44PM -0600, Bastian Hecht wrote:
> +Required properties:
> +- compatible : Should be "renesas,shmobile-sci-hwb-<x>", where <x> denotes a
> +  hardware block version number of the following list - choose it according
> +  to your SoC in use.
> +  1: sh7372, sh73a0, r8a7740
> +  2: r8a7779

This is introducing another layer of arbitrary versioning that pretty
much side-steps all of the existing abstraction that exists for dealing
with block versioning to begin with, so no, this isn't going to fly.
If you want to use version numbering like this, then it should be matched
to the regtype, which handles all possible variations already.

There is also nothing shmobile-specific about any of this, so that should
really be dropped from the string as well.

> index 6147756..4f3613d 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2353,6 +2353,106 @@ static int sci_remove(struct platform_device *dev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +/*
> + * We provide setup data for different hardware block versionis. See
> + * Documentation/devicetree/bindings/tty/serial/renesas,sh-sci-serial.txt
> + * for further information.
> + */
> +static struct plat_sci_port sci_drv_data_hwb_1 = {
> +	.flags		= UPF_BOOT_AUTOCONF,
> +	.scscr		= SCSCR_RE | SCSCR_TE,
> +	.scbrr_algo_id	= SCBRR_ALGO_4,
> +};
> +
> +static struct plat_sci_port sci_drv_data_hwb_2 = {
> +	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
> +	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
> +	.scbrr_algo_id	= SCBRR_ALGO_2,
> +};
> +
While this no doubt works ok for some limited subset of hardware, this
has no place in the driver itself. If you want to use a DT binding, then
this information needs to be represented there somehow, as well.

The rest of it looks ok in any event.
