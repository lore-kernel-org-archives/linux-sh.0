From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 May 2014 08:53:39 +0000
Subject: [PATCH 00/03] staging: Emma Mobile USB driver and KZM9D board code
Message-Id: <20140522085339.26279.83340.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devel@driverdev.osuosl.org, linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, olof@lixom.net, Magnus Damm <magnus.damm@gmail.com>

Emma Mobile USB driver and KZM9D board code

[PATCH 01/03] staging: emxx_udc: Add Emma Mobile USB Gadget driver
[PATCH 02/03] staging: emxx_udc: I/O memory and IRQ resource support
[PATCH 03/03] staging: board: kzm9d: Board staging support for emxx_udc

This patch series contains an old USB Gadget driver for Emma Mobile
that gets slightly adjusted to make use of the platform device interface
which in turn is used to add USB Gadget support to the KZM9D board.

Two separate staging components are included in this series:
1) the emxx_udc driver - from out-of-tree Android 2.6.35.7
2) board staging support for KZM9D - platform device for DT-only KZM9D

The two components above will be used to continously improve the driver
and board integration code until the driver can be moved out of staging
and/or DT bindings are available so the board staging platform device code
can be replaced with a DT node.

Olof, patch 3/3 contains some board staging code for KZM9D. As it is
today the EMEV2 SoC is DT-only and we neither have defconfig nor Kconfig
definitions for the KZM9D board (emev2-kzm9d.dts). Instead of again adding
board code to the ARM subarchitecture I hereby propose that we use staging to
integrate non-DT drivers while they are improved to get DT support.

Greg, please let me know your opinions. I'd be happy to rework the code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against renesas-devel-v3.15-rc5-20140521

 drivers/staging/Kconfig             |    4 
 drivers/staging/Makefile            |    2 
 drivers/staging/board/Kconfig       |    7 
 drivers/staging/board/Makefile      |    1 
 drivers/staging/board/board.h       |   17 
 drivers/staging/board/kzm9d.c       |   18 
 drivers/staging/emxx_udc/Kconfig    |   10 
 drivers/staging/emxx_udc/Makefile   |    1 
 drivers/staging/emxx_udc/emxx_udc.c | 3616 ++++++++++++++++++++++++++++++++++-
 drivers/staging/emxx_udc/emxx_udc.h |  671 ++++++
 10 files changed, 4299 insertions(+), 48 deletions(-)
