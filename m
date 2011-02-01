From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Tue, 01 Feb 2011 10:54:49 +0000
Subject: Re: Locking in the clk API, part 2: clk_prepare/clk_unprepare
Message-Id: <20110201105449.GY1147@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
In-Reply-To: <201102011711.31258.jeremy.kerr@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello Jeremy,

On Tue, Feb 01, 2011 at 05:11:29PM +0800, Jeremy Kerr wrote:
> > I suggested that clk_prepare() be callable only from non-atomic context=
s,
> > and do whatever's required to ensure that the clock is available.  That
> > may end up enabling the clock as a result.
>=20
> I think that clk_prepare/clk_unprepare looks like the most promising solu=
tion,=20
> so will try to get some preliminary patches done. Here's what I'm plannin=
g:
>=20
> -----
>=20
> The changes to the API are essentially:
>=20
> 1) Document clk_enable/clk_disable as callable from atomic contexts, and
>    so clock implementations must not sleep within this function.
>=20
> 2) For clock implementations that may sleep to turn on a clock, we add a
>    new pair of functions to the clock API: clk_prepare and clk_unprepare.
>=20
>    These will provide hooks for the clock implmentation to do any sleepab=
le
>    work (eg, wait for PLLs to settle) in preparation for a later clk_enab=
le.
>=20
>    For the most common clock implemntation cases (where clocks can be ena=
bled=20
>    atomically), these functions will be a no-op, and all of the enable/di=
sable
>    work can be done in clk_enable/clk_disable.
>=20
>    For implementations where clocks require blocking on enable/disable, m=
ost
>    of the work will be done in clk_prepare/clk_unprepare. The clk_enable
>    and clk_disable functions may be no-ops.
>=20
> For drivers, this means that clk_prepare must be called (and have returne=
d)=20
> before calling clk_enable.
>=20
> =3D Enable/Prepare counts =3D
>=20
> I intend to do the enable and prepare "counting" in the core clock API,=20
> meaning that that the clk_ops callbacks will only invoked on the first=20
> prepare/enable and the last unprepare/disable.
>=20
> =3D Concurrency =3D
>=20
> Splitting the prepare and enable stages introduces the concurrency=20
> requirements:
>=20
> 1) clk_enable must not return before the clock is outputting a valid cloc=
k=20
>    signal.
>=20
> 2) clk_prepare must not return before the clock is fully prepared (ie, it=
 is=20
>    safe to call clk_enable).
>=20
> It is not possible for clk_enable to wait for the clock to be prepared,=20
> because that would require synchronisation with clk_prepare, which may th=
en=20
> require blocking. Therefore:
>=20
> 3) The clock consumer *must* respect the proper ordering of clk_prepare a=
nd=20
>    clk_enable. For example, drivers that call clk_enable during an interr=
upt=20
>    must ensure that the interrupt handler will not be invoked until=20
>    clk_prepare has returned.
>=20
> =3D Other considerations =3D
>=20
> The time that a clock spends "prepared" is a superset of the the time tha=
t a=20
> clock spends "enabled". Therefore, clocks that are switched on during=20
> clk_prepare (ie, non-atomic clocks) will be running for a larger amount o=
f=20
> time. In some cases, this can be mitigated by moving some of the final=20
> (atomic) switching functionality to the clk_enable function.
>=20
> =3D Implementation =3D
>=20
> Basically:
>=20
> struct clk {
> 	const struct clk_ops *ops
> 	int                  enable_count;
> 	spinlock_t           enable_lock;
> 	int                  prepare_count;
> 	struct mutex         prepare_lock;
> };
>=20
> int clk_enable(struct clk *clk)
> {
> 	int ret =3D 0;
>=20
> 	spin_lock(&clk->enable_lock);
> 	if (!clk->enable_count)
> 		ret =3D clk->ops->enable(clk);
>=20
> 	if (!ret)
> 		clk->enable_count++;
> 	spin_unlock(&clk->enable_lock);
>=20
> 	return ret;
> }
>=20
> int clk_prepare(struct clk *clk)
> {
> 	int ret =3D 0;
>=20
> 	mutex_lock(&clk->prepare_lock);
> 	if (!clk->prepare_count)
> 		ret =3D clk->ops->prepare(clk);
>=20
> 	if (!ret)
> 		clk->prepare_count++;
> 	mutex_unlock(&clk->prepare_lock);
>=20
> 	return ret;
> }
>=20
> -----
>=20
> Comments welcome, code coming soon.
Do you plan to handle the case that clk_enable is called while prepare
isn't completed (considering the special case "not called at all")?
Maybe BUG_ON(clk->ops->prepare && !clk->prepare_count)?

Alternatively don't force the sleep in clk_prepare (e.g. by protecting
prepare_count by a spinlock (probably enable_lock)) and call clk_prepare
before calling clk->ops->enable?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
