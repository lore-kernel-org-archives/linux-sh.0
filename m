Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7830C343;
	Thu, 28 May 2026 05:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947175; cv=none; b=L5llf3POBQ688GN2N5aRmquPpjxMXTcvNZnPBokvZv/Moan/JMxR09aZS785+f8lugZ7PHvTo2XW1uxOKrg9g+gDG9drV4HnDLNqZMpEU/a9qB/YvrdFMgeIixYV+lHzdqKBZ1P9B/DAUWA3QNvV7Rxz2ceGvNncPvELOK8DXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947175; c=relaxed/simple;
	bh=YEAnjREgSBvkEnKUajxohN8jGA14KxuWFr7Z0nCeVjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oec5nBqp8vdrS3OXL7VjvfOkg/dQJIJFTilXMlvPFZGTusqBDzsTp9aao3UnPZDwpOp9G6gwMCg83nU+f7Fsk8SZVWlB+NapH4DfqscpZ+ShhhGwZ1uCvX0nk2GAI5K0/dYvRMFZFbsMo6HvyOyvhZSe5mWNR1qHSjAuzPjakz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USTJwMyG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USTJwMyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA4C1F000E9;
	Thu, 28 May 2026 05:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779947174;
	bh=95SOoqGn6jyE0UfkDK15/NBpH9CmgAfhjJteJqSZdCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=USTJwMyGvWXoMbf/S3Hkuw/RAJZlgHz1wf6Rv3/jmc2THf0cyKGDOtGKt9FmAlIO2
	 bEzFbeCt0rnDn/8rlPAlmhLya/lie2fE7s0Ml45wXgkLiE48k3nYrM5tUD//wtZoUe
	 Or1W+w7erYiqub4kaHP0qkQb3RECfdmHprx1Vj3YKxor8X2FJMM9b4kv+OtRUUTLhY
	 dmdFE+f1EYTQmxHd5kFze5j7kVMcZ/PDIzwqvicbpyNpYnweMPLgb8vUH92a7Ecsu/
	 AQ6G7A7Ro/8u63LF4IMK8XJnfB3/MXr6DrdO23eJ8HfBnbe96tH4zBoN13i1Sk2LFH
	 iU1t+RcUX53pg==
Date: Thu, 28 May 2026 08:46:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH v6 13/15] sh: cast away constness from the zero page when
 flushing it from the cache
Message-ID: <ahfWnLIwZXJvbvNg@kernel.org>
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526175846.2694125-30-ardb+git@google.com>

On Tue, May 26, 2026 at 07:59:00PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> SH performs cache maintenance on the zero page during boot, presumably
> to ensure that any clearing of BSS that has occurred at startup is
> visible to other CPUs and DMA devices.

It flushes the cache there because before 6215d9f4470f ("arch, mm:
consolidate empty_zero_page") empty_zero_page used was for boot parameters
at the very early boot.

I removed memset(empty_zero_page, 0, PAGE_SIZE) that was a line above but
missed the cache flush. 

This whole "clear zero-page" can be removed IMO.
 
> The __flush_wback_region() function takes a void* argument, which is
> conceptually sound, but given that empty_zero_page[] must never be
> modified, it is being repainted as const, making it incompatible with a
> void* formal parameter.
> 
> Given the above, and the fact that __flush_wback_region() is in fact a
> function pointer variable with multiple implementations, take the easy
> way out, and cast away the constness in this particular invocation.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/sh/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index 4e40d5e96be9..acbb481cdbfe 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -332,7 +332,7 @@ void __init mem_init(void)
>  	cpu_cache_init();
>  
>  	/* clear the zero-page */
> -	__flush_wback_region(empty_zero_page, PAGE_SIZE);
> +	__flush_wback_region((void *)empty_zero_page, PAGE_SIZE);
>  
>  	vsyscall_init();
>  
> -- 
> 2.54.0.794.g4f17f83d09-goog
> 

-- 
Sincerely yours,
Mike.
