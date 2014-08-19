From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Aug 2014 00:33:34 +0000
Subject: Re: [PATCH 2/8] ARM: shmobile: Initial r8a7794 SoC support
Message-Id: <CANqRtoQHPg05JXzAWJA+SAtjn=OXfwWx8JBrJCZEb6_XXt43KQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1408377107-3822-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1408377107-3822-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 19, 2014 at 12:51 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Initial support for the r8a7794 SoC, based on work by Hisashi Nakamura.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/Kconfig         |  4 ++++
>  arch/arm/mach-shmobile/Makefile        |  1 +
>  arch/arm/mach-shmobile/Makefile.boot   |  1 +
>  arch/arm/mach-shmobile/setup-r8a7794.c | 34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 40 insertions(+)
>  create mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c
>
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 5814754..0ef01d4 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -41,6 +41,10 @@ config ARCH_R8A7791
>         select RENESAS_IRQC
>         select SYS_SUPPORTS_SH_CMT
>
> +config ARCH_R8A7794
> +       bool "R-Car E2 (R8A77940)"
> +       select RENESAS_IRQC
> +
>  comment "Renesas ARM SoCs Board Type"
>
>  config MACH_KOELSCH
> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
> index 2eb2c5b..315784f 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_R8A7779)    += setup-r8a7779.o
>  obj-$(CONFIG_ARCH_R8A7790)     += setup-r8a7790.o
>  obj-$(CONFIG_ARCH_R8A7790)     += setup-r8a7790.o setup-rcar-gen2.o
>  obj-$(CONFIG_ARCH_R8A7791)     += setup-r8a7791.o setup-rcar-gen2.o
> +obj-$(CONFIG_ARCH_R8A7794)     += setup-r8a7794.o setup-rcar-gen2.o
>  obj-$(CONFIG_ARCH_EMEV2)       += setup-emev2.o
>  obj-$(CONFIG_ARCH_R7S72100)    += setup-r7s72100.o
>
> diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
> index a23e155..dbc0482 100644
> --- a/arch/arm/mach-shmobile/Makefile.boot
> +++ b/arch/arm/mach-shmobile/Makefile.boot
> @@ -12,6 +12,7 @@ loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
>  loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
>  loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
>  loadaddr-$(CONFIG_MACH_MARZEN) += 0x60008000
> +loadaddr-$(CONFIG_MACH_ALT) += 0x40008000
>
>  __ZRELADDR     := $(sort $(loadaddr-y))
>     zreladdr-y   += $(__ZRELADDR)

Hi Ulrich,

Thanks for your patches. This hunk with loadaddr can go away. It is
specific to ALT anyway. Also, we use dynamic calculation of the load
address in case of zImage and multiplatform, so you want to make sure
to use zImage instead of uImage and then this is not needed.

Cheers,

/ magnus
