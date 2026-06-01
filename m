Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3C03876A7;
	Mon,  1 Jun 2026 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303036; cv=none; b=IBHE6ASiy9HPVM853jL4eNotcV4BJnvuKLszQeR6oJnT1EAFQ2J/csBlQCp6TD9qYk756pW0voVcJ9rTZgOqv09eHi3nSpPOVvK3vnyAWdP8ZHQr08xc+S9K9dSGczg+xzaVgt65AkiTBRVaM1rLK9yiSHl0Z0mCDazA9c3SNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303036; c=relaxed/simple;
	bh=KhZVl+Vwqx0OaCH6S7jXIByk6u8k8lh7Uhiuy+3SVi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTQHCBX3eBd66D02VNZEJcJnH5As6yDDcbntCroA+PIzUHNQ7Blj4e+y8erM40LCSmNcMNehDrzmoy55poW9xubfL7fcDo0c7viQSxDfDDS8VPblC7PJaIKnY2jGCgNuXEtHVWnjb32fBXmLltKcHnzROE2ciN8Fv3t3MK+HoxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PZxls1oX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PZxls1oX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6BEF1E8D;
	Mon,  1 Jun 2026 01:37:07 -0700 (PDT)
Received: from [10.57.94.8] (unknown [10.57.94.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 367EE3F93E;
	Mon,  1 Jun 2026 01:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780303032; bh=KhZVl+Vwqx0OaCH6S7jXIByk6u8k8lh7Uhiuy+3SVi0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PZxls1oXIsr6hApf9XohwV3WTI1Qo/Er1dviSU6itCMJmAKDxMZHODtjuGAfErgJl
	 6867qR2HsryNZcylx+G0a/AX10BCLvlvPK4pBvuCBYe/sz6hhDG0C2A1TIs2eBczWC
	 E1gn7G1PE54lFFInYxUKOqbSvwpx/gKLHzFd0Yb4=
Message-ID: <69488547-cf2a-4aa0-bca7-0cb65aa01914@arm.com>
Date: Mon, 1 Jun 2026 10:37:03 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/15] arm64: Move fixmap and kasan page tables to end
 of kernel image
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
 <20260526175846.2694125-26-ardb+git@google.com>
 <2a6f9f05-ac57-4ef8-9328-74cc8ccfea16@arm.com>
 <96a8b6b9-71f2-4550-bbbb-fbfa146f4e6a@app.fastmail.com>
 <b76b327f-612e-494f-b8d3-44108aa73d2a@arm.com>
 <feab72b8-2961-4145-ac5c-80e820bf1ce9@app.fastmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <feab72b8-2961-4145-ac5c-80e820bf1ce9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/05/2026 16:47, Ard Biesheuvel wrote:
>>>>> +	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
>>>>> +	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {
>>>> Do we actually need the NOLOAD type here?
>>> Yes, otherwise it is emitted as PROGBITS, resulting in all of BSS to be
>>> emitted into Image.
>> That's rather strange, aren't the .pgdir.bss input sections already
>> NOBITS since __pgtbl_bss is only used on default-initialised globals?
> Not sure why, but the section was PROGBITS not NOBITS before I added the (NOLOAD)

I've had a closer look into this. Similar sections in other
architectures are all named .bss..<something>. If I rename this section
to .bss..pgdir, then indeed the compiler does emit an object file with
that section marked NOBITS:

$ readelf -e out/arch/arm64/mm/fixmap.o | grep bss
  [ 4] .bss              NOBITS          0000000000000000 0002ac 000000
00  WA  0   0  1
  [18] .bss..pgdir       NOBITS          0000000000000000 000750 005000
00  WA  0   0 4096

And then the linker does the right thing without having to use NOLOAD.

I was concerned that .bss..pgdir might get caught by BSS_SECTION(), but
it seems that the double dots are meant to prevent exactly that.

- Kevin
