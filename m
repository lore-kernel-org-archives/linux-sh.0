From: morimoto.kuninori@renesas.com
Date: Wed, 03 Dec 2008 10:23:10 +0000
Subject: Re: [PATCH 1/2] Add support ov772x driver setting for Migo-R
Message-Id: <utz9lzhf5.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <u3ah7m2kz.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u3ah7m2kz.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

Thank you for checking patch.

> > Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> > ---
> > this patch is for linux 2.6.29
> > V4L2 maintainer said ov772x driver will be added to linux 2.6.29
> > 
> As these depend on new headers and data structures, I will include these
> with the second round of updates for the merge window, after the V4L2
> merge has taken place.

Thank you

> > +struct ov772x_camera_info ov7725_info = {
> > +	.buswidth  = SOCAM_DATAWIDTH_8,
> > +	.link = {
> > +		.power  = ov7725_power,
> > +	},
> > +};
> > +
(snip)
> Also note that ov7725_info should be static, as you are assigning it to
> platform_data and nothing outside of this file is using it otherwise.

ouch !
I will fix it and send again

Thanks.

/Morimoto
