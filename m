From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 12 Mar 2015 12:42:00 +0000
Subject: [PATCH 0/3] i2c: slave: API updates
Message-Id: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Andrey Danin <danindrey-JGs/UdohzUI@public.gmane.org>, Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>, Debora Grosse <debora-HRUOeNTICTI@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

So, after some more thoughts and people using the slave framewoek, I finally
decided some API seem in place. Please read the patch description for details.
Thanks to all people joining the discussion! Also, finally, the documentation
is here.

Please let me know what you think!

Thanks,

   Wolfram


Wolfram Sang (3):
  i2c: slave: rework the slave API
  Documentation: i2c: describe the new slave mode
  i2c: slave: add documentation for i2c-slave-eeprom

 Documentation/i2c/slave-eeprom-backend |  14 +++
 Documentation/i2c/slave-interface      | 178 +++++++++++++++++++++++++++++++++
 Documentation/i2c/summary              |   4 -
 drivers/i2c/busses/i2c-rcar.c          |  10 +-
 drivers/i2c/i2c-slave-eeprom.c         |  12 +--
 include/linux/i2c.h                    |   8 +-
 6 files changed, 206 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/i2c/slave-eeprom-backend
 create mode 100644 Documentation/i2c/slave-interface

-- 
2.1.4

