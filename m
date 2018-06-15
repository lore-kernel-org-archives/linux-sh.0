From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Fri, 15 Jun 2018 15:49:24 +0000
Subject: [PATCH] arch/sh: kernel: use KERN_CONT in dump_mem()
Message-Id: <20180615154924.7942-1-thomas.petazzoni@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180615154917.7888-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180615154917.7888-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The dump_mem() function prints the contents of various areas of
memory, for example the Stack when a crash occurs. It uses multiple
printk() calls to create a single line, but due to the lack of
KERN_CONT, those multiple printk() calls end up on separate lines,
causing a ridiculous output:

Stack: (0x97e45d74 to 0x97e46000)
5d60:

88316514
97e45d84
88002ec4

5d80:
00000000
88010f4c
97e45da4
97c5e35c
97e6a3e0
00000001
97e45df4
29ee9000

By fixing this, the output becomes a lot more useful:

Stack: (0x96d1dd94 to 0x96d1e000)
dd80:                                              883163f4 96d1dda4 88002ec4
dda0: 00000000 88010eee 96d1ddc4 97cd23dc 295ab020 00000001 96d1ddf4 00000001
ddc0: 29ee9000 8806f23a 96d1dddc 880558cc 8805588c 88010ed0 29ee9000 88071eb8
dde0: 97cda080 00000000 96d1de24 00000001 00000001 8800ff34 8806f8ac 96d1de18
de00: 97cd23dc 295ab020 00000000 00000001 ffffffff 29ee9518 8800ec50 00000001
de20: 96d1de1c 00000000 00000000 00000518 88070eae 96d1de50 97cd23dc 295ab020
de40: 00000000 00000001 00000000 29ee9518 97ef4008 97cda0b8 97cda080 29ee3fff

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/sh/kernel/dumpstack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index b564b1eae4ae..e47635f602df 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -33,16 +33,16 @@ void dump_mem(const char *str, unsigned long bottom, unsigned long top)
 			unsigned int val;
 
 			if (p < bottom || p >= top)
-				printk("         ");
+				printk(KERN_CONT "         ");
 			else {
 				if (__get_user(val, (unsigned int __user *)p)) {
-					printk("\n");
+					printk(KERN_CONT "\n");
 					return;
 				}
-				printk("%08x ", val);
+				printk(KERN_CONT "%08x ", val);
 			}
 		}
-		printk("\n");
+		printk(KERN_CONT "\n");
 	}
 }
 
-- 
2.14.4

