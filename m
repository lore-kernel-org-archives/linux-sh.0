From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Jun 2014 23:47:08 +0000
Subject: Re: [PATCH 08/14] ARM: shmobile: Add shared R-Car Gen2 CMA reservation code
Message-Id: <20140625234708.GD7130@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
 <f8e819352d12f1b7d109d846e9bf1c07e006469a.1403681315.git.horms+renesas@verge.net.au>
 <53AAE831.3040003@cogentembedded.com>
In-Reply-To: <53AAE831.3040003@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jun 25, 2014 at 07:18:09PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 06/25/2014 11:35 AM, Simon Horman wrote:
> 
> >From: Magnus Damm <damm+renesas@opensource.se>
> 
> >Add R-Car Gen2 CMA memory reservation code that can be
> >shared between multiple SoCs and boards. At this point
> >r8a7790 and r8a7791 are supported.
> 
> >The top 256MiB of the legacy 32-bit physical memory space
> >is assigned to a separate CMA area that may be assigned
> >to various devices later on.
> 
> >Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> >[horms+renesas@verge.net.au: rebased]
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> [...]
> 
> >diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> >index fdc714e..544b9bf 100644
> >--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
> >+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> >@@ -20,8 +20,11 @@
> >
> >  #include <linux/clk/shmobile.h>
> >  #include <linux/clocksource.h>
> >+#include <linux/device.h>
> >+#include <linux/dma-contiguous.h>
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> >+#include <linux/of_fdt.h>
> >  #include <asm/mach/arch.h>
> >  #include "common.h"
> >  #include "rcar-gen2.h"
> 
>    Hm, this part looks incomplete. I thought you were going to add CMA code here?

Thanks, something does indeed seem to have gone wrong there.
