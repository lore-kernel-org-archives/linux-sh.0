Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.238.66.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575801;
	b=2MfI9E5xA3ZT8Y3Mve8hrApnx90id/SXle8BhojqQGzRmkbKnAD5c3RzNQ2i8lbbitzd
	 BdxZ7PSpwOfZzSm1RHCZjFbRMn3cK56C+vx0lQ1c1DBvnI7a55WM+VXWlPG2B430pCYbU
	 su0UOk8ApKLCxrvSU7lXzKEiWqJbpHLoMCcQZmLXBlv71Q80sEQ5BNir/spkTPsghAIhY
	 r00E1BqduMWefIWtYhsXVX7GKFL6muNJX+5XWTjf2YXVGJeFJC3bp7ZjV6QWsyrokz8wn
	 m457pWsqLzDLXl3S7DtSFSSrSJfESBrVi1s+cM5xuL7zHvIfQV435p6+MeF+92zjMHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575801;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Operating-System;
	bh=Q5kXhv1Rq6ndziUIknJI3cQ3tQdNmAOS1JwWBHwQIQE=;
	b=3sfL98aTeYa3aHlGj3Z98wCLKdSWkOwkniKgyf+tqBW0lNcvmgm3QJYxPizkaM8Da61w
	 VhwaIxXt9XgmVk2FjKdqxk+Ode/OacVxMSusVTX1K2nJikAqYUAkq10OIEtwaWJSNhl9l
	 A3wZfMSa/fQLutcvDQMj1sEhg3dzjIYhOM671WokfSSA9ugkpMA+P3mfFrZrF4NVOm8QY
	 PQ1qnkEuXZ6dj510nlOu2Nw3b4d+Pjo3zGkUsXbtHeC1Zd1y6gH1IwtD78e5ytHKAMbW2
	 Wfpc4cABE3xDoOyHI/QV2AJbWjwcPRrFzjvy2xsFYr3Rev9S1MTEs1kODzQcWwRnDTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=openadk.org;
	spf=pass smtp.mailfrom=openadk.org;
	arc=none smtp.remote-ip=89.238.66.15
Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6264606A320
	for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 09:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6264606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openadk.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
	t=1792575798; bh=0pMcKOweZkcfGfAFVflS0GQDvxErg+nKawzdrOFsPJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cs8skq28JKxYP4F0bIG6RbaFLHlz+jKN3kd0RxyGAx7HbA7oHY8jjbnNXtx/9Zi3y
	 JF07pl+Ka6QWx6Q/KHFlBL5tIU+FMuHzKt8WefuZqhotMyKGU60ru4/3z8mwQxS6mE
	 Gtn3gfrYmPnQSr2YlRp+kYi2ZsP+lKAOZCxtfat7AkK8AgBDgNMWF9TtsXA4Mfo07M
	 DFX3nlxtPXPZkVD9Wq7TXhHRfO2U5dV2gMQzngoNVt2J4aGd7tiTGxdnmZ8Q+xKfH4
	 0xQQMEvVjNQdG5X0wFRMjTLZtJFVdDUqKrbc5SnbLjsSgX2gahsPSS/rD9ohUpkaKs
	 AQrUOgo91FjiA==
Received: by helium.openadk.org (Postfix, from userid 1000)
	id F265731E0AF3; Wed, 21 Oct 2026 11:43:18 +0200 (CEST)
Date: Wed, 21 Oct 2026 11:43:18 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Waldemar Brodkorb <wbx@openadk.org>, linux-sh@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v2] sh: select BINFMT_FLAT_NO_DATA_START_OFFSET for noMMU
Message-ID: <atiJNhV5IDmRSWoT@waldemar-brodkorb.de>
References: <atgBKmRydeRteQ0T@waldemar-brodkorb.de>
 <843827c5eb85807d4f55a0d8a4cd572811ee3644.camel@physik.fu-berlin.de>
 <atiFE4oreXlgTzQz@waldemar-brodkorb.de>
 <c6f6e7da42978b8368c9fcd66ab298dafef4636b.camel@physik.fu-berlin.de>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6f6e7da42978b8368c9fcd66ab298dafef4636b.camel@physik.fu-berlin.de>
