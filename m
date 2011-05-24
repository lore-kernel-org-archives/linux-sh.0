From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 24 May 2011 06:26:20 +0000
Subject: Re: [PATCH 0/4] Add a generic struct clk
Message-Id: <20110524062620.GA22096@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1305876469.325655.313573683829.0.gpush@pororo>
	<1305876469.325655.313573683829.0.gpush@pororo>
	<BANLkTik=EFayZW61TgfOni-XML+tRLOcqw@mail.gmail.com>
In-Reply-To: <BANLkTik=EFayZW61TgfOni-XML+tRLOcqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, May 23, 2011 at 04:12:24PM -0700, Colin Cross wrote:
> >
> > =A0 tglx's plan is to create a separate struct clk_hwdata, which contai=
ns a
> > =A0 union of base data structures for common clocks: div, mux, gate, et=
c. The
> > =A0 ops callbacks are passed a clk_hw, plus a clk_hwdata, and most of t=
he base
> > =A0 hwdata fields are handled within the core clock code. This means le=
ss
> > =A0 encapsulation of clock implementation logic, but more coverage of
> > =A0 clock basics through the core code.
>=20
> I don't think they should be a union, I think there should be 3
> separate private datas, and three sets of clock ops, for the three
> different types of clock blocks: rate changers (dividers and plls),
> muxes, and gates.  These blocks are very often combined - a device
> clock often has a mux and a divider, and clk_set_parent and
> clk_set_rate on the same struct clk both need to work.

The idea is to being able to propagate functions to the parent. It's
very convenient for the implementation of clocks when they only
implement either a divider, a mux or a gate. Combining all of these
into a single clock leads to complicated clock trees and many different
clocks where you can't factor out the common stuff.

Sascha

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
