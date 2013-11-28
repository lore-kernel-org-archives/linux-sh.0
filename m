From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 16:37:49 +0000
Subject: [PATCH 0/2] ARM: shmobile: emev2: Use interrupt macros in DT file
Message-Id: <1385656671-18748-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

These two patches replace numeric constants with IRQ_TYPE_* macros in the
emev2 DT files, and replace IRQ_TYPE_NONE with the proper type. I can't test
the second patch due to lack of hardware, I'd appreciate if someone could
take care of that.

Laurent Pinchart (2):
  ARM: shmobile: emev2: Use interrupt macros in DT files
  ARM: shmobile: emev2: Setup internal peripheral interrupts as level
    high

 arch/arm/boot/dts/emev2-kzm9d.dts |  3 ++-
 arch/arm/boot/dts/emev2.dtsi      | 30 ++++++++++++++++++------------
 2 files changed, 20 insertions(+), 13 deletions(-)

-- 
Regards,

Laurent Pinchart

