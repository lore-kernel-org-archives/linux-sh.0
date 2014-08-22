From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 22 Aug 2014 10:48:33 +0000
Subject: Re: [PATCH 5/6] ARM: shmobile: Add CPU notifier for CPUIdle boot vector
Message-Id: <CANqRtoR5aCLv9_Qnh5gzjd3-zZCnZGk95sO0sLc7FXR+-r5Kxw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53DB6284.3090506@renesas.com>
In-Reply-To: <53DB6284.3090506@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: keita kobayashi <keita.kobayashi.ym@renesas.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Kobayashi-san,

Thanks for your patches. About the use of CPU notifiers, please see my
question below:

On Fri, Aug 1, 2014 at 6:48 PM, keita kobayashi
<keita.kobayashi.ym@renesas.com> wrote:
> Add CPU notifiers for the shared mach-shmobile cpuidle code.
>
> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> ---
>  arch/arm/mach-shmobile/cpuidle.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
> index 19c0c98..1771dd3 100644
> --- a/arch/arm/mach-shmobile/cpuidle.c
> +++ b/arch/arm/mach-shmobile/cpuidle.c
> @@ -20,6 +20,27 @@
>  #include <asm/io.h>
>  #include "common.h"
>
> +static int shmobile_cpuidle_notifier_call(struct notifier_block *nfb,
> +                                         unsigned long action, void *hcpu)
> +{
> +       unsigned int cpu = (long)hcpu;
> +
> +       switch (action) {
> +       case CPU_ONLINE:
> +       case CPU_STARTING:
> +       case CPU_STARTING_FROZEN:
> +               /* For this particular CPU register CPUIdle boot vector */
> +               shmobile_smp_hook(cpu, virt_to_phys(cpu_resume), 0);
> +               break;
> +       };
> +
> +       return NOTIFY_OK;
> +}

In my earlier CPUIdle and reset vector sharing experiments it seemed
enough to install the reset vector with CPU notifier using CPU_ONLINE.

Can you please explain the reason why you also include CPU_STARTING
and CPU_STARTING_FROZEN above?

Thanks,

/ magnus
