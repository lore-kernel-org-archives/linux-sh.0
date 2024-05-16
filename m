Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211E282E1
	for <linux-sh@vger.kernel.org>; Thu, 16 May 2024 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715891144; cv=none; b=D2IbVUOSuW2TyRhQNt4kXptinYQ0EkvPtNptY3b6CfstU2CNh4eHfEPlDuFifagNM2MIAETbJBK9jm8RZQzQuYFjXF5vGu3f5/iq2lWIWjOWxKJpyWepTNP8W0V56BZqwlRvmYjSANEqco0OWUklxR3WmcW4yfhr3aJIv2XTRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715891144; c=relaxed/simple;
	bh=UVTh/wHgrDImkHexSwe4pikqqPivQUcm5RPx4VxH2kw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q+5M9NbEIgKkx8IsOEU8AYAmkLDAaCm0dANkC36g18xgSy/ODRXg49Djc4Ifiwej1hmjWLNFHPpbgOQColdd5tfm9szxrudQ4pGNwhbee965rgBBL/nlO4PTOLCx0rT5LrtpLNtvI+v19ttuF+lfwTwwHzVqLLOLUubKJF5q3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZzmJPGvi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2bxU9Ffz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZzmJPGvi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2bxU9Ffz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZzmJPGvi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2bxU9Ffz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZzmJPGvi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2bxU9Ffz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8365B34EED;
	Thu, 16 May 2024 20:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715891134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=6XUPoY9/XW5YAoS5bjuK4zffCvXdJJFcLFOR5mMhWRE=;
	b=ZzmJPGviaGNICG276KlSoNUoIItWaqMYTR4Sebh3j/u7mJX6DxI7ayGuKCwMAOm4HFlRsD
	KfCJ0yuDHcQwg/bQ5fzawroNEZdruvItIrg7C3ErMva8pXZLiEsMV3Euzi7bA9pXZ2Z8Ky
	hsawFhUy1vrq4mtZbv6apkfzkOIH+Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715891134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=6XUPoY9/XW5YAoS5bjuK4zffCvXdJJFcLFOR5mMhWRE=;
	b=2bxU9FfzwXFv6EDl1E5qN+8dXmx8Z6/rfLxNF1CHgXfGIvWxcEJLEA+AGaOyt7egJDhA+X
	DhykX0Kwbs69I3CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZzmJPGvi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2bxU9Ffz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715891134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=6XUPoY9/XW5YAoS5bjuK4zffCvXdJJFcLFOR5mMhWRE=;
	b=ZzmJPGviaGNICG276KlSoNUoIItWaqMYTR4Sebh3j/u7mJX6DxI7ayGuKCwMAOm4HFlRsD
	KfCJ0yuDHcQwg/bQ5fzawroNEZdruvItIrg7C3ErMva8pXZLiEsMV3Euzi7bA9pXZ2Z8Ky
	hsawFhUy1vrq4mtZbv6apkfzkOIH+Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715891134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=6XUPoY9/XW5YAoS5bjuK4zffCvXdJJFcLFOR5mMhWRE=;
	b=2bxU9FfzwXFv6EDl1E5qN+8dXmx8Z6/rfLxNF1CHgXfGIvWxcEJLEA+AGaOyt7egJDhA+X
	DhykX0Kwbs69I3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BA6713991;
	Thu, 16 May 2024 20:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mjGYC75rRmZjDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 16 May 2024 20:25:34 +0000
Date: Thu, 16 May 2024 22:25:28 +0200
From: Oscar Salvador <osalvador@suse.de>
To: glaubitz@physik.fu-berlin.de
Cc: geert+renesas@glider.be, david@redhat.com, linux-sh@vger.kernel.org
Subject: drop memory-hotplug on superH
Message-ID: <ZkZruHmlKd7GaRHs@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-2.98 / 50.00];
	BAYES_HAM(-2.97)[99.88%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8365B34EED
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.98

Hi,

After talking to Adrian Glaubitz about superH and memory-hotplug, he mentioned
that currently superH runs only on 32bits (there was a 64bit version but no is
longer supported?).
The thing is that since the below commit

   commit 7ec58a2b941ed88986694d037e38012738323171
   Author: David Hildenbrand <david@redhat.com>
   Date:   Fri Nov 5 13:44:28 2021 -0700

       mm/memory_hotplug: restrict CONFIG_MEMORY_HOTPLUG to 64 bit



we no longer support memory-hotplug on 32bit platforms, so let us drop the
memory-hotplug code for superH because it is a no-op at the moment.
If there is ever a 64bit platform again, we shall re-implement it, and we
shall do it on CONFIG_SPARSEMEM_VMEMMAP, since we plan do make memory-hotplug
dependant on that, and drop support for CONFIG_SPARSEMEM &&
!CONFIG_SPARSEMEM_VMEMMAP environments.

I prepared two patches at [1] that drop the code and the CONFIG_MEMORY_HOTPLUG_foo
from the Kconfigs.

Let me know if you are fine with that and I shall send it.

Thanks

[1] https://github.com/leberus/linux/tree/deprecate-memhotplug-sh

-- 
Oscar Salvador
SUSE Labs
