From: Simon Horman <horms@verge.net.au>
Date: Fri, 07 Aug 2015 06:06:55 +0000
Subject: Re: [PATCH 00/13 v5][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <20150807060653.GA29647@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878u9nequq.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878u9nequq.wl%kuninori.morimoto.gx@renesas.com>
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

On Fri, Aug 07, 2015 at 03:13:26AM +0000, Kuninori Morimoto wrote:
> 
> Hi SH-ML
> 
> These are v5 patch set for Gen3 support
> I tested these patches on Gen3 SalvatorX board.
> Because it is still not full supported patch-set, it needs local hack patches
> for booting. I added all of them on this series.
> 
> Basically this patchset is based on renesas-drivers-2015-08-05-v4.2-rc5,
> but it is including v3 Gen3 patchset. So, it is based on below.
> It is same as renesas-drivers-2015-08-05-v4.2-rc5 - Gen3 - DU
> 
> 	eb1094ca2b66e1c77119daa40695b5cbb8440e8e
> 	([WIP] clocksource: sh_tmu: Fix traceback in -next due to commit
> 	 'clockevents/drivers/sh_tmu: Migrate to new 'set-state' interface')
> 
> 1 notes here.
> 
> 1) Because SalvatorX still doesn't have uboot,
>    we put kernel on memory via JTAG
>    You need to put
> 	dtb   file on 0x48000000
> 	Image file on 0x48080000
>    Then, set each registers
> 	X0 = 0x48000000
> 	PC = 0x48080000
> 
> Because it doesn't support network yet, I used initramfs for booting.
> 12) added it on defconfig as local hack. you need fix its ${PATH}.
> you can check attached method if you don't have initramfs environment.
> 
> Here, "Local: Hack" are local hack patches. these should be removed/replaced
> in the future, but is needed at this point.
> 
> 	 1) clk: shmobile: add Renesas R-Car Gen3 CPG support
> 	 2) arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
> 	 3) ARM: shmobile: Add Renesas R8A7795 SoC support
> 	 4) clk: shmobile: Add r8a7795 SoC to MSTP bindings
> 	 5) arm64: renesas: Add initial r8a7795 SoC support
> 	 6) arm64: renesas: Enable Renesas R-Car Gen3 SoC in defconfig
> 	 7) serial: sh-sci: Add device tree support for r8a7795
> 	 8) arm64: renesas: Add SCIF2 support on r8a7795
> 	 9) arm64: renesas: enable SCIF on defconfig

I have pushed the above 9 patches to a new
topic/arm64-rcar-gen3-v5 branch.

I have based this on a merge of:
* The next/arm64 branch of the arm-soc tree[1],
  which is in turn based on is v4.2-rc2.
* The next/soc branch of the arm-soc tree [2],
  which is also based on v4.2-rc2.

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

> 	10) Local: Hack: enable CONFIG_ARCH_SHMOBILE_MULTI temporary
> 	11) Local: Hack: enable SCIF2 without using PFC
> 	12) Local: Hack: remove pm_sysrq_init
> 	13) Local: Hack: of: Limit FDT size for CRC check on arm64
> 	14) Local: Hack: disable CONFIG_SUSPEND
> 	15) Local: Hack: enable Initramfs
> 	16) Local: arm64: renesas: add SalvatorX board support on DTS

I have pushed the above 7 "local" patches to a new
topic/arm64-rcar-gen3-local-v5 branch.

The base of that branch is topic/arm64-rcar-gen3-v5.
And as such the order of your patchset is preserved.


I am more than happy to adjust the above branches if needed.
