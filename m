From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 20 Jun 2015 18:48:22 +0000
Subject: [PATCH 0/2] generic timeout handling for Renesas drivers
Message-Id: <1434826104-16346-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Here is a small patch series to make I2C timeout handling easier for users. It
is not so amazingly huge anymore and it can be modified via i2c-dev if wanted.

Wolfram Sang (2):
  i2c: rcar: use adapter default for timeout
  i2c: sh_mobile: use adapter default for timeout

 drivers/i2c/busses/i2c-rcar.c      | 2 +-
 drivers/i2c/busses/i2c-sh_mobile.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
