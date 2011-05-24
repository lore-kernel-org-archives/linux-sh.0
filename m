From: Colin Cross <ccross@google.com>
Date: Tue, 24 May 2011 07:59:11 +0000
Subject: Re: [PATCH 2/4] clk: Implement clk_set_rate
Message-Id: <BANLkTikstyLHOYiGtb8tG0TchYwxRj3UYQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1305876469.325655.313573683829.0.gpush@pororo>
	<1305876469.326620.351525457111.2.gpush@pororo>
In-Reply-To: <1305876469.326620.351525457111.2.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, May 20, 2011 at 12:27 AM, Jeremy Kerr <jeremy.kerr@canonical.com> w=
rote:
> Implemenent clk_set_rate by adding a set_rate callback to clk_hw_ops,
> and core code to handle propagation of rate changes up and down the
> clock tree.
>
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
>
> ---
> =A0drivers/clk/clk.c =A0 | =A0 74 +++++++++++++++++++++++++++++++++++++++=
+----
> =A0include/linux/clk.h | =A0 12 +++++++
> =A02 files changed, 80 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index ad90a90..3a4d70e 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -21,6 +21,8 @@ struct clk {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0enable_count;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0prepare_count;
> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*parent;
> + =A0 =A0 =A0 struct hlist_head =A0 =A0 =A0 children;
> + =A0 =A0 =A0 struct hlist_node =A0 =A0 =A0 child_node;
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 rate;
> =A0};
>
> @@ -176,10 +178,61 @@ long clk_round_rate(struct clk *clk, unsigned long =
rate)
> =A0}
> =A0EXPORT_SYMBOL_GPL(clk_round_rate);
>
> +/*
> + * clk_recalc_rates - Given a clock (with a recently updated clk->rate),
> + * =A0 =A0 notify its children that the rate may need to be recalculated=
, using
> + * =A0 =A0 ops->recalc_rate().
> + */
> +static void clk_recalc_rates(struct clk *clk)
> +{
> + =A0 =A0 =A0 struct hlist_node *tmp;
> + =A0 =A0 =A0 struct clk *child;
> +
> + =A0 =A0 =A0 if (clk->ops->recalc_rate)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->rate =3D clk->ops->recalc_rate(clk->hw=
);
> +
> + =A0 =A0 =A0 hlist_for_each_entry(child, tmp, &clk->children, child_node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_recalc_rates(child);
> +}
> +
> =A0int clk_set_rate(struct clk *clk, unsigned long rate)
> =A0{
> - =A0 =A0 =A0 /* not yet implemented */
> - =A0 =A0 =A0 return -ENOSYS;
> + =A0 =A0 =A0 unsigned long parent_rate, new_rate;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 if (!clk->ops->set_rate)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOSYS;
> +
> + =A0 =A0 =A0 new_rate =3D rate;
> +
> + =A0 =A0 =A0 /* prevent racing with updates to the clock topology */
> + =A0 =A0 =A0 mutex_lock(&prepare_lock);
> +
> +propagate:
> + =A0 =A0 =A0 ret =3D clk->ops->set_rate(clk->hw, new_rate, &parent_rate);
> +
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 /* ops->set_rate may require the parent's rate to change (to
> + =A0 =A0 =A0 =A0* parent_rate), we need to propagate the set_rate call t=
o the
> + =A0 =A0 =A0 =A0* parent.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (ret =3D CLK_SET_RATE_PROPAGATE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_rate =3D parent_rate;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk =3D clk->parent;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto propagate;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* If successful (including propagation to the parent clock=
(s)),
> + =A0 =A0 =A0 =A0* recalculate the rates of the clock, including children=
. =A0We'll be
> + =A0 =A0 =A0 =A0* calling this on the 'parent-most' clock that we propag=
ated to.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 clk_recalc_rates(clk);
> +
> + =A0 =A0 =A0 mutex_unlock(&prepare_lock);
> +
> + =A0 =A0 =A0 return 0;
> =A0}
> =A0EXPORT_SYMBOL_GPL(clk_set_rate);
>
> @@ -213,16 +266,25 @@ struct clk *clk_register(struct clk_hw_ops *ops, st=
ruct clk_hw *hw,
> =A0 =A0 =A0 =A0clk->hw =3D hw;
> =A0 =A0 =A0 =A0hw->clk =3D clk;
>
> - =A0 =A0 =A0 /* Query the hardware for parent and initial rate */
> + =A0 =A0 =A0 /* Query the hardware for parent and initial rate. We may a=
lter
> + =A0 =A0 =A0 =A0* the clock topology, making this clock available from t=
he parent's
> + =A0 =A0 =A0 =A0* children list. So, we need to protect against concurre=
nt
> + =A0 =A0 =A0 =A0* accesses through set_rate
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 mutex_lock(&prepare_lock);
>
> - =A0 =A0 =A0 if (clk->ops->get_parent)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We don't to lock against prepare/enable =
here, as
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the clock is not yet accessible from a=
nywhere */
> + =A0 =A0 =A0 if (clk->ops->get_parent) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk->parent =3D clk->ops->get_parent(clk->=
hw);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (clk->parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hlist_add_head(&clk->child_=
node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &clk->parent->children);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (clk->ops->recalc_rate)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk->rate =3D clk->ops->recalc_rate(clk->h=
w);
>
> + =A0 =A0 =A0 mutex_unlock(&prepare_lock);
> +
>
> =A0 =A0 =A0 =A0return clk;
> =A0}
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 93ff870..e0969d2 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -58,6 +58,12 @@ struct clk_hw {
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 parent. Currently only called when the clock=
 is first
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 registered.
> =A0*
> + * @set_rate =A0 Change the rate of this clock. If this callback returns
> + * =A0 =A0 =A0 =A0 =A0 =A0 CLK_SET_RATE_PROPAGATE, the rate change will =
be propagated to
> + * =A0 =A0 =A0 =A0 =A0 =A0 the parent clock (which may propagate again).=
 The requested
> + * =A0 =A0 =A0 =A0 =A0 =A0 rate of the parent is passed back from the ca=
llback in the
> + * =A0 =A0 =A0 =A0 =A0 =A0 second 'unsigned long *' argument.
This seems backwards to me, it requires children to have knowledge of
the best states for their parents.  I don't think it can ever be
implemented safely, either.  If the child's set rate needs to decrease
its divider value to increase its rate, but increase the parents
divider to decrease the rate, the clock can end up running too fast,
and out of spec, after set_rate on the child clock has finished, but
set_rate on the parent clock has not been called yet.  And if the
parent clock errors out, clk_set_rate returns an error, but the rate
has still changed to some random intermediate value.

Can you explain a use case where propagation is necessary?  It doesn't
match the Sascha's reply to my comments on the main patch, where he
said users are best suited to make the decision on the correct parent,
but child clocks are best suited to make the decision on the parent's
rate?  Can you point me to a current clock implementation that does
anything like this?

> + *
> =A0* The clk_enable/clk_disable and clk_prepare/clk_unprepare pairs allow
> =A0* implementations to split any work between atomic (enable) and sleepa=
ble
> =A0* (prepare) contexts. =A0If a clock requires sleeping code to be turne=
d on, this
> @@ -76,9 +82,15 @@ struct clk_hw_ops {
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0(*disable)(struct clk_hw *);
> =A0 =A0 =A0 =A0unsigned long =A0 (*recalc_rate)(struct clk_hw *);
> =A0 =A0 =A0 =A0long =A0 =A0 =A0 =A0 =A0 =A0(*round_rate)(struct clk_hw *,=
 unsigned long);
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*set_rate)(struct clk_hw *,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 unsigned long, unsigned long *);
> =A0 =A0 =A0 =A0struct clk * =A0 =A0(*get_parent)(struct clk_hw *);
> =A0};
>
> +enum {
> + =A0 =A0 =A0 CLK_SET_RATE_PROPAGATE =3D 1,
> +};
> +
> =A0/**
> =A0* clk_prepare - prepare clock for atomic enabling.
> =A0*
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
