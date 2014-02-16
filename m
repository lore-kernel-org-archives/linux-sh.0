From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 16 Feb 2014 21:31:57 +0000
Subject: [PATCH v3 0/4] Lager and Koelsh reference DU support
Message-Id: <1392586321-12187-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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

Changes since v2:

- Split off the refactoring of the clock registration.

Changes since v1:

- Rebased directly on top of Simon's latest devel branch.

Laurent Pinchart (4):
  ARM: shmobile: lager-reference: Refactor clock lookup hack
  ARM: shmobile: lager-reference: Add DU device
  ARM: shmobile: koelsch-reference: Refactor clock lookup hack
  ARM: shmobile: koelsch-reference: Add DU device

 arch/arm/boot/dts/r8a7790-lager.dts              |   7 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts            |   7 +-
 arch/arm/mach-shmobile/board-koelsch-reference.c | 101 ++++++++++++++++++----
 arch/arm/mach-shmobile/board-lager-reference.c   | 103 +++++++++++++++++++----
 4 files changed, 186 insertions(+), 32 deletions(-)

-- 
Regards,

Laurent Pinchart

