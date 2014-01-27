From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 27 Jan 2014 08:35:44 +0000
Subject: Re: [PATCH 7/9] SH: remove redundant cpuidle_idle_call()
Message-Id: <52E61A60.3030202@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-8-git-send-email-nicolas.pitre@linaro.org>
In-Reply-To: <1390802904-28399-8-git-send-email-nicolas.pitre@linaro.org>
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
>   arch/sh/kernel/idle.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
> index 2ea4483fd7..be616ee0cf 100644
> --- a/arch/sh/kernel/idle.c
> +++ b/arch/sh/kernel/idle.c
> @@ -16,7 +16,6 @@
>   #include <linux/thread_info.h>
>   #include <linux/irqflags.h>
>   #include <linux/smp.h>
> -#include <linux/cpuidle.h>
>   #include <linux/atomic.h>
>   #include <asm/pgalloc.h>
>   #include <asm/smp.h>
> @@ -40,8 +39,7 @@ void arch_cpu_idle_dead(void)
>
>   void arch_cpu_idle(void)
>   {
> -	if (cpuidle_idle_call())
> -		sh_idle();
> +	sh_idle();
>   }
>
>   void __init select_idle_routine(void)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

