From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 13 Jul 2015 08:58:07 +0000
Subject: Re: [PATCH] ARM: shmobile: apmu: silence build warnings
Message-Id: <20150713085807.GA3886@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
List-Id: <linux-sh.vger.kernel.org>
References: <1436561296-29141-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1436561296-29141-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 10:04:06AM +0900, Simon Horman wrote:
> Hi Wolfram,
>=20
> On Fri, Jul 10, 2015 at 10:48:16PM +0200, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >=20
> > With shmobile_defconfig but SMP=3Dn && SUSPEND=3Dn, I get:
> >=20
> > arch/arm/mach-shmobile/platsmp-apmu.c:49:12: warning: 'apmu_power_off' =
defined but not used [-Wunused-function]
> > arch/arm/mach-shmobile/platsmp-apmu.c:70:12: warning: 'apmu_wrap' defin=
ed but not used [-Wunused-function]
> >=20
> > Annotate those functions like the functions around it.
>=20
> thanks for noticing this.
>=20
> I'm not familiar with when it is appropriate to use __maybe_unused but do=
es
> anything speak against using #if as per the conditional compilation of the
> callers in platsmp-apmu.c of the above functions?

I did my approach for consistency reasons. It looked to me that the
*_on/off functions wanted to be grouped at the beginning.

Your approach works but looks fragile to me as soon as the ifdeffery of
the callers change. So, we could move the code into the callers ifdef
block, but we should do this consistently, even for the functions
currently marked __maybe_unused. That would scatter them a little,
though. apmu_wrap needs its own ifdeffery in any case.

Do you have a preference?

>=20
> diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobi=
le/platsmp-apmu.c
> index b0790fc32282..54cf153b570f 100644
> --- a/arch/arm/mach-shmobile/platsmp-apmu.c
> +++ b/arch/arm/mach-shmobile/platsmp-apmu.c
> @@ -46,12 +46,14 @@ static int __maybe_unused apmu_power_on(void __iomem =
*p, int bit)
>  	return 0;
>  }
> =20
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND)
>  static int apmu_power_off(void __iomem *p, int bit)
>  {
>  	/* request Core Standby for next WFI */
>  	writel_relaxed(3, p + CPUNCR_OFFS(bit));
>  	return 0;
>  }
> +#endif
> =20
>  static int __maybe_unused apmu_power_off_poll(void __iomem *p, int bit)
>  {
> @@ -67,12 +69,14 @@ static int __maybe_unused apmu_power_off_poll(void __=
iomem *p, int bit)
>  	return 0;
>  }
> =20
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND) || defined(CO=
NFIG_SMP)
>  static int apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu))
>  {
>  	void __iomem *p =3D apmu_cpus[cpu].iomem;
> =20
>  	return p ? fn(p, apmu_cpus[cpu].bit) : -EINVAL;
>  }
> +#endif
> =20
>  static void apmu_init_cpu(struct resource *res, int cpu, int bit)
>  {

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVo32eAAoJEBQN5MwUoCm24QkQALOLjXh5NN8joNNzNuYvvSol
OJgXGqYvImlU2uoUjNAqU1cbSuWRfs2nFUK0CsEU0BNwzBSE9e/I/+4dA0D69+kV
Xng2Eaj767eA3y6HBAH7H0s3/okckxGMAt07KdQ8d8yB7n3JHnPGMUDBTJpZj3H+
YoMaqDwolftBOaUKQMHnKSIqioKUTJQUCVv5mldvhnYW3JuBJYHdSNFN2uHGci9f
qegARBXBjSeunfPFlbLFSE3lG6ZKtFcnsCJF8Ln+Tpng5+OWHepKAdwZBT/tP1M6
QJXw4Uq82o+IA3SlGcazPSnq0GJDg1KxQoNle1CrzOi6BI5guUASPinSaxwyjQCC
9S/hdhDLj5DyPoHUqnEUimcA52hcsPQ3jYWlgZsjcB5nUNqoqJL/bRoDe/JmhQLq
cuLiC5qXQ9+AGShuo5O57Uzdw79D1YITKmzQUd0MhtQXblDfCK+uK0A4khH1GMhF
NDxYW0FB8QFrGOzTfEV6ZjgPhConnj8v33NeC/78O+aS/w6o31CC1ANOcApe3grh
/PQVWuY7vJyO2bdYJgk83k7mxAiqf1E3ATXbnVmME7py6cmxwhY4IIVXxqyt/Z1U
GO0b805RF3lWGKaWIQZqiTmP5J9M2QTVvTeFyw7xANmYd2zsGOuufBYN6Im7JUPL
ruYQ9K0saxdGR4Jq5NA/
=UN8T
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
