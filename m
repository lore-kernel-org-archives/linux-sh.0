From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 23 Jul 2013 01:18:03 +0000
Subject: [PATCH 0/2 v4 net-next repost] sh_eth: Add support for r8a7790 SoC
Message-Id: <1374542285-19602-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms+renesas@verge.net.au>

[ Repost with v4 and net-next tags in subject ]

Hi,

this short series enhances the sh_eth driver for use with the r8a7790 SoC.

Changes since v3:

* Removed "sh_eth: add support for gpio reset" as it appears unnecessary
  and I am not entirely confident is is correct.
* Updated "sh_eth: Add support for r8a7790 SoC" to
  refer to R8A777x intead of R8A7779.

Simon Horman (2):
  sh_eth: add support for RMIIMODE register
  sh_eth: Add support for r8a7790 SoC

 drivers/net/ethernet/renesas/Kconfig  |  2 +-
 drivers/net/ethernet/renesas/sh_eth.c | 25 +++++++++++++++++++++++++
 drivers/net/ethernet/renesas/sh_eth.h |  2 ++
 3 files changed, 28 insertions(+), 1 deletion(-)

-- 
1.8.2.1

