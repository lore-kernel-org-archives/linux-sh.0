From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 09 Jul 2014 11:29:52 +0000
Subject: [PATCH 0/2] usb: renesas_usbhs: gadget: fix for g_zero
Message-Id: <53BD27B0.9000304@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From a5aea0fe3afcdfea82f08806856747e426ba8064 Mon Sep 17 00:00:00 2001
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 9 Jul 2014 20:18:56 +0900
Subject: [PATCH 0/2] usb: renesas_usbhs: gadget: fix for g_zero

This patch fixes an issue that the renesas_usbhs driver in gadget mode
cannot work correctly even if I disabled DMAC of the driver when I used
the g_zero driver and the testusb tool.

Yoshihiro Shimoda (2):
  usb: renesas_usbhs: fix usbhs_pipe_malloc() to re-enable a pipe.
  usb: renesas_usbhs: gadget: fix re-enabling pipe without
    re-connecting

 drivers/usb/renesas_usbhs/mod_gadget.c |    2 ++
 drivers/usb/renesas_usbhs/pipe.c       |   11 +++++++++++
 drivers/usb/renesas_usbhs/pipe.h       |    1 +
 3 files changed, 14 insertions(+)

-- 
1.7.9.5

