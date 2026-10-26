Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018350;
	b=Pt7K4SFD57IhOdEwQWSOYyT6pDwFu6Ft+b4cFBuBVSH8vFCMowvFdNzzNPcMVkWN5lVs
	 gwH+bV7IMCs6Wus1Rb+IfhceyXJNq3Bv9CU757PYdzKiflgxDIPR4Ro91ZI2Os6qsn+52
	 qLFcxdHQt1gFdswji6rXdDFkqJhdkFXOYDKNNG9maJgy77bxk7seLWBM5q5OBqeXvtkbb
	 Ea8ggou2eMp6+mH5WPWx0EATAN6s8yMb5C3pJ4rtBj14kXiK2p9ysuLnbkMFO2EpH5L7F
	 mFKqCNJRFQMawIR0sj6Cl6GWfdnjP8CUgOdefFMyCBxB7Hc4mcvN55G/i8Fm8MnMy0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018350;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=uH9DzsWwtOUf5TNTaECVznpCxu+r0jH1i9qKy4zL0RM=;
	b=2EFmPUVVZy0T7pCebn4WuuRTk6OxWiuWNrVwIUyzRIpcSAUjLjMCUVxE1R8+wJouB/93
	 gNCLFaGfck49suiT5OHoEzLNfqhqQ2aCRfjl2HsLuQaISQYkFzrM5bXu9HIhhS6XA8cq+
	 A9PvDziQdz1vNznIEfic9MMM/6uoK5xtaLyJgSkdd7yGG1j2UvuqGFwql2SPMl6sDBiCX
	 0ELwpwyjrCs0r6KLxdqobDCSXIfEntFa2R9XYYXdhM1Mbq8yXwO0afuE1UOZYd6EyqZcT
	 Itbbm2W2qthYd315FP1C13WZkjshL68qIGvNxqWBJlGLaYBpL10xCKHAD7l2s9kkdCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=VNsZj1xB;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655E606A32A
	for <linux-sh@vger.kernel.org>; Mon, 26 Oct 2026 12:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C655E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=VNsZj1xB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=uH9DzsWwtOUf5TNTaECVznpCxu+r0jH1i9qKy4zL0RM=; t=1793018348;
	x=1793623148; b=VNsZj1xBhFmvxFJ4cLj7+PeWOZ2jemRrnZQvsYAQylMCIqYrkX0jducgNs0NG
	V9cDIJTL68fHMmMvM3t6a/AZAHr8f6fVy6Ee+NBWBhAdqPJWTPUDHIM7HrK1f2hAK6EmP14E+Jzmh
	DxOF49l/OAKvSKqGsZV5EIoSAkxLSLDLEOzRJD07ozr0p3EKx7J5LxmWFcoaAzs5PyJ3zWi04XsvH
	rB6h5lN4eIhCN6TvMgGJfGtlTIcf1Nee7HUQyj0O86S5K2cVOHxfHkVf3WAi6ntqjW/rsR4SFPnj7
	oWc5VM1npl0pJbfuX0XJlml5Gl4IUMX/TDmIoIxkaHpiUGsKPA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xLJye-00000000uVm-0ygq; Mon, 26 Oct 2026 13:39:00 +0100
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xLJye-00000001Znt-03De; Mon, 26 Oct 2026 13:39:00 +0100
Message-ID: <88989b6b3292c36fcdbdee2cc352290ab86ddc0e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: select BINFMT_FLAT_NO_DATA_START_OFFSET for noMMU
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Greg Ungerer <gerg@linux-m68k.org>, Waldemar Brodkorb <wbx@openadk.org>,
 	linux-sh@vger.kernel.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Damien Le Moal <damien.lemoal@wdc.com>
Date: Mon, 26 Oct 2026 13:38:59 +0100
In-Reply-To: <1ead42f9-470d-4a04-846b-62d1b5ef3963@linux-m68k.org>
References: <atgBKmRydeRteQ0T@waldemar-brodkorb.de>
	 <1ead42f9-470d-4a04-846b-62d1b5ef3963@linux-m68k.org>
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

Hi Greg,

On Mon, 2026-10-26 at 22:32 +1000, Greg Ungerer wrote:
> Hi Waldemar,
>=20
> On 21/10/26 10:02, Waldemar Brodkorb wrote:
> > binfmt_flat offsets the in-memory start of the data segment by
> > MAX_SHARED_LIBS words and then aligns it to FLAT_DATA_ALIGN, so FLAT_FL=
AG_RAM
> > binaries end up with a gap between text and data (commit 2217b9826246
> > ("binfmt_flat: revert "binfmt_flat: don't offset the data start"")).
> >=20
> > SH position-independent code finds the GOT with a PC-relative mova of
> > _GLOBAL_OFFSET_TABLE_, which assumes data follows text directly, as elf=
2flt
> > lays out the image. With the gap, the GOT register points below the rea=
l GOT,
> > so every GOT load reads the neighbouring slot and gets a wrong pointer.=
 On a
> > J2 (sh2eb, noMMU) this made userland crash or hang right after start-up=
.
> > In my case the data was moved up by 0x20 bytes.
> >=20
> > Commit 04d82a6d0881 ("binfmt_flat: allow not offsetting data start") ad=
ded
> > CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET for architectures that cannot
> > tolerate such a gap; currently only riscv noMMU selects it. Select it o=
n SH
> > as well when building without an MMU.
> >=20
> > Tested on a J2 board (Numato Mimas V2, sh2eb, noMMU) with Linux 7.3 and
> > FLAT binaries built with elf2flt: with this change the data segment sta=
rts
> > exactly at the end of text and init runs.
> >=20
> > Without the patch bootup fails with:
> > [   12.080472] Fixing up unaligned userspace access in "init" pid=3D1 p=
c=3D0x(ptrval) ins=3D0x6583
> > [   12.123609] Fixing up unaligned userspace access in "init" pid=3D1 p=
c=3D0x(ptrval) ins=3D0x6583
> > [   12.175153] Kernel panic - not syncing: Attempted to kill init! exit=
code=3D0x00007f00
> >=20
> > Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
> > Assisted-by: LLM
> > Fixes: 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset th=
e data start"")
>=20
> That looks like the right fix for SH.
>=20
> Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>

The patch is already in Linus' tree.

Adrian

> > ---
> > v1->v2:
> >   - add fixes tag (Geert)
> >   - tested with 7.3 + Florian's uaccess patch (Geert)
> >   - added failing bootup messages to commit message
> > ---
> >  arch/sh/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > index d60f1d5a94c0..b501153551c0 100644
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -15,6 +15,7 @@ config SUPERH
> >  	select ARCH_MIGHT_HAVE_PC_PARPORT
> >  	select ARCH_WANT_IPC_PARSE_VERSION
> >  	select ARCH_NEED_CMPXCHG_1_EMU
> > +	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> >  	select CPU_NO_EFFICIENT_FFS
> >  	select DMA_DECLARE_COHERENT
> >  	select GENERIC_ATOMIC64

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
