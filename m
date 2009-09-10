From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 10 Sep 2009 01:40:02 +0000
Subject: [PATCH 5/6] sh: USB disable process is needed if romImage boot for
Message-Id: <umy53y3v1.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

when you use romImage on EcoVec24, 1st Linux will enable USB device.
But no-one disable it.
So re-started Linux will get interrupt before USB driver is attached.
This patch disable USB device at first

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 .../mach-ecovec24/mach/partner-jet-setup.txt       |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt b/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
index ae805ba..8b8e4fa 100644
--- a/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
+++ b/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
@@ -77,3 +77,6 @@ WAIT 1
 
 LIST "setup cache"
 ED 0xff00001c, 0x0000090b
+
+LIST "disable USB"
+EW 0xA4D80000, 0x0000
-- 
1.6.0.4

