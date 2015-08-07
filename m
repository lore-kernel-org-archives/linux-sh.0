From: Simon Horman <horms@verge.net.au>
Date: Fri, 07 Aug 2015 01:01:17 +0000
Subject: Re: [PATCH 00/13 v4][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <20150807010115.GE1145@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87wpx8yhhm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wpx8yhhm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

thanks to you and the team for your hard work getting this together before Obon.

I have pushed these patches to the renesas tree in topic branches as
described below.

To be quite clear none of these patches are queued up for mainline yet and
as such they are not included in the next or devel branches of the renesas
tree.

On Thu, Aug 06, 2015 at 08:03:10AM +0000, Kuninori Morimoto wrote:
> 
> Hi SH-ML
> 
> These are v4 patch set for Gen3 support I tested these patches on Gen3
> SalvatorX board.
> Because it is still not full supported patch-set, it needs local hack patches
> for booting. I added all of them on this series.
> 
> I need to add some notes here.
> 
> 1) Because there was a bug report which indicated it couldn't boot
>    on renesas-drivers-2015-08-0x-v4.2-rc5 branch,
>    I used renesas-devel-20150803-v4.2-rc5. these patches are based on it.
>    We still don't know why it couldn't boot on renesas-driver branch
> 
> 2) Because SalvatorX still doesn't have uboot,
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
> 	 3) arm64: renesas: Add initial r8a7795 SoC support
> 	 4) arm64: renesas: Enable Renesas R-Car Gen3 SoC in defconfig
> 	 5) arm64: renesas: Add SCIF2 support on r8a7795
> 	 6) arm64: renesas: enable SCIF on defconfig

I have pushed the above 6 patches to a new
topic/arm64-rcar-gen3-v4 branch.

As per v3 of this patchset the base of the branch is v4.2-rc1.

> 	 7) Local: Hack: enable CONFIG_ARCH_SHMOBILE_MULTI temporary
> 	 8) Local: Hack: enable SCIF2 without using PFC
> 	 9) Local: Hack: remove pm_sysrq_init
> 	10) Local: Hack: of: Limit FDT size for CRC check on arm64
> 	11) Local: Hack: disable CONFIG_SUSPEND
> 	12) Local: Hack: enable Initramfs
> 	13) Local: arm64: renesas: add SalvatorX board support on DTS

I have pushed the above 7 "local" patches to a new
topic/arm64-rcar-gen3-local-v4 branch.

The base of that branch is topic/arm64-rcar-gen3-v4.
And as such the order of your patchset is preserved.


I am more than happy to adjust the above branches if needed.
