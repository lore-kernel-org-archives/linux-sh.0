From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 05 Jun 2008 05:42:51 +0000
Subject: Re: [PATCH v2] sh: Add support Renesas Solutions AP-325RXA board
Message-Id: <20080605054251.GA29591@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <484777EB.3@renesas.com>
In-Reply-To: <484777EB.3@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 05, 2008 at 02:21:47PM +0900, Yusuke.Goda wrote:
> I added math-type to v1.
> This board is SH7723 base board.
> This has SCIF, LCDC, USB Host controler, NOR/NAND Flash, Sound, Ether and other.
> This patch supports SCIF, NOR Flash.
> 
> Signed-off-by: Yusuke Goda <goda.yusuke@renesas.com>

Looks good.

[snip]

> +static struct mtd_partition ap325rxa_nor_flash_partitions[] = {
> +	{
> +		 .name = "uboot",
> +		 .offset = 0,
> +		 .size = (1 * 1024 * 1024),
> +		 .mask_flags = MTD_WRITEABLE,	/* Read-only */
> +	 },
> +	{
> +		 .name = "kernel",
> +		 .offset = MTDPART_OFS_APPEND,
> +		 .size = (2 * 1024 * 1024),
> +	 },
> +	{
> +		 .name = "other",
> +		 .offset = MTDPART_OFS_APPEND,
> +		 .size = MTDPART_SIZ_FULL,
> +	 },
> +};
> +
There's some whitespace damage here. Make sure your text editor has these
as tabs, not spaces.

I'll tidy it up and add it to the 2.6.27 queue, thanks.
