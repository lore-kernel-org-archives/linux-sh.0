From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 14 Feb 2014 17:20:39 +0000
Subject: [PATCH v2 0/2] Lager and Koelsh reference DU support
Message-Id: <1392398441-9560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

These two patches add support for the Display Unit to the Lager and Koelsch 
reference board files. The device should ideally be instantiated through DT,
but given the lack of DT bindings for the foreseeable future platform devices
are used as a temporary solution.

Compared to v1 the patches have been rebased directly on top of Simon's latest
devel branch.

Laurent Pinchart (2):
  ARM: shmobile: lager-reference: Add DU device
  ARM: shmobile: koelsch-reference: Add DU device

 arch/arm/boot/dts/r8a7790-lager.dts              |   7 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts            |   7 +-
 arch/arm/mach-shmobile/board-koelsch-reference.c | 101 ++++++++++++++++++----
 arch/arm/mach-shmobile/board-lager-reference.c   | 103 +++++++++++++++++++----
 4 files changed, 186 insertions(+), 32 deletions(-)

-- 
Regards,

Laurent Pinchart

