From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 06 Jan 2015 10:02:06 +0000
Subject: [PATCH 0/2] thermal: rcar: minor fixes
Message-Id: <1420538528-5236-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch series is based on linux-soc-thermal.git / fixes branch.
(commit id = 5a723e81923410f0d3ae4c38974607b13befdda9)

Yoshihiro Shimoda (2):
  thermal: rcar: fix ENR register value
  thermal: rcar: change type of ctemp in rcar_thermal_update_temp()

 drivers/thermal/rcar_thermal.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.9.5

