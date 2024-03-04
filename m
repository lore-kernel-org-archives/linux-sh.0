Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30078B79
	for <linux-sh@vger.kernel.org>; Mon,  4 Mar 2024 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579456; cv=none; b=X5ROabZZttRKBfMNB7Cv4KL7jUBsVjUzc439TOdQzErHQo7dgHsIEss932tAQCc1o4ca82QRBX1C0/fGYkXn+8KCOdAn/9MGBk7ypOTfactLW0lzaLuYMRYVMoD2lo1H79mDxNwLwfI7yfMRRA3pSsZYBCPTUnH4/AFPgHeUTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579456; c=relaxed/simple;
	bh=YBY7KZbj02wlfGdHmoSJj6VE56Cov9ptssg9IM+FkNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4PXWrBYJ6fM4Rr8w9NJab6iIVtqAp8LQJ60d7ofA9gPHIFgm7/6lti6UvExF7WhfZwls14AvexHxmAU+NB6S3NxrDc1O60ZFxwjCLwIyDejD/lxlmybC6Iuldu12DsyPdSLifhXpSnCo5zz8E+2kqycx12oSorPI+wloSiziGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2716:1247:52e8:4f90])
	by laurent.telenet-ops.be with bizsmtp
	id ujAr2B00J2qflky01jArdh; Mon, 04 Mar 2024 20:10:52 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDhv-002KK3-Mr;
	Mon, 04 Mar 2024 20:10:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhDi7-00BCcp-Ck;
	Mon, 04 Mar 2024 20:10:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/7] sh: mach-sh03: Make sh03_rtc_settimeofday() static
Date: Mon,  4 Mar 2024 20:10:46 +0100
Message-Id: <95417f2a3eb1561af7c2ee064efbc3ef3f03dac3.1709579038.git.geert+renesas@glider.be>
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

arch/sh/boards/mach-sh03/rtc.c:123:5: warning: no previous prototype for ‘sh03_rtc_settimeofday’ [-Wmissing-prototypes]

There are no users outside this file, so make it static.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/boards/mach-sh03/rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-sh03/rtc.c b/arch/sh/boards/mach-sh03/rtc.c
index 7fb474844a2d1d65..bc6cf995128c6547 100644
--- a/arch/sh/boards/mach-sh03/rtc.c
+++ b/arch/sh/boards/mach-sh03/rtc.c
@@ -120,7 +120,7 @@ static int set_rtc_mmss(struct rtc_time *tm)
 	return retval;
 }
 
-int sh03_rtc_settimeofday(struct device *dev, struct rtc_time *tm)
+static int sh03_rtc_settimeofday(struct device *dev, struct rtc_time *tm)
 {
 	return set_rtc_mmss(tm);
 }
-- 
2.34.1

