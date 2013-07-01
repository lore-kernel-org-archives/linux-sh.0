From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 01 Jul 2013 04:24:52 +0000
Subject: [PATCH net-next v3 0/3] sh_eth: Add support for r8a7790 SoC
Message-Id: <1372652695-16606-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms+renesas@verge.net.au>

Hi,

this short series enhances the sh_eth driver for use with the r8a7790 SoC.

Simon Horman (3):
  sh_eth: add support for gpio reset
  sh_eth: add support RMIIMODE register
  sh_eth: Add support for r8a7790 SoC

 drivers/net/ethernet/renesas/Kconfig  |  2 +-
 drivers/net/ethernet/renesas/sh_eth.c | 29 +++++++++++++++++++++++++++++
 drivers/net/ethernet/renesas/sh_eth.h |  2 ++
 include/linux/sh_eth.h                |  3 +++
 4 files changed, 35 insertions(+), 1 deletion(-)

-- 
1.8.2.1

