From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 18 Aug 2015 13:12:16 +0000
Subject: [PATCH 0/2] legacy leftovers cleanup
Message-Id: <1439903538-19201-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

As requested, this incremental series removes the remaining obsolete legacy
bits found by Geert.

CU
Uli


Ulrich Hecht (2):
  ARM: shmobile: bockw: remove legacy DTB build target
  ARM: shmobile: Kconfig: remove unused SHMOBILE_TIMER_HZ section

 arch/arm/boot/dts/Makefile     |  2 --
 arch/arm/mach-shmobile/Kconfig | 20 --------------------
 2 files changed, 22 deletions(-)

-- 
2.4.6

