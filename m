Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F1374735;
	Thu, 17 Sep 2026 07:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629429; cv=none; b=ezwjjPSLkv4oC4sIQ2no+mrz2okQKS7p9dFCFuBowQ27vQ/vPt9OLBmbY4V69NUWqUxUEFAbKN/dmhurwSeDaCEIrvzv2E7vyOyIt7Zxi9qZgYk3/JSjVXvT+gSuQ1OYRV7AtYKfd0XLNDBr/7mZRan8dDfHbWIzjahb98GSkJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629429; c=relaxed/simple;
	bh=6jpcI/gnGPXCuIu9T+DoZYnzF/oxOh2gSFbbipL4bWA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LH0lVeaRQyeubiz0bd6si8t9cHcMkUB6Usol11P8HuPvB/gBnEpJ3VxSvIYvylsgqKNrL0suu25mfEsdo/qeVB8jWMeFPtc27Vag0Rf9BniwhdwixbAY61xhJWCgRBFdoeUcsxMs0l4VwFIVqka1ACi3KIIYi4mxEo1pziau+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=AzF4ENGd; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="AzF4ENGd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ewSGL9omp7E5j2kipp6vgIKxit9QEcUNRslfVeTSeSA=; t=1789629425;
	x=1790234225; b=AzF4ENGdMHF18QeTlMHxe4ny+uUXdm7NveeeRCKyLRV+8ZxwDluQOlphdLe8v
	BZH9DIOQ9rpOkv2cTdGfeMRChT8DNON9NoL4zorq8PxxWUuPOqvursHR2UBiX312X/IVxy4W25jlD
	4bTQznxfaaIg8UiPm25PdSSqFnR2rHifFQ3reb/NogvRsnk2du0d2rQPGMurIXJrOeImYUQrUv+Sz
	YnPQiI74DiBzeBexfyvsqPk6h6rvxCnD9SjfuYavolT9EugAlxYvxOuyqblKnsFRoxmXrxwy1Zbm4
	X63bFo55NrdpAvMLS6t1o7oovrcx5SR/Uzhi8tVW15Lr60aAxA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x76Mf-000000043lr-1ssK; Thu, 17 Sep 2026 09:17:01 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x76Mf-00000000jWn-0y41; Thu, 17 Sep 2026 09:17:01 +0200
Message-ID: <85c4e0b40ec4b52b73c1525c2340cdaf31fd7d6a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: lib: Restore r4 in shift helpers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato
	 <yoshinori.sato@nifty.com>, linux-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 09:17:00 +0200
In-Reply-To: <20260714104147.2016549-1-fuchsfl@gmail.com>
References: <20260714104147.2016549-1-fuchsfl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Florian.

On Tue, 2026-07-14 at 12:41 +0200, Florian Fuchs wrote:
> Commit 940d4113f330 ("sh: New gcc support") added new shift helpers
> that use r4 as a scratch register while dispatching to the selected shift
> sequence. But, the helpers return without restoring r4. With GCC 17, the
> register allocator can keep a live value in r4 across the helper call.
> Clobbering it results in runtime data corruption. Restore r4 before
> jumping to the selected shift sequence.
>=20
> Fixes: 940d4113f330 ("sh: New gcc support")
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> ---
> Without the patch, the early boot on e.g J2 gets a kernel BUG at
> mm/percpu.c:2604 / "can't handle more than one group."
>         PCPU_SETUP_BUG_ON(pcpu_verify_alloc_info(ai) < 0);
> As the static condition in mm/percpu-km.c wasn't true:
>         ai->nr_groups !=3D 1
> nr_groups contained 60 - the clobbered value from the shift helper.
>=20
> This change was tested on the J2 core on the Mimas v2 board. It can
> theoretically also target other SH2 devices, but I don't have any other
> than J2 sadly.
>=20
> The flow of operations matches now the state in the libgcc, see also
> in gcc: libgcc/config/sh/lib1funcs.S
> ---
>  arch/sh/lib/ashlsi3.S | 3 ++-
>  arch/sh/lib/ashrsi3.S | 3 ++-
>  arch/sh/lib/lshrsi3.S | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/sh/lib/ashlsi3.S b/arch/sh/lib/ashlsi3.S
> index 4df4401cdf31..73a9d709b169 100644
> --- a/arch/sh/lib/ashlsi3.S
> +++ b/arch/sh/lib/ashlsi3.S
> @@ -63,8 +63,9 @@ __ashlsi3_r0:
>  	mova	ashlsi3_table,r0
>  	mov.b	@(r0,r4),r4
>  	add	r4,r0
> +	mov.l	@r15+,r4
>  	jmp	@r0
> -	mov.l	@r15+,r0
> +	mov	r4,r0
>=20

Please correct me if I'm wrong, but after reading the code in [1], it looks
to me as your patch doesn't preserve r4 but it's actually storing it into
r0 to be used by the selected shift sequence.

With the previous code, r4 is pushed onto the stack first but not restored
before the shift sequence is jumped to, so what your patch does not make su=
re
that r4 is restored across the complete call of the shift helper but rather
restore the input value in r4 from the stack before calling the jump sequen=
ce.

What am I missing?

Adrian

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/sh/lib/ashlsi3.S

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
