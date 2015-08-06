From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 06 Aug 2015 08:03:10 +0000
Subject: [PATCH 00/13 v4][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <87wpx8yhhm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi SH-ML

These are v4 patch set for Gen3 support
I tested these patches on Gen3 SalvatorX board.
Because it is still not full supported patch-set, it needs local hack patches
for booting. I added all of them on this series.

I need to add some notes here.

1) Because there was a bug report which indicated it couldn't boot
   on renesas-drivers-2015-08-0x-v4.2-rc5 branch,
   I used renesas-devel-20150803-v4.2-rc5. these patches are based on it.
   We still don't know why it couldn't boot on renesas-driver branch

2) Because SalvatorX still doesn't have uboot,
   we put kernel on memory via JTAG
   You need to put
	dtb   file on 0x48000000
	Image file on 0x48080000
   Then, set each registers
	X0 = 0x48000000
	PC = 0x48080000

Because it doesn't support network yet, I used initramfs for booting.
12) added it on defconfig as local hack. you need fix its ${PATH}.
you can check attached method if you don't have initramfs environment.

Here, "Local: Hack" are local hack patches. these should be removed/replaced
in the future, but is needed at this point.

	 1) clk: shmobile: add Renesas R-Car Gen3 CPG support
	 2) arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
	 3) arm64: renesas: Add initial r8a7795 SoC support
	 4) arm64: renesas: Enable Renesas R-Car Gen3 SoC in defconfig
	 5) arm64: renesas: Add SCIF2 support on r8a7795
	 6) arm64: renesas: enable SCIF on defconfig
	 7) Local: Hack: enable CONFIG_ARCH_SHMOBILE_MULTI temporary
	 8) Local: Hack: enable SCIF2 without using PFC
	 9) Local: Hack: remove pm_sysrq_init
	10) Local: Hack: of: Limit FDT size for CRC check on arm64
	11) Local: Hack: disable CONFIG_SUSPEND
	12) Local: Hack: enable Initramfs
	13) Local: arm64: renesas: add SalvatorX board support on DTS

Gaku Inami (7):
      clk: shmobile: add Renesas R-Car Gen3 CPG support
      arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
      arm64: renesas: Add initial r8a7795 SoC support
      Local: Hack: enable CONFIG_ARCH_SHMOBILE_MULTI temporary
      Local: Hack: enable SCIF2 without using PFC
      Local: Hack: disable CONFIG_SUSPEND
      Local: arm64: renesas: add SalvatorX board support on DTS

Jon Medhurst (1):
      Local Hack: of: Limit FDT size for CRC check on arm64

Kuninori Morimoto (4):
      arm64: renesas: Enable Renesas R-Car Gen3 SoC in defconfig
      arm64: renesas: Add SCIF2 support on r8a7795
      arm64: renesas: enable SCIF on defconfig
      Local: Hack: enable Initramfs

Yoshifumi Hosoya (1):
      Local: Hack: remove pm_sysrq_init

 Documentation/devicetree/bindings/arm/shmobile.txt                       |   2 +
 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt      |   1 +
 Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |  31 ++++++++++
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt          |   4 ++
 arch/arm64/Kconfig                                                       |  13 +++++
 arch/arm64/boot/dts/Makefile                                             |   1 +
 arch/arm64/boot/dts/renesas/Makefile                                     |   5 ++
 arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts                        |  36 ++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi                                 | 101 ++++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                                             |   6 ++
 drivers/clk/shmobile/Makefile                                            |   1 +
 drivers/clk/shmobile/clk-rcar-gen3.c                                     | 274 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/of/fdt.c                                                         |  10 +++-
 include/dt-bindings/clock/r8a7795-clock.h                                |  31 ++++++++++
 kernel/power/poweroff.c                                                  |   2 +-
 15 files changed, 515 insertions(+), 3 deletions(-)

-- initramfs --
busybox based tiny/simple rootfs

1. download tiny-rootfs from https://github.com/morimoto/tiny-rootfs
2. cp sample.config to .config
3. modify .config
4. make
5. make install
6. you can find ./initramfs

