Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C470CDB465
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjJNOyW (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjJNOyV (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:21 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CC9CA
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:17 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 34dfa1eb-f0d2-4b70-9cca-29cad356af93;
        Sat, 14 Oct 2023 23:54:16 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 435561C03DF;
        Sat, 14 Oct 2023 23:54:15 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v3 00/35] Device Tree support for SH7751 based board
Date:   Sat, 14 Oct 2023 23:53:35 +0900
Message-Id: <cover.1697199949.git.ysato@users.sourceforge.jp>
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


Yoshinori Sato (35):
  arch/sh/boot/compressed/head_32.S: passing FDT address to initialize
    function.
  arch/sh/boards/Kconfig: unified OF supported targets.
  arch/sh: Disable SH specific modules in OF enabled.
  include/linux/sh_intc.h: Add stub function "intc_finalize".
  arch/sh/kernel/setup.c: Update DT support.
  arch/sh/boards/of-generic.c: some cleanup.
  arch/sh/kernel/time.c: support COMMON_CLK.
  arch/sh/include/asm: Disable SH specific PCI define in OF enabled.
  drivers/pci/controller: SH7751 PCI Host bridge driver.
  Documentation/devicetree/bindings/pci: renesas,pci-sh7751.yaml new
    file.
  include/dt-bindings/clock/sh7750.h: cpg-sh7750 binding header.
  drivers/clk/renesas: clk-sh7750.c SH7750/7751 CPG driver.
  Documentation/devicetree/bindings/clock: Add renesas,sh7750-cpg
    binding document.
  drivers/irqchip: Add SH7751 Internal INTC drivers.
  Documentation/devicetree/bindings/interrupt-controller: Add
    renesas,sh7751-intc.yaml
  drivers/irqchip: SH7751 IRL external encoder with enable gate.
  Documentation/devicetree/bindings/interrupt-controller: Add
    renesas,sh7751-irl-ext.yaml
  drivers/tty/serial: sh-sci.c fix SH4 OF support.
  Documentation/devicetree/bindings/serial: renesas,scif.yaml Add SH.
  drivers/mfd: sm501 add some properties.
  devicetree/binding/display/sm501fb.txt: sm501fb add properies.
  drivers/clocksource/sh_tmu: Add support CLOCKSOURCE.
  Documentation/devicetree/bindings/timer: renesas,tmu.yaml add SH.
  include/dt-binding/interrupt-controller/sh_intc.h:
    renesas,sh7751-intc.h helper
  Documentation/devicetree/bindings/sh/cpus.yaml: Add SH CPU.
  arch/sh/boot/dts: SH7751R SoC Internal peripheral definition dtsi.
  Documentation/devicetree/bindings: vendor-prefix add IO DATA DEVICE
    Inc.
  Documentation/devicetree/bindings/ata: ata-generic.yaml add usl-5p and
    rts7751r2d.
  Documentation/devicetree/bindings/soc/renesas/sh.yaml: Add SH7751
    based target.
  arch/sh/boot/dts: RTS7751R2D Plus DeviceTree.
  arch/sh/boot/dts: LANDISK DeviceTree.
  arch/sh/boot/dts: USL-5P DeviceTree.
  arch/sh: Add dtbs target support.
  arch/sh: RTS7751R2D Plus OF defconfig
  arch/sh/configs: LANDISK OF defconfig

 .../devicetree/bindings/ata/ata-generic.yaml  |   2 +
 .../bindings/clock/renesas,sh7750-cpg.yaml    |  74 ++
 .../devicetree/bindings/display/sm501fb.txt   |  17 +
 .../renesas,sh7751-intc.yaml                  | 102 +++
 .../renesas,sh7751-irl-ext.yaml               |  89 ++
 .../bindings/pci/renesas,pci-sh7751.yaml      | 123 +++
 .../bindings/serial/renesas,scif.yaml         |   5 +
 .../devicetree/bindings/sh/cpus.yaml          |  45 +
 .../devicetree/bindings/soc/renesas/sh.yaml   |  32 +
 .../bindings/timer/renesas,tmu.yaml           |  11 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/sh/Kconfig                               |   7 +-
 arch/sh/boards/Kconfig                        |  25 +-
 arch/sh/boards/of-generic.c                   |  28 +-
 arch/sh/boot/compressed/head_32.S             |   5 +-
 arch/sh/boot/dts/Makefile                     |   5 +
 arch/sh/boot/dts/landisk.dts                  |  79 ++
 arch/sh/boot/dts/rts7751r2dplus.dts           | 157 ++++
 arch/sh/boot/dts/sh7751r.dtsi                 | 148 ++++
 arch/sh/boot/dts/usl-5p.dts                   |  88 ++
 arch/sh/configs/landisk-of_defconfig          | 111 +++
 arch/sh/configs/rts7751r2dplus-of_defconfig   |  92 ++
 arch/sh/drivers/Makefile                      |   2 +
 arch/sh/include/asm/io.h                      |  14 +-
 arch/sh/include/asm/pci.h                     |   4 +
 arch/sh/kernel/cpu/Makefile                   |   9 +-
 arch/sh/kernel/cpu/sh4/Makefile               |   2 +
 arch/sh/kernel/setup.c                        |  36 +-
 arch/sh/kernel/time.c                         |  12 +
 drivers/clk/renesas/Kconfig                   |  21 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/clk-sh7750.c              | 787 ++++++++++++++++++
 drivers/clocksource/sh_tmu.c                  | 161 ++--
 drivers/irqchip/Kconfig                       |  16 +
 drivers/irqchip/Makefile                      |   3 +
 drivers/irqchip/irq-renesas-sh7751.c          | 255 ++++++
 drivers/irqchip/irq-renesas-sh7751irl.c       | 206 +++++
 drivers/mfd/sm501.c                           | 113 +++
 drivers/pci/controller/Kconfig                |   9 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pci-sh7751.c           | 285 +++++++
 drivers/pci/controller/pci-sh7751.h           | 267 ++++++
 drivers/tty/serial/sh-sci.c                   |   6 +-
 drivers/video/fbdev/sm501fb.c                 |  92 ++
 include/dt-bindings/clock/sh7750.h            |  26 +
 .../interrupt-controller/sh_intc.h            |  18 +
 include/linux/sh_intc.h                       |   7 +-
 47 files changed, 3484 insertions(+), 116 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-sh7751.yaml
 create mode 100644 Documentation/devicetree/bindings/sh/cpus.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/sh.yaml
 create mode 100644 arch/sh/boot/dts/landisk.dts
 create mode 100644 arch/sh/boot/dts/rts7751r2dplus.dts
 create mode 100644 arch/sh/boot/dts/sh7751r.dtsi
 create mode 100644 arch/sh/boot/dts/usl-5p.dts
 create mode 100644 arch/sh/configs/landisk-of_defconfig
 create mode 100644 arch/sh/configs/rts7751r2dplus-of_defconfig
 create mode 100644 drivers/clk/renesas/clk-sh7750.c
 create mode 100644 drivers/irqchip/irq-renesas-sh7751.c
 create mode 100644 drivers/irqchip/irq-renesas-sh7751irl.c
 create mode 100644 drivers/pci/controller/pci-sh7751.c
 create mode 100644 drivers/pci/controller/pci-sh7751.h
 create mode 100644 include/dt-bindings/clock/sh7750.h
 create mode 100644 include/dt-bindings/interrupt-controller/sh_intc.h

-- 
2.39.2

