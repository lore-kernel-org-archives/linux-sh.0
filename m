From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 29 Jul 2013 13:47:50 +0000
Subject: Re: [PATCH] SH: cpuidle: Add missing parameter for cpuidle_register()
Message-Id: <51F67286.5010402@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1374790444-25473-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1374790444-25473-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms+renesas@verge.net.au>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/26/2013 12:14 AM, Geert Uytterhoeven wrote:
> arch/sh/kernel/cpu/shmobile/cpuidle.c: In function 'sh_mobile_setup_cpuid=
le':
> arch/sh/kernel/cpu/shmobile/cpuidle.c:102:2: error: too few arguments to =
function 'cpuidle_register'
> include/linux/cpuidle.h:129:12: note: declared here
> arch/sh/kernel/cpu/shmobile/cpuidle.c:94:6: warning: unused variable 'ret=
' [-Wunused-variable]
>=20
> Add the missing parameter, and remove the unused variable.
>=20
> Both introduced by commit b181a3b03f866776211f22390c185c4da1dc45ff ("SH:
> cpuidle: use init/exit common routine").
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Thanks for the fix.

Applied to my tree.

>  arch/sh/kernel/cpu/shmobile/cpuidle.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/s=
hmobile/cpuidle.c
> index d306225..e3abfd4 100644
> --- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
> +++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> @@ -91,13 +91,11 @@ static struct cpuidle_driver cpuidle_driver =3D {
> =20
>  int __init sh_mobile_setup_cpuidle(void)
>  {
> -	int ret;
> -
>  	if (sh_mobile_sleep_supported & SUSP_SH_SF)
>  		cpuidle_driver.states[1].disabled =3D false;
> =20
>  	if (sh_mobile_sleep_supported & SUSP_SH_STANDBY)
>  		cpuidle_driver.states[2].disabled =3D false;
> =20
> -	return cpuidle_register(&cpuidle_driver);
> +	return cpuidle_register(&cpuidle_driver, NULL);
>  }
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

