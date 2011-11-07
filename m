From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 07 Nov 2011 04:48:11 +0000
Subject: Re: [PATCH 2.3/5 v2] ARM: mach-shmobile: add bonito board support.
Message-Id: <20111107044811.GC3927@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87zkg8rcxs.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zkg8rcxs.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Nov 06, 2011 at 04:30:59PM -0800, Kuninori Morimoto wrote:
> diff --git a/arch/arm/configs/bonito_defconfig b/arch/arm/configs/bonito_defconfig
> new file mode 100644
> index 0000000..adb4fc3
> --- /dev/null
> +++ b/arch/arm/configs/bonito_defconfig
> @@ -0,0 +1,978 @@
> +#
> +# Automatically generated file; DO NOT EDIT.
> +# Linux/arm 3.1.0-rc3 Kernel Configuration
> +#
We're only interested in defconfig fragments.

See c2330e286f68f1c408b4aa6515ba49d57f05beae for a script you can use to
trim this down.

> +/*
> + * FPGA
> + */
> +#define A1MDSR		0x10E0
> +#define BVERR		0x1100
> +u16 fpga_read(u32 offset)
> +{
> +	return __raw_readw(0xf0003000 + offset);
> +}
> +
> +void fpga_write(u32 offset, u16 val, u16 mask)
> +{
> +	u16 tmp;
> +
> +	tmp = fpga_read(offset);
> +	tmp = (tmp & ~mask) | (val & mask);
> +	__raw_writew(tmp, 0xf0003000 + offset);
> +}
> +
You may want a more descriptive name, like bonito_fpga_read/write() or
so. This also seems like something you are going to want in a header and
inlined, rather than part of the global namespace (especially with such
generic naming).

The rest looks fine to me.
