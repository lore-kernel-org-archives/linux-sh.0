Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888411CABF;
	Sat, 11 May 2024 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715455050; cv=none; b=CvtPgQBCB64AVI0Ld7/8L+J4RtB3M3NAyOF5YUfUjU2/EMtk20I9rQ7V4qJSSAmB/1wxGxKT2OM2TjUSCFy8oVKd4SIfZt8wIC0+yZytGu9fuhrDzycX5QmyR7+DJf4OT7gJTMIStjME1tdilf/0vAiyo5uK1UeLCwnA7w0+OUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715455050; c=relaxed/simple;
	bh=26xCqLa3bHFY0yayOPph5pktQTDIuMbgEypxVupkULk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsgyYA4ZBTZfEbFOzfgS58odjsCGrIZrsqzFqaIpK2QusFl4dzgBQNQ+1AcbnlxdlyXrpxWaNV9pFKYGJx94C9UyamxuRGqmKFQqhEMcNSCu8beSvkJe+f6iEDvl8j424yj2Q/olAyRano2V3Eqo/E3VwdVJ4/m2tT50Ej/wYFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B588E0006;
	Sat, 11 May 2024 19:17:18 +0000 (UTC)
From: Artur Rojek <contact@artur-rojek.eu>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Paul Cercueil <paul@crapouillou.net>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 1/1] sh: dreamcast: Fix GAPS PCI bridge addressing
Date: Sat, 11 May 2024 21:16:14 +0200
Message-ID: <20240511191614.68561-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240511191614.68561-1-contact@artur-rojek.eu>
References: <20240511191614.68561-1-contact@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: contact@artur-rojek.eu

The G2-to-PCI bridge chip found in SEGA Dreamcast assumes P2 area
relative addresses.

Set the appropriate IOPORT base offset.

Tested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 arch/sh/Kconfig                       | 3 ++-
 arch/sh/boards/mach-dreamcast/setup.c | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 217bdc4d0201..f723e2256c9c 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -126,7 +126,8 @@ config ARCH_HAS_ILOG2_U64
 
 config NO_IOPORT_MAP
 	def_bool !PCI
-	depends on !SH_SHMIN && !SH_HP6XX && !SH_SOLUTION_ENGINE
+	depends on !SH_SHMIN && !SH_HP6XX && !SH_SOLUTION_ENGINE && \
+		   !SH_DREAMCAST
 
 config IO_TRAPPED
 	bool
diff --git a/arch/sh/boards/mach-dreamcast/setup.c b/arch/sh/boards/mach-dreamcast/setup.c
index 2d966c1c2cc1..daa8455549fa 100644
--- a/arch/sh/boards/mach-dreamcast/setup.c
+++ b/arch/sh/boards/mach-dreamcast/setup.c
@@ -25,10 +25,13 @@
 #include <asm/irq.h>
 #include <asm/rtc.h>
 #include <asm/machvec.h>
+#include <cpu/addrspace.h>
 #include <mach/sysasic.h>
 
 static void __init dreamcast_setup(char **cmdline_p)
 {
+	/* GAPS PCI bridge assumes P2 area relative addresses. */
+	__set_io_port_base(P2SEG);
 }
 
 static struct sh_machine_vector mv_dreamcast __initmv = {
-- 
2.45.0

