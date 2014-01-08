From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Wed, 08 Jan 2014 16:31:22 +0000
Subject: [PATCH 0/3] ARM: shmobile: r8a7790: Add VIN, PCI USB and SATA clocks
Message-Id: <1389198685-6435-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds VIN, PCI USB and SATA clocks to R8A7790 SoC
The patches are rebased on top of the following commit:
357f3cc31e "ARM: shmobile: r8a7790: Wait for status on all MSTP clocks"

Valentine Barshak (3):
  ARM: shmobile: r8a7790: Add VIN clock support
  ARM: shmobile: r8a7790: Add PCI USB host clock support
  ARM: shmobile: r8a7790: Add SATA clocks

 arch/arm/mach-shmobile/clock-r8a7790.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
1.8.3.1

