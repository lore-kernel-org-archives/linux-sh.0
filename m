From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Wed, 09 Feb 2011 20:39:00 +0000
Subject: Re: [RFC,PATCH 1/3] Add a common struct clk
Message-Id: <20110209203900.GT27982@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1297233693.242364.862698430999.1.gpush@pororo>
	<4D52F73A.4010707@bluewatersys.com>
In-Reply-To: <4D52F73A.4010707@bluewatersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Ryan,

On Thu, Feb 10, 2011 at 09:21:14AM +1300, Ryan Mallon wrote:
> > +int clk_enable(struct clk *clk)
> > +{
> > +	unsigned long flags;
> > +	int ret =3D 0;
> > +
> > +	spin_lock_irqsave(&clk->enable_lock, flags);
>=20
> 	WARN_ON(clk->prepare_count =3D 0); ?
This is added in patch 3/3

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
