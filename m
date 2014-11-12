From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 12 Nov 2014 08:35:17 +0000
Subject: Re: next build: 355 warnings 7 failures (next/next-20141112)
Message-Id: <2043641.Fxl9XYOHjL@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday 12 November 2014 00:05:05 Olof's autobuilder wrote:
> 
> 	arm.allmodconfig:
> /tmp/ccHK7J0q.s:366: Error: selected processor does not support ARM mode `isb'
> /tmp/ccHK7J0q.s:369: Error: selected processor does not support ARM mode `isb'
> /tmp/ccHK7J0q.s:371: Error: selected processor does not support ARM mode `isb'

I sent a patch yesterday to shmobile folks, got an Ack from Geert.

> drivers/crypto/talitos.c:96:2: error: implicit declaration of function 'setbits32' [-Werror=implicit-function-declaration]
> drivers/crypto/talitos.c:98:2: error: implicit declaration of function 'in_be32' [-Werror=implicit-function-declaration]
> drivers/crypto/talitos.c:233:2: error: implicit declaration of function 'out_be32' [-Werror=implicit-function-declaration]

IMX/LS1021A selects FSL_SOC, which enables powerpc-only drivers.
Sent a patch to Shawn.

> drivers/dma/fsldma.h:194:2: error: implicit declaration of function 'in_be32' [-Werror=implicit-function-declaration]
> drivers/dma/fsldma.h:200:2: error: implicit declaration of function 'out_be32' [-Werror=implicit-function-declaration]
> drivers/dma/fsldma.h:207:2: error: implicit declaration of function 'in_le32' [-Werror=implicit-function-declaration]
> drivers/spi/spi-fsl-cpm.c:18:21: fatal error: asm/cpm.h: No such file or directory
> drivers/spi/spi-fsl-lib.c:27:28: fatal error: sysdev/fsl_soc.h: No such file or directory
> drivers/spi/spi-fsl-espi.c:24:28: fatal error: sysdev/fsl_soc.h: No such file or directory
> drivers/net/ethernet/freescale/xgmac_mdio.c:57:2: error: implicit declaration of function 'spin_event_timeout' [-Werror=implicit-function-declaration]
> drivers/net/ethernet/freescale/xgmac_mdio.c:58:3: error: implicit declaration of function 'in_be32' [-Werror=implicit-function-declaration]
> drivers/virt/fsl_hypervisor.c:44:28: fatal error: asm/fsl_hcalls.h: No such file or directory
> drivers/usb/host/ehci-fsl.c:120:3: error: implicit declaration of function 'setbits32' [-Werror=implicit-function-declaration]
> drivers/usb/host/ehci-fsl.c:216:4: error: implicit declaration of function 'clrbits32' [-Werror=implicit-function-> drivers/usb/phy/phy-fsl-usb.c:277:23: error: 'struct usb_phy' has no member named 'state'
> drivers/usb/phy/phy-fsl-usb.c:627:7: error: request for member 'state' in something not a structure or union
>     otg.state = OTG_STATE_UNDEFINED;
> drivers/usb/phy/phy-fsl-usb.c:685:14: error: request for member 'state' in something not a structure or union
> drivers/video/fbdev/fsl-diu-fb.c:37:28: fatal error: sysdev/fsl_soc.h: No such file or directory

And lots more of the same.
 
> 	arm.davinci_all_defconfig:
> drivers/tty/vt/vt.c:2703:4: error: implicit declaration of function 'vt_get_kmsg_redirect' [-Werror=implicit-function-declaration]

Haven't looked at that one yet.

> 	arm.dove_defconfig:
> arch/arm/plat-orion/gpio.c:509:12: error: too few arguments to function 'irq_reg_readl'
> arch/arm/plat-orion/gpio.c:511:2: error: too few arguments to function 'irq_reg_writel'
> arch/arm/plat-orion/gpio.c:523:12: error: too few arguments to function 'irq_reg_readl'
> arch/arm/plat-orion/gpio.c:525:2: error: too few arguments to function 'irq_reg_writel'

This must be a result of the generic irqchip changes that Kevin Cernekee
did clashing with Evgeniy's "ARM: orion: Fix for certain sequence of
request_irq can cause irq storm". Jason applied both patches, so I'll let
him figure out a solution. The necessary change should be trivial. Jason,
I suspect it's best if you apply Evgeniy's patch to the irqchip tree instead
of the mvebu/soc tree. Feel free to add my Ack when you do that.

> 
> Warnings:
>       1 arch/arm64/kernel/efi.c:276:20: warning: 'free_end' may be used uninitialized in this function [-Wmaybe-uninitialized]

No idea. Maybe added by the compiler update?

>       1 arch/arm/include/asm/irqflags.h:152:2: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]

Missing context, no idea where this came from.

>       1 arch/arm/mach-cns3xxx/pcie.c:313:1: warning: the frame size of 1080 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Old, have a patch that I should submit.

>       5 fs/binfmt_elf.c:718:13: warning: passing argument 1 of 'arch_elf_pt_proc' from incompatible pointer type
>       5 fs/binfmt_elf.c:718:13: warning: passing argument 2 of 'arch_elf_pt_proc' from incompatible pointer type
>       5 fs/binfmt_elf.c:747:14: warning: passing argument 1 of 'arch_elf_pt_proc' from incompatible pointer type
>       5 fs/binfmt_elf.c:747:14: warning: passing argument 2 of 'arch_elf_pt_proc' from incompatible pointer type
>       5 fs/binfmt_elf.c:761:11: warning: passing argument 1 of 'arch_check_elf' from incompatible pointer type
>     127 include/linux/elf.h:84:15: warning: its scope is only this definition or declaration, which is probably not what you want
>     127 include/linux/elf.h:84:15: warning: 'struct file' declared inside parameter list

These look new, let's hope for them to get noticed.

> Section mismatches:
>       1 multi_lpae_defconfig WARNING: vmlinux.o(.text+0x238e68): Section mismatch in reference from the function brcmstb_gisb_arb_probe() to the function .init.text:hook_fault_code()
>       1 multi_v7_defconfig WARNING: vmlinux.o(.text+0x238e68): Section mismatch in reference from the function brcmstb_gisb_arb_probe() to the function .init.text:hook_fault_code()

Introduced by the bcma bus driver we just merged.

	Arnd

