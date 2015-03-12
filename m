From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 12 Mar 2015 06:35:17 +0000
Subject: [PATCH v3 0/3] usb: renesas_usbhs: add support for USB-DMAC
Message-Id: <1426142120-5072-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch set is based on Felipe's usb.git / testing/next branch.
(commit id = 9024c495f35be735a917571406fab30a789c27d1)

To use the USB-DMAC, we have to add some device nodes for USB-DMAC
in dts file. If we don't have such device nodes, this driver will
use PIO.

Changes from v2:
 - Remove patch 1 because this spinlock suspected issue disappears
   if I use a new usb-dmac dmaengine driver.

Changes from v1:
 - Change local_irq_save/restore() area in patch 1.
 - Modify the commit log in patch 1.
 - fix some comments in patch 4.

Yoshihiro Shimoda (3):
  usb: renesas_usbhs: add the channel number in dma-names
  usb: renesas_usbhs: fix the sequence in xfer_work()
  usb: renesas_usbhs: add support for USB-DMAC

 .../devicetree/bindings/usb/renesas_usbhs.txt      |   5 +-
 drivers/usb/renesas_usbhs/common.c                 |  19 +++
 drivers/usb/renesas_usbhs/common.h                 |   7 +
 drivers/usb/renesas_usbhs/fifo.c                   | 189 +++++++++++++++++++--
 drivers/usb/renesas_usbhs/fifo.h                   |   1 +
 drivers/usb/renesas_usbhs/pipe.c                   |  39 +++++
 drivers/usb/renesas_usbhs/pipe.h                   |   1 +
 include/linux/usb/renesas_usbhs.h                  |   2 +
 8 files changed, 247 insertions(+), 16 deletions(-)

-- 
1.9.1

