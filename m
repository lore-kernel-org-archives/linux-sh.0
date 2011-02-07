From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Mon, 07 Feb 2011 08:05:55 +0000
Subject: Re: [RFC, PATCH 3/3] clk: add warnings for incorrect
Message-Id: <20110207080555.GC27982@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1297058877.800990.238556019385.3.gpush@pororo>
In-Reply-To: <1297058877.800990.238556019385.3.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello Jeremy,

On Mon, Feb 07, 2011 at 02:07:57PM +0800, Jeremy Kerr wrote:
> This change adds warnings to check for:
>=20
>  1) enabling a clock that hasn't been prepared; and
>=20
>  2) unpreparing a clock that is still enabled
>=20
> While the correctness can't be guaranteed, these warnings should cover
> most situations.
>=20
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
>=20
> ---
>  drivers/clk/clk.c |    4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 51dbd33..2369959 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -35,6 +35,8 @@ void clk_unprepare(struct clk *clk)
>  	if (!clk->ops->unprepare)
>  		return;
> =20
> +	WARN_ON(clk->enable_count);
> +
>  	mutex_lock(&clk->prepare_lock);
>  	if (--clk->prepare_count =3D 0)
>  		clk->ops->unprepare(clk);
> @@ -50,6 +52,8 @@ int clk_enable(struct clk *clk)
>  	if (!clk->ops->enable)
>  		return 0;
> =20
> +	WARN_ON(clk->ops->prepare && clk->prepare_count);
> +
This implies the warning is only issued on clocks that have a prepare
callback.  If we want to enforce the new API the warning here shouldn't
depend on clk->ops->prepare.  (clk_prepare and clk_unprepare need to
be changed then to adapt the prepare_count even in the absence of
clk->ops->prepare.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
