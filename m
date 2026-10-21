Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573015;
	b=sAjWDkeNBePZnaZxDgG4vcldmfxMVUXXLoH71BYp4in+33Us5s7dxsGl5mS6zg8Dr3rJ
	 6byikUXYqmjHswLO0MXDAOzVDkDuZhnPQCL5QEZt/z1kOAZvM10G9MQxvgVfgm8FyfoOf
	 FN8TuCtakh0KVFvh9q7oOuebnlBk+8XcSkPF8ksJKiveLtWbRypUhIrGU5No6wk7M+iq9
	 FInvnCuWhGf5boHG5iL3q21n11w5oo6hnpDsrVNrS16UgXp3TacuDsJFN3uXgI+32OLSJ
	 /s/m0RG+E8fp4hAdB51us2Uikfr9YoXwxMxJPNFOqbG04KZ9FckFBnCl5mQnSCbdzWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573015;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=NN7X2qHI+Bzp7O4aI/7aSCG0nt92AEk+cvxkkewI1xo=;
	b=3UP8B/vq9DeOIcr+m3pjO/DZoM+N5ivAFbLpaO6hd+jTp98o0yBSiy39y60GZuUlIeCx
	 PDKApzn0MLtLR/TIXy1TpawY/Y4N/y0r1zhSJh/7bmfJ14xpxoI6YZmV0Rg7JlxakMgo3
	 vk+VNM0+gKzWrSQWMPv8A3+BjpOdRNca7yBCWbB28KtYlUSa92ffyitKMhJa0EjXYjcjW
	 rQN03Q3yhQjongsgfBfARfuiRLTpJkHKJs5ykK6a2XY3nR3Dd5D806KsDhYUAZ0jElbbi
	 rcZaM8dfkxiiZqpkuAooRL+P6KNkzw2UzORpDwlunKnKWhkjlNHvo1bxXMyhW7dzF6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=jxENECQS;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A752606A319
	for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 08:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A752606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=jxENECQS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=NN7X2qHI+Bzp7O4aI/7aSCG0nt92AEk+cvxkkewI1xo=; t=1792573014;
	x=1793177814; b=jxENECQSD/OKYmTBB7aReuLflEVTTjTns9YrWR5UnIwFPN3yaNGMb+kV4ukb8
	dwy8Y7I7w6IISB6gdkf4Bs0edU3/qv0Cscx5O8sWlRJbaZf2qrI2IaitBsoQmU+j4HJvd3Bg6RXpf
	JduVMjErxSXF0xSodZ8/iqY0bpJhN0/0BgHOLh+rCpKiGUOEdRpggb6Edx8wYg65TYcqqEvC7HYrF
	mOvVizZNgfHgcGlzVmXnDvdzyTPWgr3P9XDRobQh68Q0wn/BObHn0/xygct/i/Cv8rodu7wZSzwJZ
	lTkayH/pZJ4AEQLk5OX/7U+Y1EUFzepQVduKC8ljuXG1/JplaA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xJS7w-00000001Kwc-0ic3; Wed, 21 Oct 2026 10:56:52 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xJS7v-00000003INo-2oEc; Wed, 21 Oct 2026 10:56:52 +0200
Message-ID: <843827c5eb85807d4f55a0d8a4cd572811ee3644.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: select BINFMT_FLAT_NO_DATA_START_OFFSET for noMMU
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Waldemar Brodkorb <wbx@openadk.org>, linux-sh@vger.kernel.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, 
 Damien Le Moal <damien.lemoal@wdc.com>
Date: Wed, 21 Oct 2026 10:56:50 +0200
In-Reply-To: <atgBKmRydeRteQ0T@waldemar-brodkorb.de>
References: <atgBKmRydeRteQ0T@waldemar-brodkorb.de>
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

On Wed, 2026-10-21 at 02:02 +0200, Waldemar Brodkorb wrote:
> binfmt_flat offsets the in-memory start of the data segment by
> MAX_SHARED_LIBS words and then aligns it to FLAT_DATA_ALIGN, so FLAT_FLAG=
_RAM
> binaries end up with a gap between text and data (commit 2217b9826246
> ("binfmt_flat: revert "binfmt_flat: don't offset the data start"")).
>=20
> SH position-independent code finds the GOT with a PC-relative mova of
> _GLOBAL_OFFSET_TABLE_, which assumes data follows text directly, as elf2f=
lt
> lays out the image. With the gap, the GOT register points below the real =
GOT,
> so every GOT load reads the neighbouring slot and gets a wrong pointer. O=
n a
> J2 (sh2eb, noMMU) this made userland crash or hang right after start-up.
> In my case the data was moved up by 0x20 bytes.
>=20
> Commit 04d82a6d0881 ("binfmt_flat: allow not offsetting data start") adde=
d
> CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET for architectures that cannot
> tolerate such a gap; currently only riscv noMMU selects it. Select it on =
SH
> as well when building without an MMU.
>=20
> Tested on a J2 board (Numato Mimas V2, sh2eb, noMMU) with Linux 7.3 and
> FLAT binaries built with elf2flt: with this change the data segment start=
s
> exactly at the end of text and init runs.
>=20
> Without the patch bootup fails with:
> [   12.080472] Fixing up unaligned userspace access in "init" pid=3D1 pc=
=3D0x(ptrval) ins=3D0x6583
> [   12.123609] Fixing up unaligned userspace access in "init" pid=3D1 pc=
=3D0x(ptrval) ins=3D0x6583
> [   12.175153] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x00007f00
>=20
> Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
> Assisted-by: LLM
> Fixes: 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset the =
data start"")
>=20
> ---
> v1->v2:
>   - add fixes tag (Geert)
>   - tested with 7.3 + Florian's uaccess patch (Geert)
>   - added failing bootup messages to commit message
> ---
>  arch/sh/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index d60f1d5a94c0..b501153551c0 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -15,6 +15,7 @@ config SUPERH
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_WANT_IPC_PARSE_VERSION
>  	select ARCH_NEED_CMPXCHG_1_EMU
> +	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>  	select CPU_NO_EFFICIENT_FFS
>  	select DMA_DECLARE_COHERENT
>  	select GENERIC_ATOMIC64

I have not tested this yet but I will do so later this week. Personally, I
test my kernel images on J2 with ToyBox which builds a minimal rootfs with
busybox.

I am not sure if the binaries are flat binaries in this case, do you know?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
