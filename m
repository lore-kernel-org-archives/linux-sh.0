From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 21 Mar 2008 08:14:21 +0000
Subject: Re: [PATCH] i2c: SuperH Mobile I2C Bus Controller
Message-Id: <aec7e5c30803210114i1ed8e5d6u53d659b579f70bde@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080320141840.13560.24850.sendpatchset@rx1.opensource.se>
	 <20080321062312.GA17225@linux-sh.org>
In-Reply-To: <20080321062312.GA17225@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, i2c@lm-sensors.org, khali@linux-fr.org, linux-sh@vger.kernel.org

On Fri, Mar 21, 2008 at 3:23 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Thu, Mar 20, 2008 at 11:18:40PM +0900, Magnus Damm wrote:
>  > +static void sh_mobile_i2c_setup_channel(struct platform_device *dev)
>  > +{
>  > +     struct sh_mobile_i2c_data *pd = platform_get_drvdata(dev);
>  > +     unsigned long peripheral_clk = CONFIG_SH_PCLK_FREQ;
>  > +     u_int32_t num;
>  > +     u_int32_t denom;
>  > +     u_int32_t tmp;
>  > +
>  Use clk_get() and friends here for the module clock. This should
>  absolutely not be hardcoded, especially as it can be scaled by the clock
>  framework, and the i2c clock will need to rebalance itself to account for
>  that. Any driver that references CONFIG_SH_PCLK_FREQ is utterly broken.

Thanks for spotting this. I'll fix this and repost V2 in a bit.

/ magnus
