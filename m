From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 15:44:51 +0000
Subject: [PATCH 0/2] Document GPIO regulator regulator-type property and use it
Message-Id: <1385653493-9952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

This patch set documents the required regulator-type property for the GPIO
regulator DT bindings and uses it in the Renesas Armadillo DT.

I've checked the DT files in mainline and all the GPIO regulator nodes but the
one in r8a7740-armadillo800eva-reference.dts specify the regulator-type
property.

Laurent Pinchart (2):
  regulator: gpio-regulator: Add required regulator-type property
  ARM: shmobile: armadillo: Set vccq_sdhi0 regulator type in DT

 Documentation/devicetree/bindings/regulator/gpio-regulator.txt | 2 ++
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts        | 2 ++
 2 files changed, 4 insertions(+)

-- 
Regards,

Laurent Pinchart

