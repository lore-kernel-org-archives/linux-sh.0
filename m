From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Sep 2015 13:53:51 +0000
Subject: renesas-drivers-2015-09-15-v4.3-rc1
Message-Id: <1442325231-23238-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I've pushed renesas-drivers-2015-09-15-v4.3-rc1 to
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
This tree is meant to ease development of platform support and drivers for
Renesas ARM ("shmobile") SoCs. It's created by merging (a) the for-next 
branches of various subsystem trees and (b) branches with driver code
submitted or planned for submission to maintainers into the development
branch of Simon Horman's renesas.git tree.

Today's version is based on renesas-devel-20150914-v4.3-rc1.

Included branches with driver code:
  - topic/gen3-cpg-v7
  - topic/r8a7795-pfc-v2
  - topic/r8a7795-scif-v1
  - git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git#topic/arm64-rcar-gen3-v9.plus
  - git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git#topic/r8a7795-gpio-v1.rebase
  - topic/rcar-dmac-residue-v1
  - topic/scif-misc-v3
  - topic/scif-dma-v3
  - topic/gen3-modemr-syscon-v1.rebase2
  - git://linuxtv.org/pinchartl/media#vsp1-kms-gen3-20150913
  - git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git#me/r8a7795-ravb-driver-v2
  - git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git#me/r8a7795-ravb-integration-v2

Included fixes:
  - ASoC: rsnd: fixup clkout_name[] index error for single AUDIO_CLKOUT SoC

Included subsystem trees (the last one is new):
  - git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git#linux-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git#clk-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git#for-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git#for-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git#for-next
  - git://git.infradead.org/users/dedekind/l2-mtd-2.6.git#master
  - git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git#master
  - git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git#tty-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git#i2c/for-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git#for-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git#master
  - git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git#usb-next
  - git://people.freedesktop.org/~airlied/linux#drm-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git#next
  - git://linuxtv.org/mchehab/media-next.git#master
  - git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git#mmc-next
  - git://git.linaro.org/people/ulf.hansson/mmc.git#next
  - git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git#for-next
  - git://git.linaro.org/people/daniel.lezcano/linux.git#clockevents/next
  - git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git#next
  - git://git.kernel.org/pub/scm/linux/kernel/git/djbw/dmaengine.git#next
  - git://git.infradead.org/users/vkoul/slave-dma.git#next
  - git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git#staging-next
  - git://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git#for-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git#next
  - git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git#for-next
  - git://git.infradead.org/users/jcooper/linux.git#irqchip/for-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git#for-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git#for-next
  - git://git.infradead.org/battery-2.6.git#master
  - git://www.linux-watchdog.org/linux-watchdog-next.git#master
  - git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git#for-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git#for-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git#for-next/core
  - git://anongit.freedesktop.org/drm-intel#topic/drm-misc

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
