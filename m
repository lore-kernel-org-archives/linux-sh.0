From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Thu, 13 Nov 2014 07:02:13 +0000
Subject: [PATCH 0/2] Fix sleeping function called from invalid context
Message-Id: <1415862135-27972-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

This series is based on net tree.

Mitsuhiro Kimura (2):
  sh_eth: Fix sleeping function called from invalid context
  sh_eth: Fix asynchronous external abort

 drivers/net/ethernet/renesas/sh_eth.c | 70 ++++++++++++++++++++---------------
 drivers/net/ethernet/renesas/sh_eth.h |  1 +
 2 files changed, 42 insertions(+), 29 deletions(-)

-- 
1.9.1

