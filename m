From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 11 Feb 2014 20:49:48 +0000
Subject: [PATCH 0/2] Lager and Koelsh reference DU support
Message-Id: <1392151790-11262-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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

The patches are based on top of the "[PATCH v4 0/2] [RESEND] Lager and Koelsch
reference serial port support" series that I've posted earlier today.

Laurent Pinchart (2):
  ARM: shmobile: lager-reference: Add DU device
  ARM: shmobile: koelsch-reference: Add DU device

 arch/arm/boot/dts/r8a7790-lager.dts              |  8 +++
 arch/arm/boot/dts/r8a7791-koelsch.dts            |  8 +++
 arch/arm/mach-shmobile/board-koelsch-reference.c | 82 ++++++++++++++++++++--
 arch/arm/mach-shmobile/board-lager-reference.c   | 89 ++++++++++++++++++++++--
 4 files changed, 175 insertions(+), 12 deletions(-)

-- 
Regards,

Laurent Pinchart

