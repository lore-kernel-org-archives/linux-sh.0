Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3338F255;
	Thu, 16 Apr 2026 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327019; cv=none; b=FA+wYlV/do+tRQuLJC0r/bJhdzmGmLzl8BLlYG7jAxmXZoCURKhdAdOX2xtfB43t9TYohtoC0dnG7nbc/LCQ6ujVx57kt6vqjxUfR2D/0UUU6VPTfQkdHWUyqW1vFChtxZQALU5X9yi2besVlIqA53ImKdwMynahLzWRdK/hWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327019; c=relaxed/simple;
	bh=ryPFvNd9nLqxmG1mo+OAAGd4a7ehiYg2rraD+1fVjtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEUIuS85ElcwYV9t7DwQL7Pr6VfGrczgH6ifqcyGC2KQm3GQMo5Iz7vWM/AVU6SKmpcdMhK0E5w9V8hO4EeNMmUuMgK/bVXUe4d7w4dl1FBuEFe1K6vsx1O74xl2rqsTWB28OYfq7P+cahve/No2QRYJg0H/5iZ2ULfbiEJIKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o5nNKC8L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g4gWjQ5y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o5nNKC8L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g4gWjQ5y"
Date: Thu, 16 Apr 2026 10:10:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776327011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=er7vZbJm0ZYM6q0ZXrYoh6LIB6r018Yma2LhfiIlGek=;
	b=o5nNKC8LJKPE34sFNjKrYUTrgatUmZpwyzIdMfVgOXerYuwOETULW01H1sh9dq1IkLAXoK
	LMG51nzhS67JG6krNZVWS/ki1tni5P4F75UNo70+HIv875yXzG855q/BS1loERNx1pj6XL
	OczSJYhs0WUt2L0P4OX+cI+EK64zJnreVuA5kMVYB/+kLcDBnY4T/++h0Q4d0IhsFksH7F
	eVp/m8bctx17Qd4fJ04OsLD9KJ9juTEJhnaycl2odC5dwRxbLIizReKb1c5FRRYxpWlW9V
	0/3cDkRD0MXfA2JR0kqnTE45xViDrGYL9qARirhiBVdwAno8tV+FWU8TjyqAKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776327011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=er7vZbJm0ZYM6q0ZXrYoh6LIB6r018Yma2LhfiIlGek=;
	b=g4gWjQ5y1WR9OhVJ2/iH82sndAB47SOqEWhyZKOYWQE/ySeEGTIvGpseS4lGcbUiKEXB7t
	kTMhZ77DIILacZDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Mike Rapoport <rppt@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 3/4] arch, mm: consolidate empty_zero_page
Message-ID: <20260416100221-57063053-1c9e-4450-8b0c-d9783657fa47@linutronix.de>
References: <20260211103141.3215197-1-rppt@kernel.org>
 <20260211103141.3215197-4-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211103141.3215197-4-rppt@kernel.org>

Hi Mike,

On Wed, Feb 11, 2026 at 12:31:40PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Reduce 22 declarations of empty_zero_page to 3 and 23 declarations of
> ZERO_PAGE() to 4.
> 
> Every architecture defines empty_zero_page that way or another, but for the
> most of them it is always a page aligned page in BSS and most definitions
> of ZERO_PAGE do virt_to_page(empty_zero_page).
> 
> Move Linus vetted x86 definition of empty_zero_page and ZERO_PAGE() to the
> core MM and drop these definitions in architectures that do not implement
> colored zero page (MIPS and s390).
> 
> ZERO_PAGE() remains a macro because turning it to a wrapper for a static
> inline causes severe pain in header dependencies.
> 
> For the most part the change is mechanical, with these being noteworthy:
> 
> * alpha: aliased empty_zero_page with ZERO_PGE that was also used for boot
>   parameters. Switching to a generic empty_zero_page removes the aliasing
>   and keeps ZERO_PGE for boot parameters only
> * arm64: uses __pa_symbol() in ZERO_PAGE() so that definition of
>   ZERO_PAGE() is kept intact.
> * m68k/parisc/um: allocated empty_zero_page from memblock,
>   although they do not support zero page coloring and having it in BSS
>   will work fine.
> * sparc64 can have empty_zero_page in BSS rather allocate it, but it
>   can't use virt_to_page() for BSS. Keep it's definition of ZERO_PAGE()
>   but instead of allocating it, make mem_map_zero point to
>   empty_zero_page.
> * sh: used empty_zero_page for boot parameters at the very early boot.
>   Rename the parameters page to boot_params_page and let sh use the generic
>   empty_zero_page.

With this in mainline as commit 6215d9f4470f ("arch, mm: consolidate
empty_zero_page") booting sh on QEMU is now broken.
The machine hangs before any output.

Reproducer:
./tools/testing/kunit/kunit.py run --arch sh --cross_compile sh4-linux- --raw_output=all example

> * hexagon: had an amusing comment about empty_zero_page
> 
> 	/* A handy thing to have if one has the RAM. Declared in head.S */
> 
>   that unfortunately had to go :)

(...)


Thomas
