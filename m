From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 18 Mar 2014 18:04:46 +0000
Subject: [PATCH 0/2] Lager & Koelsch: Set ethernet PHY LED mode
Message-Id: <1395165888-1498-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

These two patches set the ethernet PHY LED mode to output etherner link status
on LED0 for the Lager and Koelsch board.

Both have a runtime dependency on "sh_eth: update OF PHY registeration" and
"phy: micrel: add of configuration for LED mode" (scheduled for merge in v3.15)
to have any effect. Without those dependencies the led-mode property will be
ignored. The patches can thus be merged separately.

Ben, I haven't seen similar patches being posted to the linux-sh mailing list,
but I might have missed them. I apologize if that's the case.

Laurent Pinchart (2):
  ARM: shmobile: lager: Set ethernet PHY LED mode
  ARM: shmobile: koelsch: Set ethernet PHY LED mode

 arch/arm/boot/dts/r8a7790-lager.dts   | 1 +
 arch/arm/boot/dts/r8a7791-koelsch.dts | 1 +
 2 files changed, 2 insertions(+)

-- 
Regards,

Laurent Pinchart

