From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Tue, 16 Dec 2014 11:14:40 +0000
Subject: Re: [PATCH] clocksource: sh_tmu: Set cpu_possible_mask to fix SMP broadcast
Message-Id: <54901420.50403@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20141216094854.22639.69181.sendpatchset@w520>
In-Reply-To: <20141216094854.22639.69181.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, tglx@linutronix.de

On 12/16/2014 10:48 AM, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Update the TMU driver to use cpu_possible_mask as cpumask to make
> r8a7779 SMP work as expected with or without the ARM TWD timer.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Applied as a 3.18 fix.

Thanks !

   -- Daniel

ps: May I suggest to use the CLOCK_EVT_FEAT_DYNIRQ flag for this driver ?

> ---
>
>   drivers/clocksource/sh_tmu.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- 0001/drivers/clocksource/sh_tmu.c
> +++ work/drivers/clocksource/sh_tmu.c	2014-12-16 17:49:49.000000000 +0900
> @@ -428,7 +428,7 @@ static void sh_tmu_register_clockevent(s
>   	ced->features =3D CLOCK_EVT_FEAT_PERIODIC;
>   	ced->features |=3D CLOCK_EVT_FEAT_ONESHOT;
>   	ced->rating =3D 200;
> -	ced->cpumask =3D cpumask_of(0);
> +	ced->cpumask =3D cpu_possible_mask;
>   	ced->set_next_event =3D sh_tmu_clock_event_next;
>   	ced->set_mode =3D sh_tmu_clock_event_mode;
>   	ced->suspend =3D sh_tmu_clock_event_suspend;
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

