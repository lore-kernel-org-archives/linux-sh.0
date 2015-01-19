From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 19 Jan 2015 03:53:15 +0000
Subject: [PATCH 0/2] usb: renesas_usbhs: add support for requesting DT DMA
Message-Id: <1421639597-2784-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series is based on Felipe's usb.git / testing/next branch.
(commit id = 05cf6e00b8ff2b80c8b2d1e69f07cdd6c830efe0)

Yoshihiro Shimoda (2):
  usb: renesas_usbhs: add usbhsf_dma_init_pdev() function
  usb: renesas_usbhs: add support for requesting DT DMA

 .../devicetree/bindings/usb/renesas_usbhs.txt      |    2 ++
 drivers/usb/renesas_usbhs/fifo.c                   |   21 +++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

-- 
1.7.9.5

