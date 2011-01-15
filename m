From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 15 Jan 2011 15:15:07 +0000
Subject: Re: Locking in the clk API
Message-Id: <20110115151507.GD15996@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
	<4D2D184A.8020405@codeaurora.org>
	<20110112090301.GS11039@n2100.arm.linux.org.uk>
	<4D31A8F1.4080301@weinigel.se>
	<20110115145358.GC15996@n2100.arm.linux.org.uk>
	<20110115150331.GB6917@pengutronix.de>
In-Reply-To: <20110115150331.GB6917@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Sat, Jan 15, 2011 at 04:03:31PM +0100, Uwe Kleine-K=F6nig wrote:
> Hi Russell,
>=20
> On Sat, Jan 15, 2011 at 02:53:58PM +0000, Russell King - ARM Linux wrote:
> > We've been around returning EAGAIN, WARN_ONs, BUG_ONs, having clk_enabl=
e()
> > vs clk_enable_atomic(), clk_enable_cansleep() vs clk_enable(), etc.
> >=20
> > There's been a lot of talk on this issue for ages with no real progress
> > that I'm just going to repeat: let's unify those implementations which
> > use a spinlock for their clks into one consolidated solution, and
> > a separate consolidated solution for those which use a mutex.
> >=20
> > This will at least allow us to have _some_ consolidation of the existing
> > implementations - and it doesn't add anything to the problem at hand.
> > It might actually help identify what can be done at code level to resol=
ve
> > this issue.
> Great, so how should we do it?  Take Jeremy's patch and make the
> differenciation between sleeping and atomic implementation a Kconfig
> variable?

No - I've been suggesting for about a week now about doing two entirely
separate consolidations.

I think it would be insane to do the consolidation of the two different
implementations in one patch or even one patch set.  There needs to be
a consolidation of spinlock-based clks as one patch set, which is
entirely separate and independent from the consolidation of mutex-based
clks.

What if one of the consolidations turns out to be a problem?  Do we want
to throw both out, or do we want to keep as much as we possibly can?
