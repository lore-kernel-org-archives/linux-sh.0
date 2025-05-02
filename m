Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D1230D1E
	for <linux-sh@vger.kernel.org>; Fri,  2 May 2025 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746184421; cv=none; b=ietPeOdHUl5yV+5dEQazn/o5PBRW00yWfF2Nh2lsM0RRekkv6qG65BHXtGjY2uVtY9g2PJ1XZS0DcwktwziwPYvPqIKqC6k/jUEapIfTJyV93IUQGc1cQZ+BGMTZX7KsOvbM3TNOHf9gs+pPee7GwxfsO2LNOIlC88HFNgbmrYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746184421; c=relaxed/simple;
	bh=tjBCAb/DLkfP5OBG9sx5z+XWVL2yHRxWf7h1YKj3rOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzosAYru2JZy73RGNYPgJNTE3PDhqjWP2wTqI/MNMOBmMtnZY4nEKakf6PHFtNJ6cepLwJ2HcO1CqQ4Q40cnVb+6sd4ZL30mBhTOxMZr35DJI9Ac6F5P5G44pBDp4AP1W/RQN0rIOXz6nX6PTryJZxZPPu6btuO20ow5Otl1Ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by andre.telenet-ops.be with cmsmtp
	id kBDd2E00D4sst1101BDd7C; Fri, 02 May 2025 13:13:38 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAoKi-00000000WaV-3lh9;
	Fri, 02 May 2025 13:13:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAoKn-00000008p5y-1DQS;
	Fri, 02 May 2025 13:13:37 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sh: ecovec24: Make SPI mode explicit
Date: Fri,  2 May 2025 13:13:36 +0200
Message-ID: <430f42c458dc8e514ae678099b298cd41a050fb9.1746184374.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cf9e4784f3bde3e4 ("spi: sh-msiof: Add slave mode support") added
a new mode member to the sh_msiof_spi_info structure, but did not update
any board files.  Hence all users in board files rely on the default
being host mode.

Make this unambiguous by configuring host mode explicitly.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/boards/mach-ecovec24/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 6f13557eecd6bb21..a641e26f8fdf7369 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -825,6 +825,7 @@ static struct spi_board_info spi_bus[] = {
 /* MSIOF0 */
 static struct sh_msiof_spi_info msiof0_data = {
 	.num_chipselect = 1,
+	.mode = MSIOF_SPI_HOST,
 };
 
 static struct resource msiof0_resources[] = {
-- 
2.43.0

