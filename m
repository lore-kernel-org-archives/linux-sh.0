From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Wed, 15 Sep 2010 05:53:20 +0000
Subject: Re: [PATCH 0/3] Common struct clk implementation, v7
Message-Id: <20100915055320.GB23518@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1284522014.516876.675872472687.0.gpush@pororo>
In-Reply-To: <1284522014.516876.675872472687.0.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi,

	please put sh ml in cc too as we use the same clkdev

Best Regards,
J.
On 11:40 Wed 15 Sep     , Jeremy Kerr wrote:
> Hi all,
>=20
> These patches are an attempt to allow platforms to share clock code. At
> present, the definitions of 'struct clk' are local to platform code,
> which makes allocating and initialising cross-platform clock sources
> difficult, and makes it impossible to compile a single image containing
> support for two ARM platforms with different struct clks.
>=20
> The two patches are for the architecture-independent kernel code,
> introducing the common clk infrastructure. The changelog for the first
> patch includes details about the new clock definitions.
>=20
> As requested by rmk, I've put together a small series of patches
> illustrating the usage of the common struct clock on the ARM imx51
> platform. These are available in my git tree:
>=20
>  git://kernel.ubuntu.com/jk/dt/linux-2.6
>=20
> in the clk-common-mx51 branch (clk-common..clk-common-mx51). There is
> also a port  for versatile (clk-common-versatile) in this tree too.
>=20
> The approach I've taken with the imx51 port is to temporarly duplicate
> the platform-common clock code (ie, for all mxc-based boards) to enable
> usage of the common struct clk on one machine (imx51), while leaving the
> others as-is. For a proper platform-wide usage of the common struct clk,
> we'd be better off doing the whole platform at once. However, mx51 is
> the only mxc-based HW I have, hence the duplicated example port.
>=20
> In the example port, the first change simply converts the mxc's struct
> clk to a struct clk_mxc, using the new API.  The subsequent patches move
> certain clocks to more specific data structures (eg clk_fixed and
> clk_pll) where possible.
>=20
> Ben Herrenschmidt is looking at using common struct clk code for powerpc
> too, hence the kernel-wide approach.
>=20
> Many thanks to the following for their input:
>  * Ben Dooks <ben-linux@fluff.org>
>  * Baruch Siach <baruch@tkos.co.il>
>  * Russell King <linux@arm.linux.org.uk>
>  * Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>  * Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>=20
> Russell - now that we've had a few platforms ported to the common clk
> infrastructure, I believe it's ready to merge. If so, do you want this
> in the patch tracker? Otherwise, let me know what needs changing.
>=20
> This series includes a patch to hook the common clk API into ARM.
>=20
> Cheers,
>=20
>=20
> Jeremy
>=20
> --
> v7:
>  * change CLK_INIT to initialise clk->mutex statically
>=20
> v6:
>  * fixed up references to 'clk_operations' in the changelog
>=20
> v5:
>  * uninline main API, and share definitions with !USE_COMMON_STRUCT_CLK
>  * add __clk_get
>  * delay mutex init
>  * kerneldoc for struct clk
>=20
> v4:
>  * use mutex for enable/disable locking
>  * DEFINE_CLK -> INIT_CLK, and pass the clk name for mutex init
>  * struct clk_operations -> struct clk_ops
>=20
> v3:
>  * do clock usage refcounting in common code
>  * provide sample port
>=20
> v2:
>  * no longer ARM-specific
>  * use clk_operations
>=20
> ---
> Jeremy Kerr (3):
>       Add a common struct clk
>       clk: Generic support for fixed-rate clocks
>       arm/clkdev: Allow common struct clk usage
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
