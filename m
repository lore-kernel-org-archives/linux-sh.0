From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 24 Mar 2008 03:09:45 +0000
Subject: Re: [PATCH] 1/3 mtd: add Kbuild support and makefile support for Dreamcast VMU
Message-Id: <20080324030945.GA15872@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1206207805.6324.13.camel@localhost.localdomain>
	<1206208592.6324.19.camel@localhost.localdomain>
In-Reply-To: <1206208592.6324.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Andrew Morton <akpm@osdl.org>, linux-sh <linux-sh@vger.kernel.org>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>, dwmw2 <dwmw2@infradead.org>

On Sat, Mar 22, 2008 at 05:56:32PM +0000, Adrian McMenamin wrote:
> Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> ---
> diff -ruN a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> --- a/drivers/mtd/maps/Kconfig	2008-03-22 17:26:24.000000000 +0000
> +++ b/drivers/mtd/maps/Kconfig	2008-03-22 17:20:45.000000000 +0000
> @@ -590,5 +590,19 @@
>  
>  	  This selection automatically selects the map_ram driver.
>  
> +config MTD_VMU_FLASH
> +	tristate "Dreamcast Visual Memory devices and clones"
> +	depends on SH_DREAMCAST
> +	select MAPLE
> +	help
> +	  Flash map driver for the SEGA Dreamcast Visual Memory Unit
> +	  and clones.
> +
> +	  Most Dreamcast users will have one of these and so will want
> +	  to say Y here.
> +
> +	  To compile this driver as a module choose M here: the module
> +	  will be called vmu-flash.
> +
>  endmenu
>  
1/3 and 2/3 should be merged, they're completely tied to each other and
are useless on their own.
