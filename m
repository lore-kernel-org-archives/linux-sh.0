From: Borislav Petkov <bp@alien8.de>
Date: Wed, 30 Mar 2016 11:42:46 +0000
Subject: [PATCH 3/5] sh/defconfigs: Remove CONFIG_IPV6_PRIVACY
Message-Id: <1459338168-29334-4-git-send-email-bp@alien8.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1459338168-29334-1-git-send-email-bp@alien8.de>
In-Reply-To: <1459338168-29334-1-git-send-email-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-sh@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Option is long gone, see

  5d9efa7ee99e ("ipv6: Remove privacy config option.")

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/configs/titan_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index a77b778c745b..886bc28fa487 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -52,7 +52,6 @@ CONFIG_INET_IPCOMP=y
 # CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=m
 CONFIG_IPV6=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_INET6_AH=y
 CONFIG_INET6_ESP=y
 CONFIG_INET6_IPCOMP=y
-- 
2.7.3

