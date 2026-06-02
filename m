Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607913403F8;
	Tue,  2 Jun 2026 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432491; cv=none; b=trB99rVyn2z+NUgBRurdOrsJh2Vrf84m6/7RE2c+ucH9fxrvZrG9mcUTTiakHrMXZ8JU/rS1GoPln9wGZrsgltRaTj+GCk6Q5+aFGALLOUldvdJxMsfFYhO4f1WxZ6s+H9G89hilv2tl5YwQ7ZEqnB/RJLNP5ePLC3Jw+ZGiqKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432491; c=relaxed/simple;
	bh=z2/CwMmdEu8nK/R+4KV2Eu57q8EkVOD08lpnXMmV3OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XB1PdZl2OAKHJI7CnqkqQSH/5HP8PSDOCqSZqWC78Jac6zuX4X1owFyZEXcwTNe3hQikrtVJBmQvA0Wt7rtV3rEhBtERW/sYBYy9EgvHoAetAbV848Qbeyf06Y07cxGYK6AFw/iJ/4WN/s/f3K/ygOY5hbj9fDQedDIq6r8FN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxfxWfdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxfxWfdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1437C1F00893;
	Tue,  2 Jun 2026 20:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780432490;
	bh=S//fEDteJ4rzTnDBScY4eGHQWJlVMyyy6h7anmp3x+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZxfxWfdMQ3+Vq+Ma03V2QSXlB3XRJ2M5Did8lMtEII0G+3I0Mn+KoGSxk5Mbv0z3I
	 eSifAuVTOlBV98gSsIUbmj8ujq+U/KmlZ/dQP7pUzZjY04CU58Y+sgkwr1wg6evnYM
	 IVoXvJxep7VzxPFXOGANf1mU6ye3Mafv+WmYKvzi7at8qUa+iZFeY7zqiUxCEvZFM/
	 fjusegJTSCUmjBP7CA/qHQtB8wTK8Jc4dadNTvYGMtjatVjBZN4rZEnYKHGBQHPrCt
	 j6I3SYxIA9f1IMqxFo73y3NYXAPu3pvvOvODplkrV/iUNmLrtqWvgusvQ/0MXkcYQw
	 RZn0bqJ/It5Ww==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb+git@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>,
	Kees Cook <kees@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH v7 00/15] arm64: Unmap linear alias of kernel data/bss
Date: Tue,  2 Jun 2026 21:34:36 +0100
Message-ID: <178041415770.4024555.11336437584927054639.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
References: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 29 May 2026 17:01:51 +0200, Ard Biesheuvel wrote:
> One of the reasons the lack of randomization of the linear map on arm64
> is considered problematic is the fact that bootloaders adhering to the
> original arm64 boot protocol (i.e., a substantial fraction of all
> Android phones) may place the kernel at the base of DRAM, and therefore
> at the base of the non-randomized linear map. This puts a writable alias
> of the kernel's data and bss regions at a predictable location, removing
> the need for an attacker to guess where KASLR mapped the kernel.
> 
> [...]

It would've been nice to hear from the ppc folks on patch 11, but I've
picked it up on the assumption that they'll love the negative diff stat.
Worst case, we can drop/revert stuff if they have late objections.

Applied to arm64 (for-next/mm), thanks!

[01/15] arm64: mm: Remove bogus stop condition from map_mem() loop
        https://git.kernel.org/arm64/c/36ca7f4be809
[02/15] arm64: mm: Drop redundant pgd_t* argument from map_mem()
        https://git.kernel.org/arm64/c/2e527667a3b9
[03/15] arm64: mm: Check for pud_/pmd_set_huge() failures on kernel mappings
        https://git.kernel.org/arm64/c/8dd640d9233d
[04/15] arm64: mm: Preserve existing table mappings when mapping DRAM
        https://git.kernel.org/arm64/c/a64293e993f6
[05/15] arm64: mm: Preserve non-contiguous descriptors when mapping DRAM
        https://git.kernel.org/arm64/c/ecda73ae92ca
[06/15] arm64: mm: Permit contiguous descriptors to be manipulated
        https://git.kernel.org/arm64/c/05c5c31e9d8d
[07/15] arm64: kfence: Avoid NOMAP tricks when mapping the early pool
        https://git.kernel.org/arm64/c/dfd73e574d38
[08/15] arm64: mm: Permit contiguous attribute for preliminary mappings
        https://git.kernel.org/arm64/c/28becb2c1d74
[09/15] arm64: Move fixmap and kasan page tables to end of kernel image
        https://git.kernel.org/arm64/c/382a03e12eba
[10/15] arm64: mm: Don't abuse memblock NOMAP to check for overlaps
        https://git.kernel.org/arm64/c/d672a4b72c95
[11/15] powerpc/code-patching: Avoid r/w mapping of the zero page
        https://git.kernel.org/arm64/c/c0693153fb17
[12/15] sh: Drop cache flush of the zero page at boot
        https://git.kernel.org/arm64/c/99bad3e992e2
[13/15] mm: Make empty_zero_page[] const
        https://git.kernel.org/arm64/c/0aae825f1ed7
[14/15] arm64: mm: Map the kernel data/bss read-only in the linear map
        https://git.kernel.org/arm64/c/f2ba877402e5
[15/15] arm64: mm: Unmap kernel data/bss entirely from the linear map
        https://git.kernel.org/arm64/c/63e0b6a5b693

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
