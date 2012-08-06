From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 06 Aug 2012 12:31:03 +0000
Subject: [PATCH 0/2 v2] Add SDHI to Marzen board
Message-Id: <1344256265-9802-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Just clock & board resources.

Phil Edworthy (2):
  r8a7779: add SDHI clock support
  marzen: add SDHI0 support

 arch/arm/configs/marzen_defconfig      |    4 +-
 arch/arm/mach-shmobile/board-marzen.c  |   52 +++++++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/clock-r8a7779.c |   11 ++++++-
 3 files changed, 63 insertions(+), 4 deletions(-)

-- 
1.7.5.4

