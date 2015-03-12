From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 12 Mar 2015 03:55:35 +0000
Subject: [PATCH 0/2] ARM: shmobile: Correct SYSCIER values
Message-Id: <1426132537-31606-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

this short series corrects the SYSCIER value used on the r9a7790 and
r8a7791 SoCs.

I am not aware of any run-time effect of these changes.

This series is based on renesas-devel-20150312-v4.0-rc3

Simon Horman (2):
  ARM: shmobile: r8a7790: Correct SYSCIER value
  ARM: shmobile: r8a7791: Correct SYSCIER value

 arch/arm/mach-shmobile/pm-r8a7790.c | 2 +-
 arch/arm/mach-shmobile/pm-r8a7791.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.1.4

