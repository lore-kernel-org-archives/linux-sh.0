From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 08 Nov 2010 05:55:14 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: UIO platform data for sh7372/ap4evb V2
Message-Id: <w3pwroouzp9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Magnus, Paul

> From: Magnus Damm <damm@opensource.se>
> 
> Export the following sh7372 multimedia hardware blocks
> using UIO: VPU, VEU[0-3], JPU and SPU2DSP[0-1]
> 
> The amount of physically continguous memory assigned to
> each hardware block can be configured using the kernel
> command line option "memchunk".
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
(snip)
> +/* JPU */
> +static struct uio_info jpu_platform_data = {
> +	.name = "JPU",
> +	.version = "0",
> +	.irq = intcs_evt2irq(0x560),
> +};
> +
> +static struct resource jpu_resources[] = {
> +	[0] = {
> +		.name	= "JPU",
> +		.start	= 0xfe980000,
> +		.end	= 0xfe9802d3,
> +		.flags	= IORESOURCE_MEM,
> +	},

here.
.end is

X 0xfe9802d3,
O 0xfe9902d3,

Reported-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
--
Kuninori Morimoto
 
