Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9673C4167D
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjKNIAl (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjKNIAi (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:00:38 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F079419B
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:00:33 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 9D7461C02FE;
        Tue, 14 Nov 2023 17:00:32 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v4 00/37] Device Tree support for SH7751 based board
Date:   Tue, 14 Nov 2023 16:59:51 +0900
Message-Id: <cover.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

This is an updated version of something I wrote about 7 years ago.
Minimum support for R2D-plus and LANDISK.
I think R2D-1 will work if you add AX88796 to dts.
And board-specific functions and SCI's SPI functions are not supported.

You can get it working with qemu found here.
https://gitlab.com/yoshinori.sato/qemu/-/tree/landisk

v4 changes.
- cpg-sh7750: use clk-divider and clk-gate.
- pci-sh7751: unified header files to old PCI driver.
- irq-renesas-sh7751: IPR registers direct mapping.
- irq-renesas-sh7751irl: useful register bit mapping.
- sm501 and sm501fb: re-write dt parser.
- j2_minus: fix build error.
- dt-binding schema: fix some errors.
- *.dts: cleanup.

v3 changes.
- Rewrite clk drivers.
- Added sh_tmu to OF support.
- Cleanup PCI stuff.
- Update sm501 and sm501fb OF support.
- Update devicetree and documents.

v2 changes.
- Rebasing v6,6-rc1
- re-write irqchip driver.
- Add binding documents.
- Cleanup review comment.

Yoshinori Sato (37):
  sh: passing FDT address to kernel startup.
  sh: Kconfig unified OF supported targets.
  sh: Enable OF support for build and configuration.
  dt-bindings: interrupt-controller: Add header for Renesas SH3/4 INTC.
  sh: GENERIC_IRQ_CHIP support for CONFIG_OF=y
  sh: kernel/setup Update DT support.
  sh: Fix COMMON_CLK support in CONFIG_OF=y.
  clocksource: sh_tmu: CLOCKSOURCE support.
  dt-bindings: timer: renesas,tmu: add renesas,tmu-sh7750
  sh: Common PCI framework support
  sh: Add old PCI drivers compatible stub.
  pci: pci-sh7751: Add SH7751 PCI driver
  dt-bindings: pci: pci-sh7751: Add SH7751 PCI
  dt-bindings: clock: sh7750-cpg: Add renesas,sh7750-cpg header.
  clk: Compatible with narrow registers
  clk: renesas: Add SH7750/7751 CPG Driver
  irqchip: Add SH7751 INTC driver
  dt-bindings: interrupt-controller: renesas,sh7751-intc: Add
    json-schema
  irqchip: SH7751 IRL external encoder with enable gate.
  dt-bindings: interrupt-controller: renesas,sh7751-irl-ext: Add
    json-schema
  serial: sh-sci: fix SH4 OF support.
  dt-bindings: serial: renesas,scif: Add scif-sh7751.
  dt-bindings: display: smi,sm501: SMI SM501 binding json-schema
  mfd: sm501: Convert platform_data to OF property
  dt-binding: sh: cpus: Add SH CPUs json-schema
  dt-bindings: vendor-prefix: Add new vendor iodata and smi.
  dt-bindings: ata: ata-generic: Add new targets
  dt-bindings: soc: renesas: sh: Add SH7751 based target
  sh: SH7751R SoC Internal peripheral definition dtsi.
  sh: add RTS7751R2D Plus DTS
  sh: Add IO DATA LANDISK dts
  sh: Add IO DATA USL-5P dts
  sh: j2_mimas_v2.dts update
  sh: Add dtbs target support.
  sh: RTS7751R2D Plus OF defconfig
  sh: LANDISK OF defconfig
  sh: j2_defconfig: update

 .../devicetree/bindings/ata/ata-generic.yaml  |   2 +
 .../bindings/clock/renesas,sh7750-cpg.yaml    | 103 ++++
 .../bindings/display/smi,sm501.yaml           | 138 +++++
 .../renesas,sh7751-intc.yaml                  | 105 ++++
 .../renesas,sh7751-irl-ext.yaml               |  83 +++
 .../bindings/pci/renesas,sh7751-pci.yaml      | 123 +++++
 .../bindings/serial/renesas,scif.yaml         |   1 +
 .../devicetree/bindings/sh/cpus.yaml          |  73 +++
 .../devicetree/bindings/soc/renesas/sh.yaml   |  32 ++
 .../bindings/timer/renesas,tmu.yaml           |  11 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
 arch/sh/Kconfig                               |  11 +-
 arch/sh/boards/Kconfig                        |  25 +-
 arch/sh/boards/of-generic.c                   |  28 +-
 arch/sh/boot/compressed/head_32.S             |   5 +-
 arch/sh/boot/dts/Makefile                     |   5 +
 arch/sh/boot/dts/j2_mimas_v2.dts              |   2 +-
 arch/sh/boot/dts/landisk.dts                  |  74 +++
 arch/sh/boot/dts/rts7751r2dplus.dts           | 158 ++++++
 arch/sh/boot/dts/sh7751r.dtsi                 | 151 ++++++
 arch/sh/boot/dts/usl-5p.dts                   |  84 +++
 arch/sh/configs/j2_defconfig                  |  11 +-
 arch/sh/configs/landisk-of_defconfig          | 111 ++++
 arch/sh/configs/rts7751r2dplus-of_defconfig   |  93 ++++
 arch/sh/drivers/Makefile                      |   2 +
 arch/sh/drivers/pci/pci-sh4.h                 | 183 +------
 arch/sh/include/asm/io.h                      |  40 +-
 arch/sh/include/asm/irq.h                     |  10 +-
 arch/sh/include/asm/pci-sh4.h                 | 183 +++++++
 .../{drivers/pci => include/asm}/pci-sh7751.h |   0
 .../{drivers/pci => include/asm}/pci-sh7780.h |   0
 arch/sh/include/asm/pci.h                     |   4 +
 arch/sh/kernel/cpu/Makefile                   |   6 +-
 arch/sh/kernel/cpu/irq/imask.c                |  17 +
 arch/sh/kernel/cpu/sh4/Makefile               |   3 +
 arch/sh/kernel/setup.c                        |  36 +-
 arch/sh/kernel/time.c                         |  12 +
 drivers/clk/clk-divider.c                     |  56 +-
 drivers/clk/clk-gate.c                        |  56 +-
 drivers/clk/renesas/Kconfig                   |  16 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/clk-sh7750.c              | 498 ++++++++++++++++++
 drivers/clocksource/sh_tmu.c                  | 161 ++++--
 drivers/irqchip/Kconfig                       |  15 +
 drivers/irqchip/Makefile                      |   3 +
 drivers/irqchip/irq-renesas-sh7751.c          | 290 ++++++++++
 drivers/irqchip/irq-renesas-sh7751irl.c       | 227 ++++++++
 drivers/mfd/sm501.c                           |  70 +++
 drivers/pci/controller/Kconfig                |   9 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pci-sh7751.c           | 293 +++++++++++
 drivers/tty/serial/Kconfig                    |   2 +-
 drivers/tty/serial/sh-sci.c                   |   6 +-
 drivers/video/fbdev/sm501fb.c                 |  70 ++-
 include/dt-bindings/clock/sh7750-cpg.h        |  26 +
 include/dt-bindings/display/sm501.h           |  25 +
 .../interrupt-controller/sh_intc.h            |  16 +
 include/linux/clk-provider.h                  |  22 +-
 include/linux/sh_intc.h                       |   7 +-
 include/linux/sm501.h                         |   3 +-
 60 files changed, 3438 insertions(+), 364 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
 create mode 100644 Documentation/devicetree/bindings/display/smi,sm501.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
 create mode 100644 Documentation/devicetree/bindings/sh/cpus.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/sh.yaml
 create mode 100644 arch/sh/boot/dts/landisk.dts
 create mode 100644 arch/sh/boot/dts/rts7751r2dplus.dts
 create mode 100644 arch/sh/boot/dts/sh7751r.dtsi
 create mode 100644 arch/sh/boot/dts/usl-5p.dts
 create mode 100644 arch/sh/configs/landisk-of_defconfig
 create mode 100644 arch/sh/configs/rts7751r2dplus-of_defconfig
 create mode 100644 arch/sh/include/asm/pci-sh4.h
 rename arch/sh/{drivers/pci => include/asm}/pci-sh7751.h (100%)
 rename arch/sh/{drivers/pci => include/asm}/pci-sh7780.h (100%)
 create mode 100644 drivers/clk/renesas/clk-sh7750.c
 create mode 100644 drivers/irqchip/irq-renesas-sh7751.c
 create mode 100644 drivers/irqchip/irq-renesas-sh7751irl.c
 create mode 100644 drivers/pci/controller/pci-sh7751.c
 create mode 100644 include/dt-bindings/clock/sh7750-cpg.h
 create mode 100644 include/dt-bindings/display/sm501.h
 create mode 100644 include/dt-bindings/interrupt-controller/sh_intc.h

-- 
2.39.2

