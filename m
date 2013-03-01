From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Mar 2013 07:09:23 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: fixup of_platform.h compile warning
Message-Id: <20130301070923.GC14376@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87y5ekelc9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5ekelc9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 19, 2013 at 06:29:53PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 19-02-2013 12:53, Kuninori Morimoto wrote:
> 
> >This patch fixup below warning
> 
> >CC      arch/arm/mach-shmobile/setup-r8a7779.o
> >In file included from ${LINUX}/arch/arm/mach-shmobile/setup-r8a7779.c:25:0:
> >${LINUX}/include/linux/of_platform.h:107:13:
> >	warning: 'struct of_device_id' declared inside
> >	parameter list [enabled by default]
> >${LINUX}/include/linux/of_platform.h:107:13:
> >	warning: its scope is only this definition or declaration,
> >	which is probably not what you want [enabled by default]
> >${LINUX}/include/linux/of_platform.h:107:13:
> >	warning: 'struct device_node' declared inside
> >	parameter list [enabled by default]
> 
> >Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >---
> >>>Simon
> 
> >This is based on simon/soc5 branch
> 
> >  arch/arm/mach-shmobile/setup-r8a7779.c |    1 +
> >  1 file changed, 1 insertion(+)
> 
> >diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
> >index 7b4c1eb8..5911c04 100644
> >--- a/arch/arm/mach-shmobile/setup-r8a7779.c
> >+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> >@@ -21,6 +21,7 @@
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> >+#include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/delay.h>
> 
>    I think this is only papering over the issue which lies within a
> header file <linux/oh_platform.h> itself. Exactly this file needs
> fixing -- which I tried to do in my patch posted somewhat earlier:
> 
> http://marc.info/?l=linux-sh&m6122828108385

Thanks, I agree with your analysis.
