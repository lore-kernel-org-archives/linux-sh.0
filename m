Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2031DEFF3;
	Tue, 28 Jan 2025 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056343; cv=none; b=gJvESsp6UoQ3r1P9vQl4BYnhHnDGNuasqvQBvSVEn9XvAjxAdhmOTqlEaMX76dtste08Zf0cRbUEtcNovRa2cfCUWYFZwvQguXOF94XxoCJcTAH3q2V8bcsDJQnNHD0ng79v7oqmGRelUBx0KT74PX+nIVYurX8rs3Vw3sVmlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056343; c=relaxed/simple;
	bh=pYu7rJ7KeQY/ttVAyeuBW4B3UYcO0uYC0VcBhjCwR3Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ip+lpoB58Ry70QOOiQiCAER6eDw9yISHPa2STymyfxAGwEmZDeHfLmFogR80T551tp0804IU/UTJa/FsJY5sy7Wa3WdFgXVhj0yV7lTfa9pPyB4jZSG2yJXDolFJ0TtDg2icCblVVEYJxd1vcIzB4HS56cNTNxDxQ3nhytlJPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=8xZifekj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dtqLPl+a; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="8xZifekj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dtqLPl+a"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id DEA3511401E0;
	Tue, 28 Jan 2025 04:25:39 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 28 Jan 2025 04:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738056339;
	 x=1738142739; bh=olMOIybAEgAUxXho6ysS2GqLBN/k14SWcCl8uSNASdQ=; b=
	8xZifekj0ovi/5Wx6yh15z59EO0+Ja/OXgeZVGxjomx5SoKw1yN3YH7MbhrKiAid
	2RQriY5WuQFO8rG9gvKYjtSGceRq4QeqTlScoAn7BHEbJygOLU/I9mPG09PpfCOH
	yyutg2FDOC8YCwmKmDeZMiCZIm1gONoWH9d5JqwxtJK81NosIByGf0OpwrvMOkar
	TZA8UTJsNkrSmA99hx8oFXv/hJooul/iWtNN1a3Vl7IwfMjSc3K9nSK3PmzkWVA7
	4E9dkS87GyW6wzxPn5ngVMdQV6Kwv3eGIEaYx+SzqaLg5L8xLYFjEBhIDhp4Cufq
	HOhWTUb25QlhSNamyakbUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738056339; x=
	1738142739; bh=olMOIybAEgAUxXho6ysS2GqLBN/k14SWcCl8uSNASdQ=; b=d
	tqLPl+aj0oqlS88WFtKXoDY39WoFXyBNPJ/hcFHEO4AxzTw697zKv6qrW6qDEKxl
	ATmvcjgNACr+dHo76MebQ799HCDBR/YSVVN8qqEfwBASHCA2eMpuIlEoR/haCJ2l
	eiDpWVA44AocUgaRHUwl/7RzBTrlzN8bbEVGAQKiKkGhchX5Pk4Pk95ovmyV1gBX
	NXKi8J1KHmjYnIalXJ+epbKXDJ9SbxqnRQpmCS+jw+TmQVeJ0RK1Otqy8IjLM7ve
	AXNGHAKOh277lTdCy2r4f8UX+ZrQ4C9pc8sAPG8X0RHInb2hT8CoTQIywFSabIuq
	KK8B/j5qtS2egm8gUhyeA==
X-ME-Sender: <xms:kqKYZ1dLyASOMGYTtYJQCdYQoXb-RPdYtHS-i2rSoNAvHFZwSVoZLw>
    <xme:kqKYZzNaIitNqp5oOiZDZRsw1iAAS6GReT6PwJ4wlYUyhWI1Lt9b_SZJfwDFipMrV
    U0LcmyGnhz5Vm-ohdo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrlhhirghssehlihgstgdroh
    hrghdprhgtphhtthhopehjuhhlihgrnhesohhuthgvrhdqlhhimhhithhsrdhorhhgpdhr
    tghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpd
    hrtghpthhtohephihsrghtohesuhhsvghrshdrshhouhhrtggvfhhorhhgvgdrjhhppdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqshhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:k6KYZ-iRDpPgTKm9TP20CgE3ZFeP3hYksGWGNfM1OtzBgutnD8_7iA>
    <xmx:k6KYZ-_7DatHlOol7iyYwgshTP0HPc2zuDTvVA8e-ndq4qnKXNsCsg>
    <xmx:k6KYZxvD5CMZqXKa_x6v1ekMXfKv6ppMyY36BXyRFlT0amUAfWAzDw>
    <xmx:k6KYZ9Hwe5fUPijWMUvwfNXli_3RGQp-AI_-UDcelUg6oVI9IA_3ZQ>
    <xmx:k6KYZ_XZPni164tUAxbYo0f07S61qrzth5ZcRc2hhD4epWPPr_qC0YBa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C583F2220073; Tue, 28 Jan 2025 04:25:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 28 Jan 2025 10:25:18 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Vetter" <julian@outer-limits.org>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ffe019a1-11b4-4ad7-bbe2-8ef3e01ffeb0@app.fastmail.com>
In-Reply-To: <20250128084254.1408815-1-julian@outer-limits.org>
References: <20250128084254.1408815-1-julian@outer-limits.org>
Subject: Re: [PATCH] sh: Remove IO memcpy and memset from sh code
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jan 28, 2025, at 09:42, Julian Vetter wrote:
> Remove IO memcpy and memset from sh specific code and fall back to the
> new implementation from lib/iomem_copy.c. It uses word accesses if the
> buffers are aligned and only falls back to byte accesses for potentially
> unaligned parts of a buffer. Keep only the SH4 optimized memcpy_fromio.
>
> Signed-off-by: Julian Vetter <julian@outer-limits.org>

This looks good in pinciple, but I see one mistake:

> +#ifdef CONFIG_CPU_SH4
> +void memcpy_fromio(void *to, const volatile void __iomem *from, size_t 
> count)
>  {
>  	/*
>  	 * Would it be worthwhile doing byte and long transfers first
>  	 * to try and get aligned?
>  	 */
> -#ifdef CONFIG_CPU_SH4
>  	if ((count >= 0x20) &&
>  	     (((u32)to & 0x1f) == 0) && (((u32)from & 0x3) == 0)) {
>  		int tmp2, tmp3, tmp4, tmp5, tmp6;
> @@ -53,59 +50,6 @@ void memcpy_fromio(void *to, const volatile void 
> __iomem *from, unsigned long co
>  			: "7"(from), "0" (to), "1" (count)
>  			: "r0", "r7", "t", "memory");
>  	}
> -#endif
> -
> -	if ((((u32)to | (u32)from) & 0x3) == 0) {
> -		for (; count > 3; count -= 4) {
> -			*(u32 *)to = *(volatile u32 *)from;
> -			to += 4;
> -			from += 4;
> -		}
> -	}
> -

The SH4 version still needs the bottom of the function to
handle data that is not a multiple of 32 bytes long.

I would expect gcc to produce a properly optimized
version for sh4 from the generic code as well, so I would
suggest you remove it entirely and rely on the common code
here.

     Arnd
