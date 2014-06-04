From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 04 Jun 2014 12:08:07 +0000
Subject: Re: [PATCH v2 7/8] ARM: shmobile: Make r8a7791 CPUFreq capable
Message-Id: <CANqRtoRN9uCo36SV-gmEYsFAqpQ_t706zfZx4JPGtpUS29vSMg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <538DB98D.20009@bp.renesas.com>
In-Reply-To: <538DB98D.20009@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Inami-san,

On Tue, Jun 3, 2014 at 9:03 PM, Gaku Inami <gaku.inami.xw@bp.renesas.com> wrote:
> Mark r8a7791 platform as CPUFreq capable
> on multiplatform build only.
>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> ---
>  arch/arm/mach-shmobile/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index a0b2b7f..9636f6e 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -42,6 +42,8 @@ config ARCH_R8A7791
>         bool "R-Car M2 (R8A77910)"
>         select RENESAS_IRQC
>         select SYS_SUPPORTS_SH_CMT
> +       select ARCH_HAS_CPUFREQ
> +       select ARCH_HAS_OPP

Thanks for your patches. In general they look good, but I wonder about
this Kconfig magic for r8a7790 and r8a7791.

Instead of enabling the above for r8a7790 and r8a7791, how about
enabling it for all SoCs included in ARCH_SHMOBILE_MULTI?

Best,

/ magnus
