Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3AF78B7E
	for <linux-sh@vger.kernel.org>; Mon,  4 Mar 2024 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579457; cv=none; b=kqZjBVmNStuMrBZFt0yoVFpxGFT2GQG/+0bCjhAI96jOyCfNg195wEb73K3/cOZLmDl7mXTdr3hrTk03C7UP+kRx5lsmjBtOu/YvTJAh9FtmK7nVgfVHZ28h2mu0mWcaTFgEfxzVhRHNFTlvfbE8YWUxvpg0WEYlLRmUZS7EvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579457; c=relaxed/simple;
	bh=1NU2jdozNlhSkJZyevmnH2H6GJDZ1F/40k7wWV+RudM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHrCmyvfdfnVbKvw+1FkI+Pyyb1hZYLIQbtPttbZfc8QlzcqW+DKuBz5L0OIRtHYV8SP95+c/e1K3W/9m4NeRrC2P4ktJpxHdMsAHCBwUBqM0JwzG2uCP9Oa+GEk+skEfwYrMTRON7ZvrBswWOllXpp1NVG35Ye/+ASoKCeXxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2716:1247:52e8:4f90])
	by laurent.telenet-ops.be with bizsmtp
	id ujAr2B00K2qflky01jArdj; Mon, 04 Mar 2024 20:10:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDhv-002KKB-OM;
	Mon, 04 Mar 2024 20:10:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDi7-00BCct-DV;
	Mon, 04 Mar 2024 20:10:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5/7] sh: sh7757lcr: Make init_sh7757lcr_IRQ() static
Date: Mon,  4 Mar 2024 20:10:47 +0100
Message-Id: <fba00424b5b0bee0f9b9cbc63d649a86854d202f.1709579038.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709579038.git.geert+renesas@glider.be>
References: <cover.1709579038.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/sh/boards/board-sh7757lcr.c:572:13: warning: no previous prototype for 'init_sh7757lcr_IRQ' [-Wmissing-prototypes]

There are no users outside this file, so make it static.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/boards/board-sh7757lcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index 4014c042d2a5a5c2..bca54e489e11678e 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -569,7 +569,7 @@ static int __init sh7757lcr_devices_setup(void)
 arch_initcall(sh7757lcr_devices_setup);
 
 /* Initialize IRQ setting */
-void __init init_sh7757lcr_IRQ(void)
+static void __init init_sh7757lcr_IRQ(void)
 {
 	plat_irq_setup_pins(IRQ_MODE_IRQ7654);
 	plat_irq_setup_pins(IRQ_MODE_IRQ3210);
-- 
2.34.1

