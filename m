Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6DD158A0B
	for <linux-sh@vger.kernel.org>; Wed, 24 Apr 2024 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959697; cv=none; b=iOims0CZhjXiGCzt/coH8OHc68CEmUFz70juB//REO9n6F60VDkl1rFIxb6Toz4Rq3qy25X3WkiyI2U7Q+WQ3cRIyk1TFYTx893LoFIHED2Uhif740qEZBu2UTVcgHYAMWi6jC9dGAf1k3A8Q1xz8x33J3d/3yHAYny4ZUQ3D90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959697; c=relaxed/simple;
	bh=lHtB8RAP6CSWSjASPOYaKZEbrYyViaYz+U/1gb8ZgG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ndGzgPaxbV1NhBRVlLnXTrJ46T4VdMfCcvvbYJvV3jOASDK2oEHGl6bt4Fb97Ctlyj/Qghb5nmPjwtRWGmAD7m3UezW3FdUkxjg7mfTiQ7ZZDFDllQG/a1mA6dCC5Sqo0xiAmW2QHIvdb68SBtDV68hBPRSavGeG1Ks/oqmJSIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by laurent.telenet-ops.be with bizsmtp
	id Ezur2C0030SSLxL01zurM9; Wed, 24 Apr 2024 13:54:52 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rzbCU-006HeI-TM;
	Wed, 24 Apr 2024 13:54:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rzbD8-00BIyU-WC;
	Wed, 24 Apr 2024 13:54:51 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sh: boot: Remove sh5 cache handling
Date: Wed, 24 Apr 2024 13:54:31 +0200
Message-Id: <23e9b3fd0d78e46c9fc1835852ba226aba92c3ca.1713959531.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 37744feebc086908 ("sh: remove sh5 support") in v5.8 forgot to
remove the sh5 cache handling.

Suggested-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/boot/compressed/Makefile |  2 +-
 arch/sh/boot/compressed/cache.c  | 13 -------------
 arch/sh/boot/compressed/misc.c   |  7 -------
 3 files changed, 1 insertion(+), 21 deletions(-)
 delete mode 100644 arch/sh/boot/compressed/cache.c

diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index 6c6c791a1d0630e2..54efed53c8918eef 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -5,7 +5,7 @@
 # create a compressed vmlinux image from the original vmlinux
 #
 
-OBJECTS := head_32.o misc.o cache.o piggy.o \
+OBJECTS := head_32.o misc.o piggy.o \
            ashiftrt.o ashldi3.o ashrsi3.o ashlsi3.o lshrsi3.o
 
 targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 \
diff --git a/arch/sh/boot/compressed/cache.c b/arch/sh/boot/compressed/cache.c
deleted file mode 100644
index 31e04ff4841ed084..0000000000000000
--- a/arch/sh/boot/compressed/cache.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-int cache_control(unsigned int command)
-{
-	volatile unsigned int *p = (volatile unsigned int *) 0x80000000;
-	int i;
-
-	for (i = 0; i < (32 * 1024); i += 32) {
-		(void)*p;
-		p += (32 / sizeof(int));
-	}
-
-	return 0;
-}
diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index ca05c99a3d5b488d..195367d40031f9e9 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -26,11 +26,6 @@
 #undef memcpy
 #define memzero(s, n)     memset ((s), 0, (n))
 
-/* cache.c */
-#define CACHE_ENABLE      0
-#define CACHE_DISABLE     1
-int cache_control(unsigned int command);
-
 extern char input_data[];
 extern int input_len;
 static unsigned char *output;
@@ -139,8 +134,6 @@ void decompress_kernel(void)
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
 	puts("Uncompressing Linux... ");
-	cache_control(CACHE_ENABLE);
 	__decompress(input_data, input_len, NULL, NULL, output, 0, NULL, error);
-	cache_control(CACHE_DISABLE);
 	puts("Ok, booting the kernel.\n");
 }
-- 
2.34.1

