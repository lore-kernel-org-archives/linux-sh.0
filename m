From: jacopo mondi <jacopo@jmondi.org>
Date: Wed, 03 Jan 2018 17:13:47 +0000
Subject: Re: [PATCH v2 9/9] media: i2c: tw9910: Remove soc_camera dependencies
Message-Id: <20180103171347.GF9493@w540>
List-Id: <linux-sh.vger.kernel.org>
References: <1514469681-15602-1-git-send-email-jacopo+renesas@jmondi.org>
 <1514469681-15602-10-git-send-email-jacopo+renesas@jmondi.org>
 <CAOMZO5CjrXfzum7JgimGqvnM7kjMyZZdtpEhvYwO-DLnig=uMQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CjrXfzum7JgimGqvnM7kjMyZZdtpEhvYwO-DLnig=uMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, geert-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Fabio,

On Wed, Jan 03, 2018 at 02:41:20PM -0200, Fabio Estevam wrote:
> Hi Jacopo,
>
> On Thu, Dec 28, 2017 at 12:01 PM, Jacopo Mondi
> <jacopo+renesas@jmondi.org> wrote:
>
> > +       if (priv->rstb_gpio) {
> > +               gpiod_set_value(priv->rstb_gpio, 0);
> > +               usleep_range(500, 1000);
> > +               gpiod_set_value(priv->rstb_gpio, 1);
> > +               usleep_range(500, 1000);
>
> This seems to be inverted.
>
> Consider you have an active low GPIO reset.
>
> In order to reset it:
>
> Put the GPIO to logic level 0
> Wait some time
> Put the GPIO to logic level 1
>
> gpiod_set_value(priv->rstb_gpio, 1), means the GPIO in the active
> state (0 in this example).
>
> , so this should be:
>
> gpiod_set_value(priv->rstb_gpio, 1);
> usleep_range(500, 1000);
> gpiod_set_value(priv->rstb_gpio, 0);

That would be true if I would have declared the GPIO to be ACTIVE_LOW.
See patch [5/9] in this series and search for "rstb". The GPIO (which
is shared between two devices) is said to be active high...

Are you maybe suggesting I should declare it ACTIVE_LOW in board setup
code and invert the set_value() order in the driver as you proposed?
Don't you think it would be more natural for the driver to follow the
current sequence, as the reset GPIO is effectively active low (so
setting it to 0 put the video decoder in reset state and setting it to
1 wakes the video decoder up)?

I can maybe agree with you for the PDN GPIO instead. That's said to be
active high, so setting it to 1 disables the video decoder, and yes,
it feels unnatural in the driver's power up routines to set PDN GPIO
to 0 and set it to 1 when putting the device to sleep...

Thanks
   j

