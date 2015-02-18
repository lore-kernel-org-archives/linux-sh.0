From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Feb 2015 02:52:38 +0000
Subject: Re: [PATCH 04/05] ARM: shmobile: marzen-reference: Remove C board code
Message-Id: <CANqRtoSHASGogwmDpKNS9aK+LLQ80iYMhzxaYe9+dY6fVRnMTQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150218023853.12588.57588.sendpatchset@little-apple>
In-Reply-To: <20150218023853.12588.57588.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 17, 2015 at 6:38 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> The generic r8a7779 machine vector is now feature-wise equivalent
> to the Marzen-reference case, so simply remove the Marzen C board
> code to fall over on the generic r8a7779 machine vector.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  arch/arm/mach-shmobile/Kconfig                  |    7 ---
>  arch/arm/mach-shmobile/Makefile                 |    2
>  arch/arm/mach-shmobile/board-marzen-reference.c |   49 -----------------------
>  3 files changed, 58 deletions(-)
>
> --- 0001/arch/arm/mach-shmobile/Kconfig
> +++ work/arch/arm/mach-shmobile/Kconfig 2015-02-17 02:31:26.496199165 +0900
> @@ -84,13 +84,6 @@ config ARCH_SH73A0
>         select ARCH_RMOBILE
>         select RENESAS_INTC_IRQPIN
>
> -comment "Renesas ARM SoCs Board Type"
> -
> -config MACH_MARZEN
> -       bool "MARZEN board"
> -       depends on ARCH_R8A7779
> -       select REGULATOR_FIXED_VOLTAGE if REGULATOR
> -
>  comment "Renesas ARM SoCs System Configuration"
>  endif
>
> --- 0001/arch/arm/mach-shmobile/Makefile
> +++ work/arch/arm/mach-shmobile/Makefile        2015-02-17 02:29:29.276199586 +0900
> @@ -51,8 +51,6 @@ obj-$(CONFIG_PM_RMOBILE)      += pm-rmobile.o
>
>  # Board objects
>  ifdef CONFIG_ARCH_SHMOBILE_MULTI
> -obj-$(CONFIG_MACH_MARZEN)      += board-marzen-reference.o
> -else
>  obj-$(CONFIG_MACH_APE6EVM)     += board-ape6evm.o
>  obj-$(CONFIG_MACH_APE6EVM_REFERENCE)   += board-ape6evm-reference.o
>  obj-$(CONFIG_MACH_BOCKW)       += board-bockw.o

Oops, the hunk above is wrong. The code both compiled and executed OK though. =)

I will fix and resend after receiving feedback on this series.

Cheers,

/ magnus
