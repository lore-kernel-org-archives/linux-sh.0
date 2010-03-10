From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 10 Mar 2010 07:36:49 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb SDHI0 platform data
Message-Id: <20100310073649.GD19518@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100310071528.5975.28821.sendpatchset@t400s>
In-Reply-To: <20100310071528.5975.28821.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 10, 2010 at 04:15:28PM +0900, Magnus Damm wrote:
> @@ -206,10 +207,38 @@ static struct platform_device keysc_devi
>  	},
>  };
>  
> +/* SDHI0 */
> +static struct sh_mobile_sdhi_info sdhi0_info = {
> +};
> +
Try again?

> +static struct resource sdhi0_resources[] = {
> +	[0] = {
> +		.name	= "SDHI0",
> +		.start  = 0xe6850000,
> +		.end    = 0xe68501ff,
> +		.flags  = IORESOURCE_MEM,

If you aren't going to use a useful name for the resource, then the
name can just be left unset, this will ensure that the driver core
assigns the resource a name matching the device name/id pair.

So if left unset you would end up with "sh_mobile_sdhi.0" in /proc/iomem,
which could be more intuitive.
