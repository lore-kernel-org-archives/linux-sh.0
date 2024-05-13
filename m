Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85027152182
	for <linux-sh@vger.kernel.org>; Mon, 13 May 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606464; cv=none; b=Ypp7Fg7/lIK7/j8fBBT4B1rBnHNzg9BBMGZfFscC6i/lNpb+8mkSPHJO35HvMXReiQxHVkaPbnlOyKyxzWyTkTnzP57uy9SKJROg4IYRwdm9Nqn9bU8ACVRmPb4SmqY9izi0AonIC34Nu9mbjQ9EiuHEgOxSzerA1h3T+QsypAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606464; c=relaxed/simple;
	bh=t+9d5z/RIWVL4mfXlBPmUVnjbCVQGratb2WunXgnKGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pwMHpqHSh1F6tkAhuoDlDcGaAJh0uIsQZnp4w9/Bt2A6sKIFambc7BYI3ds4f1YIM3yZo0CL5YBR3yV8a0FRoCY5Ad6H1hOq9GG8P5PF5HjSu9xzrPK0QZA1nNApe3yDm17KOAuVvb2n+d67xrfENw5TAQgE1c9jP0CF2JLaryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c85e:4b6d:1f91:1410])
	by laurent.telenet-ops.be with bizsmtp
	id NdM02C0075V4kqY01dM0ZE; Mon, 13 May 2024 15:21:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6Vb7-00399r-Si;
	Mon, 13 May 2024 15:21:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6Vbw-008tqZ-1D;
	Mon, 13 May 2024 15:21:00 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] sh: setup: Add missing forward declaration for sh_fdt_init()
Date: Mon, 13 May 2024 15:20:55 +0200
Message-Id: <7e3ea09e706a075bceb6bfd172990676e79be1c2.1715606232.git.geert+renesas@glider.be>
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

arch/sh/kernel/setup.c:244:12: warning: no previous prototype for 'sh_fdt_init' [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/include/asm/setup.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
index fc807011187fa1c0..84bb23a771f3538b 100644
--- a/arch/sh/include/asm/setup.h
+++ b/arch/sh/include/asm/setup.h
@@ -21,5 +21,6 @@
 void sh_mv_setup(void);
 void check_for_initrd(void);
 void per_cpu_trap_init(void);
+void sh_fdt_init(phys_addr_t dt_phys);
 
 #endif /* _SH_SETUP_H */
-- 
2.34.1

