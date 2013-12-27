From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 27 Dec 2013 11:44:02 +0000
Subject: [PATCH V3 0/2] ARM: shmobile: lager: Add VIN1 support
Message-Id: <1388144644-9000-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds VIN clocks to R8A7790 SoC and VIN1 camera support to Lager.
VIN1 uses I2C ADV7180 decoder device that is also added.
The board also has VIN0 wired up to the I2C ADV7612 decoder, but it's
not enabled yet due to the lack of ADV7612 support in the kernel.

Changes in V2:
* made lager_add_vin_device function static.

Changes in V3:
* capitalized ARM in the subject.

Valentine Barshak (2):
  ARM: shmobile: r8a7790: Add VIN clock support
  ARM: shmobile: lager: Add VIN1 SoC camera support

 arch/arm/mach-shmobile/board-lager.c   | 76 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c |  9 ++++
 2 files changed, 85 insertions(+)

-- 
1.8.3.1

