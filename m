Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3C176FCE;
	Tue,  8 Oct 2024 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379675; cv=none; b=QzkZtRDNCYJMvRgjPT5M7AdXzUSsMK3OPVtPxk9xjSEj0nEr3yYKz+ivA7lcso2WG79X+3g2oJKhEdFGsrGJivYAjqwe56qihNFIGUgeYc6gItFauIbKjxNL2+qhoJ6hhCOhwJrjabnbsXFYe45RtOvLtF9TYRp1DlLW+6vgjag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379675; c=relaxed/simple;
	bh=VKY9AlnrM9YiRfo50NjYcLDV1DcMPrKJfBa2b9+eWDU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eOlTfkCbRKndwkCn0TSGn8pwDrLBDWwhQs6yqrj4qA4uEaP/tkzO2Iab6I15VwlnGcK+deQFukVJq4zNDKOYIDZVGANdAF2HF3u0bX6LNX//qHC3U3VdbYWpFzO+FdXqe4mw1nc2ws2HoMvWstLNvZssFvoZ4lxv+etltNpoWD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LjjH3xnM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S1dpOTft; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LjjH3xnM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S1dpOTft"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A49D1140191;
	Tue,  8 Oct 2024 05:27:51 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 08 Oct 2024 05:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728379671;
	 x=1728466071; bh=vXVXlSmeQt3lDbjU6nzfzfDoQAW9RRomvBadp2xogcw=; b=
	LjjH3xnM+GRAQaxqfnil0f4K0CXhopX0CoBsCvjtefpsoLeCdXj+uE52WuSWVaRb
	7CCsmaKCl7FOnb2xQc0rS0LQ4Iv4/0Qc0SnVIsWbC3p1ya2nPNPePYAanHYcZe9G
	+VeZ9Fppu1CZBWtvkhhIvzZMizyyVVdSRVytP6zmADDgyKABMnO6Mju5BKtrcPbw
	0VCLurE7mhnVUsOlXjk494dKt9P2EOBNj3Q4lbWtrNVqMwLm+g5PhnHkuFTWxoHw
	iAvIL4yYKdn1K+cEOSTy/UroLyjGf/D+i4wok9h/WkRc2YoTHmKOXto5kB3t2HRd
	mQaG7DXIpcTKF0EAgOkf1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728379671; x=
	1728466071; bh=vXVXlSmeQt3lDbjU6nzfzfDoQAW9RRomvBadp2xogcw=; b=S
	1dpOTfto0kp/nMHnp9dxXL+YK7E+K5bPy5w1cnooppdgroFoA9gFil+FIYniOL2K
	0+/jcoFMMduW53yAkr46efUVh+ba1uXb2zgJeug+7Tffs/oV2iCnKUlUC1wzaH41
	+kKhKoDiDalrs7gSadbeoFPn5QXuhVqGgkGq5W9ezH7wMr31GkE4N0p7AX93Um+l
	mCyFKE1tbpCen7juEjXe/F1mqwgVd0qa/V6z4WlmFrAuXah9O5t6PJFlQWOcYB0g
	sxpHAda6FeIChJHj5a6edd5lG/TzG4Uh2peUp9AMNBneQ7YOYyedG8TCAWkN9/m2
	YVmviKb9JFy7k+PRr0GnA==
X-ME-Sender: <xms:FvsEZy8NZLdQike1dcbRC7pB3gS2H1pYi341JH_p7RYLdiNr2Kd-xg>
    <xme:FvsEZyvzuyp1QYB3WJyW_cF4ePPBHna7nAI6AaJXP7yrYk5AwQNgRwodQCrZIcHZm
    sfGvbNZom0-U_YUG7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqshhhsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhouhhnugesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgv
X-ME-Proxy: <xmx:FvsEZ4CDg3tRN1fNEhEj5w0EhOCdLCyEFHhESwSzNhEu6Y7Ngl5UrA>
    <xmx:FvsEZ6dpBz6Q5vZByLwehr3R-uasgYZfmBMKg6tgIJj_yHaNuWJWdA>
    <xmx:FvsEZ3PKS4bc-qBI68EWWD1Lxv1ChmMoBpkNREJ0CKtz1txDJmo2UQ>
    <xmx:FvsEZ0khEyMdVX7qTxLErr5Wqv0mrVx-Vms0Hyx--9bqiORe5wJGSw>
    <xmx:F_sEZwaT7M44JHYhTAjNewfTTgrHtNMUGqV9O7kCzSKKXHSiu3GotpjS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C545D2220071; Tue,  8 Oct 2024 05:27:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Oct 2024 09:27:20 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Vetter" <jvetter@kalrayinc.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, guoren <guoren@kernel.org>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-sound@vger.kernel.org, "Yann Sionneau" <ysionneau@kalrayinc.com>
Message-Id: <a9fa56b4-b00c-4941-8c8c-1d3b58b573e2@app.fastmail.com>
In-Reply-To: <20241008075023.3052370-2-jvetter@kalrayinc.com>
References: <20241008075023.3052370-1-jvetter@kalrayinc.com>
 <20241008075023.3052370-2-jvetter@kalrayinc.com>
Subject: Re: [PATCH v8 01/14] Consolidate IO memcpy/memset into iomap_copy.c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 8, 2024, at 07:50, Julian Vetter wrote:
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 80de699bf6af..f14655ed4d9d 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -102,6 +102,12 @@ static inline void log_post_read_mmio(u64 val, u8 
> width, const volatile void __i
> 
>  #endif /* CONFIG_TRACE_MMIO_ACCESS */
> 
> +extern void memcpy_fromio(void *to, const volatile void __iomem *from,
> +			  size_t count);
> +extern void memcpy_toio(volatile void __iomem *to, const void *from,
> +			size_t count);
> +extern void memset_io(volatile void __iomem *dst, int c, size_t count);
> +

I think having this globally visible is the reason you are running
into the mismatched prototypes. The patches to change the architecture
specific implementations are all good, but I would instead add
#ifdef checks around the prototypes the same way you do for the
implementation, to make the series bisectible and shorter.

 include/asm-generic/io.h |  58 ++----------------
 lib/iomap_copy.c         | 127 +++++++++++++++++++++++++++++++++++++++

Along the same lines, I would change lib/Makefile to build
this file unconditionally even on architectures that don't
set CONFIG_HAS_IOMEM. Again, strengthening the driver dependencies
is good, but it feels like a distraction here when we just need the
common implementation to be available.

       Arnd
