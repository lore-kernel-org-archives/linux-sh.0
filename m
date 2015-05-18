From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 18 May 2015 09:34:23 +0000
Subject: [PATCH 0/2] usb: renesas_usbhs: Add support for R-Car E2
Message-Id: <1431941665-3768-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421639597-2784-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1421639597-2784-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch set is based on Felipe's usb.git / testing/next branch.
(commit id = 1c14905ef951fb968c8da90e4e64be02c309a2ae)

This patch set adds support for R-Car E2. This patch set also changes
the SoC types from #define values to enum values.

Yoshihiro Shimoda (2):
  usb: renesas_usbhs: Change the SoC types to enum values
  usb: renesas_usbhs: Add support for R-Car E2

 Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 1 +
 drivers/usb/renesas_usbhs/common.c                      | 6 ++++++
 include/linux/usb/renesas_usbhs.h                       | 7 +++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

-- 
1.9.1

