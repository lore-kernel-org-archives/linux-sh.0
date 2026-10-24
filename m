Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792818984;
	b=0dtpTBcb5slWnP/VPVIFRTZC3WgtIBj2vtWjmdz78De0IYaeqjsi1U1m1hpd6r5i6oyv
	 8BH/WIzPcDLXQptsfv8Vu7lENb3CBd//AlgHdzrxbSeMI1ywWhUh9YLpfbbVw+I1TA0uB
	 1BWZsen9ykr9N0498a/7bk7ZWyD7fAHUz1uajFEUfzkPkseWOJuoBcYBxlgSOo/IsSu/F
	 4ldVMqdBSAq3XhViZqgyUj6R0Ot6hUlVIhwl20QQRLdVQcKjnJQg00q7n+OWEfqqlK0ya
	 dhRwixzaMU0e7T2CZRQfxl4z1aFRkpya1wDBrh9wUAlhKQgYocQtPicLZDgYTkNhVFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792818984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=xK4SMVmULID+nciE/Lj6KOvW8I2NZswUGNT0We+t9YE=;
	b=mn2zjM20ZQlj41b2n9Yn67JbjfFeHkD0sMh6d18r5aDGMpmbRhwvUND/yf1cfcpdS09c
	 Na6MZum05OkiqPQy0E/5vi6Sg0E4CzMneSiVVSP8Lb339nXBNbZF2Q3qpFTpbkYxk/uc5
	 hiFoBcB6iXpozgaCkYpeFH+vyNcP9PhbR7UozIMv9FJcKULvYQ4U6LTc0TaU+jaeaMhNe
	 2sqwGSOou4y3zxIuPwLOxSoXzCQylcr3ICzLkDbu+0AozFhD2Bb6NqDWdhgnKtxEcN+VM
	 Jnw1ApH93zL8swlLEFT9/WXP4NLrqb+sZImd/SLlSp81+qJw0PuAZB9JbEviJJnMURg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b="K/EmFxXY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17639606A31B
	for <linux-sh@vger.kernel.org>; Sat, 24 Oct 2026 05:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17639606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=K/EmFxXY
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-15dd124bbe7so2454032c88.1
        for <linux-sh@vger.kernel.org>; Fri, 23 Oct 2026 22:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792818982; cv=none;
        d=google.com; s=arc-20260327;
        b=cMWk0W6it2GCEfneKtEKWJYqJbL3ElidWDN1z2ehIPaBJHkatsvFPqHt7iU8lmFMLe
         EFw0JpufL7rsI13au3fs8CiLrvKw12wU2J2HTqydQ7FOjLJZ/Go2GYanSESWS/CYkFTs
         OxDBzPRjgx8zWuhREVN7QYMXHIYByJjp8SX/5DVO0hrEks/bgyPdTz9fw4sD3lM1ednE
         wseNpX/hPfCOykEoht6wq5HgXxdrbsEs2widv/rtbel2hZPXkjs5c7Cr68dEhPBCVosL
         RmI9gSgMJya4VGU3VZk2AfuJo46cH4rlnNvf3KD3iUmaYDs7mlqPAXUFZVIweyryDgqi
         RDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xK4SMVmULID+nciE/Lj6KOvW8I2NZswUGNT0We+t9YE=;
        fh=e9RpRR9mWi3TVPIJrjRV0VkbaFRxxr8KUO/IkP1X5rc=;
        b=bDbB+zo3+hlcR8o0FYZdtgDd8VPHIvpQnWB1X5YuYquU5g0pVPj3slo6efwBTNB/dq
         /+0lPvJ9+Y+Ep9PpwU3v7KisQa5alZ/NPZDj7TWUCUE6Q0DSXXYJwRiBQ0zEaTIGumZH
         XZBW5pBkDHJ0y+fmouf3FjXfzr2au4z9tl24ozPpjZETv4nsvS43WPenpv7ywb1/bZCz
         miExvnp+mgBM1ogiWD3jFDrdhLmI+hYwSPKTMIam5agO2TWW3cllY65bK4Lok1s2P0KT
         lTXb381cTvs+uFUA4BSRJRJ8ES50RjUtDuzB2CvoDQUW2YpBvmZcACm01SiAumImMLbS
         9L/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792818982; x=1793423782; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xK4SMVmULID+nciE/Lj6KOvW8I2NZswUGNT0We+t9YE=;
        b=K/EmFxXYJLoLSM8hzo5GFgUhAW14+F6AfkR7S6g1KmFpgECEFIc8J725R0nsQ4v8VG
         ZCk0UHDQ6r2VbQxSwlc+BA3tT1xLfXCuvLZ8ICWToJU3KDmMo7NWDTj2wOHUgnXyBsO3
         i3ui3QyiQZJyA0r3hLXTarZpRDtIyUKRD0DTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792818982; x=1793423782;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xK4SMVmULID+nciE/Lj6KOvW8I2NZswUGNT0We+t9YE=;
        b=egMM/e1YXLyL9MQvTBufU6nL41EQu9uSIxkRTr/oI1vtr/6JzXwwDmUIC65Xn//Szo
         MIpVPhGPfsptDQFix2GbNIa+NlieE0oGPQjeOSpqfslwN/Tj/F8xb2D/nf4pr8NuAZYM
         gJ78Bfxhle4oq3ppt+XA7V3Bo2sVf3qjRoGlAnCkm77yEFmftOYvVeg2Ai+3OVfIypqz
         BWioPx91BHmWkW3ZO4Kwiyf7NdgJyLLCntyRg7nLYwHHhoUTREmPIE6NyP/YrSk7seSw
         vCCQF/l5UxplFXZWnts+9e5zYxOkpDmnsfuV5O+RuEP37jiZNYSIWFqWzaSKfMgd5RiZ
         JLVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVEVebep/ngNk15BYwFPI8HiGdmAPeXEDtdokgad6nzeQyt57I7b8qsFDdGxt96t1Qr8ZWjK+gnA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKOssmyTQkhHp9V3gUvb9W23knpzp8UFxCIS9mvsLzk2sjnLpTW
	xJtI5GOqBdIMDKmJNLoJlxP9KJ4XfxwMOnfO3wBRIdIkEtZ8yTmdI5zkNNHY1EBGv6FZd1UIvyp
	V66CBHnL06fFmFwCiQylYlw1VGua83RYeJVP9WRN6SQ==
