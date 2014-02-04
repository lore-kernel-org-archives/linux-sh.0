From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 04 Feb 2014 18:48:19 +0000
Subject: [PATCH 0/4] Rebased pending Koelsch patches on v3.14-rc1
Message-Id: <1391539703-5787-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is a rebase of I2C and VIN1 support for Koelsch
as requested by Simon here:
http://marc.info/?l=linux-sh&m8898894707395&w=2
http://marc.info/?l=linux-sh&m8899483408459&w=2

Also I2C and VIN SoC camera support have been added
to koelsch_defconfig.

I've decided to combine them in a single series
since VIN depends on I2C support.

Valentine Barshak (4):
  ARM: shmobile: koelsch: Add I2C support
  ARM: shmobile: koelsch: Add VIN1 SoC camera support
  ARM: shmobile: koelsch: Enable I2C in defconfig
  ARM: shmobile: koelsch: Enable VIN SoC camera in defconfig

 arch/arm/configs/koelsch_defconfig     |   9 +++
 arch/arm/mach-shmobile/board-koelsch.c | 122 +++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

-- 
1.8.3.1

