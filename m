From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 02 Oct 2014 08:02:31 +0000
Subject: [PATCH 0/2] add support for generic PHY
Message-Id: <1412236953-1084-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series adds support for the generic PHY.

This series is based on the origin/testing/next branch in Felipe's git.
(commit id : 0255b031447df5a81988e2f312588d0e2c8c3688)

Yoshihiro Shimoda (2):
  usb: renesas_usbhs: rename phy to usb_phy in usbhs_priv
  usb: renesas_usbhs: add support for generic PHY

 drivers/usb/renesas_usbhs/common.h |    3 +-
 drivers/usb/renesas_usbhs/rcar2.c  |   73 ++++++++++++++++++++++++++----------
 2 files changed, 55 insertions(+), 21 deletions(-)

-- 
1.7.9.5

