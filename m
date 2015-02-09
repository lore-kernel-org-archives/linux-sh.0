From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 09 Feb 2015 08:16:10 +0000
Subject: [PATCH 0/4] usb: renesas_usbhs: add support for USB-DMAC
Message-Id: <1423469774-6532-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

Yoshihiro Shimoda (4):
  usb: renesas_usbhs: fix spinlock recursion by usbhsf_dma_complete()
  usb: renesas_usbhs: add the channel number in dma-names
  usb: renesas_usbhs: fix the sequence in xfer_work()
  usb: renesas_usbhs: add support for USB-DMAC

 .../devicetree/bindings/usb/renesas_usbhs.txt      |    5 +-
 drivers/usb/renesas_usbhs/common.c                 |   19 ++
 drivers/usb/renesas_usbhs/common.h                 |    7 +
 drivers/usb/renesas_usbhs/fifo.c                   |  191 ++++++++++++++++++--
 drivers/usb/renesas_usbhs/fifo.h                   |    1 +
 drivers/usb/renesas_usbhs/pipe.c                   |   39 ++++
 drivers/usb/renesas_usbhs/pipe.h                   |    1 +
 include/linux/usb/renesas_usbhs.h                  |    2 +
 8 files changed, 249 insertions(+), 16 deletions(-)

-- 
1.7.9.5

