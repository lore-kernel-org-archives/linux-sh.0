Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F4F1514E5
	for <linux-sh@vger.kernel.org>; Mon, 13 May 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606466; cv=none; b=SNxydYrEtJAFzTMzdf2RXV1PrgwoM6rwk5tv+AqINqFaSFEAV4uoWbFG3ddVoi5lQb1gSRzuVufNAOgEoAWkLUB18WqPh0laUQKVWZvQkqvuCCy+kGt+ei88JFZanNEnfSBI5Y3PxUJ4vq9I35OJb/ocIv/HOEIUkVN5thWt6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606466; c=relaxed/simple;
	bh=RJCXdkLFskpSIxdK08El8C87yvPHTIuYVmWle4eyCy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGCr6c4aSM/wxfxZGrUROqvLnl70JjQADDD1uHSVDW5xyYjl4Qhd3bsjEmxAuWF+3OGjRfBzYk0nOm/rJdY3NuBliuyPAIL3wpl+A0TG6vPu3YoRQIDSTEl2tOb4O4UwLKsFoqJIenQdJzHShvv87UOidFc9nQTUdvxh/FmgZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c85e:4b6d:1f91:1410])
	by laurent.telenet-ops.be with bizsmtp
	id NdM02C0055V4kqY01dM0ZC; Mon, 13 May 2024 15:21:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6Vb7-00399i-RK;
	Mon, 13 May 2024 15:21:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6Vbv-008tqR-VC;
	Mon, 13 May 2024 15:20:59 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] sh: of-generic: Add missing #include <asm/clock.h>
Date: Mon, 13 May 2024 15:20:53 +0200
Message-Id: <942621553ed82e3331e2e91485b643892d2d08bc.1715606232.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715606232.git.geert+renesas@glider.be>
References: <cover.1715606232.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/sh/boards/of-generic.c:146:20: warning: no previous prototype for 'arch_init_clk_ops' [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/boards/of-generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index f7f3e618e85b6a52..cc88cb8908cc1d2e 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -10,6 +10,8 @@
 #include <linux/of_fdt.h>
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
+
+#include <asm/clock.h>
 #include <asm/machvec.h>
 #include <asm/rtc.h>
 
-- 
2.34.1

