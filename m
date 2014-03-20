From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 20 Mar 2014 13:58:53 +0000
Subject: [PATCH 0/5] sh_eth: Fix the race between open and MDIO bus registration
Message-Id: <1395324035-22918-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Ben Dooks <ben.dooks@codethink.co.uk>

Hello,

This patch series fixes the race condition that exists in the sh_eth driver
between network device open and MDIO bus registration. The actual fix is in
patch 4/5, with previous patches preparing the driver and patch 5/5 cleaning
up an unrelated issue.

I've based the idea on Sergei's attempt to fix the problem and can successfully
boot the Koelsch board over NFS with this series. I might have missed other
issues though, hence the RFC status.

The patches are based on top of the latest net-next master branch.

Laurent Pinchart (5):
  sh_eth: Use the platform device for memory allocation
  sh_eth: Use the platform device as the MDIO bus parent
  sh_eth: Simplify MDIO bus initialization and release
  sh_eth: Register MDIO bus before registering the network device
  sh_eth: Remove goto statements that jump straight to a return

 drivers/net/ethernet/renesas/sh_eth.c | 85 +++++++++++++----------------------
 1 file changed, 31 insertions(+), 54 deletions(-)

-- 
Regards,

Laurent Pinchart

