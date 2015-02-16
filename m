From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 16 Feb 2015 01:52:55 +0000
Subject: [PATCH v2 0/4] usb: renesas_usbhs: add support for USB-DMAC
Message-Id: <1424051579-5060-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

This patch set is based on Felipe's usb.git / testing/next branch.
(commit id = 6461d69d12508fe166be5c6c31d5a9da02a4dfb5)

To use the USB-DMAC, we have to add some device nodes for USB-DMAC
in dts file. If we don't have such device nodes, this driver will
use PIO.

Changes from v1:
 - Change local_irq_save/restore() area in patch 1.
 - Modify the commit log in patch 1.
 - fix some comments in patch 4.

Yoshihiro Shimoda (4):
  usb: renesas_usbhs: fix spinlock suspected in a gadget complete
    function
  usb: renesas_usbhs: add the channel number in dma-names
  usb: renesas_usbhs: fix the sequence in xfer_work()
  usb: renesas_usbhs: add support for USB-DMAC

 .../devicetree/bindings/usb/renesas_usbhs.txt      |    5 +-
 drivers/usb/renesas_usbhs/common.c                 |   19 ++
 drivers/usb/renesas_usbhs/common.h                 |    7 +
 drivers/usb/renesas_usbhs/fifo.c                   |  189 ++++++++++++++++++--
 drivers/usb/renesas_usbhs/fifo.h                   |    1 +
 drivers/usb/renesas_usbhs/mod_gadget.c             |   11 ++
 drivers/usb/renesas_usbhs/pipe.c                   |   39 ++++
 drivers/usb/renesas_usbhs/pipe.h                   |    1 +
 include/linux/usb/renesas_usbhs.h                  |    2 +
 9 files changed, 258 insertions(+), 16 deletions(-)

-- 
1.7.9.5

