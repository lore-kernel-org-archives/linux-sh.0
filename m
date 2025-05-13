Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C162D7BF
	for <linux-sh@vger.kernel.org>; Tue, 13 May 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121841; cv=none; b=PRs7gc4QUAX4oX/1DtZntoLQScnGZVF9vX7GXOVE/3/FTFUF9uUXOGpeEjCWf6Tm/3pPe1oEwlcV3lGqueAbtXuDIhRKZRuV7/XHGC+YUawuwlTw+1UrROlSsPzWAXvezypx0Nsy4wmcBBc+qixKOLaRfiXxR+e4wgsn3q+PjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121841; c=relaxed/simple;
	bh=sG196z0t+5EOJzX1/7CgQIWKhCvV/Tag+seHV+RghWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OI3ohg44zn29FlaW1/RP+Uh/BIm7aaUx67t4VDqsGb2ilFnm1eXZHPcjQmq466VvM3uVPB7UnTwLWEe+DKn8QMLWg9iCuxrGrip/ONKTaM5z9XGZ9TYs+Tzl/QDvEk+moEfCv/xuDda2LKFvDREtc8uH6T0QV7XQcng2t2HtFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4ZxSnt5bYTz4x210
	for <linux-sh@vger.kernel.org>; Tue, 13 May 2025 09:31:14 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:e731:371c:7707:a2ae])
	by andre.telenet-ops.be with cmsmtp
	id oXX52E00F4HZolA01XX57H; Tue, 13 May 2025 09:31:06 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uEk6I-00000001Vcc-2luw;
	Tue, 13 May 2025 09:31:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uEk6T-00000000A7n-1bem;
	Tue, 13 May 2025 09:31:05 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	Rich Felker <dalias@libc.org>
Cc: linux-sound@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] ALSA: sh: SND_AICA should depend on SH_DMA_API
Date: Tue, 13 May 2025 09:31:04 +0200
Message-ID: <b90625f8a9078d0d304bafe862cbe3a3fab40082.1747121335.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_SH_DMA_API=n:

    WARNING: unmet direct dependencies detected for G2_DMA
      Depends on [n]: SH_DREAMCAST [=y] && SH_DMA_API [=n]
      Selected by [y]:
      - SND_AICA [=y] && SOUND [=y] && SND [=y] && SND_SUPERH [=y] && SH_DREAMCAST [=y]

SND_AICA selects G2_DMA.  As the latter depends on SH_DMA_API, the
former should depend on SH_DMA_API, too.

Fixes: f477a538c14d07f8 ("sh: dma: fix kconfig dependency for G2_DMA")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505131320.PzgTtl9H-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/sh/Kconfig b/sound/sh/Kconfig
index b75fbb3236a7b945..f5fa09d740b4c954 100644
--- a/sound/sh/Kconfig
+++ b/sound/sh/Kconfig
@@ -14,7 +14,7 @@ if SND_SUPERH
 
 config SND_AICA
 	tristate "Dreamcast Yamaha AICA sound"
-	depends on SH_DREAMCAST
+	depends on SH_DREAMCAST && SH_DMA_API
 	select SND_PCM
 	select G2_DMA
 	help
-- 
2.43.0

