From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 18 May 2015 11:04:13 +0000
Subject: [PATCH v2 0/2] usb: renesas_usbhs: Add support for R-Car E2
Message-Id: <1431947055-4324-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch set is based on Felipe's usb.git / testing/next branch.
(commit id = 1c14905ef951fb968c8da90e4e64be02c309a2ae)

This patch set adds support for R-Car E2. This patch set also changes
the SoC types "USBHS_TYPE_R8A779[01]" to USBHS_TYPE_RCAR_GEN2.

Changes from v1:
 - Use USBHS_TYPE_RCAR_GEN2 instead of USBHS_TYPE_R8A779[014].
 - Add "Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>" in patch 2
   (This is for the DT binding part).

Yoshihiro Shimoda (2):
  usb: renesas_usbhs: Change USBHS_TYPE_R8A779x to USBHS_TYPE_RCAR_GEN2
  usb: renesas_usbhs: Add support for R-Car E2

 .../devicetree/bindings/usb/renesas_usbhs.txt         |  1 +
 drivers/usb/renesas_usbhs/common.c                    | 19 ++++++++-----------
 include/linux/usb/renesas_usbhs.h                     |  3 +--
 3 files changed, 10 insertions(+), 13 deletions(-)

-- 
1.9.1

