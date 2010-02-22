From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 22 Feb 2010 10:31:38 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: G3EVM FLCTL platform data
Message-Id: <20100222103138.GB4356@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100219095406.5206.86934.sendpatchset@t400s>
In-Reply-To: <20100219095406.5206.86934.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 19, 2010 at 06:54:06PM +0900, Magnus Damm wrote:
> +static struct mtd_partition nand_partition_info[] = {
> +	{
> +		.name	= "system",
> +		.offset	= 0,
> +		.size	= 64 * 1024 * 1024,
> +	},
> +	{
> +		.name	= "userdata",
> +		.offset	= MTDPART_OFS_APPEND,
> +		.size	= 128 * 1024 * 1024,
> +	},
> +	{
> +		.name	= "cache",
> +		.offset	= MTDPART_OFS_APPEND,
> +		.size	= 64 * 1024 * 1024,
> +	},
> +};
> +
You may want to #include <asm/sizes.h> here and use the SZ_ helpers
instead. There is far too much existing ambiguity with sz vs sz - 1 for
resource length that consolidating on common helpers at least makes the
intent more immediately apparent.

> +static struct resource nand_flash_resources[] = {
> +	[0] = {
> +		.start	= 0xe6a30000,
> +		.end	= 0xe6a3009b,
> +		.flags	= IORESOURCE_MEM,
> +	}
> +};
> +
> +static struct sh_flctl_platform_data nand_flash_data = {
> +	.parts		= nand_partition_info,
> +	.nr_parts	= ARRAY_SIZE(nand_partition_info),
> +	.flcmncr_val	= QTSEL_E | FCKSEL_E | TYPESEL_SET | NANWF_E
> +			| SHBUSSEL | SEL_16BIT,
> +};

This is also a bit special, |'s usually are at the end of the previous
line, not the beginning of the second one.

> +	/* FOE, FCDE, FSC on dedicated pins */
> +	__raw_writel(__raw_readl(0xe6158048) & ~(1 << 15), 0xe6158048);
> +
This looks suspiciously like an obfuscated MSTP toggle that the clock
framework needs to be handling. I thought I was already pretty clear when
I said I wouldn't be applying any more of these sorts of patches until
some basic clock framework support was in place?
