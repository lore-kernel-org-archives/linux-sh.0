From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 29 Jan 2015 14:21:57 +0000
Subject: renesas-drivers-2015-01-29-v3.19-rc6
Message-Id: <1422541317-19457-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I've pushed renesas-drivers-2015-01-29-v3.19-rc6 to
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
This tree is meant to ease development of platform support and drivers for
Renesas ARM ("shmobile") SoCs. It's created by merging (a) the for-next 
branches of various subsystem trees and (b) branches with driver code
submitted or planned for submission to maintainers into the development
branch of Simon Horman's renesas.git tree.

Today's version is based on renesas-devel-20150128-v3.19-rc6.

Included branches with driver code:
  - shmobile-pfc-emev2
      - sh-pfc: add macro to define pinmux without function
      - sh-pfc: Add emev2 pinmux support
      - ARM: shmobile: emev2: Add PFC information to emev2.dtsi
      - ARM: shmobile: emev2-kzm9d: Add PFC information for uart1

Included fixes:
  - Revert "clk: Add rate constraints to clocks"
    "Division by zero in kernel." (https://lkml.org/lkml/2015/1/29/560)
  - Simple Power-Managed Bus (updated):
      - drivers: bus: Sort Kconfig entries alphabetically
      - drivers: bus: Sort Makefile entries alphabetically
      - drivers: bus: Add Simple Power-Managed Bus DT Bindings
      - drivers: bus: Add Renesas Bus State Controller (BSC) DT Bindings
      - drivers: bus: Add Simple Power-Managed Bus Driver
  - sh73a0/kzm9g and r8a73a4/ape6evm BSC and Ethernet (updated):
      - ARM: shmobile: sh73a0 dtsi: Add Bus State Controller node
      - ARM: shmobile: kzm9g dts: Move Ethernet node to BSC
      - ARM: shmobile: r8a73a4 dtsi: Add Bus State Controller node
      - ARM: shmobile: ape6evm dts: Move Ethernet node to BSC
  - sh73a0/kzm9g Multiplatform:
      - ARM: shmobile: kzm9g-reference: Remove board C code and DT file
      - ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node
  - sh73a0/kzm9g PM domain:
      - ARM: shmobile: sh73a0 dtsi: Add PM domain support
      - drivers: sh: Disable PM runtime for multi-platform sh73a0 with genpd
  - r8a73a4/ape6evm Multiplatform:
      - ARM: shmobile: ape6evm-reference: Remove board C code and DT file
      - ARM: shmobile: r8a73a4: ape6evm: Remove legacy platform
      - ARM: shmobile: r8a73a4: Remove legacy code

Included subsystem trees:
  - git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git#linux-next
  - git://git.linaro.org/people/mturquette/linux.git#clk-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git#for-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git#for-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git#for-next
  - git://git.infradead.org/users/dedekind/l2-mtd-2.6.git#master
  - git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git#master
  - git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git#tty-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git#i2c/for-next
  - git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git#for-next
  - git://gitorious.org/linux-can/linux-can-next.git#master
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

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
