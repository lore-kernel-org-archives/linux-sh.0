Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77534582CC;
	Fri, 21 Aug 2026 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305311; cv=none; b=auzWUYpf8A2OR2TNcwxeep62eQjfQo1A3UOrXZ/6oTU061BPBelGjgP4uvLLgApplpwLvY0tUJ4OOcdLXGKplK7uDOYYpNBU4PHtZJDUaKWWnbg7bRA+ozyZpwE4xwWzYWmM/1GXedUPcN3oOq/jF8uYadX9KL6jVo/HHKU1YqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305311; c=relaxed/simple;
	bh=FmkDQCnbrYwsSA6IkKc1BKZOJumquomHcgUGfPDdCf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1GYBk6Zly6xmIYWtHYhuRRQL6S7ExKiYPbvmbQcDah+86q4MgctWDvfHMTHxp2ww9tATeXwmU+F1yHh5QKIYVQIvlTuTEEz5MJHwECfhigW/ut/Rlrmu4bbyW/8Ua6wt2xMB5Wfr2ohBU3qv/MpDHRrEc76Qzg49R2MolfVVOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IfFSpkuj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gOxJ958b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IfFSpkuj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gOxJ958b"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 920E53EFC;
	Fri, 21 Aug 2026 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787305294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lp996p4ro/fsbltsyWi4yBjbpcypgEnTiXPjo9NWNro=;
	b=IfFSpkujE1QpIfxf2vKYu2UvwHze62rvwlHS9egQckoj6hSLO+SZHDthyjIhDlQI5qAeQs
	sCHdcIGvW8bFcVdaUsza7LoDj/wmIaEvnJX9BHBHMfRTGOdyI8o9uVbutOs1JLtdjOg0pC
	o4atlf1YXarYyUVWqckH4JkKue3kKi0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787305290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lp996p4ro/fsbltsyWi4yBjbpcypgEnTiXPjo9NWNro=;
	b=gOxJ958biRSh01UAe9qw4SpnmWraiifrHoTHfkAqIYFb0cPmCICPwUYvMAwkJsHZ+UdMBQ
	bGDcTpmtA5hbebYtdoGYfUoeDKurBb7ycz4yQtzY0a8D2L2pbnYzN/EZBw9VLrdlnnTFum
	pmPHOPwygd/4fwKmFu0rbd+hU0A09lI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33CAB26F8;
	Fri, 21 Aug 2026 09:41:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3fmTCUodiGp9NgAAD6G6ig
	(envelope-from <ailiop@suse.com>); Fri, 21 Aug 2026 09:41:30 +0000
Date: Fri, 21 Aug 2026 11:41:29 +0200
From: Anthony Iliopoulos <ailiop@suse.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: remove unused setup_profiling_timer function
Message-ID: <aogdSZi3gWqaSfnc@technoir>
References: <20260820123931.142532-1-ailiop@suse.com>
 <047975cb5fdeb0e3cb52cb78d55c3a45023cc992.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <047975cb5fdeb0e3cb52cb78d55c3a45023cc992.camel@physik.fu-berlin.de>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Thu, Aug 20, 2026 at 04:00:37PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Anthony,
> 
> On Thu, 2026-08-20 at 14:39 +0200, Anthony Iliopoulos wrote:
> > setup_profiling_timer() is not used by any code at this point. Since a
> > default weak implementation exists, there is no need to keep this
> > arch-specific definition around. Remove it along with the now-redundant
> > profile header includes.
> 
> Do you have any clue why it was still implemented for LoongArch which is
> a rather new architecture? I'm also seeing that it's not used anywhere,
> I'm just wondering why it was not removed before and why it was even
> included when LoongArch was added.

Its addition to LoongArch [1] slightly predates converting it to a weak
function [2], so up until that point all archs had to include the stub.

Regards,
Anthony

[1] 46859ac8af52 ("LoongArch: Add multi-processor (SMP) support")
[2] 787dbea11a5d ("profile: setup_profiling_timer() is moslty not implemented")
