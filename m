From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 14 May 2015 12:40:01 +0000
Subject: [PATCH 0/4] i2c: small updates to the slave framework
Message-Id: <1431607205-2316-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Before nailing down the DT representation problem, here are some smaller
updates for the slave framework I have lying around.

Wolfram Sang (4):
  i2c: add FUNC flag for slave capabilities
  i2c: rcar: report slave capabilities to users
  i2c: slave: docs: be more precise about the prerequsites
  i2c: slave: add error messages to slave core

 Documentation/i2c/slave-interface | 25 +++++++++++++++----------
 drivers/i2c/busses/i2c-rcar.c     |  3 ++-
 drivers/i2c/i2c-core.c            | 22 +++++++++++++++++-----
 include/uapi/linux/i2c.h          |  1 +
 4 files changed, 35 insertions(+), 16 deletions(-)

-- 
2.1.4

