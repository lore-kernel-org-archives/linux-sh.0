From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Sep 2012 08:20:14 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: emev2: enable PMU(Performance Monitoring Unit)
Message-Id: <CANqRtoSLDER9xvVNtzB1Uh4U5b+Q_9uSnSnC7wt2EsoJRhee6w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1346813317-4030-3-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1346813317-4030-3-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Kobayashi-san,

Many thanks for your patches!

On Tue, Sep 4, 2012 at 9:48 PM, Tetsuyuki Kobayshi <koba@kmckk.co.jp> wrote:
> From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
>
> This patch enables PMU(Performance Monitoring Unit) for emev2 when compiled with CONFIG_HW_PERF_EVENTS.
>
> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> ---
>  arch/arm/mach-shmobile/setup-emev2.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
> index dae9aa6..f3ff171 100644
> --- a/arch/arm/mach-shmobile/setup-emev2.c
> +++ b/arch/arm/mach-shmobile/setup-emev2.c
> @@ -36,6 +36,7 @@
>  #include <asm/mach/map.h>
>  #include <asm/mach/time.h>
>  #include <asm/hardware/gic.h>
> +#include <asm/pmu.h>
>
>  static struct map_desc emev2_io_desc[] __initdata = {
>  #ifdef CONFIG_SMP
> @@ -356,6 +357,28 @@ static struct platform_device gio4_device = {
>         },
>  };
>
> +#ifdef CONFIG_HW_PERF_EVENTS
> +static struct resource pmu_resources[] = {
> +       [0] = {
> +               .start  = 152,
> +               .end    = 152,
> +               .flags  = IORESOURCE_IRQ,
> +       },
> +       [1] = {
> +               .start  = 153,
> +               .end    = 153,
> +               .flags  = IORESOURCE_IRQ,
> +       },
> +};
> +
> +static struct platform_device pmu_device = {
> +       .name           = "arm-pmu",
> +       .id             = ARM_PMU_DEVICE_CPU,
> +       .num_resources  = ARRAY_SIZE(pmu_resources),
> +       .resource       = pmu_resources,
> +};
> +#endif
> +
>  static struct platform_device *emev2_early_devices[] __initdata = {
>         &uart0_device,
>         &uart1_device,
> @@ -370,6 +393,9 @@ static struct platform_device *emev2_late_devices[] __initdata = {
>         &gio2_device,
>         &gio3_device,
>         &gio4_device,
> +#ifdef CONFIG_HW_PERF_EVENTS
> +       &pmu_device,
> +#endif

Is there any special reason why you want to wrap the code in #ifdefs?
As you can see, that's not so common for arch/arm/mach-shmobile to use
#ifdefs.

Usually we try to avoid using #ifdefs for regular platform data since
it makes the code more unreadable. The idea behind this is that the
platform device will exist regardless of the configuration and this
rather low potentially additional memory overhead has so far been seen
as acceptable.

Also, is there some way you can use the PMU with the DT (device tree)?
If so then the per-soc device tree files should be updated as well. We
have been requested this from the ARM soc maintainers. Such changes
should be CC:ed to the ARM mailing list so they can see that we are
following the standard way and working with the device tree.

Thank you!

/ magnus
