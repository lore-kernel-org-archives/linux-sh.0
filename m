From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Apr 2011 01:18:01 +0000
Subject: Re: [PATCH] i2c: i2c-sh_mobile bus speed platform data
Message-Id: <20110428011757.GB15883@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110421132254.3725.84300.sendpatchset@t400s>
 <20110427221357.GA12273@verge.net.au>
 <BANLkTi=YbtWYKLdcEkv6TDRfm-BbXGXa4w@mail.gmail.com>
In-Reply-To: <BANLkTi=YbtWYKLdcEkv6TDRfm-BbXGXa4w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org

On Thu, Apr 28, 2011 at 10:06:38AM +0900, Magnus Damm wrote:
> On Thu, Apr 28, 2011 at 7:14 AM, Simon Horman <horms@verge.net.au> wrote:
> > Hi Magnus,
> >
> > On Thu, Apr 21, 2011 at 10:22:54PM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Add support to the i2c-sh_mobile driver for setting
> >> the I2C bus speed using platform data.
> >>
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> ---
> >>
> >>  drivers/i2c/busses/i2c-sh_mobile.c |   13 +++++++++++--
> >>  include/linux/i2c-sh_mobile.h      |   10 ++++++++++
> >>  2 files changed, 21 insertions(+), 2 deletions(-)
> >>
> >> --- 0013/drivers/i2c/busses/i2c-sh_mobile.c
> >> +++ work/drivers/i2c/busses/i2c-sh_mobile.c   2011-04-21 20:20:23.000000000 +0900
> >> @@ -32,6 +32,7 @@
> >>  #include <linux/clk.h>
> >>  #include <linux/io.h>
> >>  #include <linux/slab.h>
> >> +#include <linux/i2c-sh_mobile.h>
> >>
> >>  /* Transmit operation:                                                      */
> >>  /*                                                                          */
> >> @@ -117,7 +118,7 @@ struct sh_mobile_i2c_data {
> >>       struct device *dev;
> >>       void __iomem *reg;
> >>       struct i2c_adapter adap;
> >> -
> >> +     unsigned long bus_speed;
> >>       struct clk *clk;
> >>       u_int8_t icic;
> >>       u_int8_t iccl;
> >> @@ -205,7 +206,7 @@ static void activate_ch(struct sh_mobile
> >>        * We also round off the result.
> >>        */
> >>       num = i2c_clk * 5;
> >> -     denom = NORMAL_SPEED * 9;
> >> +     denom = pd->bus_speed * 9;
> >
> > I believe that on the sh73a0 and so far only the sh73a0
> > denom needs to be doubled.
> 
> Uhm, I don't think this patch is specific to any SoC type. It may of
> course be used on sh73a0 to adjust the denom value, but setting the
> I2C bus speed is something that can be used on any SoC. So I'd say
> that this is a fairly generic feature.

I'm just saying that that I've observed the value being doubled for sh73a0.

