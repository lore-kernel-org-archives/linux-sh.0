Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B0213E67
	for <linux-sh@vger.kernel.org>; Tue, 13 May 2025 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126812; cv=none; b=aftRs7661Qj01rLdZoAjBpvzEOcdaQ+ZTphd0jJkQ/0150yFWHRsMslvE+ASM21bBcK/a35Th2vCfd8Vk5Z8BqIAF2Fx78VteK3UPOd9XSpKeYf8WU5fP+vnM06FEA4A4vGGp6obut4XN6YWCsUuIaBRAs+CsIh6m+0/b7EKWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126812; c=relaxed/simple;
	bh=DJPYRRspkNRNwfzB0qcQYnFe7Em4op/YgtRLUsGmJV4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGLKbGv7ANwzzrftEBvz8Dt+bLFh1uExASahqqkBzQ2l3FqpDFC97kkWXR4kwv887TkH0U0AhsRj+Rf0IX3yszEeJOYiV0gEyq8NiPQk54nwUNSN9QsGVphwnh90yAjkMH+4br+V8CAASTIHmEdmfR8R6hzvcuQm3RQjWQBxWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RN5Aw6Cy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Px6SqorE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bawo5G6n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=scitoupB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RN5Aw6Cy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Px6SqorE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bawo5G6n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="scitoupB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBC541F6E6;
	Tue, 13 May 2025 09:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747126809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6W6RFAD/RWmnTm9AYB/P5QZT5NCjQ2Cku5lv7gxJjg=;
	b=RN5Aw6CyfCUr1QZYGlB5hcCKLrI12Db2ZMsgrrv2wU9C+P7h99VMYQfIabwp/5TpVfes/Y
	+wKYrUb/POAXvRW4UTlK0dXLTtaWJuOu/qnxP0+ZLAC6o7zn530QDXFKWzGGZaKJlefY4L
	IzrX86mmNsckLyLnW8HdEbNrzM9uQYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747126809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6W6RFAD/RWmnTm9AYB/P5QZT5NCjQ2Cku5lv7gxJjg=;
	b=Px6SqorEi5FCA12WixdzwPN+waSwJIpDZ0HmwmLAHXukZVESS1J2LhmPhGWZt7TD6LiFn4
	jLx5gS0ks641RFAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Bawo5G6n;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=scitoupB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747126807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6W6RFAD/RWmnTm9AYB/P5QZT5NCjQ2Cku5lv7gxJjg=;
	b=Bawo5G6nvEH12eObEBLZDUcAbtaMkG1gtBGjfR21gP6vVvga9aLiaUf47JdRsA5QymFYzy
	mhmKHRZVaOKPQzEAd1IDVVA/lk0IzORf1UT5wWfvqYJuEw4eT0sWJjdsL2/Gmq/RnD2leW
	YYp5Fe4C2goLb+pNDzrQSUxXrYOGx08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747126807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6W6RFAD/RWmnTm9AYB/P5QZT5NCjQ2Cku5lv7gxJjg=;
	b=scitoupBK52GXAbkofb0LujdK3V7UtSCu1zodJoXhfjvuYjiSpB3xtU4Kzm1jCV2sbVySe
	ixH/rk/3vp2/OsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF709137E8;
	Tue, 13 May 2025 09:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KXZEKhcKI2jIfQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 May 2025 09:00:07 +0000
Date: Tue, 13 May 2025 10:59:59 +0200
Message-ID: <8734d8ubqo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	Rich Felker <dalias@libc.org>,
	linux-sound@vger.kernel.org,
	linux-sh@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ALSA: sh: SND_AICA should depend on SH_DMA_API
In-Reply-To: <b90625f8a9078d0d304bafe862cbe3a3fab40082.1747121335.git.geert+renesas@glider.be>
References: <b90625f8a9078d0d304bafe862cbe3a3fab40082.1747121335.git.geert+renesas@glider.be>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CBC541F6E6
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,libc.org,vger.kernel.org,intel.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[renesas];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,glider.be:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action

On Tue, 13 May 2025 09:31:04 +0200,
Geert Uytterhoeven wrote:
> 
> If CONFIG_SH_DMA_API=n:
> 
>     WARNING: unmet direct dependencies detected for G2_DMA
>       Depends on [n]: SH_DREAMCAST [=y] && SH_DMA_API [=n]
>       Selected by [y]:
>       - SND_AICA [=y] && SOUND [=y] && SND [=y] && SND_SUPERH [=y] && SH_DREAMCAST [=y]
> 
> SND_AICA selects G2_DMA.  As the latter depends on SH_DMA_API, the
> former should depend on SH_DMA_API, too.
> 
> Fixes: f477a538c14d07f8 ("sh: dma: fix kconfig dependency for G2_DMA")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505131320.PzgTtl9H-lkp@intel.com/
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied now.  Thanks.


Takashi
