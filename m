From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 18 Feb 2015 07:27:04 +0000
Subject: Re: [PATCH 03/05] ARM: shmobile: r8a7779: Generic SoC SMP support
Message-Id: <8848415.1C9ihezqOX@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150218023842.12588.17833.sendpatchset@little-apple>
In-Reply-To: <20150218023842.12588.17833.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thank you for the patch.

On Wednesday 18 February 2015 11:38:42 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Add a r8a7779-specific SMP operation pointer to support
> all 4 CPU cores through SMP on r8a7779 without C board code.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/setup-r8a7779.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- 0003/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2015-02-17
> 00:46:51.566221714 +0900 @@ -773,6 +773,7 @@ static const char
> *r8a7779_compat_dt[] _
>  };
> 
>  DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
> +	.smp		= smp_ops(r8a7779_smp_ops),
>  	.map_io		= r8a7779_map_io,
>  	.init_early	= shmobile_init_delay,
>  	.init_time	= r8a7779_init_time,

I've been told by Arnd last week that an alternate method exists to select SMP 
operations when booting from DT. The CPU_METHOD_OF_DECLARE() registers SMP 
operations with a CPU enabling method name, which can then be specified in DT 
using the enable-method property. This allows using the same DT machine 
description for several SoCs when only the SMP operations differ.

We unfortunately can't switch to this method completely for Gen2, otherwise we 
would break backward compatibility with older DT that don't specify the 
enable-method property. For newer addition, though, we could avoid introducing 
a dependency on SMP operations in the DT machine descriptions.

-- 
Regards,

Laurent Pinchart

