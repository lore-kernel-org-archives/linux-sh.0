Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC473CA551A
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbjIMJYK (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjIMJYJ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:09 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9AFC3
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:05 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id d0c4eb52-b572-4898-b2f3-9638a622facc;
        Wed, 13 Sep 2023 18:24:03 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id D3AB21C0198;
        Wed, 13 Sep 2023 18:24:01 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 00/30] Device Tree support for SH7751 based board
Date:   Wed, 13 Sep 2023 18:23:25 +0900
Message-Id: <cover.1694596125.git.ysato@users.sourceforge.jp>
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

v2 changes.
- Rebasing v6,6-rc1
- re-write irqchip driver.
- Add binding documents.
- Cleanup review comment.

Yoshinori Sato (30):
  arch/sh: head_32.S passing FDT address to initialize function.
  arch/sh: boards/Kconfig unified OF supported targets.
  arch/sh: Disable SH specific drivers in OF enabled.
  include: sh_intc.h Add stub function "intc_finalize".
  arch/sh: setup.c update DeviceTree support.
  drivers/pci: SH7751 PCI Host bridge header.
  drivers/pci: SH7751 PCI Host bridge controller driver.
  drivers/pci: Add SH7751 Host bridge controller
  Documentation/devicetree: Add renesas,sh7751-pci binding document.
  drivers/clk: SH7750 / SH7751 CPG Driver
  drivers/clk: SuperH generai clock divider helper
  drivers/clk: Add SH7750 CPG drivers entry.
  Documentation/devicetree: Add renesas,sh7751-cpg binding document.
  drivers/irqchip: Add SH7751 Internal INTC drivers.
  Documentation/devicetree: Add renesas,sh7751-intc binding document.
  drivers/irqchip: SH7751 IRL external encoder with enable gate.
  Documentation/devicetree: Add renesas,sh7751-irl-ext binding document.
  drivers/clocksource: sh_tmu clocks property support.
  drivers/tty: sh-sci fix SH4 OF support.
  drivers/mfd: sm501 add some properties.
  Documentation/devicetree: sm501fb add properies.
  arch/sh: Add dtbs target support.
  arch/sh: Add SH7751 SoC Internal periphreal devicetree.
  include/dt-bindings: Add SH7750 CPG header.
  include/dt-bindings: Add sh_intc IRQ - EVT conversion helper
  arch/sh: RTS7751R2D Plus DeviceTree.
  arch/sh: LANDISK DeviceTree.
  arch/sh: USL-5P DeviceTree.
  arch/sh: RTS7751R2D Plus OF defconfig
  arch/sh: LANDISK OF defconfig

 .../bindings/clock/renesas,sh7750-cpg.yaml    |  58 +++
 .../devicetree/bindings/display/sm501fb.txt   |  11 +
 .../renesas,sh7751-intc.yaml                  |  45 +++
 .../renesas,sh7751-irl-ext.yaml               |  77 ++++
 .../bindings/pci/renesas,sh7751-pci.yaml      |  57 +++
 arch/sh/Kconfig                               |   6 +-
 arch/sh/boards/Kconfig                        |  26 +-
 arch/sh/boards/of-generic.c                   |  23 +-
 arch/sh/boot/compressed/head_32.S             |   5 +-
 arch/sh/boot/dts/Makefile                     |   5 +
 arch/sh/boot/dts/include/dt-bindings          |   1 +
 arch/sh/boot/dts/landisk.dts                  | 103 ++++++
 arch/sh/boot/dts/rts7751r2dplus.dts           | 124 +++++++
 arch/sh/boot/dts/sh7751.dtsi                  |  76 ++++
 arch/sh/boot/dts/usl-5p.dts                   | 106 ++++++
 arch/sh/configs/landisk-of_defconfig          | 110 ++++++
 arch/sh/configs/rts7751r2dplus-of_defconfig   |  93 +++++
 arch/sh/drivers/Makefile                      |   2 +
 arch/sh/include/asm/io.h                      |  14 +-
 arch/sh/include/asm/pci.h                     |   4 +
 arch/sh/kernel/cpu/Makefile                   |   9 +-
 arch/sh/kernel/cpu/sh4/Makefile               |   2 +
 arch/sh/kernel/setup.c                        |  34 +-
 arch/sh/kernel/time.c                         |   7 +-
 drivers/clk/renesas/Kconfig                   |  15 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/clk-sh7750.c              | 236 ++++++++++++
 drivers/clk/renesas/clk-shdiv.c               | 346 ++++++++++++++++++
 drivers/clk/renesas/clk-shdiv.h               |  18 +
 drivers/clocksource/sh_tmu.c                  |   3 +
 drivers/irqchip/Kconfig                       |  16 +
 drivers/irqchip/Makefile                      |   3 +
 drivers/irqchip/irq-renesas-sh7751.c          | 232 ++++++++++++
 drivers/irqchip/irq-renesas-sh7751irl.c       | 183 +++++++++
 drivers/mfd/sm501.c                           | 113 ++++++
 drivers/pci/controller/Kconfig                |   9 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pci-sh7751.c           | 338 +++++++++++++++++
 drivers/pci/controller/pci-sh7751.h           | 270 ++++++++++++++
 drivers/sh/Makefile                           |   2 +
 drivers/tty/serial/sh-sci.c                   |   8 +-
 include/dt-bindings/clock/sh7750.h            |  13 +
 .../interrupt-controller/sh_intc.h            |   7 +
 include/linux/sh_intc.h                       |   7 +-
 44 files changed, 2772 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
 create mode 120000 arch/sh/boot/dts/include/dt-bindings
 create mode 100644 arch/sh/boot/dts/landisk.dts
 create mode 100644 arch/sh/boot/dts/rts7751r2dplus.dts
 create mode 100644 arch/sh/boot/dts/sh7751.dtsi
 create mode 100644 arch/sh/boot/dts/usl-5p.dts
 create mode 100644 arch/sh/configs/landisk-of_defconfig
 create mode 100644 arch/sh/configs/rts7751r2dplus-of_defconfig
 create mode 100644 drivers/clk/renesas/clk-sh7750.c
 create mode 100644 drivers/clk/renesas/clk-shdiv.c
 create mode 100644 drivers/clk/renesas/clk-shdiv.h
 create mode 100644 drivers/irqchip/irq-renesas-sh7751.c
 create mode 100644 drivers/irqchip/irq-renesas-sh7751irl.c
 create mode 100644 drivers/pci/controller/pci-sh7751.c
 create mode 100644 drivers/pci/controller/pci-sh7751.h
 create mode 100644 include/dt-bindings/clock/sh7750.h
 create mode 100644 include/dt-bindings/interrupt-controller/sh_intc.h

-- 
2.39.2

