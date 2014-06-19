From: Paul Bolle <pebolle@tiscali.nl>
Date: Thu, 19 Jun 2014 07:49:35 +0000
Subject: Re: [PATCH v3] ARM: shmobile: Mark all SoCs in shmobile as CPUFreq, capable
Message-Id: <1403164175.23136.13.camel@x220>
List-Id: <linux-sh.vger.kernel.org>
References: <538FE8D8.3050602@bp.renesas.com>
In-Reply-To: <538FE8D8.3050602@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 2014-06-05 at 12:49 +0900, Gaku Inami wrote:
> From: Benoit Cousson <bcousson@baylibre.com>
> 
> Mark all SoCs in shmobile as CPUFreq capable
> on multiplatform build only.
> 
> Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
> [gaku.inami.xw@bp.renesas.com: Move the definition of cpufreq capable]
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> ---

This patch landed in next-20140619.

> Changes since version 1:
> - changed "Signed-off-by" and "From" correctly.
> - fixed typo.
> 
> Changes since version 2:
> - moved the definition of cpufreq capable for shmobile.
> - reworked based on renesas-devel-v3.15-rc8-20140605.
> 
>  arch/arm/mach-shmobile/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 2a7712b..3b28bd8 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -13,6 +13,8 @@ config ARCH_SHMOBILE_MULTI
>  	select NO_IOPORT_MAP
>  	select PINCTRL
>  	select ARCH_REQUIRE_GPIOLIB
> +	select ARCH_HAS_CPUFREQ

The symbol ARCH_HAS_CPUFREQ was just removed in next-20140616, see
commit e49d9b375628 ("ARM: Remove ARCH_HAS_CPUFREQ config option"). So
selecting that became a nop.

Is the trivial patch to drop this select statement queued somewhere? 

(Grepping for CPU_FREQ and CPUFREQ in arch/arm/mach-shmobile suggests
that this trivial patch is all that is needed at this point.)

> +	select ARCH_HAS_OPP
>  
>  if ARCH_SHMOBILE_MULTI
>  


Paul Bolle

