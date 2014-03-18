From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 18 Mar 2014 23:25:51 +0000
Subject: [PATCH/RFC 0/5] Fix the sh_eth race between open and MDIO bus registration
Message-Id: <1395185156-6681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch series attempts to fix the race condition that exists in the sh_eth
driver between network device open and MDIO bus registration. The actual fix
is in patch 4/5, with previous patches preparing the driver and patch 5/5
cleaning up an unrelated issue.

I've based the idea on Sergei's attempt to fix the problem and can successfully
boot the Koelsch board over NFS with this series. I might have missed other
issues though, hence the RFC status.

The patches are based on top of Simon's latest devel branch plus the following
two patches

	sh_eth: add device tree support
	sh_eth: update OF PHY registeration

Sergei, assuming this series gets accepted, should I send it to the netdev
mailing list or would you like to take it in your tree to avoid conflicts ?

Laurent Pinchart (5):
  sh_eth: Use the platform device for memory allocation
  sh_eth: Use the platform device as the MDIO bus parent
  sh_eth: Simplify MDIO bus initialization and release
  sh_eth: Register MDIO bus before registering the network device
  sh_eth: Remove goto statements that jump straight to a return

 drivers/net/ethernet/renesas/sh_eth.c | 82 +++++++++++++----------------------
 1 file changed, 29 insertions(+), 53 deletions(-)

-- 
Regards,

Laurent Pinchart

