From: Richard Zhao <linuxzsc@hsia.com.cn>
Date: Tue, 24 May 2011 17:22:31 +0000
Subject: Re: [PATCH 0/4] Add a generic struct clk
Message-Id: <20110524172231.GA2764@b20223-02.ap.freescale.net>
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
> On Fri, May 20, 2011 at 12:27 AM, Jeremy Kerr <jeremy.kerr@canonical.com>=
 wrote:
> > [This series was originally titled 'Add a common struct clk', but
> > the goals have changed since that first set of patches. We're now aiming
> > for a more complete generic clock infrastructure, rather than just
> > abstracting struct clk]
> >
> > [This series still needs work, see the TODO section below]
> >
> > [Totally RFC at the moment]
> >
> > Hi all,
> >
> > These patches are an attempt to allow platforms to share clock code. At
> > present, the definitions of 'struct clk' are local to platform code,
> > which makes allocating and initialising cross-platform clock sources
> > difficult, and makes it impossible to compile a single image containing
> > support for two ARM platforms with different struct clks.
> >
> > The three patches are for the architecture-independent kernel code,
> > introducing the common clk infrastructure. The changelog for the first
> > patch includes details about the new clock definitions.
> >
> > The second patch implements clk_set_rate, and in doing so adds
> > functionality to walk the clock tree in both directions.
> >
> > clk_set_parent is left unimplemented, see TODO below for why.
> >
> > The third and fourth patches provide some basic clocks (fixed-rate and
> > gated), mostly to serve as an example of the hardware implementation.
> > I'm intending to later provide similar base clocks for mux and divider
> > hardware clocks.
> >
> > Many thanks to the following for their input:
> > =A0* Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > =A0* Thomas Gleixner <tglx@linutronix.de>
> > =A0* Ben Dooks <ben-linux@fluff.org>
> > =A0* Baruch Siach <baruch@tkos.co.il>
> > =A0* Russell King <linux@arm.linux.org.uk>
> > =A0* Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > =A0* Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> > =A0* Vincent Guittot <vincent.guittot@linaro.org>
> > =A0* Sascha Hauer <s.hauer@pengutronix.de>
> > =A0* Ryan Mallon <ryan@bluewatersys.com>
> > =A0* Colin Cross <ccross@google.com>
> > =A0* Jassi Brar <jassisinghbrar@gmail.com>
> > =A0* Saravana Kannan <skannan@codeaurora.org>
>=20
> I have a similar set of patches I was working on that handles a little
> more of the common code than these.  I can post them if you want, but
> for now I'll just point out where I had different ideas, and not muddy
> the waters with conflicting patches.
>=20
> > TODO:
> >
> > =A0* Need to figure out the locking around clk_set_parent. Changing the=
 in-kernel
> > =A0 clock topology requires acquiring both the mutex (to prevent agains=
t races
> > =A0 with clk_prepare, which may propagate to the parent clock) and the =
spinlock
> > =A0 (to prevent the same race with clk_enable).
> >
> > =A0 However, we should also be changing the hardware clock topology in =
sync with
> > =A0 the in-kernel clock topology, which would imply that both locks *al=
so* need
> > =A0 to be held while updating the parent in the hardware (ie, in
> > =A0 clk_hw_ops->set_parent) too. =A0However, I believe some platform cl=
ock
> > =A0 implementations may require this callback to be able to sleep. Comm=
ents?
>=20
> This sequence is the best I could come up with without adding a
> temporary 2nd parent:
> 1. lock prepare mutex
Maybe tell child clocks "I'm going to change clock rate, please stop work i=
f needed"
> 2. call prepare on the new parent if prepare_count > 0
> 3. lock the enable spinlock
> 4. call enable on the new parent if enable_count > 0
> 5. change the parent pointer to the new parent
> 6. unlock the spinlock
> 7. call the set_parent callback
Why do it need to sleep if it only set some hw registers?
> 8. lock the enable spinlock
> 9. call disable on the old parent iff you called enable on the new
> parent (enable_count may have changed)
> 10. unlock the enable spinlock
> 11. call unprepare on the old parent if prepare_count
propagate rate here and also tell child clocks "rate changed already, chang=
e your
parameters and go on to work".
> 12. unlock prepare mutex
>=20
> The only possible problem I see is that if a clock starts disabled at
> step 1., and clk_enable is called on it between steps 6 and 7,
> clk_enable will return having enabled the new parent, but the clock is
> still running off the old parent.  As soon as the clock gets switched
> to the new parent, the clock will be properly enabled.  I don't see
> this as a huge problem - calling clk_set_parent on a clock while it is
> enabled may not even work without causing glitches on some platforms.
some do be glitch free, especially for cpu clock parents.
>=20
> I guess the only way around it would be to store a temporary
> "new_parent" pointer between steps 5 and 9, and have
> clk_enable/disable operate on both the current parent and the new
> parent.  They would also need to refcount the extra enables separately
> to undo on the old parent.
>=20
> > =A0* tglx and I have been discussing different ways of passing clock in=
formation
> > =A0 to the clock hardware implementation. I'm proposing providing a bas=
e 'struct
> > =A0 clk_hw', which implementations subclass by wrapping in their own st=
ructure
> > =A0 (or one of a set of simple 'library' structures, like clk_hw_mux or
> > =A0 clk_hw_gate). =A0The clk_hw base is passed as the first argument to=
 all
> > =A0 clk_hw_ops callbacks.
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
>=20
> > =A0 tglx, could you send some details about your approach? I'm aiming t=
o refine
> > =A0 this series with the good bits from each technique.
> >
> > =A0* The clock registration code probably needs work. This is the domain
> > =A0 of the platform/board maintainers, any wishes here?
When clock init, data in struct clk may not be synced with hw registers. Af=
ter
enabled minimal needed clk (cpu, core bus etc), we need sync the whole tree,
disable zero enable_count clocks, set correct .rate ... . The sync function
is also common code, right? but not have to be called all times I think.

Thanks
Richard
> >
> > Cheers,
> >
> >
> > Jeremy
> >
> > --
> >
> > ---
> > Jeremy Kerr (4):
> > =A0 =A0 =A0clk: Add a generic clock infrastructure
> > =A0 =A0 =A0clk: Implement clk_set_rate
> > =A0 =A0 =A0clk: Add fixed-rate clock
> > =A0 =A0 =A0clk: Add simple gated clock
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at =A0http://www.tux.org/lkml/
> >
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
