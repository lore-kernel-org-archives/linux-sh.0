Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DDF7AE75
	for <linux-sh@vger.kernel.org>; Mon,  4 Mar 2024 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579461; cv=none; b=UnqgUYWn+DEWrpSayF+XUvbcUhj2nokenOR1LeD7qtaXGrhm5Hz8BfwXiXMemW42qnW2Cu4AzRuBwpjDH4MWyqptk+whHTTPM1sjvByj8TIeSiVjWVHKHTHV0O6nP2XBGEfF/Jvq7zxgq03LApVjmdeCGn7v9nrD0jQT4i3Kayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579461; c=relaxed/simple;
	bh=UgXL7h1cn275yguuSgiJgSKSKNaSdhoQTwdlVguxmNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOd/bKJ8y6CNIgSvuNj7a7XQsbxppk/KD72j2YD0VqUNxGFGHsK93b6Al8O0TcUTbTsuDa2ipPT6ZTIN2ss1yJzW3ri5j0ZSK1JeAm+r23u9pk8vJiXGSUMYGiPcIldv7SkE1R+kx1R/tP+gLWSZLUjvEjUG55H/JWUD20wt3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2716:1247:52e8:4f90])
	by andre.telenet-ops.be with bizsmtp
	id ujAr2B00H2qflky01jArLk; Mon, 04 Mar 2024 20:10:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDhv-002KKH-Q5;
	Mon, 04 Mar 2024 20:10:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDi7-00BCd4-Fv;
	Mon, 04 Mar 2024 20:10:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 7/7] sh: sh7785lcr: Make init_sh7785lcr_IRQ() static
Date: Mon,  4 Mar 2024 20:10:49 +0100
Message-Id: <cbe9da98a1106cdab686766e2f23f768399dbdbf.1709579038.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709579038.git.geert+renesas@glider.be>
References: <cover.1709579038.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

arch/sh/boards/board-sh7785lcr.c:298:13: warning: no previous prototype for ‘init_sh7785lcr_IRQ’ [-Wmissing-prototypes]

There are no users outside this file, so make it static.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/boards/board-sh7785lcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
index 77dad1e511b4652b..25c4968f0d8b0e7d 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -295,7 +295,7 @@ static int __init sh7785lcr_devices_setup(void)
 device_initcall(sh7785lcr_devices_setup);
 
 /* Initialize IRQ setting */
-void __init init_sh7785lcr_IRQ(void)
+static void __init init_sh7785lcr_IRQ(void)
 {
 	plat_irq_setup_pins(IRQ_MODE_IRQ7654);
 	plat_irq_setup_pins(IRQ_MODE_IRQ3210);
-- 
2.34.1

