Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF947AE70
	for <linux-sh@vger.kernel.org>; Mon,  4 Mar 2024 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579462; cv=none; b=STI8e1YQWFMMUMzE9h5MfjaWWP0JWBcs88QAYCeNbOcFc+PLoAIo0IxoFFpZmcLo+FPiGE09L2CBerqomWic1mDbx6aSC3/P21ol5oAed7oWVsxLSEMR6Nu6jmDVhhLcXU58h7U5L99y6FPI9MsnCGRD+vdSOb+3rXx5xnOEXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579462; c=relaxed/simple;
	bh=E+qJDFY6zi9Nz5E3gi8d133G0ewbF7dK4ZuSWuhwbU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RA6tRZN6ZxpEAr6TH1laHvmWPbmjabe/wXo3h3bjHN/70NtXNFqxEN0G0w0EbZDRjoZzg1Rcz131BcNmJrQgDLeSadqNOYyJ3Cy7zc4lvBuHYWcq0zhKV6v/Rh8H9xYkvs88LydWzeIWNCj6P/wtvS0arVAHY16xCtc4sZDZ+HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2716:1247:52e8:4f90])
	by andre.telenet-ops.be with bizsmtp
	id ujAr2B00F2qflky01jArLi; Mon, 04 Mar 2024 20:10:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDhv-002KKF-PG;
	Mon, 04 Mar 2024 20:10:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDi7-00BCcx-EG;
	Mon, 04 Mar 2024 20:10:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6/7] sh: sh7757: Add missing #include <asm/mmzone.h>
Date: Mon,  4 Mar 2024 20:10:48 +0100
Message-Id: <c9c26472151d16a2ca91f14bccd64af07a6abdd8.1709579038.git.geert+renesas@glider.be>
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

arch/sh/kernel/cpu/sh4a/setup-sh7757.c:1240:13: warning: no previous prototype for ‘plat_mem_setup’ [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 67e330b7ea4621e9..2ad19a0c5e04ef2a 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -17,8 +17,11 @@
 #include <linux/sh_dma.h>
 #include <linux/sh_intc.h>
 #include <linux/usb/ohci_pdriver.h>
+
 #include <cpu/dma-register.h>
 #include <cpu/sh7757.h>
+
+#include <asm/mmzone.h>
 #include <asm/platform_early.h>
 
 static struct plat_sci_port scif2_platform_data = {
-- 
2.34.1

