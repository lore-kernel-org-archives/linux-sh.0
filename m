From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Thu, 13 Nov 2014 07:04:58 +0000
Subject: [PATCH 0/3] sh_eth: Remove redundant alignment adjustment
Message-Id: <1415862301-28032-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

This series is based on net tree.

Mitsuhiro Kimura (3):
  sh_eth: Remove redundant alignment adjustment
  sh_eth: Fix skb alloc size and alignment adjust rule.
  sh_eth: Fix dma mapping issue

 drivers/net/ethernet/renesas/sh_eth.c | 65 +++++++++++++++++++++--------------
 drivers/net/ethernet/renesas/sh_eth.h |  2 ++
 2 files changed, 41 insertions(+), 26 deletions(-)

-- 
1.9.1

