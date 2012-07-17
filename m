From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 17 Jul 2012 11:53:57 +0000
Subject: [PATCH 0/2] Add SDHI to Marzen board
Message-Id: <1342526039-11128-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Just clock & board resources.

Phil Edworthy (2):
  r8a7779: add SDHI clock support
  marzen: add SDHI0 support

 arch/arm/mach-shmobile/board-marzen.c  |   48 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7779.c |   13 ++++++--
 2 files changed, 58 insertions(+), 3 deletions(-)

-- 
1.7.5.4

