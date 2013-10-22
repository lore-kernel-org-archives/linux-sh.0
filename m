From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Tue, 22 Oct 2013 02:21:10 +0000
Subject: [PATCH 0/2 v4] ARM: shmobile: QSPI support for R8a7790
Message-Id: <1382408472-20315-1-git-send-email-cm-hiep@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Hi Simon,

Here's version number four(v4) of the patchs add QSPI support to R8a7790 SOC. 
This QSPI attaches to SPI Flash Memory (Spansion S25FL512SAGMFIG11 64Mb)
I have updated the patch of 0001 with setting MSTP917 on a line of its own.
These patches are based on the branch renesas "renesas-devel-v3.12-rc5-20131017"
and have tested on the Lager board.
The qspi patch is on topic/rspi (5ce0ba8 and cb52c67) in the SPI tree:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git

Best Regards,
Hiep Cao Minh.

Hiep Cao Minh (2):
  ARM: shmobile: r8a7790: add QSPI support
  ARM: shmobile: Lager:add SPI FLASH support on QSPI

 arch/arm/mach-shmobile/board-lager.c   |   64 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c |    3 ++
 2 files changed, 67 insertions(+)

-- 
1.7.9.5

