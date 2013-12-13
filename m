From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 13 Dec 2013 11:52:38 +0000
Subject: [PATCH 0/2] arm: shmobile: r8a7790: Add SATA and PCI USB clocks
Message-Id: <1386935560-16739-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds SATA and PCI USB clocks to R8A7790 SoC.

Valentine Barshak (2):
  arm: shmobile: r8a7790: Add PCI USB host clock support
  arm: shmobile: r8a7790: Add SATA clock

 arch/arm/mach-shmobile/clock-r8a7790.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

-- 
1.8.3.1

