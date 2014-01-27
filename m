From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 27 Jan 2014 08:43:12 +0000
Subject: Re: [PATCH 8/9] X86: remove redundant cpuidle_idle_call()
Message-Id: <52E61C20.50804@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-9-git-send-email-nicolas.pitre@linaro.org>
In-Reply-To: <1390802904-28399-9-git-send-email-nicolas.pitre@linaro.org>
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
>   arch/x86/kernel/process.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 3fb8d95ab8..4505e2a950 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -298,10 +298,7 @@ void arch_cpu_idle_dead(void)
>    */
>   void arch_cpu_idle(void)
>   {
> -	if (cpuidle_idle_call())
> -		x86_idle();
> -	else
> -		local_irq_enable();

For the record, it was pointless to enable the local irq here because it=20
is handled by the cpuidle framework when exiting the idle state.

> +	x86_idle();
>   }
>
>   /*
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

