From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Wed, 25 Dec 2013 19:36:00 +0000
Subject: [PATCH 0/3] arm: shmobile: koelsch: Add VIN1 camera support
Message-Id: <1388000163-9932-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387998730-6012-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387998730-6012-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds VIN pins and clocks to R8A7791 SoC along with
VIN1 camera support to Koelsch board.

This is probably a bit early since it depends on
the following pending patches:
http://marc.info/?l=linux-sh&m8783049300710&w=2
([PATCH] media: soc_camera: rcar_vin: Add preliminary R-Car M2 support)
http://marc.info/?l=linux-sh&m8799873528360&w=2
([PATCH 0/3] arm: shmobile: koelsch: Add I2C support)

Valentine Barshak (3):
  pinctrl: sh-pfc: r8a7791: Add VIN pins
  arm: shmobile: r8a7791: Add VIN clocks
  arm: shmobile: koelsch: Add VIN1 SoC camera support

 arch/arm/mach-shmobile/board-koelsch.c |  76 +++++++
 arch/arm/mach-shmobile/clock-r8a7791.c |  10 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c   | 360 +++++++++++++++++++++++++++++++++
 3 files changed, 446 insertions(+)

-- 
1.8.3.1

