From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 05 Nov 2015 08:43:31 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Introduce ARCH_RENESAS
Message-Id: <3748528.BkhGxHFj5s@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1446702397-24078-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1446702397-24078-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 05 November 2015 14:46:37 Simon Horman wrote:
>  config PM_RCAR
>         bool
> @@ -29,10 +31,11 @@ config ARCH_RMOBILE
>         select SYS_SUPPORTS_SH_CMT
>         select SYS_SUPPORTS_SH_TMU
>  
> -menuconfig ARCH_SHMOBILE_MULTI
> +config ARCH_RENESAS
>         bool "Renesas ARM SoCs" if ARCH_MULTI_V7
>         depends on MMU
>         select ARCH_SHMOBILE
> +       select ARCH_SHMOBILE_MULTI
>         select HAVE_ARM_SCU if SMP
>         select HAVE_ARM_TWD if SMP
>         select ARM_GIC
> 

The patch looks mostly good to me, but please leave this as a
'menuconfig' rather than 'config'. I'd like to keep having one
Kconfig submenu for each mach-* directory, as most platforms
do today. We should really fix the ones that don't currently do
it like this.

	Arnd
