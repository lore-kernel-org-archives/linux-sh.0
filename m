From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Aug 2015 09:19:43 +0000
Subject: [PATCH 00/17 v6][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <87oai2b9rj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi SH-ML

These are v6 patch set for Gen3 support
I tested these patches on Gen3 Salvator-X board.
Because it is still not full supported patch-set, it needs local hack patches
for booting. I added all of them on this series.

Basically this patchset is based on renesas-drivers-2015-08-18-v4.2-rc7
but it is including v3 Gen3 patchset. So, it is based on below.
It is same as renesas-drivers-2015-08-18-v4.2-rc7 - Gen3 - DU

	cc4a47b53bed0fdf02cea9fab559e619eb1f15bb
	("Merge remote-tracking branch 'arm64/for-next/core' into base")

Big difference from v5 are...

	- it includes PFC driver
	- SCIF is based on PFC
	- board name was changed (salvatorx -> salvator-x)
	- DT was changed (cpg goes to under root)
	- clock-output-names was removed

Now, uboot is working on Salvator-X, but it can't use bootp
We can boot it by this

	> set ipaddr 192.168.xxx.xxx
	> set serverip 192.168.yyy.yyy
	> tftp 0x48080000 /salvatorx/Image
	> tftp 0x48f00000 /salvatorx/r8a7795-salvatorx.dtb
	> booti 0x48080000 - 0x48f00000

Because it doesn't support network yet, I used initramfs for booting.
17) added it on defconfig as local hack. you need fix its ${PATH}.
you can check attached method if you don't have initramfs environment.

Here, "Local: Hack" are local hack patches. these should be removed/replaced
in the future, but is needed at this point.
4) is very big size patch. SH-ARM ML can't accept this patch (?),
but is should goes to maintainer

	 1) clk: shmobile: add Renesas R-Car Gen3 CPG support
	 2) clk: shmobile: Add r8a7795 SoC to MSTP bindings
	 3) serial: sh-sci: Add device tree support for r8a7795
	 4) pinctrl: sh-pfc: Add R8A7795 PFC support
	 5) arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
	 6) arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
	 7) arm64: renesas: r8a7795: Add initial SoC support
	 8) arm64: renesas: r8a7795: Add SCIF2 support
	 9) arm64: renesas: r8a7795: enable PFC
	10) arm64: renesas: add SalvatorX board support on DTS
	11) arm64: defconfig: renesas: Enable Renesas R-Car Gen3 SoC
	12) arm64: defconfig: renesas: enable SCIF
	13) Local: Hack: enable CONFIG_ARCH_SHMOBILE_MULTI temporary
	14) Local: Hack: remove pm_sysrq_init
	15) Local: Hack: of: Limit FDT size for CRC check on arm64
	16) Local: Hack: disable CONFIG_SUSPEND
	17) Local: Hack: enable Initramfs

Gaku Inami (7):
      clk: shmobile: add Renesas R-Car Gen3 CPG support
      arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
      arm64: renesas: r8a7795: Add initial SoC support
      arm64: renesas: r8a7795: Add SCIF2 support
      arm64: renesas: add SalvatorX board support on DTS
      Local: Hack: enable CONFIG_ARCH_SHMOBILE_MULTI temporary
      Local: Hack: disable CONFIG_SUSPEND

Jon Medhurst (1):
      Local: Hack: of: Limit FDT size for CRC check on arm64

Kuninori Morimoto (7):
      clk: shmobile: Add r8a7795 SoC to MSTP bindings
      serial: sh-sci: Add device tree support for r8a7795
      arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
      arm64: renesas: r8a7795: enable PFC
      arm64: defconfig: renesas: Enable Renesas R-Car Gen3 SoC
      arm64: defconfig: renesas: enable SCIF
      Local: Hack: enable Initramfs

Takeshi Kihara (1):
      pinctrl: sh-pfc: Add R8A7795 PFC support

Yoshifumi Hosoya (1):
      Local: Hack: remove pm_sysrq_init


-- initramfs --
busybox based tiny/simple rootfs

1. download tiny-rootfs from https://github.com/morimoto/tiny-rootfs
2. cp sample.config to .config
3. modify .config
4. make
5. make install
6. you can find ./initramfs



--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
