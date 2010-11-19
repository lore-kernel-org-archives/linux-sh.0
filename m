From: Yoshii Takashi <takashi.yoshii.zj@renesas.com>
Date: Fri, 19 Nov 2010 13:18:13 +0000
Subject: [PATCH 0/2] ARM: sh-mobile: ag5evm i2c-sh_mobile support.
Message-Id: <4CE67915.1010707@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Following patches make sh73a0/ag5evm support i2c-sh_mobile i2c bus controller.
Currently, no target device support is included.
CPU part is just a list of resource definitions. And what needed in board
part is only pinmux setting.
These(platform/pinmux/clkdev/pm/..) systems are great!
/yoshii

Takashi YOSHII (2):
  ARM: sh-mobile: sh73a0 i2c_shmobile support.
  ARM: sh-mobile: ag5evm i2c_shmobile support.

 arch/arm/mach-shmobile/board-ag5evm.c |    6 ++
 arch/arm/mach-shmobile/clock-sh73a0.c |   21 ++++++-
 arch/arm/mach-shmobile/setup-sh73a0.c |  115 +++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 2 deletions(-)

-- 1.7.2.2 
