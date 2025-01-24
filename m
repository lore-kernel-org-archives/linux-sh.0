Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A61DB120
	for <linux-sh@vger.kernel.org>; Fri, 24 Jan 2025 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737708785; cv=none; b=LO1ra+foF7Gzr24YVbT/GtFKE4PKh0bx40mwgcewpIjWlqHZoDoomwqzxTVF3nKZYqtDAtapOKda4W7S5O0NtADn1Rt9A/qluAofizyszlp7vZVhxmXvl36+xRVFj1jdpBf40u73unIRXZWHV/OWafMCCguHW/SLz0WYIZVxmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737708785; c=relaxed/simple;
	bh=o0owUnv02fTniOWFOuS6cANeXvxFd0j5zU+9oKCY628=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBRgjlnl9WN/19WpZZKQ4nALHYppnWSV0u4ML1VQQSNp9ZiRHHOczP668e84di5fNB+En+S9N6YNkc9/OWpv9Tc9xKqGw3zw7ti27owFgLZ72Dnltz7DLk8hs2hYZ14Zp+DPYsNCu38c9DCY0I3rPajYdHLSOKuYmCLNyc/mDRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:4563:f165:f885:ebc1])
	by michel.telenet-ops.be with cmsmtp
	id 4wso2E00D5PrELR06wsoP5; Fri, 24 Jan 2025 09:52:54 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tbFQd-0000000EJVr-1iXF;
	Fri, 24 Jan 2025 09:52:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tbFQm-00000003UHU-0FbW;
	Fri, 24 Jan 2025 09:52:48 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: renesas: SND_SIU_MIGOR should depend on DMADEVICES
Date: Fri, 24 Jan 2025 09:52:45 +0100
Message-ID: <8c17ff52584ce824b8b42d08ea1b942ebeb7f4d9.1737708688.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_DMADEVICES=n:

    WARNING: unmet direct dependencies detected for SND_SOC_SH4_SIU
      Depends on [n]: SOUND [=y] && SND [=y] && SND_SOC [=y] && (SUPERH [=y] || ARCH_RENESAS || COMPILE_TEST [=n]) && ARCH_SHMOBILE [=y] && HAVE_CLK [=y] && DMADEVICES [=n]
      Selected by [y]:
      - SND_SIU_MIGOR [=y] && SOUND [=y] && SND [=y] && SND_SOC [=y] && (SUPERH [=y] || ARCH_RENESAS || COMPILE_TEST [=n]) && SH_MIGOR [=y] && I2C [=y]

SND_SIU_MIGOR selects SND_SOC_SH4_SIU.  As the latter depends on
DMADEVICES, the former should depend on DMADEVICES, too.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501241032.oOmsmzvk-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/renesas/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/renesas/Kconfig b/sound/soc/renesas/Kconfig
index 426632996a0a3172..cb01fb36355f02c3 100644
--- a/sound/soc/renesas/Kconfig
+++ b/sound/soc/renesas/Kconfig
@@ -67,7 +67,7 @@ config SND_SH7760_AC97
 
 config SND_SIU_MIGOR
 	tristate "SIU sound support on Migo-R"
-	depends on SH_MIGOR && I2C
+	depends on SH_MIGOR && I2C && DMADEVICES
 	select SND_SOC_SH4_SIU
 	select SND_SOC_WM8978
 	help
-- 
2.43.0

