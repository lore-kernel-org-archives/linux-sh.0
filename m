From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 May 2012 02:56:36 +0000
Subject: Re: [PATCH 02/11] ARM: mach-shmobile: setup-r8a7740: add MERAM work-around
Message-Id: <20120522025635.GA22483@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87fwatar29.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fwatar29.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 21, 2012 at 07:27:13PM -0700, kuninori.morimoto.gx@renesas.com wrote:
> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> @@ -324,6 +324,24 @@ static struct platform_device *r8a7740_late_devices[] __initdata = {
> +/*
> + * r8a7740 chip has lasting errata on MERAM buffer.
> + * this is work-around for it.
> + * see
> + *	"Media RAM (MERAM)" on r8a7740 documentation
> + */
> +#define MEBUFCNTR	0xFE950098
> +static void r8a7740_meram_workaround(void)
> +{
> +	void __iomem *reg;
> +
> +	reg = ioremap_nocache(MEBUFCNTR, 4);
> +	if (reg) {
> +		iowrite32(0x01600164, reg);
> +		iounmap(reg);
> +	}
> +}
> +
If this exists within the MERAM register space, it should probably be
handled in the MERAM driver itself. If this is all going to go to DT in
the future it will be easy to to node to quirk matching then, but in the
mean time we can match on CPU or machine types.
