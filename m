From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 29 Aug 2014 18:15:42 +0000
Subject: [PATCH 0/3] r8a7794/Cortex-A7 arch timer fix
Message-Id: <1409336145-619-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Here's a little bit to get the arch timer working on the r8a7794 platform. 
There probably is a better place for the assembly code in setup-rcar-gen2.c
because it is likely to be needed on other platforms with A7 cores as well.
Suggestions would be appreciated.

CU
Uli


Hisashi Nakamura (2):
  ARM: shmobile: r8a7794: Add arch_timer to device tree
  ARM: shmobile: Add CA7 arch_timer initialization for secondary CPUs

Ulrich Hecht (1):
  ARM: shmobile: rcar-gen2: Add CA7 arch_timer initialization for
    r8a7794

 arch/arm/boot/dts/r8a7794.dtsi           |  8 ++++
 arch/arm/mach-shmobile/headsmp.S         | 26 ++++++++++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 72 ++++++++++++++++++++++----------
 3 files changed, 83 insertions(+), 23 deletions(-)

-- 
1.8.4.5

