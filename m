From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 27 Feb 2010 16:51:36 +0000
Subject: [PATCH 55/66] arch/sh/boot/compressed/cache.c: Checkpatch cleanup
Message-Id: <1267289508-31031-56-git-send-email-andrea.gelmini@gelma.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

arch/sh/boot/compressed/cache.c:8: WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/sh/boot/compressed/cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boot/compressed/cache.c b/arch/sh/boot/compressed/cache.c
index e27fc74..d0b77b6 100644
--- a/arch/sh/boot/compressed/cache.c
+++ b/arch/sh/boot/compressed/cache.c
@@ -5,7 +5,7 @@ int cache_control(unsigned int command)
 
 	for (i = 0; i < (32 * 1024); i += 32) {
 		(void)*p;
-		p += (32 / sizeof (int));
+		p += (32 / sizeof(int));
 	}
 
 	return 0;
-- 
1.7.0.90.g251a4

