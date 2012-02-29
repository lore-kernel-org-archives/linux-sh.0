From: Amit Kachhap <amit.kachhap@linaro.org>
Date: Wed, 29 Feb 2012 06:53:04 +0000
Subject: Re: [PATCH v6 3/9] ARM: exynos: Consolidate time keeping and irq enable
Message-Id: <CAK44p224NL6+UuLKZ2vrP=CnBOARPBxj5f_+SNX_4j3RfBesEg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
 <1330485109-7327-4-git-send-email-rob.lee@linaro.org>
In-Reply-To: <1330485109-7327-4-git-send-email-rob.lee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi,

I verified this patch on exynos4 based origen board.

Tested-by: Amit Daniel <amit.kachhap@linaro.org>

Thanks,
Amit D

On 29 February 2012 08:41, Robert Lee <rob.lee@linaro.org> wrote:
> Enable core cpuidle timekeeping and irq enabling and remove that
> handling from this code.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
> =A0arch/arm/mach-exynos/cpuidle.c | =A0 53 ++++--------------------------=
---------
> =A01 files changed, 6 insertions(+), 47 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidl=
e.c
> index 9bf6743..75bb88b 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -20,6 +20,7 @@
> =A0#include <asm/smp_scu.h>
> =A0#include <asm/suspend.h>
> =A0#include <asm/unified.h>
> +#include <asm/cpuidle.h>
> =A0#include <mach/regs-pmu.h>
> =A0#include <mach/pmu.h>
>
> @@ -34,22 +35,12 @@
>
> =A0#define S5P_CHECK_AFTR =A0 =A0 =A0 =A0 0xFCBA0D10
>
> -static int exynos4_enter_idle(struct cpuidle_device *dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int index);
> =A0static int exynos4_enter_lowpower(struct cpuidle_device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct cpu=
idle_driver *drv,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int index);
>
> =A0static struct cpuidle_state exynos4_cpuidle_set[] =3D {
> - =A0 =A0 =A0 [0] =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enter =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D exynos4_enter_idle,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .exit_latency =A0 =A0 =A0 =A0 =A0 =3D 1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .target_residency =A0 =A0 =A0 =3D 100000,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D CPUIDLE_FLAG_TIME_VALID,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D "C0",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D "ARM clock gating(WFI)",
> - =A0 =A0 =A0 },
> + =A0 =A0 =A0 [0] =3D CPUIDLE_ARM_WFI_STATE,
> =A0 =A0 =A0 =A0[1] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.enter =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D exynos4_enter_lowpower,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.exit_latency =A0 =A0 =A0 =A0 =A0 =3D 300,
> @@ -63,8 +54,9 @@ static struct cpuidle_state exynos4_cpuidle_set[] =3D {
> =A0static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
>
> =A0static struct cpuidle_driver exynos4_idle_driver =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "exynos4_idle",
> - =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "exynos4_idle=
",
> + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 .en_core_tk_irqen =A0 =A0 =A0 =3D 1,
> =A0};
>
> =A0/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
> @@ -103,13 +95,8 @@ static int exynos4_enter_core0_aftr(struct cpuidle_de=
vice *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct cpu=
idle_driver *drv,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int index)
> =A0{
> - =A0 =A0 =A0 struct timeval before, after;
> - =A0 =A0 =A0 int idle_time;
> =A0 =A0 =A0 =A0unsigned long tmp;
>
> - =A0 =A0 =A0 local_irq_disable();
> - =A0 =A0 =A0 do_gettimeofday(&before);
> -
> =A0 =A0 =A0 =A0exynos4_set_wakeupmask();
>
> =A0 =A0 =A0 =A0/* Set value of power down register for aftr mode */
> @@ -148,34 +135,6 @@ static int exynos4_enter_core0_aftr(struct cpuidle_d=
evice *dev,
> =A0 =A0 =A0 =A0/* Clear wakeup state register */
> =A0 =A0 =A0 =A0__raw_writel(0x0, S5P_WAKEUP_STAT);
>
> - =A0 =A0 =A0 do_gettimeofday(&after);
> -
> - =A0 =A0 =A0 local_irq_enable();
> - =A0 =A0 =A0 idle_time =3D (after.tv_sec - before.tv_sec) * USEC_PER_SEC=
 +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (after.tv_usec - before.tv_usec);
> -
> - =A0 =A0 =A0 dev->last_residency =3D idle_time;
> - =A0 =A0 =A0 return index;
> -}
> -
> -static int exynos4_enter_idle(struct cpuidle_device *dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cpui=
dle_driver *drv,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int index)
> -{
> - =A0 =A0 =A0 struct timeval before, after;
> - =A0 =A0 =A0 int idle_time;
> -
> - =A0 =A0 =A0 local_irq_disable();
> - =A0 =A0 =A0 do_gettimeofday(&before);
> -
> - =A0 =A0 =A0 cpu_do_idle();
> -
> - =A0 =A0 =A0 do_gettimeofday(&after);
> - =A0 =A0 =A0 local_irq_enable();
> - =A0 =A0 =A0 idle_time =3D (after.tv_sec - before.tv_sec) * USEC_PER_SEC=
 +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (after.tv_usec - before.tv_usec);
> -
> - =A0 =A0 =A0 dev->last_residency =3D idle_time;
> =A0 =A0 =A0 =A0return index;
> =A0}
>
> @@ -190,7 +149,7 @@ static int exynos4_enter_lowpower(struct cpuidle_devi=
ce *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_index =3D drv->safe_state_index;
>
> =A0 =A0 =A0 =A0if (new_index =3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return exynos4_enter_idle(dev, drv, new_ind=
ex);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return cpuidle_simple_enter(dev, drv, new_i=
ndex);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return exynos4_enter_core0_aftr(dev, drv, =
new_index);
> =A0}
> --
> 1.7.1
>
