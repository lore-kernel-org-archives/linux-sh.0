From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Tue, 15 Oct 2013 09:08:22 +0000
Subject: [PATCH 0/2] ARM: shmobile: QSPI support to R8a7790
Message-Id: <1381828104-31302-1-git-send-email-cm-hiep@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Hi Simon,

These patchs add QSPI support to R8a7790 SOC. 
This QSPI attaches to SPI Flash Memory (Spansion S25FL512SAGMFIG11 64Mb)

These patches was developed base on the  branch upstream linux-
v3.12-rc1 and have tested on the Lager board.

Best Regards!
Hiep Cao Minh,

Hiep Cao Minh (2):
  ARM: shmobile: r8a7790: add QSPI support
  ARM: shmobile: Lager: add SPI FLASH support

 arch/arm/mach-shmobile/board-lager.c          |   55 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c        |    4 ++
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    2 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |   16 +++++++
 4 files changed, 77 insertions(+)

-- 
1.7.9.5

