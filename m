From: Rob Herring <robherring2@gmail.com>
Date: Tue, 22 Nov 2011 14:12:24 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: AG5EVM GIC Sparse IRQ fix
Message-Id: <4ECBADC8.5090503@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20111122063140.31045.57736.sendpatchset@w520>
In-Reply-To: <20111122063140.31045.57736.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/22/2011 12:31 AM, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Fix IRQ support on the AG5EVM board. The sh73a0 and the AG5EVM
> board make use of the ARM GIC hardware block as main interrupt
> controller. The following commit changed the default behaviour
> for non-device tree platforms and broke AG5EVM irq support:
> 
> f37a53c ARM: gic: fix irq_alloc_descs handling for sparse irq
> 
> Without this fix the following warning triggers at boot:
> 
> NR_IRQS:1024 nr_irqs:1024 1024
> ------------[ cut here ]------------
> WARNING: at arch/arm/common/gic.c:607 gic_init+0x90/0x2e4()
> Cannot allocate irq_descs @ IRQ16, assuming pre-allocated
> [<c000c868>] (unwind_backtrace+0x0/0xe0) from [<c001857c>] (warn_slowpath_commo)
> [<c001857c>] (warn_slowpath_common+0x48/0x60) from [<c00185d8>] (warn_slowpath_)
> [<c00185d8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c029ee08>] (gic_init+0x90/0x2)
> [<c029ee08>] (gic_init+0x90/0x2e4) from [<c029f278>] (sh73a0_init_irq+0x30/0x18)
> [<c029f278>] (sh73a0_init_irq+0x30/0x184) from [<c029c0b4>] (init_IRQ+0x14/0x1c)
> [<c029c0b4>] (init_IRQ+0x14/0x1c) from [<c029a5cc>] (start_kernel+0x15c/0x2b8)
> [<c029a5cc>] (start_kernel+0x15c/0x2b8) from [<4000803c>] (0x4000803c)
> ---[ end trace 1b75b31a2719ed1c ]---
> 
> With this fix applied interrupts work as expected.
> 

They work without the fix as well, right?

> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---

For both patches:

Acked-by: Rob Herring <rob.herring@calxeda.com>

> 
>  arch/arm/mach-shmobile/board-ag5evm.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- 0001/arch/arm/mach-shmobile/board-ag5evm.c
> +++ work/arch/arm/mach-shmobile/board-ag5evm.c	2011-11-17 18:35:51.000000000 +0900
> @@ -607,6 +607,7 @@ struct sys_timer ag5evm_timer = {
>  
>  MACHINE_START(AG5EVM, "ag5evm")
>  	.map_io		= ag5evm_map_io,
> +	.nr_irqs	= NR_IRQS_LEGACY,
>  	.init_irq	= sh73a0_init_irq,
>  	.handle_irq	= shmobile_handle_irq_gic,
>  	.init_machine	= ag5evm_init,

