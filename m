Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574884;
	b=pTlPSSvCVztRfsV455kKhl1BrUfW7WdQzqmSs6WnVMtsROoOhTaZWiMrR6vPJQhrZxQ1
	 /DsEl8W39zYa10W7i3CNqTmiB7ialfjPGhubK/a1BKAUausxKBH+iegpgzqUOTCOxZzRT
	 8ubdKT3yFUQf/e40ZhykDnb6uzGEsgf6lbFCTc/ZSt1z42KpEzXbmKSWo60y9f6spB1YJ
	 Rl7VJ7OH8TABYcx6csACmxfNPqSmq6Lt2+Osw03fC57AodRyUYZq1oDwNCJ2YX+h646UU
	 pVRUJX0IXR9CV2iZpNRvWEvwvpi82GrpnhfKqkUkEGpzrmO46PV+riITXfGC8mfgTlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574884;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=bxH27+2YW4krw503GnVC2e7PGcoShicKzbTaAjdlFbQ=;
	b=dTC7ddyNmjNd1v+1GkBoK5D4lPhnN6t0B4be929vyGD+6bjY5DWLfxMoZ23MxPuZRjec
	 +d15UxIun53899rBprNg5rkKhBfrwyvecyEjeLGqw26yv9rakv1bRIo9cUMAiQm3UMmQg
	 aR3+emNBZgmCzz+cRPYtacO0sQtvYcmpw7RMQ24pd2gKSTzI7olgcQpLqGZ0J2P37JNEL
	 I+Ru12nllgfVbQKgq2bQf7ss7OxMyuRNOQG6FMGDFuLPHw2hAPs6UKpHkMNbJ+NAP6d4H
	 3w0A4ncqY0pD97ICakLv2btQTRE8eq4dazV6PuhkXDK+7TUkgoPO68c7AUpmYFb57QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=LsVIskUm;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440D1606A319
	for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 09:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 440D1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=LsVIskUm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=bxH27+2YW4krw503GnVC2e7PGcoShicKzbTaAjdlFbQ=; t=1792574883;
	x=1793179683; b=LsVIskUmj7+v3I+MKMeosq2gfUoElpYR2ltqdtIUWh7K2ufMC5pxmTcaF3Gdf
	+P2kJT4dFE4FHqajGM/dCSfS91a//OgI/yi/NqWCOvaBucKgkEJ9iSrLuwDWQQ06CmGF6Emsi7U9J
	5Fnpn9Kzg644HwUnvqn4gd1w2IRefgwtVT6yj9GxAtXZcZQGh/v09wW7VPtrrTEZqI8lBrWbakcRW
	t7pMcpoRsLkasGJ8LOeO4N2x85703OXDxkkBLkz37YzBNKsA2xuSNg8CZOxpn36+haaEEP1efO3lC
	5QYg5SzldBbrhTfspTSWhyojrXQ2gP4cxaiaVJKUBBCqHTSBVg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xJSc5-00000001vSZ-1zZz; Wed, 21 Oct 2026 11:28:01 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xJSc5-00000003R3W-13eD; Wed, 21 Oct 2026 11:28:01 +0200
Message-ID: <c6f6e7da42978b8368c9fcd66ab298dafef4636b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: select BINFMT_FLAT_NO_DATA_START_OFFSET for noMMU
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Waldemar Brodkorb <wbx@openadk.org>
Cc: linux-sh@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Greg
 Ungerer	 <gerg@linux-m68k.org>, Damien Le Moal <damien.lemoal@wdc.com>
Date: Wed, 21 Oct 2026 11:28:00 +0200
In-Reply-To: <atiFE4oreXlgTzQz@waldemar-brodkorb.de>
References: <atgBKmRydeRteQ0T@waldemar-brodkorb.de>
	 <843827c5eb85807d4f55a0d8a4cd572811ee3644.camel@physik.fu-berlin.de>
	 <atiFE4oreXlgTzQz@waldemar-brodkorb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Waldemar,

