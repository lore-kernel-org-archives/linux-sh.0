From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 10 Dec 2014 13:21:47 +0000
Subject: [RFC 0/2] i2c: sh_mobile: don't regress on deferred probing
Message-Id: <1418217709-26392-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>

Okay, here is my take on solving the problem found by Geert. I still don't like
it much but it is not as bad as I expected it to be ;) Let me know what you
think.

Thanks,

   Wolfram


Wolfram Sang (2):
  i2c: sh_mobile: refactor DMA setup
  i2c: sh_mobile: rework deferred probing

 drivers/i2c/busses/i2c-sh_mobile.c | 111 ++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 58 deletions(-)

-- 
2.1.3

