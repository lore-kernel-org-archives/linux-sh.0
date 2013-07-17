From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Wed, 17 Jul 2013 14:33:43 +0000
Subject: Re: [v2,2/2] spi: bitbang: convert to using core message queue
Message-Id: <20130717143343.GA32014@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1301091507120.13376@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1301091507120.13376@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, kernel@pengutronix.de

On Wed, Jan 09, 2013 at 03:08:59PM +0100, Guennadi Liakhovetski wrote:
> The SPI subsystem core now manages message queues internally. Remove the
> local message queue implementation from the spi-bitbang driver and
> migrate to the common one.
>=20
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
It works fine for me on an efm32 board communicating with an ks8851.
Maybe the mmc problem is to be found in the mmc subsystem?

Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
