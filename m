Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977ED26D
	for <linux-sh@vger.kernel.org>; Sat, 18 May 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716033506; cv=none; b=LZAooDHEFMpA9y2n26CrcoHXVIoUU38F6YYoWlsxBoG9BeJgt0pAESKkYVEXqhPWxRQ5BYFtHS3tD1JXvTHH/ZyMnQGdvdo/Fnx9ggsTTcVnZjDv/xLY3ka1dlQiw8Ln4JeCRxRUO5QGZ/dftuaq9g1ZwFDTW+K1+HnsmkEAhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716033506; c=relaxed/simple;
	bh=bwgKEuiGWzBPap3PC1BqYAiCLoahldjMoAosjKMwB6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEbykLXXlFIZr8YiwzkhUyg/lVfUkIv88Bk4ONScQ2CTLZnSiQqntsnvAwpo/XWA5U1KYXJl8+pypITrjI/Jn9or172xBXnLtcEmX48vZxlefGw8Cx/ZWKLv7QYKlA8ryFOmiEu/wTHt7ME+MxbrbjIvSwk0bmR3YfS5//aQqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41F9D22385;
	Sat, 18 May 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D999B134C3;
	Sat, 18 May 2024 11:58:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ANmPMt6XSGb8MwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sat, 18 May 2024 11:58:22 +0000
From: Oscar Salvador <osalvador@suse.de>
To: linux-sh@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 1/2] arch/sh: Remove code that handles memory-hotplug and memory-hotremove
Date: Sat, 18 May 2024 13:58:07 +0200
Message-ID: <20240518115808.8888-2-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240518115808.8888-1-osalvador@suse.de>
References: <20240518115808.8888-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[renesas]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 41F9D22385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

Since commit 7ec58a2b941ed889("mm/memory_hotplug: restrict
CONFIG_MEMORY_HOTPLUG to 64 bit"), we only support memory-hotplug on
64bits platforms, but currently superH can only run on 32bit, so
remove the code that handles memory-hotplug and memory-hotremove as
that cannot work.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/sh/mm/init.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index bf1b54055316..d1fe90b2f5ff 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -395,31 +395,3 @@ void __init mem_init(void)
 
 	mem_init_done = 1;
 }
-
-#ifdef CONFIG_MEMORY_HOTPLUG
-int arch_add_memory(int nid, u64 start, u64 size,
-		    struct mhp_params *params)
-{
-	unsigned long start_pfn = PFN_DOWN(start);
-	unsigned long nr_pages = size >> PAGE_SHIFT;
-	int ret;
-
-	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
-		return -EINVAL;
-
-	/* We only have ZONE_NORMAL, so this is easy.. */
-	ret = __add_pages(nid, start_pfn, nr_pages, params);
-	if (unlikely(ret))
-		printk("%s: Failed, __add_pages() == %d\n", __func__, ret);
-
-	return ret;
-}
-
-void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
-{
-	unsigned long start_pfn = PFN_DOWN(start);
-	unsigned long nr_pages = size >> PAGE_SHIFT;
-
-	__remove_pages(start_pfn, nr_pages, altmap);
-}
-#endif /* CONFIG_MEMORY_HOTPLUG */
-- 
2.45.1

