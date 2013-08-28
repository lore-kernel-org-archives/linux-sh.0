From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 28 Aug 2013 00:43:07 +0000
Subject: [PATCH net-next 0/2] sh_eth Updates
Message-Id: <1377650589-20960-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kouei Abe <kouei.abe.cp@renesas.com>, Simon Horman <horms+renesas@verge.net.au>

Hi,

please consider the following updates to the sh_eth driver
by Abe-san. They were developed during his testing of the
driver on the r8a7790/lager board.

Kouei Abe (2):
  sh_eth: Fix cache invalidation omission of receive buffer
  sh_eth: Enable Rx descriptor word 0 shift for r8a7790

 drivers/net/ethernet/renesas/sh_eth.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
1.8.3.2

