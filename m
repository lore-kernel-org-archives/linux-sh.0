From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 23 Mar 2015 08:45:10 +0000
Subject: Re: [PATCH v2 2/4] Documentation: i2c: describe the new slave mode
Message-Id: <20150323084510.GL5664@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1427099199-3628-1-git-send-email-wsa@the-dreams.de>
 <1427099199-3628-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1427099199-3628-3-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Hello Wolfram,

On Mon, Mar 23, 2015 at 09:26:37AM +0100, Wolfram Sang wrote:
> +Developer manual
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +I2C slave events
> +----------------
> +
> +The bus driver sends an event to the backend using the following functio=
n:
> +
> +	ret =3D i2c_slave_event(client, event, &val)
> +
> +'client' describes the i2c slave device. 'event' is one of the special e=
vent
> +types described hereafter. 'val' holds an u8 value for the data byte to =
be
> +read/written and is thus bidirectional. The pointer to val must always be
> +provided even if val is not used for an event, i.e. don't use NULL here.=
 'ret'
> +is the return value from the backend. Mandatory events must be provided =
by the
I don't understand why you want to force a valid pointer here. According
to my sense of defensive programming I'd say: If the bus driver doesn't
expect the slave to consume/provide a value, let's pass NULL to notice
the assumption being wrong. The wording is fine, now.

> diff --git a/Documentation/i2c/summary b/Documentation/i2c/summary
> index 13ab076dcd9248..809541ab352f03 100644
> --- a/Documentation/i2c/summary
> +++ b/Documentation/i2c/summary
> @@ -41,7 +41,3 @@ integrated than Algorithm and Adapter.
> =20
>  For a given configuration, you will need a driver for your I2C bus, and
>  drivers for your I2C devices (usually one driver for each device).
> -
> -At this time, Linux only operates I2C (or SMBus) in master mode; you can=
't
> -use these APIs to make a Linux system behave as a slave/device, either to
> -speak a custom protocol or to emulate some other device.
\o/

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
