From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 23 Jul 2014 02:42:55 +0000
Subject: [PATCH 0/11][RFC] sound DMA support patches
Message-Id: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

These are sound DMA support platform side patches.
These worked well when it was based on shdma-base
driver base.

These are including all sound DMA supports,
but, it is too much for cyclic transfer test.

I guess 1/3/5/6/10/11/ are enough.

Current rcar-dmac filter can't care "dma0" or "audma0" now.
So, I disabled "dma0/1" as quick-hack.

	&dmac0 {
			status = "disabled";
	};

	&dmac1 {
			status = "disabled";
	};

I could get short sound if I modified driver as try-and-error.
(and it dead after that, of course it is wrong fix)
So, I guess, address/IRQ/MID-RID/MSTP/etc settings are correct.

If you have alsa command, you need this

	> amixer set "LINEOUT Mixer DACL" on
	> aplay xxx.wav

I used...
  > git checkout renesas-drivers-2014-07-11-v3.16-rc4
  > git merge asoc/topic/rcar

  # asoc = git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git

Kuninori Morimoto (11):
       1) ARM: shmobile: r8a7790: Add Audio DMAC devices to DT
       2) ARM: shmobile: r8a7790: Add Audio DMAC peri peri devices to DT
       3) ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
       4) ARM: shmobile: r8a7790: sound enables Audio DMAC peri peri entry on DTSI
       5) ARM: shmobile: lager: Sound PIO support on DTS
       6) ARM: shmobile: lager: Sound DMA support on DTS
       7) ARM: shmobile: lager: Sound DMA support via BUSIF on DTS
       8) ARM: shmobile: lager: Sound DMA support via SRC on DTS
       9) ARM: shmobile: lager: Sound DMA support via DVC on DTS
      10) ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig
      11) ARM: shmobile: multiplatform: add R-Car DMAC support on defconfig

 arch/arm/boot/dts/r8a7790-lager.dts       |   66 ++++++++++
 arch/arm/boot/dts/r8a7790.dtsi            |  203 ++++++++++++++++++++++++++++-
 arch/arm/configs/shmobile_defconfig       |    2 +
 arch/arm/mach-shmobile/Kconfig            |    1 +
 include/dt-bindings/clock/r8a7790-clock.h |    2 +
 5 files changed, 271 insertions(+), 3 deletions(-)


Best regards
---
Kuninori Morimoto