X-Operating-System: Linux 6.12.107+deb13-amd64 x86_64

Hi Adrian,
John Paul Adrian Glaubitz wrote,

> Hi Waldemar,
> 
> On Wed, 2026-10-21 at 11:25 +0200, Waldemar Brodkorb wrote:
> > Hi Adrian,
> > John Paul Adrian Glaubitz wrote,
> > 
> > > Hi Waldemar,
> > > 
> > > On Wed, 2026-10-21 at 02:02 +0200, Waldemar Brodkorb wrote:
> > > > binfmt_flat offsets the in-memory start of the data segment by
> > > > MAX_SHARED_LIBS words and then aligns it to FLAT_DATA_ALIGN, so FLAT_FLAG_RAM
> > > > binaries end up with a gap between text and data (commit 2217b9826246
> > > > ("binfmt_flat: revert "binfmt_flat: don't offset the data start"")).
> > > > 
> > > > SH position-independent code finds the GOT with a PC-relative mova of
> > > > _GLOBAL_OFFSET_TABLE_, which assumes data follows text directly, as elf2flt
> > > > lays out the image. With the gap, the GOT register points below the real GOT,
> > > > so every GOT load reads the neighbouring slot and gets a wrong pointer. On a
> > > > J2 (sh2eb, noMMU) this made userland crash or hang right after start-up.
> > > > In my case the data was moved up by 0x20 bytes.
> > > > 
> > > > Commit 04d82a6d0881 ("binfmt_flat: allow not offsetting data start") added
> > > > CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET for architectures that cannot
> > > > tolerate such a gap; currently only riscv noMMU selects it. Select it on SH
> > > > as well when building without an MMU.
> > > > 
> > > > Tested on a J2 board (Numato Mimas V2, sh2eb, noMMU) with Linux 7.3 and
> > > > FLAT binaries built with elf2flt: with this change the data segment starts
> > > > exactly at the end of text and init runs.
> > > > 
> > > > Without the patch bootup fails with:
> > > > [   12.080472] Fixing up unaligned userspace access in "init" pid=1 pc=0x(ptrval) ins=0x6583
> > > > [   12.123609] Fixing up unaligned userspace access in "init" pid=1 pc=0x(ptrval) ins=0x6583
> > > > [   12.175153] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
> > > > 
> > > > Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
> > > > Assisted-by: LLM
> > > > Fixes: 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset the data start"")
> > > > 
> > > > ---
> > > > v1->v2:
> > > >   - add fixes tag (Geert)
> > > >   - tested with 7.3 + Florian's uaccess patch (Geert)
> > > >   - added failing bootup messages to commit message
> > > > ---
> > > >  arch/sh/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > > > index d60f1d5a94c0..b501153551c0 100644
> > > > --- a/arch/sh/Kconfig
> > > > +++ b/arch/sh/Kconfig
> > > > @@ -15,6 +15,7 @@ config SUPERH
> > > >  	select ARCH_MIGHT_HAVE_PC_PARPORT
> > > >  	select ARCH_WANT_IPC_PARSE_VERSION
> > > >  	select ARCH_NEED_CMPXCHG_1_EMU
> > > > +	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> > > >  	select CPU_NO_EFFICIENT_FFS
> > > >  	select DMA_DECLARE_COHERENT
> > > >  	select GENERIC_ATOMIC64
> > > 
> > > I have not tested this yet but I will do so later this week. Personally, I
> > > test my kernel images on J2 with ToyBox which builds a minimal rootfs with
> > > busybox.
> > > 
> > > I am not sure if the binaries are flat binaries in this case, do you know?
> > 
> > They are not. Toybox uses musl C library, which is FDPIC.
> > I use OpenADK (https://openadk.org) to build a J2 image with
> > uClibc-ng and FLAT binaries. You could either try OpenADK or just
> > believe me :).
> > For OpenADK you need to choose experimental support and uClibc-ng
> > git version, as there was another bug in uClibc-ng to let it work.
> 
> Thanks for the clarification. Wouldn't your patch then interfere with Toybox then?

No, because it is BINFMT FLAT specific patch. It does not change
anything about FDPIC.
best regards
 Waldemar
