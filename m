Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBC3C81BF;
	Wed,  3 Jun 2026 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485746; cv=none; b=lOHTWICAOv1beRDjocueOYVlajzB1XyvIUyPeFA37j97ePd0LCnSMRuz8/jv6S0Ks9FWHjiKNAL2QJ5LgGGbDVZKzDUkNII4GdEsDGtfEZmRD/zZyEC7LhMkYvOljWZJQ54mqz6p7QdInFwO2vSnXLBKhZ2UTa4/AwJCrAsDiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485746; c=relaxed/simple;
	bh=o3u8ifBd5fFIRMVaCkuobP4gQ0c0YAFDVzqVNxVU1Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZLbLa0T885OhNJiG4iG/Dip6RKPaOLSpZenCCK1TalikP5D5Kf+zZUpwQwE3+PzZHGPx9rKPuDj3xjoUXXAcmuT+rklxiC8LV8dnk+S+85Du4iHEq4gDVlzP0qCQrRPo6HtmC+3s7hvT/O6UtrsqEDlTshOBSt/yhsM9tEdiig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOUzc5Op; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOUzc5Op"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB941F00893;
	Wed,  3 Jun 2026 11:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780485745;
	bh=cXEjc/5hFRDYA1JmIf1Nf0sHw2o3MsqDWZosJ8VPs34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nOUzc5Op+hlkXIq555+AjTA9AOIZ7Z/YhcVbMSB4YwqOyXHfvGEboKFwb1vMLFt7z
	 rgKJtmrr9RSDpWZVJgclHeFWHWqp6QeZ+OTN48bM6NozoU4da0Hk9Gt2Y/JcudJEq2
	 GUczLX4n71GwBEEel4mmlmoZUS9yEwOF0baAxVKlshP+xIZDOeW+gOltyQf0EeJOxa
	 v1kSlqwBO+BJhMb/5PBSK1Cte2N6RJllzVJUPROBTzHF2O2Db4t8JgXrZllrcxfwyR
	 iQ0iWfIYE/MAD2Xc8q8C2xQaw0gMJu5BOUJL2/LSuVWBwP1A5hpdzljfWlbC8DcGez
	 f+NxByEYGWbkg==
Date: Wed, 3 Jun 2026 12:22:17 +0100
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb+git@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, maz@kernel.org
Subject: Re: [PATCH v7 00/15] arm64: Unmap linear alias of kernel data/bss
Message-ID: <aiAOaYwPlGEG6FML@willie-the-truck>
References: <20260529150150.1670604-17-ardb+git@google.com>
 <178041415770.4024555.11336437584927054639.b4-ty@kernel.org>
 <2c7929d4-6622-475d-af1b-bcd0cd997cd3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c7929d4-6622-475d-af1b-bcd0cd997cd3@app.fastmail.com>

On Wed, Jun 03, 2026 at 10:57:49AM +0200, Ard Biesheuvel wrote:
> (cc Marc)
> 
> On Tue, 2 Jun 2026, at 22:34, Will Deacon wrote:
> > On Fri, 29 May 2026 17:01:51 +0200, Ard Biesheuvel wrote:
> >> One of the reasons the lack of randomization of the linear map on arm64
> >> is considered problematic is the fact that bootloaders adhering to the
> >> original arm64 boot protocol (i.e., a substantial fraction of all
> >> Android phones) may place the kernel at the base of DRAM, and therefore
> >> at the base of the non-randomized linear map. This puts a writable alias
> >> of the kernel's data and bss regions at a predictable location, removing
> >> the need for an attacker to guess where KASLR mapped the kernel.
> >> 
> >> [...]
> >
> > It would've been nice to hear from the ppc folks on patch 11, but I've
> > picked it up on the assumption that they'll love the negative diff stat.
> > Worst case, we can drop/revert stuff if they have late objections.
> >
> 
> Thanks.
> 
> There is a de facto ack from Michael Ellerman in the Link:, which is why
> I included it.
> 
> Note that Sashiko found an issue with KVM+MTE, where a read-only mapping
> of the zero page in the linear map may result in issues:
> 
> """
> Does moving the zero page to .rodata (or unmapping/read-only mapping its
> linear alias) expose a guest-to-host denial of service with KVM and MTE?
> When an MTE-enabled KVM guest reads an unmapped memory address, KVM handles
> the stage-2 fault by mapping the host's shared zero page. KVM will then
> call sanitise_mte_tags() in arch/arm64/kvm/mmu.c.
> Since the PG_mte_tagged flag is never set on the zero page, KVM's
> try_page_mte_tagging() succeeds, and it calls mte_clear_page_tags().
> This executes the STGM instruction using the zero page's linear map alias.
> If this alias is read-only or unmapped, won't the STGM instruction trigger
> a synchronous permission fault or translation fault in EL1, causing a host
> kernel panic?
> """
> 
> Marc seems to think it is legit, so I came up with the following (I'll send
> it out separately with another pair of tweaks):

Thanks, it also looks like we're getting some early WARN_ON()s firing in
CI from split_kernel_leaf_mapping() after applying your changes:

https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/2571596185/test_aarch64/14662134813/artifacts/jobwatch/logs/recipes/21399931/tasks/219104268/results/1007729692/logs/journalctl.log

Will
