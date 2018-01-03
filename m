From: jacopo mondi <jacopo@jmondi.org>
Date: Wed, 03 Jan 2018 16:24:05 +0000
Subject: Re: [PATCH v2 7/9] media: i2c: ov772x: Remove soc_camera dependencies
Message-Id: <20180103162405.GA6834@w540>
List-Id: <linux-sh.vger.kernel.org>
References: <1514469681-15602-1-git-send-email-jacopo+renesas@jmondi.org>
 <5703631.yJ335LfYLI@avalon>
 <20180103154458.GD9493@w540>
 <2597640.1dqQloDucb@avalon>
In-Reply-To: <2597640.1dqQloDucb@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, magnus.damm@gmail.com, geert@glider.be, mchehab@kernel.org, hverkuil@xs4all.nl, robh+dt@kernel.org, mark.rutland@arm.com, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Jan 03, 2018 at 05:49:55PM +0200, Laurent Pinchart wrote:
> Hi Jacopo,
>
> >
> > DT based platforms won't have any info->xlkc_rate, so they should be
> > fine. I wonder how could I set rate in board code, as I'm just
> > registering an alias for the clock there...
>
> Exactly as done by the current code, get the clock and set the rate :) You can
> do that at initialization time, when you register the alias. Don't forget to
> put the clock too.

Interesting. I had no idea a clock rate is retained between get/put
cycles. I'll set the rate in board code (and now that I'm looking at
other SH boards code, it seems pretty common to do as a thing).

Thanks
   j

>
> > >> +	if (priv->clk) {
> > >> +		ret = clk_prepare_enable(priv->clk);
> > >> +		if (ret)
> > >> +			return ret;
> > >> +	}
> > >> +
> > >> +	if (priv->pwdn_gpio) {
> > >> +		gpiod_set_value(priv->pwdn_gpio, 1);
> > >> +		usleep_range(500, 1000);
> > >> +	}
> > >> +
> > >> +	/* Reset GPIOs are shared in some platforms. */
> > >
> > > I'd make this a FIXME comment as this is really a hack.
> > >
> > > 	/*
> > > 	 * FIXME: The reset signal is connected to a shared GPIO on some
> > > 	 * platforms (namely the SuperH Migo-R). Until a framework becomes
> > > 	 * available to handle this cleanly, request the GPIO temporarily
> > > 	 * only to avoid conflicts.
> > > 	 */
> > >
> > > Same for the tw9910 driver.
> >
> > Ack.
>
> --
> Regards,
>
> Laurent Pinchart
>
