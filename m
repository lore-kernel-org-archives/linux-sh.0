From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 22 Aug 2014 11:13:39 +0000
Subject: [PATCH 0/4] usb: renesas_usbhs: fixes this driver in gadget mode
Message-Id: <53F725E3.4050304@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If we tested this driver as gadget and g_ncm driver using iperf,
some issues below happened:
 - Oops happened.
 - A transaction didn't finish in PIO mode.
 - A transaction didn't finish in DMA mode if the "zero" flag is set.
 - The driver didn't cancel a transaction if dequeue() is called.

This patch series fixes them. If possible, they would like to be
merged to v3.17.
This patch series is based on Greg's usb.git / usb-linus branch.
(commit id: 6835a3a02b1ae222cbfb167a7e2d5e8df5e9854e)

Yoshihiro Shimoda (4):
  usb: renesas_usbhs: fix the behavior of some usbhs_pkt_handle
  usb: renesas_usbhs: protect mod->irq_{bemp,brdy}sts by spin lock
  usb: renesas_usbhs: fix the condition of is_done in
    usbhsf_dma_push_done
  usb: renesas_usbhs: fix the usb_pkt_pop()

 drivers/usb/renesas_usbhs/fifo.c |   72 ++++++++++++++++++++++++++++++++++----
 drivers/usb/renesas_usbhs/mod.c  |    5 +++
 drivers/usb/renesas_usbhs/pipe.c |   13 +++++++
 drivers/usb/renesas_usbhs/pipe.h |    4 +++
 4 files changed, 88 insertions(+), 6 deletions(-)

-- 
1.7.9.5

