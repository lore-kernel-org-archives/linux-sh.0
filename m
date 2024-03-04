Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3997978B76
	for <linux-sh@vger.kernel.org>; Mon,  4 Mar 2024 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579456; cv=none; b=g8oEV62EbrIxkqiotXhCwNqLIlxcwyYZHo8iABkHK22O7O1npDlZ9jFyZDYeA8hrbXUm+AqUsMW6IPhzIeWIlxlEvcyYWVEGAXtKlwWGmOFPnORws6LiC/CnJGCi/jqRuFBleeyYq0/G37sxDqKqfSPZsOHc1wxto1tH/9mVB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579456; c=relaxed/simple;
	bh=bId3MPYxq9BpmSMqtBaQ322K4+s9IXMMPd3EXM1dd0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=J2a02QfV69v+GoSbRQCxE4QXURjzLN2+CLgq8x0MYvzM9zlbr5sp7jhbw3BeagrrNFttKjPhT60hy2mdfEiOgSj4VIfwsOQ9FExk5E66hFxyoEoLbGmjQj/lZ4tt5XER/qUgDP3CkA1Ia6YwHlH/mHqlLu+6Mfw51fgW+h28stQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2716:1247:52e8:4f90])
	by albert.telenet-ops.be with bizsmtp
	id ujAr2B00H2qflky06jArfQ; Mon, 04 Mar 2024 20:10:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDhv-002KJs-L6;
	Mon, 04 Mar 2024 20:10:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDi7-00BCca-9O;
	Mon, 04 Mar 2024 20:10:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/7] sh: Fix missing prototypes (part two)
Date: Mon,  4 Mar 2024 20:10:42 +0100
Message-Id: <cover.1709579038.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series fixes more "no previous prototype for <foo>" warnings
when building a kernel for SuperH, and is a follow-up to [1].

This has been boot-tested on landisk and on qemu/rts7751r2d.

Thanks for your comments!

[1] "[PATCH 00/20] sh: Fix missing prototypes"
    https://lore.kernel.org/r/cover.1709326528.git.geert+renesas@glider.be>

Geert Uytterhoeven (7):
  sh: cache: Move forward declarations to <asm/cacheflush.h>
  sh: traps: Make is_dsp_inst() static
  sh: mach-highlander: Add missing #include <mach/highlander.h>
  sh: mach-sh03: Make sh03_rtc_settimeofday() static
  sh: sh7757lcr: Make init_sh7757lcr_IRQ() static
  sh: sh7757: Add missing #include <asm/mmzone.h>
  sh: sh7785lcr: Make init_sh7785lcr_IRQ() static

 arch/sh/boards/board-sh7757lcr.c                |  2 +-
 arch/sh/boards/board-sh7785lcr.c                |  2 +-
 arch/sh/boards/mach-highlander/pinmux-r7785rp.c |  1 +
 arch/sh/boards/mach-sh03/rtc.c                  |  2 +-
 arch/sh/include/asm/cacheflush.h                | 12 ++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c          |  3 +++
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c          |  1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c          |  3 +++
 arch/sh/kernel/traps_32.c                       |  4 ++--
 arch/sh/mm/cache-sh4.c                          |  2 --
 arch/sh/mm/cache-shx3.c                         |  1 +
 arch/sh/mm/cache.c                              | 14 --------------
 12 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
