From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 11 Sep 2013 07:20:21 +0000
Subject: Re: [PATCH 5/5] i2c: rcar: use per-device clock
Message-Id: <Pine.LNX.4.64.1309110908570.26942@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1378742120-11135-1-git-send-email-g.liakhovetski@gmx.de>
 <1378742120-11135-6-git-send-email-g.liakhovetski@gmx.de>
 <CANqRtoSKOOLs1KiOx1gYU9LAH=K9hzZP8xTkgCF8s1=R0Vm3Yg@mail.gmail.com>
In-Reply-To: <CANqRtoSKOOLs1KiOx1gYU9LAH=K9hzZP8xTkgCF8s1=R0Vm3Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>

Hi Magnus,

On Wed, 11 Sep 2013, Magnus Damm wrote:

> Hi Guennadi,
> 
> On Tue, Sep 10, 2013 at 12:55 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Using the same clock for all device instances is non-portable and obtaining
> > clock references by an ID without using a device pointer is discouraged.
> > This is also not needed, because on platforms, where this driver is used,
> > suitable clocks are available for the I2C controllers, that are children of
> > the peripheral clock and just pass its rate 1-to-1 to controllers. This
> > patch switches the driver to obtain references to correct clocks.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> >  drivers/i2c/busses/i2c-rcar.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> > index 7e71cf4..7b986cb 100644
> > --- a/drivers/i2c/busses/i2c-rcar.c
> > +++ b/drivers/i2c/busses/i2c-rcar.c
> > @@ -227,7 +227,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
> >                                     u32 bus_speed,
> >                                     struct device *dev)
> >  {
> > -       struct clk *clkp = clk_get(NULL, "peripheral_clk");
> > +       struct clk *clkp = clk_get(dev, NULL);
> >         u32 scgd, cdf;
> >         u32 round, ick;
> >         u32 scl;
> 
> I agree that passing struct device to clk_get() is a good idea. Thanks
> for spotting this.
> 
> What are the run-time dependencies for this patch? Do all affected I2C
> controllers have MSTP bits with proper parents already, or will this
> patch cause breakage for some SoCs?

Currently (Simon's devel branch of 5 days ago as of commit 5cbe867) I only 
see r8a7778 and r8a7779 using i2c-rcar. They both define clocks like

	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */

and similarly for I2C1 - I2C3. So, it looks like it should work, but would 
be nice to test.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
