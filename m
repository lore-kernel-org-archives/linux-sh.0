Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA603BADA7;
	Fri, 29 May 2026 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044566; cv=none; b=E6F8KCzhW7PirrpN2wxM5ZQPwpkINDbSEdEYgeMU7KcZTz3wmHmn/l3rcjO3pZSAL4Y9UfpSQaOVqBEBKFbB4M9f8n3W244pwzO3HHcoEX43ITCUu6RJfuHZc/6aamj/eqoWNlFKnaSVN0J/CTeV70oD+Rf4a+ev64kudZIGKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044566; c=relaxed/simple;
	bh=0Yr74bm5b1I6er6TsjOHvM8O63leqKbgA8DFDU1A6jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwRqJg/RnHH7QD/tFPrAo9RSEZyv35ajZXzRxL2Up4HstwsTGUbNGRqf5Ss5st4B3TeZmMu1kTz7zeEfj5st3jQN/SuM2CWK9RFP0cIIo8GpgeTKq+7MvrVktV8suKvtpjMhRIvnDkk5S7uJGhFgH80fY21/UfT53cJ0Em/KtQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ivprReKs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ivprReKs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20A2E204C;
	Fri, 29 May 2026 01:49:19 -0700 (PDT)
Received: from [10.57.91.162] (unknown [10.57.91.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 430AC3F632;
	Fri, 29 May 2026 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780044564; bh=0Yr74bm5b1I6er6TsjOHvM8O63leqKbgA8DFDU1A6jw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ivprReKsUadaCcTb8g0Y6fux7oLRv4zPPNFSi1TEM201qLpgF3A20EQN4tJDBDtM3
	 S0nbog1ouGDatXNHMgkBAd+V9ATrxI5QR8icYHXBy454uuQh3yuqWKsVaGy/XI47P3
	 ZKILKdQnLDYLJUH2p/YTF/kixb3dzjPrfQvx+zsA=
Message-ID: <32458c49-0e3c-4d27-b1cf-0e2d7ee0273d@arm.com>
Date: Fri, 29 May 2026 10:49:17 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/15] arm64: mm: Unmap kernel data/bss entirely from
 the linear map
To: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-32-ardb+git@google.com>
 <22042b98-cfcc-428e-bb08-ebcfe785eb69@arm.com>
 <8082b77d-6522-472a-9030-317087ecd7e9@app.fastmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <8082b77d-6522-472a-9030-317087ecd7e9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/05/2026 10:34, Ard Biesheuvel wrote:
> On Fri, 29 May 2026, at 10:29, Kevin Brodsky wrote:
>> On 26/05/2026 19:59, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> The linear aliases of the kernel text and rodata are mapped read-only in
>>> the linear map as well. Given that the contents of these regions are
>>> mostly identical to the version in the loadable image, mapping them
>>> read-only and leaving their contents visible is a reasonable hardening
>>> measure.
>>>
>>> Data and bss, however, are now also mapped read-only but the contents of
>>> these regions are more likely to contain data that we'd rather not leak.
>>> So let's unmap these entirely in the linear map when the kernel is
>>> running normally.
>>>
>>> When going into hibernation or waking up from it, these regions need to
>>> be mapped, so map the region initially, and toggle the valid bit so
>>> map/unmap the region as needed. (While the hibernation snapshot logic
>>> seems able to map inaccessible pages as needed, it currently disregards
>>> non-present pages entirely.)
>> I'm not sure I understand this, is there something wrong with the
>> kernel_page_present() check in safe_copy_page()?
>>
> No. If the hibernate code decides to snapshot a page and it is not mapped,
> safe_copy_page() will do the right thing and map it on demand.
>
> The problem is that pages belonging to the kernel image are marked as
> PageReserved, and so the hibernation logic will not even consider the
> pages for snapshotting if they are not mapped.

Right I see the check in saveable_page() now. Maybe it would be worth
spelling it out in the commit message (hibernation logic ignores
non-present Reserved pages).

- Kevin
