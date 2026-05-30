Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3883093A6;
	Sat, 30 May 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157989; cv=none; b=Aicyo9OojNaheMpa3a2a7z12hRXIKQPagy0i4XoSdZkp6vaFHv6bRDAGUua/rQsz8Pxo1UepVycUKQIqOdAfOtBldAbAxdCKEJf8Jcf4XSs4NbOgYJN9gXgiZG71hND/+nvqr4m5lVuLrYZ0clsR3BtBjVS6E3h9ApPgLRWlk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157989; c=relaxed/simple;
	bh=3ZBflBeNYm+c/oTiCGoL+2HSsJ8/5ZXdqbhea4+si1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW3vWjGffCE7W6DiQjT2zKRpaE70FjFViu9vAzB9b2QKblpLkU1fF/A45cQJQRizCHUcORP7EktO9eWwPIRcs1CcQYu4hN0ea8oSMmqtyqzzceAc2f3r4ZexCzEOl4dD7du9RfI4+KPSGJXtUpt8ZQ3V26ibPIbSP7sBgszMJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZl0+4I9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZl0+4I9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD33E1F00893;
	Sat, 30 May 2026 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157987;
	bh=WxYmQxwwBxgWs6asR9XSCI+irQfqn2faBEqKE1hn53E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WZl0+4I9eq0OPPyxyDBdqCGRR+y0CoJpx7P9J1ZNHafWZGZX1fuK9HT7HOCSp1FVU
	 9ddWJ9lDITFjq9eKGfZ8XgcPI1Gceue8QxkZpOu0JwKjN75XEWJg4tA2a8UNAkWZvu
	 d2ASsHkW3EY1IZ3rOpPzq31XPfEMQM756K5+/fSW612wkX78yv2eAZ66ejeZV4LlfY
	 gAu+RNJYW42KKsssq+PHsl1z2ZSd/eOK+QZCgtAc5FgOD8sjUj3miMaJcP2gtaD17q
	 8U+HAlTtH77+9KCSbzDnS36KQEJCJesVoZVR5wfQkL3btqSLgCjvtjIMAmDS1I+rUb
	 wf48OWQ3Lcqyg==
Date: Sat, 30 May 2026 19:19:36 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v7 12/15] sh: Drop cache flush of the zero page at boot
Message-ID: <ahsOGMc7ys3H_oAt@kernel.org>
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-29-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529150150.1670604-29-ardb+git@google.com>

On Fri, May 29, 2026 at 05:02:03PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> SuperH performs cache maintenance on the zero page during boot,
> presumably because before commit
> 
>   6215d9f4470f ("arch, mm: consolidate empty_zero_page")
> 
> the zero page did double duty as a boot params region, and was cleared
> separately, as it was not part of BSS. The memset() in question was
> dropped by that commit, but the __flush_wback_region() call remained.
> 
> As empty_zero_page[] has been moved to BSS, it can be treated as any
> other BSS memory, and so the cache flush can be dropped.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/sh/mm/init.c | 3 ---
>  1 file changed, 3 deletions(-)

-- 
Sincerely yours,
Mike.
