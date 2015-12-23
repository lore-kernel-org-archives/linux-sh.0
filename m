From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 23 Dec 2015 17:19:27 +0000
Subject: [PATCH 0/2] i2c: proper RuntimePM for the adapter device
Message-Id: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

RuntimePM for the logical adapter device should be handled in a central place
by the core, and not by drivers. This series does exactly that.

This is the first step of harmonizing RuntimePM handling in I2C.


Wolfram Sang (2):
  i2c: always enable RuntimePM for the adapter device
  i2c: s3c2410: remove superfluous runtime PM calls

 drivers/i2c/busses/i2c-s3c2410.c | 6 ------
 drivers/i2c/i2c-core.c           | 3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.1.4

