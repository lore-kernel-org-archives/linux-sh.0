From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 24 May 2011 08:09:36 +0000
Subject: Re: [PATCH 0/4] Add a generic struct clk
Message-Id: <20110524080936.GI20715@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1305876469.325655.313573683829.0.gpush@pororo>
	<BANLkTik=EFayZW61TgfOni-XML+tRLOcqw@mail.gmail.com>
	<20110524062620.GA22096@pengutronix.de>
	<BANLkTimEoCaKwJtpbQTDSEDydNkZ1BkKog@mail.gmail.com>
In-Reply-To: <BANLkTimEoCaKwJtpbQTDSEDydNkZ1BkKog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, May 24, 2011 at 12:31:13AM -0700, Colin Cross wrote:
> On Mon, May 23, 2011 at 11:26 PM, Sascha Hauer <s.hauer@pengutronix.de> w=
rote:
> > On Mon, May 23, 2011 at 04:12:24PM -0700, Colin Cross wrote:
> >> >
> >> > =A0 tglx's plan is to create a separate struct clk_hwdata, which con=
tains a
> >> > =A0 union of base data structures for common clocks: div, mux, gate,=
 etc. The
> >> > =A0 ops callbacks are passed a clk_hw, plus a clk_hwdata, and most o=
f the base
> >> > =A0 hwdata fields are handled within the core clock code. This means=
 less
> >> > =A0 encapsulation of clock implementation logic, but more coverage of
> >> > =A0 clock basics through the core code.
> >>
> >> I don't think they should be a union, I think there should be 3
> >> separate private datas, and three sets of clock ops, for the three
> >> different types of clock blocks: rate changers (dividers and plls),
> >> muxes, and gates. =A0These blocks are very often combined - a device
> >> clock often has a mux and a divider, and clk_set_parent and
> >> clk_set_rate on the same struct clk both need to work.
> >
> > The idea is to being able to propagate functions to the parent. It's
> > very convenient for the implementation of clocks when they only
> > implement either a divider, a mux or a gate. Combining all of these
> > into a single clock leads to complicated clock trees and many different
> > clocks where you can't factor out the common stuff.
>=20
> That seems complicated.  You end up with lots of extra clocks (meaning
> more boilerplate in the platform files) that have no meaning in the
> system (what is the clock between the mux and the divider in Tegra's
> i2c1 clock, it can never feed any devices), and you have to figure out
> at the framework level when to propagate and when to error out.  I'm
> not even sure you can always find the right place to stop propagating
> - do you just keep going up until the set_parent callback succeeds, or
> exists, or what?

For the set_parent there would be no propagating at all. For set_rate I
can imagine a flag in the generic clock which tells whether to propagate
set_rate or not.

>=20
> I think you can still factor out all the common code if you treat each
> clock as a possible mux, divider, and gate combination.  Each part of
> the clock is still just as abstractable as before - you can set the
> rate_ops to be the generic single register divider implementation, and
> the gate ops to be the generic single bit enable implementation.  The
> idea of what a clock node is matches the HW design,

The hardware design consists of only discrete rate changers (plls,
dividers), muxes and gates. These are the only building blocks
*every* hardware design has. I believe that many of the problems
the current implementations have are due to the multiple building
blocks stuffed into one clock. If you haven't already take a look
at my i.MX5 clock patches:

http://thread.gmane.org/gmane.linux.ports.arm.kernel/113631

They need changes to fit onto the current patches and the rate
propagation problem is not solved there, but the resulting clock
data files are really short and nice to read. Furthermore it's easy
to implement. Just look at the diagrams in the datasheet and go through
them.

Sascha

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