X-Gm-Gg: AYBFou1jexsMjDDU+FSvbaef10AOV0CC1kH/e3nUP1/6aPZ4uGQ1EmODA/EQe9wlK3e
	KO0MHkO6GWYBtxM3db+4cH3MolbbhjcRDHl489BwO9IgQGQIHTpIelZPVFm1hgj9k+e+M7TX5g4
	LLlBHJ7+zMpT9TqE6EVLXCe2kerqFbCGCXTBq99bW/bZI4ZgGJzBlPi5butr8cn1R3GeAUFj4y0
	1O9QqWcegMHeAYJ3/6UXXZxxfAl46NhxMP+hsshza1CO0UoSI0D7JeD4hS7dynxjOfLimrfeZRg
	OjUqyGwv0kLRmLYzC8OfxFweeimjBnEd0us2SIJGJCntXb8avLmOdW3YmyJ1jhNVA1PMFqap52/
	KKghwbBO2cZYNui2BPefbLB6Z8/+WNU6WisdnV58=
X-Received: by 2002:a05:7022:7f14:b0:144:c112:5f24 with SMTP id
 a92af1059eb24-19936a5e5ccmr1673320c88.25.1792818981855; Fri, 23 Oct 2026
 22:16:21 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022100159.525910-1-daniel@0x0f.com> <cd8fcccd-aa70-46f9-b497-ec3070b5f8db@t-8ch.de>
 <atrsI4aaq9t4BVra@1wt.eu> <81607eb0-596c-4943-a8fe-d272fcd258c4@t-8ch.de>
 <atuJZwT7LIzceQ2c@1wt.eu> <5a82da39-1f60-41b6-9359-f08e6fefdb6d@t-8ch.de> <atuo-ZOI7koEs8RV@1wt.eu>
In-Reply-To: <atuo-ZOI7koEs8RV@1wt.eu>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 24 Oct 2026 14:16:10 +0900
X-Gm-Features: AclHuK-5C_aN6bR6lBP7A9AgnpS_VUQ_G6cYB72lUcgFDDghR30PHJrxWl6o2c0
Message-ID: <CAFr9PXnggcsL5JSV0ASXSfvcbkt30-g1kpTrsa0PDWqgdhcsOg@mail.gmail.com>
Subject: Re: [PATCH] tools/nolibc: sh: enter _start_c with jsr instead of bsr
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Willy, Thomas

On Sat, 24 Oct 2026 at 03:35, Willy Tarreau <w@1wt.eu> wrote:
> > Maybe we let Daniel break the tie? :-)

mmm I have the same big binary (Quake using nolibc + a thin DRM/KMS +
ALSA layer, some libm bits from musl) on 32 bit ARM and x86-64 and
they were fine so my gut feeling would be that this is an SH issue and
a few extra bytes is fine for such a niche arch.
On SH this also seems to happen for much more normal binaries if you
enable LTO and get unlucky which points me towards letting the SH
entry code deal with it.

But also I'm still working on the static PIE thing so nolibc can
create binaries that nommu can run and in that case it would probably
be helpful for all of the code that runs before relocation to be close
together.

I'll have a go at the ld solution and see what happens.

Slightly different topic but related: Another thing on my pile of
patches is some stuff to extend memcpy() slightly so it generates
word-by-word copies where possible without passing -O3. This helps
m68k and SH a lot but everyone would end up with the extra bytes for
the word-by-word copy loop and the check if fallback to byte-by-byte
is needed. Would wrapping that in something like "#if
NOLIBC_FAST_MEMCPY" be acceptable?

Cheers,

Daniel
