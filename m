From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 27 Dec 2013 11:27:36 +0000
Subject: [PATCH 0/3 V2] ARM: shmobile: koelsch: Add I2C support
Message-Id: <1388143659-8739-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds support for the I2C pins and clocks to the R8A7791 SoC.
It also adds I2C support to Koelsch board.

Changes in V2:
* Capitalized ARM in the subject.

Valentine Barshak (3):
  pinctrl: sh-pfc: r8a7791: Add I2C pins
  ARM: shmobile: r8a7791: Add I2C clocks
  ARM: shmobile: koelsch: Add I2C support

 arch/arm/mach-shmobile/board-koelsch.c |  46 ++++++++
 arch/arm/mach-shmobile/clock-r8a7791.c |  13 +++
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c   | 196 +++++++++++++++++++++++++++++++++
 3 files changed, 255 insertions(+)

-- 
1.8.3.1

