From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 10 Jun 2014 00:40:04 +0000
Subject: [PATCH v2 0/2] net: sh_eth: Fix two issues in sh_eth_rx()
Message-Id: <539653E4.9080808@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

I used the latest net.git repository.
 commit id = 87757a917b0b3c0787e0563c679762152be81312
 (net: force a list_del() in unregister_netdevice_many())

I tested these patches on r8a7790.

Changes from v1:
 - Remove unnecessary parens in patch 1.

Yoshihiro Shimoda (2):
  net: sh_eth: Fix receive packet "exceeded" condition in sh_eth_rx()
  net: sh_eth: Fix timing of RACT setting in sh_eth_rx()

 drivers/net/ethernet/renesas/sh_eth.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
1.7.9.5