On Wed, 2026-10-21 at 11:25 +0200, Waldemar Brodkorb wrote:
> Hi Adrian,
> John Paul Adrian Glaubitz wrote,
>=20
> > Hi Waldemar,
> >=20
> > On Wed, 2026-10-21 at 02:02 +0200, Waldemar Brodkorb wrote:
> > > binfmt_flat offsets the in-memory start of the data segment by
> > > MAX_SHARED_LIBS words and then aligns it to FLAT_DATA_ALIGN, so FLAT_=
FLAG_RAM
> > > binaries end up with a gap between text and data (commit 2217b9826246
> > > ("binfmt_flat: revert "binfmt_flat: don't offset the data start"")).
> > >=20
> > > SH position-independent code finds the GOT with a PC-relative mova of
> > > _GLOBAL_OFFSET_TABLE_, which assumes data follows text directly, as e=
lf2flt
> > > lays out the image. With the gap, the GOT register points below the r=
eal GOT,
> > > so every GOT load reads the neighbouring slot and gets a wrong pointe=
r. On a
> > > J2 (sh2eb, noMMU) this made userland crash or hang right after start-=
up.
> > > In my case the data was moved up by 0x20 bytes.
> > >=20
> > > Commit 04d82a6d0881 ("binfmt_flat: allow not offsetting data start") =
added
> > > CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET for architectures that cannot
> > > tolerate such a gap; currently only riscv noMMU selects it. Select it=
 on SH
> > > as well when building without an MMU.
> > >=20
> > > Tested on a J2 board (Numato Mimas V2, sh2eb, noMMU) with Linux 7.3 a=
nd
> > > FLAT binaries built with elf2flt: with this change the data segment s=
tarts
> > > exactly at the end of text and init runs.
> > >=20
> > > Without the patch bootup fails with:
> > > [   12.080472] Fixing up unaligned userspace access in "init" pid=3D1=
 pc=3D0x(ptrval) ins=3D0x6583
> > > [   12.123609] Fixing up unaligned userspace access in "init" pid=3D1=
 pc=3D0x(ptrval) ins=3D0x6583
> > > [   12.175153] Kernel panic - not syncing: Attempted to kill init! ex=
itcode=3D0x00007f00
> > >=20
> > > Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
> > > Assisted-by: LLM
> > > Fixes: 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset =
the data start"")
> > >=20
> > > ---
> > > v1->v2:
> > >   - add fixes tag (Geert)
> > >   - tested with 7.3 + Florian's uaccess patch (Geert)
> > >   - added failing bootup messages to commit message
> > > ---
> > >  arch/sh/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > > index d60f1d5a94c0..b501153551c0 100644
> > > --- a/arch/sh/Kconfig
> > > +++ b/arch/sh/Kconfig
> > > @@ -15,6 +15,7 @@ config SUPERH
> > >  	select ARCH_MIGHT_HAVE_PC_PARPORT
> > >  	select ARCH_WANT_IPC_PARSE_VERSION
> > >  	select ARCH_NEED_CMPXCHG_1_EMU
> > > +	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> > >  	select CPU_NO_EFFICIENT_FFS
> > >  	select DMA_DECLARE_COHERENT
> > >  	select GENERIC_ATOMIC64
> >=20
> > I have not tested this yet but I will do so later this week. Personally=
, I
> > test my kernel images on J2 with ToyBox which builds a minimal rootfs w=
ith
> > busybox.
> >=20
> > I am not sure if the binaries are flat binaries in this case, do you kn=
ow?
>=20
> They are not. Toybox uses musl C library, which is FDPIC.
> I use OpenADK (https://openadk.org) to build a J2 image with
> uClibc-ng and FLAT binaries. You could either try OpenADK or just
> believe me :).
> For OpenADK you need to choose experimental support and uClibc-ng
> git version, as there was another bug in uClibc-ng to let it work.

Thanks for the clarification. Wouldn't your patch then interfere with Toybo=
x then?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
