From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 10 Nov 2014 11:02:43 +0000
Subject: [PATCH 0/4] usb: renesas_usbhs: expand USB-DMAC channels for R-Car Gen2
Message-Id: <1415617367-3828-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch serias expands USB-DMAC channels for R-Car Gen2 SoCs.
 - First 3 patches are clean-up source codes.
 - Last patch is expanded the channels.

This patch serias is based on Felipe's usb.git / testing/next branch.
(commit id: 83ef5086ad00ac5d9068d6b574bc660659e1f135)

Yoshihiro Shimoda (4):
  usb: renesas_usbhs: change d{0,1}fifo to dfifo array
  usb: renesas_usbhs: standardize d{0,1}fifo control
  usb: renesas_usbhs: add a new macro for extending DnFIFOs
  usb: renesas_usbhs: expand USB-DMAC channels for R-Car Gen2

 drivers/usb/renesas_usbhs/common.h |    4 ++
 drivers/usb/renesas_usbhs/fifo.c   |   77 ++++++++++++++++++------------------
 drivers/usb/renesas_usbhs/fifo.h   |    9 ++++-
 include/linux/usb/renesas_usbhs.h  |    4 ++
 4 files changed, 54 insertions(+), 40 deletions(-)

-- 
1.7.9.5

