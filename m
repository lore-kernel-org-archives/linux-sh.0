Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3C472541;
	Fri, 21 Aug 2026 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305925; cv=none; b=sO3fD8GGTEb4jQxfKQdoh+zDKz/VKI4oSqAFtG5AvxsnmdjxYf78Y2lFA+9Blgyd/x3U7yc+sEXSoWvos4583votVyqkp8th13kjjZaz1zMy7KhOuXZH+Wu2dH230Jpbmb5JsurRoB6PeTX35ciB4yQ4DYuixRyNqLh/hRGRzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305925; c=relaxed/simple;
	bh=kLg6rxppdXsRXc3eX/KwcYrGSDxhxXHPL5NJ4HE8Wxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJbcrYHoMlC9BFP9NObJeOIE5GhhyTQbpZ8EUowpt8qMUroaHS3gztC3dKt7FLXdJUBnBTposaUVuZ59eazTwGUIRMOseciKAefaEVo3atUcc7NdOD2gxRwT3B0J3aSP/Jwfnk+jHzmSgSjCSZ7LzVXbYqLMGcbVhNn5+dnhwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EomOlTbC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WUwYnaM4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EomOlTbC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WUwYnaM4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36E09855F7;
	Fri, 21 Aug 2026 09:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787305911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uKxWwwHG8gRJg8ogphsUlyDVcogiiYe2ZzPUGYpvWGs=;
	b=EomOlTbC576dnU5b9xLOEYu1NjH5y5IwT+bbys2ftNi6WqamJ056PzyvmFTHM17Q5flUsv
	3vgb7L3PCGNE9TkaY6b5qILynRyIGJR2jgdqsJu8JUcf3Jx9Iv1BcaQ/dKcHwAtuUkF3A+
	GE2dS87Lm1JPtk5RVEf46SEqguHc78E=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787305907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uKxWwwHG8gRJg8ogphsUlyDVcogiiYe2ZzPUGYpvWGs=;
	b=WUwYnaM46TbIF9/4M5mN8JaYy9SPDVHtZy8CQ7ZM4QQzBQ8nDmBkCbG8z4CQpven3PBUmJ
	S63BLA0Qk3oTW9B6OSqcV1BnD3yI5N1Mzx048LSkDrU6E5FyL3wvCNEFLoDgp57CFxlbTs
	jyTSZ/VJ4OX26ZaIw6ZfPXu7iy2lA1Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF82026F8;
	Fri, 21 Aug 2026 09:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qLuqK7IfiGoBQQAAD6G6ig
	(envelope-from <ailiop@suse.com>); Fri, 21 Aug 2026 09:51:46 +0000
Date: Fri, 21 Aug 2026 11:51:42 +0200
From: Anthony Iliopoulos <ailiop@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: remove unused setup_profiling_timer function
Message-ID: <aogfrl6URpwMKxsk@technoir>
References: <20260820123931.142532-1-ailiop@suse.com>
 <CAMuHMdUxpgiMSgjcR2-Vz33iYUrjBNKO29yXk8oEdXG6RLFRtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUxpgiMSgjcR2-Vz33iYUrjBNKO29yXk8oEdXG6RLFRtg@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri, Aug 21, 2026 at 09:36:46AM +0200, Geert Uytterhoeven wrote:
> Hi Anthony,
> 
> Thanks for your patch!
> 
> On Fri, 21 Aug 2026 at 09:27, Anthony Iliopoulos <ailiop@suse.com> wrote:
> > setup_profiling_timer() is not used by any code at this point. Since a
> 
> It is used in write_profile()
> https://elixir.bootlin.com/linux/v7.2/source/kernel/profile.c#L202
> 
> > default weak implementation exists, there is no need to keep this
> > arch-specific definition around. Remove it along with the now-redundant
> > profile header includes.
> >
> > Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> 
> > --- a/arch/sh/kernel/smp.c
> > +++ b/arch/sh/kernel/smp.c
> > @@ -21,7 +21,6 @@
> >  #include <linux/sched/hotplug.h>
> >  #include <linux/atomic.h>
> >  #include <linux/clockchips.h>
> > -#include <linux/profile.h>
> >
> >  #include <asm/processor.h>
> >  #include <asm/mmu_context.h>
> > @@ -322,14 +321,6 @@ void smp_message_recv(unsigned int msg)
> >         }
> >  }
> >
> > -#ifdef CONFIG_PROFILING
> > -/* Not really SMP stuff ... */
> > -int setup_profiling_timer(unsigned int multiplier)
> > -{
> > -       return 0;
> 
> This returns zero (success), while the default weak implementation
> returns -EINVAL, so your change breaks write_profile().
> https://elixir.bootlin.com/linux/v7.2/source/kernel/profile.c#L181

Thanks for the review, yes the plan was to also remove the call entirely
from profile code itself, so that the resetting functionality can remain
and the arch-specific stubs could be dropped. I should clearly have sent
that patch first. I just did it now:

https://lore.kernel.org/all/20260821091744.91496-1-ailiop@suse.com/

Regards,
Anthony
