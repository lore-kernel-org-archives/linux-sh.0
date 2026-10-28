Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214688;
	b=i2lVU20AmBt/kjA9JVhhXcN8FrHGDSq99xguefrtb8aGdBZn5nulYUpROUOZgzVneBUl
	 18ZxTZ+9TFwzsIjblL97LwuUtM06Wq2s4D2ijRnh2KvJ5YoB6uBcf78Hy+OKvgI1PmZyh
	 7a7ciyIK4Y8E7PNGxZSj00zHsIvXcfi4BKOS8MYYC8XxilmNm/JmKp1y778E6lZGigf0Z
	 85yDMMiTi5xxS7MZVLjDsthpIQ38iIf2N0wp15gItzATsUuHr3gZqR1IRw4Qp6b8tAU63
	 obaXfCGjwMz1WtNtzmAQ3pF+KOxPjY1iFhzIOPu5THoNzVcgHBwSZwtEoZ0fy5CY5xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214688;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1ZCiiEwQ5cdvAEferIPSF0WM9T5tFjDIqRGawKcIWjE=;
	b=Y2G9+PB4HZKcDfBCRd7wzld1OFvz309HY4KVurkVFuDJVC7RmHyPbw5xqC/2GAQTnwfn
	 Cs/CoTv5Nhxhze5t/PhVZf4PRKXbUcvCLGzAM/ySGKoR9YCn2U5FY4qKTun70dJoxHFJi
	 owbzpoy6CJ+Y5AWJejYadeR4A823b9X4Ln0NVQhy8oqpiCSKrNk9bgkwkFD2Iyw2csO8u
	 Wwo4wgA76T8CP4mnF7Z4d1KKu86a9RYgnYtgkOz333e4ab1jGvBTt9IBHXCEbEbR6vhn+
	 B1mn2oLNWOmweEehzYuu60OJ8u9AmZH9r8rcttpM1rlG0bBu7KMkPk5TnKndudurJbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmOud5m1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8E606B7FC;
	Wed, 28 Oct 2026 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmOud5m1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CAD1F01828;
	Wed, 28 Oct 2026 19:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214687;
	bh=1ZCiiEwQ5cdvAEferIPSF0WM9T5tFjDIqRGawKcIWjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hmOud5m1Sys3ZbTVWvDLH3V3m0RYDac/VMmvlzuKOpUFVThxM9d66icG4REDhsESI
	 VkbmzLvsCDD4IkwZyColJ4DMXhsDF/wQCixhdKvmY3cSyt3UhjBF/u2VaT/I3PeGZF
	 N7E+Oo5g53zikjg8t6V6ZXsvopctc4u79C51eB/ZuqqChDZ41cphS5bcgW3G9T3OZd
	 v2srl5wPazMKelBV/jMiqY9X1jjFk0iho1+sUukEBFmpNXl1eKbDlSvCPaW6KpETE9
	 p5QqvR65F9sbstCc5R7yBPIvZZQs+EolG8UszOEiTDpRu9tLd8NSeXiCtxMW004ZhA
	 pMdmD5HqKfAJg==
Date: Wed, 28 Oct 2026 21:11:21 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sh: mm: replace the page size bits in pte_mkhuge()
Message-ID: <auJI2blzfpFD9yLe@kernel.org>
References: <20260926183904.76186-1-kmehltretter@gmail.com>
 <20260926183904.76186-2-kmehltretter@gmail.com>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926183904.76186-2-kmehltretter@gmail.com>

On Sat, Sep 26, 2026 at 08:39:03PM +0200, Karl Mehltretter wrote:
> pte_mkhuge() ORs _PAGE_SZHUGE into a PTE that already carries the base
> page size from _PAGE_FLAGS_HARD, which every PAGE_* protection
> includes. The PTEL size field is an encoding, not a set of flags: on
> SH-4 with 4 KiB pages and 64 KiB huge pages, _PAGE_SZ0 | _PAGE_SZ1
> selects a 1 MiB page. Every hugetlb mapping is therefore loaded into
> the UTLB as a 1 MiB page whose physical base is the huge page's address
> rounded down to 1 MiB, so user accesses land in unrelated kernel
> memory.
> 
> In a QEMU r2d guest, after touching a MAP_HUGETLB mapping at
> 0x30000000, QEMU's "info tlb" shows
> 
>   vpn=c0000 ppn=32e00 sz=3 size=1048576
> 
> and writing the two huge pages overwrites kernel data, for example
> page tables ("bad pgd 5a5a5a5a" on munmap) or a struct file:
> 
>   Fault in unaligned fixup: 0000 [#1]
>   PC is at file_tty_write.isra.0+0x24/0x220
>   R1  : 5a5a5a5a
> 
> The SH-X2 extended size field has the same problem: a 4 KiB base page
> (ESZ0) combined with 64 KiB huge pages (ESZ2) encodes 256 KiB. Only the
> configurations whose huge size encoding happens to contain the base
> encoding, such as 1 MiB over 4 KiB on SH-4, have worked.
> 
> Clear the size field before setting the huge page size. All hugetlb
> PTE constructors, including huge_pte_modify() on mprotect() and the
> fork/COW paths, go through arch_make_huge_pte() and so pte_mkhuge().
> With this change the same entry is loaded as
> 
>   vpn=c0000 ppn=32e00 sz=2 size=65536
> 
> and the mappings read back correctly after mprotect() and fork()/COW.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

This implies nobody ever used hugetlb on sh-4, doesn't it?

> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  arch/sh/include/asm/pgtable_32.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

-- 
Sincerely yours,
Mike.
