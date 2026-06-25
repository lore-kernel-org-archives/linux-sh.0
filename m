Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617023769EF
	for <linux-sh@vger.kernel.org>; Thu, 25 Jun 2026 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377912; cv=none; b=EQDT19mebiiWW756as8tbZRRDtgbiLvaawT7phTbOolbo4/pOpWGHllTeffyLZo/qQxc5KlpdLyTYVX7iOBph8VAd9zFzC3A2l9jZMLLKpX6pwMCs6+wf+PJ3CsZNUYil/lx1cxlsNJiC8qxFFQZQ67CLG7zJWgrSIgH0nMgjZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377912; c=relaxed/simple;
	bh=mBx1RaNjuhhIOlyB6e4Fz3aKuQmS7WVwxij3N6JFznw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKdYfPK0Win6IShy5N7D2UXvP+PmUcCneLRCZ1yHpcPyQIVq/c1lXKvxji3/mFG5fdQyj+HGOvmLYQA79BIoW+nGhGNqoalJUkYVkdatM+jzLqC7tmeaBl4ArQJAH2lkw4816yGMr2rk0D/q5KA7eNHEOJsWwMT7mas1JPLgCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXVZAo8q; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXVZAo8q"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-663c66669ddso1530278d50.0
        for <linux-sh@vger.kernel.org>; Thu, 25 Jun 2026 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782377908; x=1782982708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHMuCKDp3YbDDMvuKoLEQaGreX8W6rFv5szF7QtOh38=;
        b=SXVZAo8qXAU5qukc04UndnMQpvkqja0QpLbranfS4wvWKnmkHUEA68zk6WjxQ1fLuE
         oUvqRadvqqL6SBU+MSzYlVOkqLsbSvQGDc96Ati12Y5G28oCOiwzRQHu4sOMpkSbf7CA
         guAQ4jxTL8sx7PAmfWdZlI7as4c5uvf47oSuruRlmg2LcjajXd1GDwA3az2oK4Puf1rt
         LlDDV4261h59UE0WOGbR5X/i/NPxuZmozuV9925DoEUOrlOhKym27EBJeDS7lVJkOMBm
         MIa7oysKvveJ+4vTZTdYiJRxaDAbJQN+screBscuJXDhCkRM/030h6n6UAlSeKaWVi/i
         OmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377908; x=1782982708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHMuCKDp3YbDDMvuKoLEQaGreX8W6rFv5szF7QtOh38=;
        b=Onhxr5V9UfvjPs5ZKKuj6/JUPWaugQ8kzFmhBR59+0RCPvp53s6aLxiueeG533xv2Z
         oQQcI222YFswYdBdct97Ro2KyL9JKaYk9q82AqV7PRwvYBBB3KqUTc3/cNRySAr/9Wqb
         Uk4xeYK++tgPx2ilSSWxZBUPDH3wEcjFTuc5GpXkCCWOeJJZ4rYgvSAXGKU6XXHqnPxc
         Eqxh1fKzxyqNIh9jXEoxMXDp7aEgxLDHn5QSfJ18/5JvV3oNxQoNSEPm9ihztsc4ZEjZ
         QT+Ir4CJ+JP+1TrGmvdIw4IEwXaZBtDEk70EzbtKs8SUy0+zkvOKTLDt+5JOIcJMWOHN
         5APA==
X-Forwarded-Encrypted: i=1; AHgh+RozlpJ906dICj8wtcnqxa6FVAjEKwTkhksA84fBtSJYB8pbqed6oC8Byg51oc+J8jM8s7S3CpbJ5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhsRVrZjMaklK0UMg0LE+IfDYPsB2QpC5quSvL5lYtAlrGet0T
	T57e1LM+wykPmUAHXAHwS8HtsDR7TmtfITwvsqb3A7FqKfQ5DqC433UO
X-Gm-Gg: AfdE7clRFL4v6yXnbK9ncxJdypjflJsd7/51ilIeJ9u6by+IRYdck7v/rIvKFD/vUKP
	3y/YgU+xKRd3RqlRpFDMyQAZRQ2pX2avJHXzsbCFrjRCs1lGOPS8Vzi9qp940+Nbq7omOb+dBtX
	tzwKNirOF2OxtxOHLmnEydgM2+W971yHecgoRUndI3mDz8GgEIwuvwq++uPi2iufcxyEztNWum+
	Lf78wcVP21xHcJDhBYpSDwRI4JtskbILe7SYLPZNmia/dilskwu6Ri7mhcSHP3MV0MjKXkp568X
	Wb0eCfDxB5KWwGBLfCrc71JYCI00eujrMgVoJuNraKRcHwm0w/zBWxvncPbpMEwTkvsccxU19Xk
	OzpXYGPmCbpYv9rNKjd0wuXBdNtj1uiJ/E6lnL4MOLsyM0rlKxkP8vkE06uH5Wu016cFEoO8BJ7
	APCkTh1wuLH735vGkd8z/rAnB2zw==
X-Received: by 2002:a05:690e:168b:b0:662:a4ee:104b with SMTP id 956f58d0204a3-664882bb9bdmr1048451d50.48.1782377908381;
        Thu, 25 Jun 2026 01:58:28 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6647f917b1csm1059566d50.13.2026.06.25.01.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:58:27 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sh@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] char: mem: keep arch range checks overflow-safe
Date: Thu, 25 Jun 2026 10:58:00 +0200
Message-ID: <20260625085800.4505-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic /dev/mem physical range check now avoids validating
addr + size directly, but ARM and SH provide their own
valid_phys_addr_range() implementations with the same wrapped-addition
pattern.

Use subtraction-based upper-bound checks in those overrides as well. Also
make the ARM mmap pfn check avoid overflowing the pfn plus page-count
expression.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 arch/arm/mm/mmap.c | 9 +++++++--
 arch/sh/mm/mmap.c  | 4 +++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 3dbb383c2..7467ce8cd 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -150,9 +150,11 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
  */
 int valid_phys_addr_range(phys_addr_t addr, size_t size)
 {
+	phys_addr_t end = __pa(high_memory - 1) + 1;
+
 	if (addr < PHYS_OFFSET)
 		return 0;
-	if (addr + size > __pa(high_memory - 1) + 1)
+	if (addr > end || size > end - addr)
 		return 0;
 
 	return 1;
@@ -163,5 +165,8 @@ int valid_phys_addr_range(phys_addr_t addr, size_t size)
  */
 int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 {
-	return (pfn + (size >> PAGE_SHIFT)) <= (1 + (PHYS_MASK >> PAGE_SHIFT));
+	unsigned long max_pfn = 1 + (PHYS_MASK >> PAGE_SHIFT);
+	unsigned long pages = size >> PAGE_SHIFT;
+
+	return pfn <= max_pfn && pages <= max_pfn - pfn;
 }
diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index c442734d9..ba7aade46 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -170,9 +170,11 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
  */
 int valid_phys_addr_range(phys_addr_t addr, size_t count)
 {
+	phys_addr_t end = __pa(high_memory);
+
 	if (addr < __MEMORY_START)
 		return 0;
-	if (addr + count > __pa(high_memory))
+	if (addr > end || count > end - addr)
 		return 0;
 
 	return 1;
-- 
2.54.0

