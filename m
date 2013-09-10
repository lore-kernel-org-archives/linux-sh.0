From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 10 Sep 2013 22:44:09 +0000
Subject: Re: [PATCH 5/5] i2c: rcar: use per-device clock
Message-Id: <CANqRtoSKOOLs1KiOx1gYU9LAH=K9hzZP8xTkgCF8s1=R0Vm3Yg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1378742120-11135-1-git-send-email-g.liakhovetski@gmx.de>
	<1378742120-11135-6-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1378742120-11135-6-git-send-email-g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hi Guennadi,

On Tue, Sep 10, 2013 at 12:55 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Using the same clock for all device instances is non-portable and obtaining
> clock references by an ID without using a device pointer is discouraged.
> This is also not needed, because on platforms, where this driver is used,
> suitable clocks are available for the I2C controllers, that are children of
> the peripheral clock and just pass its rate 1-to-1 to controllers. This
> patch switches the driver to obtain references to correct clocks.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>  drivers/i2c/busses/i2c-rcar.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 7e71cf4..7b986cb 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -227,7 +227,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
>                                     u32 bus_speed,
>                                     struct device *dev)
>  {
> -       struct clk *clkp = clk_get(NULL, "peripheral_clk");
> +       struct clk *clkp = clk_get(dev, NULL);
>         u32 scgd, cdf;
>         u32 round, ick;
>         u32 scl;

I agree that passing struct device to clk_get() is a good idea. Thanks
for spotting this.

What are the run-time dependencies for this patch? Do all affected I2C
controllers have MSTP bits with proper parents already, or will this
patch cause breakage for some SoCs?

Thanks,

/ magnus
