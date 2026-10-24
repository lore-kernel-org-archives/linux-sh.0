Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792819634;
	b=t7jx945vn2rJOnclCOKck2KxxsUAsLDjARR3aJx2gmNf0A20TdD3MlRUxO/gv3SMHLRO
	 rgfdxBsFsobyVs3f1Lb8Bjt7xlpqsK1y5VXp1sT/T0cWJy9CjJB1DuHQ2gB/Shmm1PulG
	 +YCT2YSOZLbwzwStnKjfCbS8k+35dOJe15vViOOGsxE5xz9ZhpGSBQV8ygZA+Q0PysUS+
	 A5WeyrHzXzNrCtqzpBlYEBgUu37XeNGwf67F53NqFoiUQ5Lum7A07MqDGrkeRs3tSnZcf
	 R9O1DvrmIiqkqJvkafTVQ22fyBz9tdcpP9c1mhGc8Kh/sFGk2mjIsAVJb1Fhe2ReaDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792819634;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=zeB7Ey/qbrJR+OHigTHJh4vHbV7H095IbRUGb1BIXX8=;
	b=wjT3/l4n7/HQ4SaHibX5F3hvT7jR7Hl+/kxS8IXIarb4hZ+2byV6jvt7hWCa4AKnBf3O
	 99XAAe5+LePvfkKs7Wj3/xotd913pSbLQC4JGN+eRFZx1Pa+DbBzcEo0mnwn17CBseWWb
	 2c9jKMmGvXAxbSPJwm8JR3TTxpF8xMCZNz4Z3wpHE+SQ5LJP5p7oqN7kPwZU6cta6mudM
	 25bRw8vVBYPQG4dr+thkUmp9+j2SA3dwnDSmPDuxZOQUyj3klpwD+8xF2zE1xC6IHL0Lr
	 P1lY9j1X3lUC+u9dLLmrimsQz2LMSFbmoW7MrINuXbrCc2xrPF0FYGPJ4m2dUzdNhZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=gjpHxwjL;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B8606A31D;
	Sat, 24 Oct 2026 05:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E89B8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=gjpHxwjL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1792819630; bh=zeB7Ey/qbrJR+OHigTHJh4vHbV7H095IbRUGb1BIXX8=;
	h=From:Message-ID:From;
	b=gjpHxwjLN7G4UO2LI2zbqgjlm46bJvuB/Y9dXGuoOoIgZA1YBhRUpL3/OHQBWusl5
	 9jn6tdTzRHvqfQ30WRhPHNEVTfcRei7VhEON0TAerTwfA26vs6GA2BJnyue8el4Ici
	 /OhsRdbDPWVgva6vKH4aJSsAoQXCyrUvm9R9HOnM=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id CC340C0944;
	Sat, 24 Oct 2026 07:27:10 +0200 (CEST)
Date: Sat, 24 Oct 2026 07:27:10 +0200
From: Willy Tarreau <w@1wt.eu>
To: Daniel Palmer <daniel@0x0f.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: sh: enter _start_c with jsr instead of bsr
Message-ID: <atxBrgD1Xfcvw7pL@1wt.eu>
References: <20261022100159.525910-1-daniel@0x0f.com>
 <cd8fcccd-aa70-46f9-b497-ec3070b5f8db@t-8ch.de>
 <atrsI4aaq9t4BVra@1wt.eu>
 <81607eb0-596c-4943-a8fe-d272fcd258c4@t-8ch.de>
 <atuJZwT7LIzceQ2c@1wt.eu>
 <5a82da39-1f60-41b6-9359-f08e6fefdb6d@t-8ch.de>
 <atuo-ZOI7koEs8RV@1wt.eu>
 <CAFr9PXnggcsL5JSV0ASXSfvcbkt30-g1kpTrsa0PDWqgdhcsOg@mail.gmail.com>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXnggcsL5JSV0ASXSfvcbkt30-g1kpTrsa0PDWqgdhcsOg@mail.gmail.com>

Hi Daniel,

On Sat, Oct 24, 2026 at 02:16:10PM +0900, Daniel Palmer wrote:
> Hi Willy, Thomas
> 
> On Sat, 24 Oct 2026 at 03:35, Willy Tarreau <w@1wt.eu> wrote:
> > > Maybe we let Daniel break the tie? :-)
> 
> mmm I have the same big binary (Quake using nolibc + a thin DRM/KMS +
> ALSA layer, some libm bits from musl) on 32 bit ARM and x86-64 and
> they were fine so my gut feeling would be that this is an SH issue and
> a few extra bytes is fine for such a niche arch.

x86 can call 32-bit displacements, so you have some margin there ;-)

> On SH this also seems to happen for much more normal binaries if you
> enable LTO and get unlucky which points me towards letting the SH
> entry code deal with it.
> 
> But also I'm still working on the static PIE thing so nolibc can
> create binaries that nommu can run and in that case it would probably
> be helpful for all of the code that runs before relocation to be close
> together.
> 
> I'll have a go at the ld solution and see what happens.

OK!

> Slightly different topic but related: Another thing on my pile of
> patches is some stuff to extend memcpy() slightly so it generates
> word-by-word copies where possible without passing -O3. This helps
> m68k and SH a lot but everyone would end up with the extra bytes for
> the word-by-word copy loop and the check if fallback to byte-by-byte
> is needed. Would wrapping that in something like "#if
> NOLIBC_FAST_MEMCPY" be acceptable?

I've been thinking about similar things a few times, and I think that
for such cases where we implementa naive function for size purposes, we
could also rely on #ifdef __OPTIMIZE_SIZE__ to keep the small one and
switch to the faster one otherwise. That way we can respect each user's
expectations.

Willy
