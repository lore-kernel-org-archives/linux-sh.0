From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 18 Dec 2014 02:26:06 +0000
Subject: [PATCH 0/4] KZM9G: Enable various I2C devices in DT
Message-Id: <1418869570-13529-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

This patch series enables the touchscreen controller, compass and
accelerometer in the KZM9G DT. It applies on top of your 'wip' branch. You
probably want to squash patches 3/4 and 4/4 with the patch(es) that add the
adxl325 and ak8975 DT nodes.

adxl325 support requires "[PATCH] input: adxl34x: Add OF match support"
previously posted to the linux-sh mailing list. This series can be applied
independently though, the device will just not be probed.

Could you please take the patches in your tree (when they will be acked of
course) ?

Laurent Pinchart (4):
  ARM: shmobile: sh73a0: Set control-parent for all irqpin nodes
  ARM: shmobile: sh73a0: kzm9g: Add touchscreen controller to DT
  ARM: shmobile: sh73a0: kzm9g: Specify the adxl325 interrupts
  ARM: shmobile: sh73a0: kzm9g: Specify the ak8975 interrupt

 arch/arm/boot/dts/sh73a0-kzm9g.dts | 25 ++++++++++++++++++-------
 arch/arm/boot/dts/sh73a0.dtsi      |  3 +++
 2 files changed, 21 insertions(+), 7 deletions(-)

-- 
Regards,

Laurent Pinchart

