From: Simon Horman <horms@verge.net.au>
Date: Thu, 20 Aug 2015 18:37:10 +0000
Subject: Re: [PATCH 00/17 v6][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <20150820183708.GB18990@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87oai2b9rj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oai2b9rj.wl%kuninori.morimoto.gx@renesas.com>
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

On Thu, Aug 20, 2015 at 09:19:43AM +0000, Kuninori Morimoto wrote:
> 
> Hi SH-ML
> 
> These are v6 patch set for Gen3 support
> I tested these patches on Gen3 Salvator-X board.
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
> Big difference from v5 are...
> 
> 	- it includes PFC driver
> 	- SCIF is based on PFC
> 	- board name was changed (salvatorx -> salvator-x)
> 	- DT was changed (cpg goes to under root)
> 	- clock-output-names was removed
> 
> Now, uboot is working on Salvator-X, but it can't use bootp
> We can boot it by this
> 
> 	> set ipaddr 192.168.xxx.xxx
> 	> set serverip 192.168.yyy.yyy
> 	> tftp 0x48080000 /salvatorx/Image
> 	> tftp 0x48f00000 /salvatorx/r8a7795-salvatorx.dtb
> 	> booti 0x48080000 - 0x48f00000
> 
> Because it doesn't support network yet, I used initramfs for booting.
> 17) added it on defconfig as local hack. you need fix its ${PATH}.
> you can check attached method if you don't have initramfs environment.
> 
> Here, "Local: Hack" are local hack patches. these should be removed/replaced
> in the future, but is needed at this point.
> 4) is very big size patch. SH-ARM ML can't accept this patch (?),
> but is should goes to maintainer
> 
> 	 1) clk: shmobile: add Renesas R-Car Gen3 CPG support
> 	 2) clk: shmobile: Add r8a7795 SoC to MSTP bindings
> 	 3) serial: sh-sci: Add device tree support for r8a7795
> 	 4) pinctrl: sh-pfc: Add R8A7795 PFC support
> 	 5) arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
> 	 6) arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
> 	 7) arm64: renesas: r8a7795: Add initial SoC support
> 	 8) arm64: renesas: r8a7795: Add SCIF2 support
> 	 9) arm64: renesas: r8a7795: enable PFC
> 	10) arm64: renesas: add SalvatorX board support on DTS
> 	11) arm64: defconfig: renesas: Enable Renesas R-Car Gen3 SoC
> 	12) arm64: defconfig: renesas: enable SCIF

I have pushed the above 12 patches to a new
topic/arm64-rcar-gen3-v6 branch.

I have based this on a merge of:
* The next/arm64 branch of the arm-soc tree[1],
  which is in turn based on is v4.2-rc2.
* The next/soc branch of the arm-soc tree [2],
  which is also based on v4.2-rc2.

This is the same base that I used for v5.

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

> 	13) Local: Hack: enable CONFIG_ARCH_SHMOBILE_MULTI temporary
> 	14) Local: Hack: remove pm_sysrq_init
> 	15) Local: Hack: of: Limit FDT size for CRC check on arm64
> 	16) Local: Hack: disable CONFIG_SUSPEND
> 	17) Local: Hack: enable Initramfs

I have pushed the above 5 "local" patches to a new
topic/arm64-rcar-gen3-local-v6 branch.

The base of that branch is topic/arm64-rcar-gen3-v6.
And as such the order of your patchset is preserved.


I am more than happy to adjust the above branches if needed.
