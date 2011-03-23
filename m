From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 23 Mar 2011 13:43:31 +0000
Subject: [PATCH 6/6] mfd: remove now redundant sh_mobile_sdhi.h header
Message-Id: <Pine.LNX.4.64.1103231437140.6836@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103231156220.6836@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1103231156220.6836@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 
No change, here for completeness
 
 include/linux/mfd/sh_mobile_sdhi.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)
 delete mode 100644 include/linux/mfd/sh_mobile_sdhi.h

diff --git a/include/linux/mfd/sh_mobile_sdhi.h b/include/linux/mfd/sh_mobile_sdhi.h
deleted file mode 100644
index 10af7f9..0000000
--- a/include/linux/mfd/sh_mobile_sdhi.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef MFD_SH_MOBILE_SDHI_H
-#define MFD_SH_MOBILE_SDHI_H
-
-/* Compatibility header - will disappear once all platforms are converted */
-#include <linux/mmc/sh_mobile_sdhi.h>
-
-#endif /* MFD_SH_MOBILE_SDHI_H */
-- 
1.7.2.5

