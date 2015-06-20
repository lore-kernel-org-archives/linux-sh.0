From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 20 Jun 2015 19:03:18 +0000
Subject: [PATCH 0/4] generic timeout handling for Renesas drivers
Message-Id: <1434827002-25918-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>

Here is a small patch series to make I2C timeout handling easier for users. It
is not so amazingly huge anymore and it can be modified via i2c-dev if wanted.
While at it, fix the type of the timeout variable to the proper one.
This time build-tested twice!

Wolfram Sang (4):
  i2c: rcar: use adapter default for timeout
  i2c: rcar: use proper type for timeout
  i2c: sh_mobile: use adapter default for timeout
  i2c: sh_mobile: use proper type for timeout

 drivers/i2c/busses/i2c-rcar.c      | 5 +++--
 drivers/i2c/busses/i2c-sh_mobile.c | 9 +++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
