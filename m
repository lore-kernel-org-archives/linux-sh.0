From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 27 Jan 2014 08:33:13 +0000
Subject: Re: [PATCH 5/9] ARM: remove redundant cpuidle_idle_call()
Message-Id: <52E619C9.4050406@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-6-git-send-email-nicolas.pitre@linaro.org>
In-Reply-To: <1390802904-28399-6-git-send-email-nicolas.pitre@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 01/27/2014 07:08 AM, Nicolas Pitre wrote:
> The core idle loop now takes care of it.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
>   arch/arm/kernel/process.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 725b8c95e0..34a59b7614 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -30,7 +30,6 @@
>   #include <linux/uaccess.h>
>   #include <linux/random.h>
>   #include <linux/hw_breakpoint.h>
> -#include <linux/cpuidle.h>
>   #include <linux/leds.h>
>   #include <linux/reboot.h>
>
> @@ -133,7 +132,11 @@ EXPORT_SYMBOL_GPL(arm_pm_restart);
>
>   void (*arm_pm_idle)(void);
>
> -static void default_idle(void)
> +/*
> + * Called from the core idle loop.
> + */
> +
> +void arch_cpu_idle(void)
>   {
>   	if (arm_pm_idle)
>   		arm_pm_idle();
> @@ -163,15 +166,6 @@ void arch_cpu_idle_dead(void)
>   #endif
>
>   /*
> - * Called from the core idle loop.
> - */
> -void arch_cpu_idle(void)
> -{
> -	if (cpuidle_idle_call())
> -		default_idle();
> -}
> -
> -/*
>    * Called by kexec, immediately prior to machine_kexec().
>    *
>    * This must completely disable all secondary CPUs; simply causing thos=
e CPUs
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

