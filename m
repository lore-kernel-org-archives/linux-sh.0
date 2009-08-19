From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 19 Aug 2009 00:12:15 +0000
Subject: [PATCH] sh: USB0 resource area fix for ms7724se
Message-Id: <uvdkk64rk.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
Magnus

in 15 Apr 2009, "Re: [PATCH 3/6] Add USB support for SH7724"
you taught me about USB area miss. (do you remember ?)
I think this is just your mistake. or is there any reason ?

 arch/sh/boards/mach-se/7724/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 9162081..c04e134 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -319,7 +319,7 @@ static struct r8a66597_platdata sh7724_usb0_host_data = {
 static struct resource sh7724_usb0_host_resources[] = {
 	[0] = {
 		.start	= 0xa4d80000,
-		.end	= 0xa4d800ff,
+		.end	= 0xa4d80124 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-- 
1.6.0.4

