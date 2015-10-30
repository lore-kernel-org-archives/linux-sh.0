From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Oct 2015 00:13:43 +0000
Subject: Re: [PATCH] i2c: rcar: call rcar_i2c_init() after pm_runtime_get_sync()
Message-Id: <87h9l9gquz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oafiyq8y.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdXnMFh5umv=wJdvrcMip+DOn8rYP_3eUTufFw4q2Sr8Jw@mail.gmail.com>
In-Reply-To: <CAMuHMdXnMFh5umv=wJdvrcMip+DOn8rYP_3eUTufFw4q2Sr8Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon <horms@verge.net.au>, Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>


Hi Geert

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > rcar_i2c_init() initializes I2C device, but it should be called
> > *after* pm_runtime_get_sync(). Otherwise it outputs very hi speed
> > clock. This patch solved this issue,
> > This patch also removes pointless rcar_i2c_init()
> > from rcar_i2c_probe()
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  drivers/i2c/busses/i2c-rcar.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> > index 616433d..edbfefc 100644
> > --- a/drivers/i2c/busses/i2c-rcar.c
> > +++ b/drivers/i2c/busses/i2c-rcar.c
> > @@ -474,6 +474,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
> >
> >         pm_runtime_get_sync(dev);
> >
> > +       rcar_i2c_init(priv);
> 
> Hence now it's done again for every transfer?
> 
> What about moving it just before the call to i2c_add_numbered_adapter(),
> and wrapping it inside pm_runtime_get_sync(dev)/pm_runtime_put()?

In my experience, it should be called again for every transfer.
Because SoC/IP might doesn't keep register setting value if you call pm_runtime_put()
(I fought with this behavior when sh_mobile IP :P )
