Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8772B358368;
	Mon,  1 Jun 2026 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303181; cv=none; b=sdu+U/MdKI5OlDukduZSBpcJGddb1G7fsPEGyf5MW2gXmo4A0o1OdKjHLqajzZBVHVgdk2knR30POS8q1svdN1eToc/F5zAnE9fZ6oqFQF0IP82Dhg1G3rjdpunWVL8MlxdpDx2qdfwxFHYS0PXE2lnj6bRQHg29MK+p5SlnXZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303181; c=relaxed/simple;
	bh=yB2zC4W1tMjrjLnHIuQhUA5cVWwiKkZsHU3BlKkjJvA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RPYRY9GzQ5+rhY2nKl4QvjB1JyV6fG6lmWlxbYLgiBPXBeEHPTofaSznr3I46wddY5L6RRfVmJMCK5NLdeooeHScd4OD6c8pWcKopVFKm0SunNMP8lTdyjpgrSFO4NDjEZFf2wic+Lpm9OLyem8fEFd6C25SwCUPLntKYUfc9gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIajcTU1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIajcTU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323671F00898;
	Mon,  1 Jun 2026 08:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780303179;
	bh=mHwvm0ceQ16bc0KPGoKmLlizlFpB9HdRz+GeUdDPkMs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=BIajcTU16E6+znd1woyWqwS+BBAXycYib81QTECMvG/hOX7aZ/uAFzUwcG45xTfmE
	 tf9W8LCSvBW58JUM8ZTWSrrXbLk0LG/A9CbVmZDLsUnNcIKGjoSFHcopw37zuAQt6y
	 RIY9JP+XwgZ5srpA1V/U8jYqz9skUUFQEayYx+3cQ8cSBbgYMpZL7YB6RZ+WvHuKNl
	 xobhQrpcyjJAAEcf6rM17filotw9MPbTMYAvB8r+SlaKWN902CDEBOWqHYS62X36aE
	 PcZxo0yOoyvxuNXSnl1mzVQ0fQljIeH4pq619zUO14fnF4R5pDVaQp4lvtAdeXReT0
	 dQ8dGv2+1ro4g==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 50A6FF4007F;
	Mon,  1 Jun 2026 04:39:37 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 04:39:37 -0400
X-ME-Sender: <xms:SUUdatExvFUiJvS4G-rzO5_b5_EVmBhCXGARrlUlPj68OMh2yNTgcw>
    <xme:SUUdatLPHZy6k7_jINeuCht2x1mIk3Xr7QLvpOruxv1mcZD7GTPOuGWVZwlv6UYag
    OjFQQepcx8WzwRHCk-aGrvn_hm4_qXnHUJ8uPUX6RNK62HXeHqgHAQ>
X-ME-Proxy-Cause: dmFkZTFDC9Qzla6YzRXCvg4qTqKRR/eKrKImym43jg5ea5Q5vrrQ+EjGg3N8fUKPpOxQR7
    TVq7XrIvj0z7DAz3z9X/juKhZVusgVnRCAtCCeFytlNFAPMtvvDQ4+dCYC6Q160toXzz4S
    XcVkttubPD2UxW685/k+uwu828S96nFll5al0jdDPfemCpkea8rdrbikQF2sFrnI6Lx04Q
    ONcYXSZ7HopdtHuW9piPefNoaIy7sVQliTdskqwc8awOiZFnU9Huwjva5c/7y1USlJ5DUY
    k6FOaBFlQ2WNslwPaZEZYp/rw/tHbsVDON310YOAcdFHjy7Nk82hy9tZEWwE6x8YVDQlsz
    Er9z8/znGDaObvUGVeBIVOThm1t//PeZFcWtIXC0I8cmehM+jGn2DjoVIYSv9Bmez6tW/2
    lKEfzUiJm3ZQGRDPcgLG+ZMhTLydaOy+jpqN+Hnf2ZdB/T1FYFwgfkHnjgZvpC5CuiX6I2
    pIW+EqzFuec7aoIebcI5qyLXKhUbZEinA2uMEBOaMiyZVdD8y+gienLjiqOTf5L1gLH7gf
    t0NN2Fa2xUvmh4ar3+IiUQfv23rHvlzmcKEdNU4pTV3DTTP+Q8FlIOlCllFOZLg9GdTvDV
    f3mzdtyp9oqq0X+BVt1UaL10E9dRrpHGrvPsGXG9iqiktxH1IMmSepCxh98A
