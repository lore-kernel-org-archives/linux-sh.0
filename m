From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 12 Sep 2014 08:52:04 +0000
Subject: [PATCH v2 0/2] ARM: shmobile: r8a7794/Cortex-A7 arch timer fix
Message-Id: <1410511926-9326-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Here's again the bit to get the arch timer working on the r8a7794 platform,
this time without the secondary CPU initialization which we don't need
anyway ATM for lack of SMP support.

CU
Uli


Changes since v1:
- dumped secondary CPU intialization until we have SMP


Hisashi Nakamura (1):
  ARM: shmobile: r8a7794: Add arch_timer to device tree

Ulrich Hecht (1):
  ARM: shmobile: rcar-gen2: Add CA7 arch_timer initialization for
    r8a7794

 arch/arm/boot/dts/r8a7794.dtsi           |  8 ++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 72 ++++++++++++++++++++++----------
 2 files changed, 57 insertions(+), 23 deletions(-)

-- 
1.8.4.5

