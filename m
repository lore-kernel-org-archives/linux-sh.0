Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922CC17BBF
	for <linux-sh@vger.kernel.org>; Sat, 18 May 2024 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716033507; cv=none; b=nUUscsDIp421FqKIwopCSQaHVPOo6Zvp7FVi5Y0qqN51VyOAbsRnu0ns5Skv+dDs+xRmi42WvKWcZ0jNzYrfQpqm7OgCG52Rm3LHgQQY0q5fTCg8tWEtZYU9DHRhVbCWzqAW8QLWQ8tsoxCJajYjw6lHvLkbsAykMMn2qthDUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716033507; c=relaxed/simple;
	bh=cerYVmnKIGxeg5dvDnXQzv5x5jgHyKoB5aL5VCmCHmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIMl79EVy+U9jDFLIkP5xzdIaF2PBSqZXgt4mRyWNgI1Wfjv1m1lkZUpxHyRsJXf/+g3ayRsSLppxj9Z1tCvxl43K5jD6u/CZY7SYByOybMwpNtPZ7v5UlTD9Jl2bBWPFz6c8KCpR8yIUjFswH/Zcz4MySbC5dfUvNh8K1ghY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sAHxT7wP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HVRo63M4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sAHxT7wP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HVRo63M4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sAHxT7wP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HVRo63M4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sAHxT7wP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HVRo63M4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DC26222FA;
	Sat, 18 May 2024 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716033502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EDgV17C6VWbbvJ3pv+5iSzpER3ZJwW/CqiA1/dZhDOY=;
	b=sAHxT7wPujmYecND++NPpjjMW4XtlAmXSgxfWmHb4kMCbLKS0uh5IAjaGk1osR+OrQhIQq
	C+yYOFGd+kfvU31ICNnPIeZVzpQPVRMyxkDocSLPzCJ1tCploeShJ5spfeUIBa63cl/lCn
	P2aoDWCjbp5DcOnCE0gZkWIsQqPmEXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716033502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EDgV17C6VWbbvJ3pv+5iSzpER3ZJwW/CqiA1/dZhDOY=;
	b=HVRo63M4+jrxEk1hnkOGo08G3aI8ycUZNjqw788hDS9FPX+UpDN6X+5wisW4CnIZFMEsVA
	qGhejAoFWBazNECw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716033502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EDgV17C6VWbbvJ3pv+5iSzpER3ZJwW/CqiA1/dZhDOY=;
	b=sAHxT7wPujmYecND++NPpjjMW4XtlAmXSgxfWmHb4kMCbLKS0uh5IAjaGk1osR+OrQhIQq
	C+yYOFGd+kfvU31ICNnPIeZVzpQPVRMyxkDocSLPzCJ1tCploeShJ5spfeUIBa63cl/lCn
	P2aoDWCjbp5DcOnCE0gZkWIsQqPmEXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716033502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EDgV17C6VWbbvJ3pv+5iSzpER3ZJwW/CqiA1/dZhDOY=;
	b=HVRo63M4+jrxEk1hnkOGo08G3aI8ycUZNjqw788hDS9FPX+UpDN6X+5wisW4CnIZFMEsVA
	qGhejAoFWBazNECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93FF5134C3;
	Sat, 18 May 2024 11:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AUPfIN2XSGb8MwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sat, 18 May 2024 11:58:21 +0000
From: Oscar Salvador <osalvador@suse.de>
To: linux-sh@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/2] Drop support for memory-hotplug and memory-hotremove on superH
Date: Sat, 18 May 2024 13:58:06 +0200
Message-ID: <20240518115808.8888-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.29
X-Spam-Level: 
X-Spamd-Result: default: False [-1.29 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.985];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[]

memory-hotplug dropped support for 32bit platforms a while back,
and given that superH can only operate on 32bit at this moment,
this cannot possibily work.

Remove all code and Kconfigs related to memory-hotplug and memory-hotremove.

Oscar Salvador (2):
  arch/sh: Remove code that handles memory-hotplug and memory-hotremove
  arch/sh: Drop support for memory-hotplug and memory-hotremove

 arch/sh/Kconfig                     |  2 --
 arch/sh/configs/apsh4ad0a_defconfig |  2 --
 arch/sh/configs/sdk7786_defconfig   |  2 --
 arch/sh/configs/shx3_defconfig      |  2 --
 arch/sh/mm/Kconfig                  |  4 ----
 arch/sh/mm/init.c                   | 28 ----------------------------
 6 files changed, 40 deletions(-)

-- 
2.45.1

