From: Simon Horman <horms@verge.net.au>
Date: Tue, 25 Aug 2015 01:52:33 +0000
Subject: Re: [PATCH 00/25 v7][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <20150825015231.GA17886@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87si7977g4.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87si7977g4.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

I have pushed these patches to the renesas tree in topic branches as
described below.

To be quite clear none of these patches are queued up for mainline yet and
as such they are not included in the next or devel branches of the renesas
tree.

On Mon, Aug 24, 2015 at 02:24:47AM +0000, Kuninori Morimoto wrote:
> 
> Hi SH-ML
> 
> These are v7 patch set for Gen3 support.
> Unfortunately, v6 patch set couldn't boot on Salvator-X since many unlucky
> thinkgs happen on my environment.
> I tested these patches on Gen3 Salvator-X board with Shimoda-san.
> Because it is still not full supported patch-set, it needs local hack patches
> for booting. I added all of them on this series.
> 
> Basically this patchset is based on renesas-drivers-2015-08-18-v4.2-rc7
> but it is including v3 Gen3 patchset. So, it is based on below.
> It is same as renesas-drivers-2015-08-18-v4.2-rc7 - Gen3 - DU
> 
> 	cc4a47b53bed0fdf02cea9fab559e619eb1f15bb
> 	("Merge remote-tracking branch 'arm64/for-next/core' into base")
> 
> This patch-set is including Shimoda-san's USB support
> 
> Big difference from v5 are...
> (no count v6)
> 
> 	- it includes PFC driver
> 	- SCIF is based on PFC
> 	- board name was changed (salvatorx -> salvator-x)
> 	- clock-output-names was removed (if possible)
> 	- USB is included
> 
> Now, uboot is working on Salvator-X, but it can't use bootp
> We can boot it by this
> 
> 	> set ipaddr 192.168.xxx.xxx
> 	> set serverip 192.168.yyy.yyy
> 	> tftp 0x48080000 /salvatorx/Image
> 	> tftp 0x48f00000 /salvatorx/r8a7795-salvator-x.dtb
> 	> booti 0x48080000 - 0x48f00000
> 
> Because it doesn't support network yet, I used initramfs for booting.
> v5/v6 patch-set enabled this initramfs on defconfig, but it creates many
> confusion. v7 patch-set removed it.
> you can check attached method if you don't have initramfs environment.
> 
> Here, "Local: Hack" are local hack patches. these should be removed/replaced
> in the future, but is needed at this point.
> 4) is very big size patch. SH-ARM ML can't accept this patch (?),
> but is should goes to maintainer
> 
> 5) is posted to USB-ML by Shimoda-san, but this patch is including it too.
> 11) - 14), 16) - 18) are for USB support by Shimoda-san
> 
> 	 1) clk: shmobile: add Renesas R-Car Gen3 CPG support
> 	 2) clk: shmobile: Add r8a7795 SoC to MSTP bindings
> 	 3) serial: sh-sci: Add device tree support for r8a7795
> 	 4) pinctrl: sh-pfc: Add R8A7795 PFC support
> 	 5) phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
> 	 6) arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
> 	 7) arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
> 	 8) arm64: renesas: r8a7795: Add initial SoC support
> 	 9) arm64: renesas: r8a7795: Add SCIF2 support
> 	10) arm64: renesas: r8a7795: enable PFC
> 	11) arm64: renesas: r8a7795: add mstp7 node and enable HSUSB clock
> 	12) arm64: renesas: r8a7795: add EHCI[012] clocks
> 	13) arm64: renesas: r8a7795: add usb-phy device nodes
> 	14) arm64: renesas: r8a7795: add device nodes of EHCI and OHCI
> 	15) arm64: renesas: add SalvatorX board support on DTS
> 	16) arm64: renesas: salvator-x: add pfc node and subnodes for usb 2.0
> 	17) arm64: renesas: salvator-x: enable usb2_phy nodes
> 	18) arm64: renesas: salvator-x: enable ehci and ohci nodes
> 	19) arm64: defconfig: renesas: Enable Renesas R-Car Gen3 SoC
> 	20) arm64: defconfig: renesas: enable SCIF
> 	21) arm64: defconfig: renesas: enable USB2 PHY of Gen3

I have pushed the above 21 patches to a new
topic/arm64-rcar-gen3-v7 branch.

I have based this on a merge of:
* The next/arm64 branch of the arm-soc tree[1],
  which is in turn based on is v4.2-rc2.
* The next/soc branch of the arm-soc tree [2],
  which is also based on v4.2-rc2.

This is the same base that I used for v5 and v6.

The reason for including next/arm64 in the base is that there were several
patches in arm-soc required to apply the patchset cleanly. In particular
eed6b3eb20b9 ("arm64: Split out platform options to separate Kconfig")
which adds arch/arm64/Kconfig.platforms.

The reason for including next/soc in the base is that it appears to
be needed for next/arm64 to compile with the arm64 defconfig.
In particular
c84e358718a6 ("soc: Mediatek: Add SCPSYS power domain driver")
appears to be required by
c02e0e86d304 ("arm64: dts: mt8173: Add afe device node").


[1] Head commit:
    bcfff4d961fb ("arm64: Enable Marvell Berlin SoC family in def config")
[2] Head commit:
    3f86e570f268 ("ARM: davinci: cp_intc: use IRQCHIP_SKIP_SET_WAKE instead
    of irq_set_wake callback")

> 	22) Local: Hack: enable CONFIG_ARCH_SHMOBILE_MULTI temporary
> 	23) Local: Hack: remove pm_sysrq_init
> 	24) Local: Hack: of: Limit FDT size for CRC check on arm64
> 	25) Local: Hack: disable CONFIG_SUSPEND

I have pushed the above 4 "local" patches to a new
topic/arm64-rcar-gen3-local-v7 branch.

The base of that branch is topic/arm64-rcar-gen3-v7.
And as such the order of your patchset is preserved.


I am more than happy to adjust the above branches if needed.

> 
> -- initramfs --
> busybox based tiny/simple rootfs
> 
> 1. download tiny-rootfs from https://github.com/morimoto/tiny-rootfs
> 2. cp sample.config to .config
> 3. modify .config
> 4. make
> 5. make install
> 6. you can find ./initramfs
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
