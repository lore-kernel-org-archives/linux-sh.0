From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 24 Jul 2012 13:26:07 +0000
Subject: [PATCH 0/2] Armadillo 800 EVA GPIO buttons fixes
Message-Id: <1343136369-14636-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here are two small patches for the Armadillo 800 EVA GPIO buttons. The first
one is mostly cosmetic, it renames the buttons to match the names printed on
the board. The second patch adds support for waking up the system using the
power GPIO button.

Laurent Pinchart (2):
  ARM: mach-shmobile: armadillo800eva: Fix GPIO buttons descriptions
  ARM: mach-shmobile: armadillo800eva: Enable power button as wakeup
    source

 arch/arm/mach-shmobile/board-armadillo800eva.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

-- 
Regards,

Laurent Pinchart

