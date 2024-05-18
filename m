Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70692D26D
	for <linux-sh@vger.kernel.org>; Sat, 18 May 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716033509; cv=none; b=MhyiGq16xxbKSYr3nrhIw3DjY6i6vbURPzcsKfmFpNnnLM+OuQgcAF9APeCRLsE2G376QgJwCm/IlqWxMW9LU0X0C9RNE87xoco2vzjeRD85FmNkRcEQvEU0JX3Hxvl3bJcTk+yZpUEHjQKIaUou+D6z2IF5O6nmeoLDXV3j9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716033509; c=relaxed/simple;
	bh=dmnIkc5GtXx192q0EpFcig9q0S9yHLVSoRo4gc2oEwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1YaTQKCx5jNvK7gu3LPPXFnTJORGU4yCN0ivm2qtimVCSDdbDKr5NMIJ7W3CZ8r6IdxnOVAsuTMwsLSNirnuGlGn74fFqXq57fi5zWAzEWNegXDkMlG82qiMMRGzWNoUfK6J6wK6ghnIpHySmJ8VOskFByrGeS4Zm4n/njWcRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mdHghlQa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P7IBKm9c; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mdHghlQa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P7IBKm9c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mdHghlQa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P7IBKm9c";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mdHghlQa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P7IBKm9c"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4927B5FAAC;
	Sat, 18 May 2024 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716033504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnDpm4EKbhBQ/1NKuX0gOKB+WHDPt4tjZ4vg0QkyK50=;
	b=mdHghlQaqx7ywTnj8CKiM/v/kQzMWO5czWRqScUwkH1rx7T5Dw922Hcrlo2JwN/JuNCwKA
	gf/t4f/LbbJ/E9/fA+X2uzhxFfi8vpOFKxCdTBb0mHs2hoDtruQNKbfENTKg4lMB+Nsp/o
	Yga+B/iXjdoimsU0kovJCQawCo9iGpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716033504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnDpm4EKbhBQ/1NKuX0gOKB+WHDPt4tjZ4vg0QkyK50=;
	b=P7IBKm9ceE6mad/2XdhmmJAVBSyMX0whFb8GL9zYHb0TjJOcizp5OYz70kawkT/T6Xx7Xh
	KHmPpTdPuAD2KnAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716033504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnDpm4EKbhBQ/1NKuX0gOKB+WHDPt4tjZ4vg0QkyK50=;
	b=mdHghlQaqx7ywTnj8CKiM/v/kQzMWO5czWRqScUwkH1rx7T5Dw922Hcrlo2JwN/JuNCwKA
	gf/t4f/LbbJ/E9/fA+X2uzhxFfi8vpOFKxCdTBb0mHs2hoDtruQNKbfENTKg4lMB+Nsp/o
	Yga+B/iXjdoimsU0kovJCQawCo9iGpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716033504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnDpm4EKbhBQ/1NKuX0gOKB+WHDPt4tjZ4vg0QkyK50=;
	b=P7IBKm9ceE6mad/2XdhmmJAVBSyMX0whFb8GL9zYHb0TjJOcizp5OYz70kawkT/T6Xx7Xh
	KHmPpTdPuAD2KnAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFAEB134C3;
	Sat, 18 May 2024 11:58:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ANzHM9+XSGb8MwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sat, 18 May 2024 11:58:23 +0000
From: Oscar Salvador <osalvador@suse.de>
To: linux-sh@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 2/2] arch/sh: Drop support for memory-hotplug and memory-hotremove
Date: Sat, 18 May 2024 13:58:08 +0200
Message-ID: <20240518115808.8888-3-osalvador@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[renesas];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -5.30
X-Spam-Flag: NO

Remove all CONFIG options related to memory-hotplug and memory-hotremove.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/sh/Kconfig                     | 2 --
 arch/sh/configs/apsh4ad0a_defconfig | 2 --
 arch/sh/configs/sdk7786_defconfig   | 2 --
 arch/sh/configs/shx3_defconfig      | 2 --
 arch/sh/mm/Kconfig                  | 4 ----
 5 files changed, 12 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 6bc60f964f96..c5c093c73aa1 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -3,8 +3,6 @@ config SUPERH
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_CPU_CACHE_ALIASING
-	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && MMU
-	select ARCH_ENABLE_MEMORY_HOTREMOVE if SPARSEMEM && MMU
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
 	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_CPU_FINALIZE_INIT
diff --git a/arch/sh/configs/apsh4ad0a_defconfig b/arch/sh/configs/apsh4ad0a_defconfig
index 64558bf60e10..19ed0601a36f 100644
--- a/arch/sh/configs/apsh4ad0a_defconfig
+++ b/arch/sh/configs/apsh4ad0a_defconfig
@@ -24,8 +24,6 @@ CONFIG_BFQ_GROUP_IOSCHED=y
 CONFIG_CPU_SUBTYPE_SH7786=y
 CONFIG_MEMORY_SIZE=0x10000000
 CONFIG_HUGETLB_PAGE_SIZE_1MB=y
-CONFIG_MEMORY_HOTPLUG=y
-CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
 CONFIG_SH_STORE_QUEUES=y
 CONFIG_SH_APSH4AD0A=y
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 7b427c17fbfe..07894f13441e 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -43,8 +43,6 @@ CONFIG_MEMORY_SIZE=0x20000000
 CONFIG_PMB=y
 CONFIG_NUMA=y
 CONFIG_HUGETLB_PAGE_SIZE_64MB=y
-CONFIG_MEMORY_HOTPLUG=y
-CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
 CONFIG_SH_STORE_QUEUES=y
 CONFIG_SPECULATIVE_EXECUTION=y
diff --git a/arch/sh/configs/shx3_defconfig b/arch/sh/configs/shx3_defconfig
index aa353dff7f19..9a0df5ea3866 100644
--- a/arch/sh/configs/shx3_defconfig
+++ b/arch/sh/configs/shx3_defconfig
@@ -31,8 +31,6 @@ CONFIG_CPU_SUBTYPE_SHX3=y
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_NUMA=y
 CONFIG_PAGE_SIZE_64KB=y
-CONFIG_MEMORY_HOTPLUG=y
-CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_SH_STORE_QUEUES=y
 CONFIG_SH_X3PROTO=y
 CONFIG_NO_HZ=y
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index f32a1963ff0c..1862411665ab 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -144,10 +144,6 @@ config ARCH_SPARSEMEM_DEFAULT
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
-config ARCH_MEMORY_PROBE
-	def_bool y
-	depends on MEMORY_HOTPLUG
-
 config IOREMAP_FIXED
        def_bool y
        depends on X2TLB
-- 
2.45.1

