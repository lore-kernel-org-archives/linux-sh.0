From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 29 May 2012 17:22:34 +0000
Subject: Re: [PATCH] Drop superfluous setting of i2c_board_info.type
Message-Id: <20120529172234.GC30400@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1337870303.22505.20.camel@x61.thuisdomein>
 <20120524162230.GU3710@pengutronix.de>
 <1337877626.22505.30.camel@x61.thuisdomein>
In-Reply-To: <1337877626.22505.30.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, May 24, 2012 at 06:40:26PM +0200, Paul Bolle wrote:
> On Thu, 2012-05-24 at 18:22 +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, May 24, 2012 at 04:38:23PM +0200, Paul Bolle wrote:
> > > 1) This is apparently legal. Doesn't gcc issue a warning for this?
> > I wondered about that too, gcc doesn't even warn when the two values are
> > different. See for example commit
> > bd9e310dca15c9987256f67af19f9f42426e7493.
>=20
> In that case it were two strings ("rtc-pcf8563" versus "pcf8563"). Why
> should gcc care? Or is there something going on behind the scenes which
> somehow depends on the contents of the string?
> =20
> > >  arch/arm/mach-imx/mach-cpuimx35.c     |    1 -
> > >  arch/arm/mach-imx/mach-cpuimx51sd.c   |    1 -
> > I already submitted a patch for the imx bits with Message id
> > 1335989287-10094-1-git-send-email-u.kleine-koenig@pengutronix.de.
> > (e.g.
> > http://mid.gmane.org/1335989287-10094-1-git-send-email-u.kleine-koenig@=
pengutronix.de)
>=20
> Thanks. I missed that one, obviously. Should I just drop that part of
> the patch and resend?

I just merged Uwes patch, this leaves the sh-mobile hunk still to be
fixed.

Sascha


--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
