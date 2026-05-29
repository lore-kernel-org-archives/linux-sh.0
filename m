Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B683CF05E;
	Fri, 29 May 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066099; cv=none; b=qVNCD+0fF+Smzx0zgp/oQTk1cQZApN2F3oO9x7yWNI2oGBp2nbtiTf2T1PGt8wL/Nc7Km6bl7PZUxdgchAc8DlB6aKe8aiOQPbsFaEq5px3L7mP0iSh78S1GQ/xxnwJEL3wAamGzTSqs8GHScinl4QXrUxsPD1tNLJw0+kB4hnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066099; c=relaxed/simple;
	bh=Vt4dJgQnYhshfJc1Hy1ScnUQdOl8XkansT2PFgaL1M8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BpPNXFyYiSDvrR/oMuPZZDwSxQRBLa/X6VbD612xRfM76Hg5IdeaqqoiPLBGhVIP+Z8rMfy50uJsLoDTDzAwjPw5uInLnXsYfsIAA/YoUD+xh/4vioKVa3jIbY4o2Li/IU1fehInDtuTzK4qWlEtSBY3K5T6XLUHdPZtsURsa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/D6PTyn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/D6PTyn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C111F00898;
	Fri, 29 May 2026 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780066096;
	bh=rDYAlmQq2lyT0mKI/5jPVDdXiqH331Ok6KPFJGIkolA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=B/D6PTynJnQoiv5UGY84Nxeys2XekviBCPy1tBM1oZoNcAiD64YXYcPbgM6mQ8r6j
	 Ju1Yszpm1IU+sDUTCsAHUupVz3c6LFjjSOxh6ZgC+NNKAcUYs7+WXyb6WLpp38882V
	 h2KchIcNii6iBq1jm/M4xT08IolsroFxcQsYL7a/wkIBzBe1a7g9hGS9ZqQj7KYG1N
	 gQICg8IZifWWVQJXVlRM4Zpy+QJTLsQSROGx1qugSXXGuszEK6z9AyhrrYMyAcRPUP
	 m6Q9q7gzhRbAGekyaQeeeXxToVJmDdYGA95NTpiDs/C+zVHTNTz9OvRjzaO6OL4R9a
	 qDAyOY9RfsG7A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9B26AF4006B;
	Fri, 29 May 2026 10:48:15 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Fri, 29 May 2026 10:48:15 -0400
X-ME-Sender: <xms:L6cZalvqhsB-aHhaRkze_h7UY2ABhSZeFnZ60Q3_IKMDCODR4iuKzA>
    <xme:L6cZapRecgER7059-g_h5SmbR74_rDZdbLKHp8wKImrL7GCvJSuQ-czyG9PRHVNgX
    LodoT-OBe61zEkLfQ414HQKZYu3vF8l4Y7Vj5axhKW3qvVV9XuVlw0>
X-ME-Proxy-Cause: dmFkZTGt+msDe027/QMow7WM2h4XBrXubrUHHx9XVuKXNuewjeECntXEkvpZpwjkpuwWEv
    A+IG7AeFN5owfWzwbPO9CjcB7TRAAsY44WxF7zXFXy6LoVGUAKFH2Bx1eeqBPzIerpvVjv
    ELx4NQx0XG6whtq/UTw90jigQlW4j18Zh0Zt1+paIGSTOJ9ku9oHpPkPFvh0lxBxqNkgBT
    FnRPsw9ol+7BaTbq+VC3GgNlb/hfOhjgLaPfDPKB8smIObxRKijH1R3rHFi8eHD+NkkdLJ
    A7LUeOTltjqUyU3MM5Wv53HhVF64Qimbf03q9/pBfm6OGXhfkEoLOeymapiGYXWuW7kwNp
    ckYNzIG87pXFDqxBpRSEjOxQSObcP/T++yyH1GkG3YItNvgZi8BW7YZJf0oLK1Eiu9ctpj
    e/Qrzm63c6EjvCPOKuUOldqVtQ9ZHP5SjAUyNeaZsq8FP10znmcrDkJjKhmkqvgalMjmqj
    5yI6GJ6yQK3gJ/0sFlH1xfNMM7hLe/tXPVaeY8cRX+7fv6nhbeMCau2aQ4gfKKOCQInygr
    DX9MXYrq5o/uY7i19kTROhADx/RRu9bkIc+kVBeOktIvcQ1AMx9acT0YqOTPMhDzC2jr7R
    qbv5MzK1kh98MwYu6S2aUc5FDL3Tal9kQVrQ86RuzLjlmuBz9HkOhgZjLFug
