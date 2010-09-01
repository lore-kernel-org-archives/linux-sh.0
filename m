From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Wed, 01 Sep 2010 15:01:12 +0000
Subject: Re: [RFC] [PATCH] arm & sh: factorised duplicated clkdev.c
Message-Id: <20100901150112.GF11107@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
	<20100901095121.GA11107@pengutronix.de>
	<20100901111846.GF22790@game.jcrosoft.org>
In-Reply-To: <20100901111846.GF22790@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, Sep 01, 2010 at 01:18:46PM +0200, Jean-Christophe PLAGNIOL-VILLARD =
wrote:
> > > =20
> > > -struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
> > > -	const char *dev_fmt, ...)
> > > +struct clk_lookup * __init_refok
> > Why do you need __init_refok?  __init_refok is defined as follows in
> > include/linux/init.h:
> >=20
> > 	/* compatibility defines */
> > 	#define __init_refok     __ref
> >=20
> > So if really needed better use __ref.  Couldn't this be __init? =20
> ok for __ref but __init_refok is more clear IMHO
For me it was not, because before your mail I didn't know __init_refok
so I had to look it up.

> and yes we need it as for early device we may use bootmem as slab allocat=
ors
> may no be availlable in some case
Yes I got that, but it doesn't explain why you need to mark your
function as __ref or why you cannot use __init.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
