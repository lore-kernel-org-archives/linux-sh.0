From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 24 Sep 2013 13:38:33 +0000
Subject: [PATCH 0/3] media: Add SH-Mobile RCAR-H2 Lager board support
Message-Id: <1380029916-10331-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The following patches add ADV7611/ADV7612 HDMI receiver I2C driver
and add RCAR H2 SOC support along with ADV761x output format support
to rcar_vin soc_camera driver.

These changes are needed for SH-Mobile R8A7790 Lager board
video input support.

Valentine Barshak (3):
  media: i2c: Add ADV761X support
  media: rcar_vin: Add preliminary r8a7790 H2 support
  media: rcar_vin: Add RGB888_1X24 input format support

 drivers/media/i2c/Kconfig                    |   11 +
 drivers/media/i2c/Makefile                   |    1 +
 drivers/media/i2c/adv761x.c                  | 1060 ++++++++++++++++++++++++++
 drivers/media/platform/soc_camera/rcar_vin.c |   17 +-
 include/media/adv761x.h                      |   28 +
 5 files changed, 1114 insertions(+), 3 deletions(-)
 create mode 100644 drivers/media/i2c/adv761x.c
 create mode 100644 include/media/adv761x.h

-- 
1.8.3.1

