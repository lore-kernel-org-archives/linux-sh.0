Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780543;
	b=1rLpSuCBCbSW935EVaMAVvJpqmdGx3XZPTTWwoNQiVZMEBW8JoVfChkXHhJ3cTrCvAhd
	 Axg8Wzi7mMF0xabZpqJ+TglF5lMkF0nJr54x2NmdeBVmiS7rFGZLf2pEnjikRMVJyVoxc
	 TKSwA6scr8M+jOJg2wobkr6XsgyaOXmC6grwRCcTd0ybaeWXXXrcqVrjbXWU3whHviQjW
	 xku6AgHrnHf7zX5BcGO7eiDI9qTA1drDheUCXKshkMK67xFpdxlss6e1jkMzaIU1jdywz
	 4JVxKUlLK8K4NGyTkEUfv50Bl8RSfc6OEzUakL9iDRz9fkt2hT/GIpZLWUR2+61K/6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780543;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=RjCrEDCBjlv7HUFE/SO7vFBP2MJBmVp6Qv3gJVlzTUQ=;
	b=rOiUnNwN2haWs0J1hBYsFVnj8rS8EY0duf7nCXZ5r/hCdbxC/9L4KfOVqyq7aP2Z8BIh
	 q2VVPpSqwCDbc5InS+eGz0KITsznLYTBQ/Oj35lcKk8MEQLJKkgznMbVyV1eE6NQvQAMy
	 AuTlFcqqJhvYygbqsTHv7TzGb9vc3D+/a8LVBl1fVMcwZWixqKEQazCkVhlGboE42Mv4B
	 dRiPEvnBvMsanK6x6edW2kT8tPUpYbEmSGpKgr6FRyGlgim2ibWzlDO3Au2LTIzu/ABXw
	 2FvRjDb/W/OhLY136yPgH2HTOPWE8b5TaFm7Dzew/I7xgxzfyO5vknYd3fKIZ3YOpXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b="qcxwVfH/";
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC41606A31A;
	Fri, 23 Oct 2026 18:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FC41606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=qcxwVfH/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1792780539; bh=RjCrEDCBjlv7HUFE/SO7vFBP2MJBmVp6Qv3gJVlzTUQ=;
	h=From:Message-ID:From;
	b=qcxwVfH/mUU98njlSxycsArGk0CeOtQ0/iZ4f4eTKwp9IEgOqncmySkF7uUhkDmBj
	 CTdE6G1bdpL3Nh0KNbujNMhogwc1zvYYGAd4xDzqL/o0yr36hmDG+jc3/YXMpP/J+O
	 sH1N6hoi1o+I9NoT71Hdch81TqZYLGLoTkVAnruk=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 53B41C0943;
	Fri, 23 Oct 2026 20:35:39 +0200 (CEST)
Date: Fri, 23 Oct 2026 20:35:37 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Daniel Palmer <daniel@0x0f.com>, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: sh: enter _start_c with jsr instead of bsr
Message-ID: <atuo-ZOI7koEs8RV@1wt.eu>
References: <20261022100159.525910-1-daniel@0x0f.com>
 <cd8fcccd-aa70-46f9-b497-ec3070b5f8db@t-8ch.de>
 <atrsI4aaq9t4BVra@1wt.eu>
 <81607eb0-596c-4943-a8fe-d272fcd258c4@t-8ch.de>
 <atuJZwT7LIzceQ2c@1wt.eu>
 <5a82da39-1f60-41b6-9359-f08e6fefdb6d@t-8ch.de>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a82da39-1f60-41b6-9359-f08e6fefdb6d@t-8ch.de>

On Fri, Oct 23, 2026 at 07:32:55PM +0200, Thomas Weißschuh wrote:
> > > I fear that we will have the same problems in other architectures.
> > > And for those we'll also need custom assembly. While the mechanisms
> > > above would not need that.
> > 
> > But all archs support indirect calls one way or another. Normally we
> > should be able to do the equivalent of placing an absolute value in a
> > storage area, load it in a register and branch to it at least.
> 
> Of course it is possible to do. But it differs between architectures and
> somebody will have to write and maintain that assembly code.
> 
> > For me, sorted sections are most likely meant to be used to group code by
> > locality, not to guarantee that branch offsets will always remain
> > small enough for all architectures.
> 
> Exactly this locality should provide small enough branch offsets.
> The section ".text.sorted.nolibc_crt" should only ever have two functions:
> Our _start() and _start_c().
> While there won't be a formal guarantee that the architecture's branch
> offsets will be able to handle those, I find it hard to imagine that
> they won't.

It has worked till then at least so it should.

> > An indirect call on the other hand is well defined, standard and can
> > be adopted where needed at the cost of only 4 or 8 bytes in the
> > startup code.
> 
> Its a few more bytes, not that it really matters.
> * 3 additional instructions -> 6 bytes
> * The embedded offset -> 4 bytes
> * Up to 3 bytes of alignment

It depends on the arch in fact but that remains the order of magnitude.

> The adoption will require additional fiddling with assembly.

Yes I agree.

> Maybe we let Daniel break the tie? :-)

The advantage of the ld-based one is that it should be the lowest effort
across all archs at once, so we should probably try with this one first.
If we later discover that it displaces the problem somewhere else, then
you can reconsider it and switch to the asm one.

Willy
