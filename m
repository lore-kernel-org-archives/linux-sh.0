From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 19 Feb 2014 22:24:38 +0000
Subject: Re: [PATCH v2 01/19] serial: sh-sci: Enable the driver on all ARM platforms
Message-Id: <1609898.QTd44x6TTB@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383086274-11049-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140219205446.GD6988@pengutronix.de>
In-Reply-To: <20140219205446.GD6988@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Uwe,

On Wednesday 19 February 2014 21:54:46 Uwe Kleine-K=F6nig wrote:
> On Tue, Oct 29, 2013 at 11:37:36PM +0100, Laurent Pinchart wrote:
> > Renesas ARM platforms are transitioning from single-platform to
> > multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> > driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> > and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
> > COMPILE_TEST.
> >=20
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-serial@vger.kernel.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >=20
> >  drivers/tty/serial/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index febd45c..9a5a8ef 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -709,7 +709,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
> >=20
> >  config SERIAL_SH_SCI
> > =20
> >  	tristate "SuperH SCI(F) serial port support"
> >=20
> > -	depends on HAVE_CLK && (SUPERH || ARCH_SHMOBILE)
> > +	depends on HAVE_CLK && (SUPERH || ARM || COMPILE_TEST)
> >=20
> >  	select SERIAL_CORE
>=20
> This patch is in mainline as d4f9e7b3d12e92ede642f6f4fc7d959f06da8ccc
> since v3.13-rc1. I wonder if
>=20
> 	depends on HAVE_CLK && (SUPERH || ARCH_SHMOBILE || COMPILE_TEST)
>=20
> isn't the better option. (Since bf98c1eac1d4a6bcf00532e4fa41d8126cd6c187
> ARCH_SHMOBILE is enabled for both multi-platform and legacy shmobile
> configs.) Or do you plan to deprecate ARCH_SHMOBILE?

We don't plan to deprecate ARCH_SHMOBILE. I've posted a patch to fix this, =

please see http://www.spinics.net/lists/linux-sh/msg28296.html ("[PATCH 1/2=
]=20
serial: sh-sci: Restrict non-COMPILE_TEST compilation").

--=20
Regards,

Laurent Pinchart

