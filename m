From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 07 Oct 2014 03:43:03 +0000
Subject: [PATCH v2 0/3] usb: renesas_usbhs: add support for generic PHY
Message-Id: <1412653386-5856-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series adds support for the generic PHY.

This series is based on the origin/testing/next branch in Felipe's git.
(commit id : cf72c46944766b69e7bc5c10ac69f2b01287b7a9)

Changes from v1:
 - Separate patch 1 to "rename" and "clean up".

Yoshihiro Shimoda (3):
  usb: renesas_usbhs: rename phy to usb_phy in usbhs_priv
  usb: renesas_usbhs: clean up rcar2.c to support a generic PHY
  usb: renesas_usbhs: add support for generic PHY

 drivers/usb/renesas_usbhs/common.h |    3 +-
 drivers/usb/renesas_usbhs/rcar2.c  |   73 ++++++++++++++++++++++++++----------
 2 files changed, 55 insertions(+), 21 deletions(-)

-- 
1.7.9.5

