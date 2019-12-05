From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Thu, 05 Dec 2019 11:15:05 +0000
Subject: Re: [PATCH 1/2] cpuidle: Drop disabled field from struct cpuidle_state
Message-Id: <6c7863ab-8efc-ab2c-cab0-3cd68e415a57@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <5961586.ml7s97geqL@kreacher> <3690440.Wzkxfdnirm@kreacher>
In-Reply-To: <3690440.Wzkxfdnirm@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

On 21/11/2019 19:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> After recent cpuidle updates the "disabled" field in struct
> cpuidle_state is only used by two drivers (intel_idle and shmobile
> cpuidle) for marking unusable idle states, but that may as well be
> achieved with the help of a state flag, so define an "unusable" idle
> state flag, CPUIDLE_FLAG_UNUSABLE, make the drivers in question use
> it instead of the "disabled" field and make the core set
> CPUIDLE_STATE_DISABLED_BY_DRIVER for the idle states with that flag
> set.
>=20
> After the above changes, the "disabled" field in struct cpuidle_state
> is not used any more, so drop it.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>=20
> Changes from RFC:
>=20
>  - Do not add extra braces (unrelated to the rest of the patch).
>=20
> ---
>  arch/sh/kernel/cpu/shmobile/cpuidle.c |    8 ++++----
>  drivers/cpuidle/cpuidle.c             |    2 +-
>  drivers/cpuidle/poll_state.c          |    1 -
>  drivers/idle/intel_idle.c             |    6 +++---
>  include/linux/cpuidle.h               |    2 +-
>  5 files changed, 9 insertions(+), 10 deletions(-)
>=20
> Index: linux-pm/drivers/idle/intel_idle.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-pm.orig/drivers/idle/intel_idle.c
> +++ linux-pm/drivers/idle/intel_idle.c
> @@ -1291,8 +1291,8 @@ static void sklh_idle_state_table_update
>  			return;
>  	}
> =20
> -	skl_cstates[5].disabled =3D 1;	/* C8-SKL */
> -	skl_cstates[6].disabled =3D 1;	/* C9-SKL */
> +	skl_cstates[5].flags |=3D CPUIDLE_FLAG_UNUSABLE;	/* C8-SKL */
> +	skl_cstates[6].flags |=3D CPUIDLE_FLAG_UNUSABLE;	/* C9-SKL */
>  }
>  /*
>   * intel_idle_state_table_update()
> @@ -1355,7 +1355,7 @@ static void __init intel_idle_cpuidle_dr
>  			continue;
> =20
>  		/* if state marked as disabled, skip it */
> -		if (cpuidle_state_table[cstate].disabled !=3D 0) {
> +		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUSABLE) {
>  			pr_debug("state %s is disabled\n",
>  				 cpuidle_state_table[cstate].name);
>  			continue;
> Index: linux-pm/include/linux/cpuidle.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-pm.orig/include/linux/cpuidle.h
> +++ linux-pm/include/linux/cpuidle.h
> @@ -54,7 +54,6 @@ struct cpuidle_state {
>  	unsigned int	exit_latency; /* in US */
>  	int		power_usage; /* in mW */
>  	unsigned int	target_residency; /* in US */
> -	bool		disabled; /* disabled on all CPUs */
> =20
>  	int (*enter)	(struct cpuidle_device *dev,
>  			struct cpuidle_driver *drv,
> @@ -77,6 +76,7 @@ struct cpuidle_state {
>  #define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
>  #define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
>  #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state=
 */
> +#define CPUIDLE_FLAG_UNUSABLE	BIT(3) /* avoid using this state */
> =20
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> Index: linux-pm/arch/sh/kernel/cpu/shmobile/cpuidle.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-pm.orig/arch/sh/kernel/cpu/shmobile/=
cpuidle.c
> +++ linux-pm/arch/sh/kernel/cpu/shmobile/cpuidle.c
> @@ -67,7 +67,7 @@ static struct cpuidle_driver cpuidle_dri
>  			.enter =3D cpuidle_sleep_enter,
>  			.name =3D "C2",
>  			.desc =3D "SuperH Sleep Mode [SF]",
> -			.disabled =3D true,
> +			.flags =3D CPUIDLE_FLAG_UNUSABLE,
>  		},
>  		{
>  			.exit_latency =3D 2300,
> @@ -76,7 +76,7 @@ static struct cpuidle_driver cpuidle_dri
>  			.enter =3D cpuidle_sleep_enter,
>  			.name =3D "C3",
>  			.desc =3D "SuperH Mobile Standby Mode [SF]",
> -			.disabled =3D true,
> +			.flags =3D CPUIDLE_FLAG_UNUSABLE,
>  		},
>  	},
>  	.safe_state_index =3D 0,
> @@ -86,10 +86,10 @@ static struct cpuidle_driver cpuidle_dri
>  int __init sh_mobile_setup_cpuidle(void)
>  {
>  	if (sh_mobile_sleep_supported & SUSP_SH_SF)
> -		cpuidle_driver.states[1].disabled =3D false;
> +		cpuidle_driver.states[1].flags =3D CPUIDLE_FLAG_NONE;

That will overwrite other flags value, bit operation should be used here
to remove CPUIDLE_FLAG_UNUSABLE.

>  	if (sh_mobile_sleep_supported & SUSP_SH_STANDBY)
> -		cpuidle_driver.states[2].disabled =3D false;
> +		cpuidle_driver.states[2].flags =3D CPUIDLE_FLAG_NONE;
> =20
>  	return cpuidle_register(&cpuidle_driver, NULL);
>  }
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -570,7 +570,7 @@ static int __cpuidle_register_device(str
>  		return -EINVAL;
> =20
>  	for (i =3D 0; i < drv->state_count; i++)
> -		if (drv->states[i].disabled)
> +		if (drv->states[i].flags & CPUIDLE_FLAG_UNUSABLE)
>  			dev->states_usage[i].disable |=3D CPUIDLE_STATE_DISABLED_BY_DRIVER;
> =20
>  	per_cpu(cpuidle_devices, dev->cpu) =3D dev;
> Index: linux-pm/drivers/cpuidle/poll_state.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-pm.orig/drivers/cpuidle/poll_state.c
> +++ linux-pm/drivers/cpuidle/poll_state.c
> @@ -53,7 +53,6 @@ void cpuidle_poll_state_init(struct cpui
>  	state->target_residency_ns =3D 0;
>  	state->power_usage =3D -1;
>  	state->enter =3D poll_idle;
> -	state->disabled =3D false;
>  	state->flags =3D CPUIDLE_FLAG_POLLING;
>  }
>  EXPORT_SYMBOL_GPL(cpuidle_poll_state_init);
>=20
>=20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
