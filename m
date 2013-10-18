From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Fri, 18 Oct 2013 05:33:02 +0000
Subject: [PATCH 0/2 v2] ARM: shmobile: QSPI support for R8a7790
Message-Id: <1382074384-24975-1-git-send-email-cm-hiep@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Hi Simon,

Here's version number two(v2) of the patchs add QSPI support to R8a7790 SOC. 
This QSPI attaches to SPI Flash Memory (Spansion S25FL512SAGMFIG11 64Mb)

This time these patches are base on the branch renesas 
"renesas-devel-v3.12-rc5-20131017" and have tested on the Lager board.
Note: 
"#define SMSTPCR9 0xe6150994" in clock setting is not needed in this verion.

Mark Brown told me that my qspi patch is on topic/rspi (5ce0ba8 and cb52c67) 
in the SPI tree:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git

Best Regards,

Hiep Cao Minh.

Hiep Cao Minh (2):
  ARM: shmobile: r8a7790: add QSPI support
  ARM: shmobile: Lager:add SPI FLASH support on QSPI

 arch/arm/mach-shmobile/board-lager.c   |   69 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c |    4 +-
 2 files changed, 72 insertions(+), 1 deletion(-)

-- 
1.7.9.5

