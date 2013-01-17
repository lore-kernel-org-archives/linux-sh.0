From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 17 Jan 2013 09:45:53 +0000
Subject: [PATCH 0/4] i2c: sh_mobile: fix STOP condition generation
Message-Id: <1358415957-8371-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

Currently the i2c-sh_mobile.c driver generates STOP conditions after each 
message. This makes any multi-message transfers, e.g. reading, impossible 
with the AS3711 PMIC on kzm9g. This patch series fixes this by only 
generating the STOP condition after the last message or if the I2C_M_STOP 
flag is set.

Guennadi Liakhovetski (4):
  i2c: i2c-sh_mobile.c: cosmetic: trivially simplify 2 functions
  i2c: sh_mobile: fix timeout error handling
  i2c: sh_mobile: eliminate an open-coded "goto" loop
  i2c: sh_mobile: don't send a stop condition by default inside
    transfers

 drivers/i2c/busses/i2c-sh_mobile.c |  152 +++++++++++++++++++++++-------------
 1 files changed, 98 insertions(+), 54 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