X-ME-Proxy: <xmx:L6cZanX74O-bar_jLvxjWKCnp-Ih7O5QrV09suBOhbCd2rIrR9xQeA>
    <xmx:L6cZamrF7UpYic3Pul9sEvDf0nlILb6aAYq-n3JKJgUil7UpBZORtQ>
    <xmx:L6cZarFrHHphMz_k0i3sOdMq0fdtjxTfs29QHz9bIdolxCo5oEEGVA>
    <xmx:L6cZaouUFRbFWAprH-4qWiANOmu1DUXbhNuFie1nlzyqPUFP98ZCWQ>
    <xmx:L6cZauQug8MFn_HvWRIXz9IpPD4mlQQP6iSw5xCI5jVhcTfQZiXZW5o_>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 780D8182007A; Fri, 29 May 2026 10:48:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 29 May 2026 16:47:54 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Kevin Brodsky" <kevin.brodsky@arm.com>,
 "Ard Biesheuvel" <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Liz Prucka" <lizprucka@google.com>, "Seth Jenkins" <sethjenkins@google.com>,
 "Kees Cook" <kees@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
 "David Hildenbrand" <david@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Jann Horn" <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Message-Id: <feab72b8-2961-4145-ac5c-80e820bf1ce9@app.fastmail.com>
In-Reply-To: <b76b327f-612e-494f-b8d3-44108aa73d2a@arm.com>
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-26-ardb+git@google.com>
 <2a6f9f05-ac57-4ef8-9328-74cc8ccfea16@arm.com>
 <96a8b6b9-71f2-4550-bbbb-fbfa146f4e6a@app.fastmail.com>
 <b76b327f-612e-494f-b8d3-44108aa73d2a@arm.com>
Subject: Re: [PATCH v6 09/15] arm64: Move fixmap and kasan page tables to end of kernel
 image
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026, at 16:42, Kevin Brodsky wrote:
> On 29/05/2026 13:19, Ard Biesheuvel wrote:
>> On Fri, 29 May 2026, at 10:27, Kevin Brodsky wrote:
>>> On 26/05/2026 19:58, Ard Biesheuvel wrote:
>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>
>>>> Move the fixmap and kasan page tables out of the BSS section, and place
>>>> them at the end of the image, right before the init_pg_dir section where
>>>> some of the other statically allocated page tables live.
>>>>
>>>> These page tables are currently the only data objects in vmlinux that
>>>> are meant to be accessed via the kernel image's linear alias, and so
>>>> placing them together allows the remainder of the data/bss section to be
>>>> remapped read-only or unmapped entirely.
>>>>
>>>> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>> ---
>>>>  arch/arm64/include/asm/mmu.h    | 2 ++
>>>>  arch/arm64/kernel/vmlinux.lds.S | 8 +++++++-
>>>>  arch/arm64/mm/fixmap.c          | 6 +++---
>>>>  arch/arm64/mm/kasan_init.c      | 2 +-
>>>>  4 files changed, 13 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>>>> index 5e1211c540ab..fb95754f2876 100644
>>>> --- a/arch/arm64/include/asm/mmu.h
>>>> +++ b/arch/arm64/include/asm/mmu.h
>>>> @@ -13,6 +13,8 @@
>>>>  
>>>>  #ifndef __ASSEMBLER__
>>>>  
>>>> +#define __pgtbl_bss __section(".pgdir.bss") __aligned(PAGE_SIZE)
>>>> +
>>>>  #include <linux/refcount.h>
>>>>  #include <asm/cpufeature.h>
>>>>  
>>>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>>>> index e1ac876200a3..2b0ebfb30c63 100644
>>>> --- a/arch/arm64/kernel/vmlinux.lds.S
>>>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>>>> @@ -349,9 +349,15 @@ SECTIONS
>>>>  	_edata = .;
>>>>  
>>>>  	/* start of zero-init region */
>>>> -	BSS_SECTION(SBSS_ALIGN, 0, 0)
>>>> +	BSS_SECTION(SBSS_ALIGN, 0, PAGE_SIZE)
>>>>  	__pi___bss_start = __bss_start;
>>>>  
>>>> +	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
>>>> +	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {
>>> Do we actually need the NOLOAD type here?
>> Yes, otherwise it is emitted as PROGBITS, resulting in all of BSS to be
>> emitted into Image.
>
> That's rather strange, aren't the .pgdir.bss input sections already
> NOBITS since __pgtbl_bss is only used on default-initialised globals?

Not sure why, but the section was PROGBITS not NOBITS before I added the (NOLOAD)

> Also AFAIU NOLOAD does not prevent the output section from being emitted
> into the ELF file.
>

NOLOAD marks it as NOBITS, which means there is no data in the file that should
be used to populate the section in memory.