X-ME-Proxy: <xmx:SUUdaksQVW8_jeB3xtl55BBVE34hsX-8-aoaNg-2HQRD8qka9ZCW2g>
    <xmx:SUUdaojoWqOJ6zjg3Jg09dGqN7viRHsj2OkvQbp3YK0wAlvQJAV0nQ>
    <xmx:SUUdandTyZF7vDk-2CIxFnV8hVemnNQPBzQP3G9OX0GQCEEev5E94w>
    <xmx:SUUdatkneOE7eIzV7ZeRu8vDWuDJM4tccORPy20Qvw2xd6aPNz7ZQA>
    <xmx:SUUdahr7u1yNhqmOzp1lyByGwuiaShMyl1FtwhEyBnqzzuX7kRi1Uf9R>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1EE0A182007A; Mon,  1 Jun 2026 04:39:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 01 Jun 2026 10:39:16 +0200
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
Message-Id: <a371089f-0d01-45d6-84bc-1fe0d78ebd85@app.fastmail.com>
In-Reply-To: <69488547-cf2a-4aa0-bca7-0cb65aa01914@arm.com>
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-26-ardb+git@google.com>
 <2a6f9f05-ac57-4ef8-9328-74cc8ccfea16@arm.com>
 <96a8b6b9-71f2-4550-bbbb-fbfa146f4e6a@app.fastmail.com>
 <b76b327f-612e-494f-b8d3-44108aa73d2a@arm.com>
 <feab72b8-2961-4145-ac5c-80e820bf1ce9@app.fastmail.com>
 <69488547-cf2a-4aa0-bca7-0cb65aa01914@arm.com>
Subject: Re: [PATCH v6 09/15] arm64: Move fixmap and kasan page tables to end of kernel
 image
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Mon, 1 Jun 2026, at 10:37, Kevin Brodsky wrote:
> On 29/05/2026 16:47, Ard Biesheuvel wrote:
>>>>>> +	/* fixmap BSS starts here - preceding data/BSS is omitted from =
the linear map */
>>>>>> +	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {
>>>>> Do we actually need the NOLOAD type here?
>>>> Yes, otherwise it is emitted as PROGBITS, resulting in all of BSS t=
o be
>>>> emitted into Image.
>>> That's rather strange, aren't the .pgdir.bss input sections already
>>> NOBITS since __pgtbl_bss is only used on default-initialised globals?
>> Not sure why, but the section was PROGBITS not NOBITS before I added =
the (NOLOAD)
>
> I've had a closer look into this. Similar sections in other
> architectures are all named .bss..<something>. If I rename this section
> to .bss..pgdir, then indeed the compiler does emit an object file with
> that section marked NOBITS:
>
> $ readelf -e out/arch/arm64/mm/fixmap.o | grep bss
> =C2=A0 [ 4] .bss=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NOBIT=
S=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0000000000000000 0002ac 000000
> 00=C2=A0 WA=C2=A0 0=C2=A0 =C2=A00=C2=A0 1
> =C2=A0 [18] .bss..pgdir=C2=A0 =C2=A0 =C2=A0 =C2=A0NOBITS=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0000000000000000 000750 005000
> 00=C2=A0 WA=C2=A0 0=C2=A0 =C2=A00 4096
>
> And then the linker does the right thing without having to use NOLOAD.
>
> I was concerned that .bss..pgdir might get caught by BSS_SECTION(), but
> it seems that the double dots are meant to prevent exactly that.
>

Thanks for this. As Sashiko appears to be making me do a v8 anyway, I'll
rename the section to .bss..pgdir too.

