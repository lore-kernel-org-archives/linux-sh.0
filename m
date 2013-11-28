From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Nov 2013 05:32:18 +0000
Subject: Re: [PATCH v3 06/15] ARM: shmobile: koelsch-reference: Initialize CPG device
Message-Id: <CANqRtoREPk38_aj1JaE-MThHQLmWcXHMd4vSEgYX3L7LaT0tjA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385600632-5181-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385600632-5181-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 28, 2013 at 10:03 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> On multiplatform kernels clocks are handled by the CCF CPG driver. It
> must be explicitly initialized by a call to rcar_gen2_clocks_init() with
> the value of the boot mode pins.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Hi Laurent,

Thanks for your efforts. I think this series looks very nice in
general. Please see below for two questions.

> --- a/arch/arm/mach-shmobile/board-koelsch-reference.c
> +++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
> @@ -46,7 +52,7 @@ static const char * const koelsch_boards_compat_dt[] __initconst = {
>  DT_MACHINE_START(KOELSCH_DT, "koelsch")
>         .smp            = smp_ops(r8a7791_smp_ops),
>         .init_early     = r8a7791_init_early,
> -       .init_time      = rcar_gen2_timer_init,
> +       .init_time      = koelsch_init_time,
>         .init_machine   = koelsch_add_standard_devices,
>         .init_late      = shmobile_init_late,
>         .dt_compat      = koelsch_boards_compat_dt,

What is the reason that you need to initialize CCF at ->init_time()?
We used to initialize timers early in the legacy board case but for DT
we've so far been able to initialize timers late. Is it really time to
go back again? =)

As for initializing the CCF, if we go down the route of early CCF
init, can't you put your CCF init call at one shared location in for
instance rcar_gen2_timer_init()?

Thanks,

/ magnus
