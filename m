From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Tue, 17 Jan 2012 01:54:20 +0000
Subject: Re: [RFC PATCH 05/10] sh: intc: remove dependency on NR_IRQS
Message-Id: <CABMQnVKfitZu01_sKeVoC94y3GjbfTHqFEZ8ANWF4PCqA6F-Ug@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
 <1326472451-9002-6-git-send-email-robherring2@gmail.com>
In-Reply-To: <1326472451-9002-6-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi,

2012/1/14 Rob Herring <robherring2@gmail.com>:
> From: Rob Herring <rob.herring@calxeda.com>
>
> SH intc has a compile time dependency on NR_IRQS. Make this dependency a
> local define so that shmobile (and ARM in general) can have run-time
> NR_IRQS setting. SH has NR_IRQS set to 512 and shmobile has NR_IRQS set to
> 1024, so we are using the maximum.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> =A0drivers/sh/intc/balancing.c | =A0 =A02 +-
> =A0drivers/sh/intc/core.c =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/sh/intc/handle.c =A0 =A0| =A0 =A02 +-
> =A0drivers/sh/intc/internals.h | =A0 =A09 +++++++++
> =A0drivers/sh/intc/virq.c =A0 =A0 =A0| =A0 =A02 +-
> =A05 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/sh/intc/balancing.c b/drivers/sh/intc/balancing.c
> index cec7a96..bc78080 100644
> --- a/drivers/sh/intc/balancing.c
> +++ b/drivers/sh/intc/balancing.c
> @@ -9,7 +9,7 @@
> =A0*/
> =A0#include "internals.h"
>
> -static unsigned long dist_handle[NR_IRQS];
> +static unsigned long dist_handle[INTC_NR_IRQS];
>
> =A0void intc_balancing_enable(unsigned int irq)
> =A0{
> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
> index e53e449..2fde897 100644
> --- a/drivers/sh/intc/core.c
> +++ b/drivers/sh/intc/core.c
> @@ -42,7 +42,7 @@ unsigned int nr_intc_controllers;
> =A0* - this needs to be at least 2 for 5-bit priorities on 7780
> =A0*/
> =A0static unsigned int default_prio_level =3D 2; =A0 =A0/* 2 - 16 */
> -static unsigned int intc_prio_level[NR_IRQS]; =A0/* for now */
> +static unsigned int intc_prio_level[INTC_NR_IRQS]; =A0 =A0 /* for now */
>
> =A0unsigned int intc_get_dfl_prio_level(void)
> =A0{
> diff --git a/drivers/sh/intc/handle.c b/drivers/sh/intc/handle.c
> index 057ce56..f461d53 100644
> --- a/drivers/sh/intc/handle.c
> +++ b/drivers/sh/intc/handle.c
> @@ -13,7 +13,7 @@
> =A0#include <linux/spinlock.h>
> =A0#include "internals.h"
>
> -static unsigned long ack_handle[NR_IRQS];
> +static unsigned long ack_handle[INTC_NR_IRQS];
>
> =A0static intc_enum __init intc_grp_id(struct intc_desc *desc,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in=
tc_enum enum_id)
> diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
> index b0e9155..469f092 100644
> --- a/drivers/sh/intc/internals.h
> +++ b/drivers/sh/intc/internals.h
> @@ -6,6 +6,15 @@
> =A0#include <linux/radix-tree.h>
> =A0#include <linux/device.h>
>
> +#define INTC_NR_IRQS =A0 1024

On SH, INTC_NR_IRQS ( NR_IRQS )  is using to by arch/sh/kernel/machvec.c.
And, this is defined by arch/sh/include/asm/irq.h.
You need to remove or rename from these.

> +
> +#ifndef evt2irq
> +#define evt2irq(evt) =A0 =A0 =A0 =A0 =A0 =A0(((evt) >> 5) - 16)
> +#endif
> +#ifndef irq2evt
> +#define irq2evt(irq) =A0 =A0 =A0 =A0 =A0 =A0(((irq) + 16) << 5)
> +#endif
> +

These are defined in arch/arm/mach-shmobile/include/mach/irqs.h and
arch/sh/include/asm/irq.h.

I propose that linux/sh_intc.h defines these.

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6
