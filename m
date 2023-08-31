Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAF2C83F19
	for <linux-sh@archiver.kernel.org>; Thu, 31 Aug 2023 01:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbjHaBMO (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Aug 2023 21:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbjHaBMM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Aug 2023 21:12:12 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968AACC5
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 18:12:07 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id cff12cc4-8b5b-4a22-9145-12533528baf3;
        Thu, 31 Aug 2023 10:12:06 +0900 (JST)
Received: from SIOS1075.flets-east.jp (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id CEAFB1C0015;
        Thu, 31 Aug 2023 10:12:04 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RESEND RFC PATCH 00/12] DeviceTree support for SH7751 based boards.
Date:   Thu, 31 Aug 2023 10:11:47 +0900
Message-Id: <cover.1693444193.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

I sent it yesterday but it wasn't delivered so I'm resending it.

This is an updated version of something I wrote about 7 years ago.
Minimum support for R2D-plus and LANDISK.
I think R2D-1 will work if you add AX88796 to dts.
And board-specific functions and SCI's SPI functions are not supported.

Yoshinori Sato (12):
  sh: Add OF target boards.
  sh: Update OF handling.
  sh: SH4 OF support.
  clk: SH7750 / 7751 clk driver.
  drivers/irqchip: Add SH7751 and boards specific irqchip.
  drivers/pci: Add SH7751 PCI Host bridge driver.
  clocksource: Update sh_tmu of handling.
  mfd/sm501: Add OF properties.
  of: FDT vaddr support for SH.
  serial/sh-sci: Fix earlyprintk / earlycon.
  sh: target dts.
  sh: OF defconfig.

 .../devicetree/bindings/display/sm501fb.txt   |  11 +
 arch/sh/Kconfig                               |  12 +-
 arch/sh/boards/Kconfig                        |  28 ++
 arch/sh/boards/of-generic.c                   |  28 +-
 arch/sh/boot/compressed/head_32.S             |   5 +-
 arch/sh/boot/dts/include/dt-bindings          |   1 +
 arch/sh/boot/dts/landisk.dts                  | 142 +++++++
 arch/sh/boot/dts/rts7751r2dplus.dts           | 168 ++++++++
 arch/sh/boot/dts/usl-5p.dts                   | 146 +++++++
 arch/sh/configs/landisk-of_defconfig          | 161 ++++++++
 arch/sh/configs/rts7751r2dplus-of_defconfig   | 159 ++++++++
 arch/sh/drivers/Makefile                      |   2 +
 arch/sh/include/asm/io.h                      |  10 +
 arch/sh/include/asm/pci.h                     |   4 +
 arch/sh/kernel/cpu/Makefile                   |   8 +-
 arch/sh/kernel/cpu/clock.c                    |   3 +-
 arch/sh/kernel/cpu/sh4/Makefile               |   2 +
 arch/sh/kernel/head_32.S                      |   2 +-
 arch/sh/kernel/setup.c                        |  26 +-
 drivers/clk/Kconfig                           |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/sh/Kconfig                        |   7 +
 drivers/clk/sh/Makefile                       |   2 +
 drivers/clk/sh/clk-sh7750.c                   | 193 +++++++++
 drivers/clk/sh/clk-shdiv.c                    | 341 ++++++++++++++++
 drivers/clocksource/sh_tmu.c                  |  33 +-
 drivers/irqchip/Kconfig                       |   4 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-iodata-julian.c           | 163 ++++++++
 drivers/irqchip/irq-renesas-r2d.c             | 175 ++++++++
 drivers/irqchip/irq-renesas-sh7751.c          | 186 +++++++++
 drivers/mfd/sm501.c                           | 113 +++++-
 drivers/of/fdt.c                              |   3 +
 drivers/pci/controller/Kconfig                |   9 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pci-sh7751.c           | 382 ++++++++++++++++++
 drivers/pci/controller/pci-sh7751.h           | 267 ++++++++++++
 drivers/sh/Makefile                           |   2 +
 drivers/tty/serial/sh-sci.c                   |  10 +-
 39 files changed, 2779 insertions(+), 33 deletions(-)
 create mode 120000 arch/sh/boot/dts/include/dt-bindings
 create mode 100644 arch/sh/boot/dts/landisk.dts
 create mode 100644 arch/sh/boot/dts/rts7751r2dplus.dts
 create mode 100644 arch/sh/boot/dts/usl-5p.dts
 create mode 100644 arch/sh/configs/landisk-of_defconfig
 create mode 100644 arch/sh/configs/rts7751r2dplus-of_defconfig
 create mode 100644 drivers/clk/sh/Kconfig
 create mode 100644 drivers/clk/sh/Makefile
 create mode 100644 drivers/clk/sh/clk-sh7750.c
 create mode 100644 drivers/clk/sh/clk-shdiv.c
 create mode 100644 drivers/irqchip/irq-iodata-julian.c
 create mode 100644 drivers/irqchip/irq-renesas-r2d.c
 create mode 100644 drivers/irqchip/irq-renesas-sh7751.c
 create mode 100644 drivers/pci/controller/pci-sh7751.c
 create mode 100644 drivers/pci/controller/pci-sh7751.h

-- 
2.39.2

