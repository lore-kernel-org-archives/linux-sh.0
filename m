From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 01 Feb 2011 13:15:12 +0000
Subject: Re: Locking in the clk API, part 2: clk_prepare/clk_unprepare
Message-Id: <20110201131512.GH31216@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
In-Reply-To: <20110201105449.GY1147@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 01, 2011 at 11:54:49AM +0100, Uwe Kleine-K=F6nig wrote:
> Alternatively don't force the sleep in clk_prepare (e.g. by protecting
> prepare_count by a spinlock (probably enable_lock)) and call clk_prepare
> before calling clk->ops->enable?

That's a completely bad idea.  I assume you haven't thought about this
very much.

There's two ways I can think of doing what you're suggesting:

int clk_prepare(struct clk *clk)
{
	unsigned long flags;
	int ret =3D 0;

	might_sleep();

	spin_lock_irqsave(&clk->enable_lock, flags);
	if (clk->prepare_count++ =3D 0)
		ret =3D clk->ops->prepare(clk);
	spin_unlock_irqrestore(&clk->enable_clock, flags);

	return ret;
}

The problem is that clk->ops->prepare() is called in a non-sleepable
context.  So this breaks the whole idea of clk_prepare(), and so isn't
a solution.

The other solution is:

int clk_prepare(struct clk *clk)
{
	unsigned long flags;
	int ret =3D 0;
	bool first;

	might_sleep();

	spin_lock_irqsave(clk->enable_lock, flags);
	first =3D clk->prepare_count++ =3D 0;
	spin_unlock_irqrestore(clk->enable_clock, flags);

	if (first)
		ret =3D clk->ops->prepare(clk);

	return ret;
}

The problem with this is that you now don't have any sane locking on
the prepare callback, and the circumstances under which it's called
are very indefinite.  For example, consider a preempt-enabled system:

	thread 1		thread 2		prepare_count
	clk_prepare					0
	clk->prepare_count++				1
	<thread switch>
				clk_prepare		1
				clk->prepare_count++	2
				clk_prepare returns	2

				clk_enable		2
				<explodes as clock is not prepared>
				<thread switch>
	clk->ops->prepare(clk)

So really, what you're suggesting is completely broken.
