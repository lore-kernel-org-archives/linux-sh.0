From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 18 Nov 2015 05:34:08 +0000
Subject: [PATCH v2 0/3] usb: renesas_usbhs: gadget: modifications for g_audio
Message-Id: <1447824850-6296-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch is based on the latest Felipe's usb.git / testing/next branch.
(The commit id = 81e9d14a53eb1abfbe6ac828a87a2deb4702b5f1)

Changes from v1:
 - Rebase the latest usb.git testing/next branch.
 - Separate other one patch. (In other words, that patch is for bugfix.)

Yoshihiro Shimoda (2):
  usb: renesas_usbhs: Modify pipe configuration
  usb: renesas_usbhs: Modify ep.caps.type_xxx and
    usb_ep_maxpacket_limit()

 drivers/usb/renesas_usbhs/common.c     |  69 ++++++++++----------
 drivers/usb/renesas_usbhs/mod_gadget.c |  19 +++---
 drivers/usb/renesas_usbhs/mod_host.c   |  11 ++--
 drivers/usb/renesas_usbhs/pipe.c       | 112 ++++++++-------------------------
 drivers/usb/renesas_usbhs/pipe.h       |   1 -
 include/linux/usb/renesas_usbhs.h      |  18 +++++-
 6 files changed, 94 insertions(+), 136 deletions(-)

-- 
1.9.1

