From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 14 May 2013 02:37:50 +0000
Subject: [RFC PATCH net-next v2 0/3] sh_eth: add support for r8a7790 SoC
Message-Id: <1368499073-21975-1-git-send-email-horms+renesas@verge.net.au>
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
  sh_eth: add support for r8a7790 SoC

 drivers/net/ethernet/renesas/Kconfig  |  2 +-
 drivers/net/ethernet/renesas/sh_eth.c | 14 ++++++++++++--
 drivers/net/ethernet/renesas/sh_eth.h |  2 ++
 include/linux/sh_eth.h                |  3 +++
 4 files changed, 18 insertions(+), 3 deletions(-)

-- 
1.8.2.1

