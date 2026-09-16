Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DBA436342;
	Wed, 16 Sep 2026 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587370; cv=none; b=dn6uJ5mOGHcV5IxT+RthuB/BTVxRlkgx8VoalzlVEd3+ISkHdhRLY7nifJt/6e8R2xu/cQyzKegYNfdeiAWOgGXOzCETndviBOWDwXnWx5qPfdcLDNBx23++aUj7vZh61FH8eC/rIMPWD7JMpRL/F6aeleG70TNCB0LJX/+xROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587370; c=relaxed/simple;
	bh=Tcb/S5YjwdxcjDkN5WDNWAixscZY3lgBbLCh+dDFu9I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UnCRd0DygUb0qJsi3kTe5qqCU3Bmqn2yXNRrrawQ1dpczAZmYoPGvSbQjSTDJ9oa7mWLzRzP6I9pFz+zgYqeVUL50kHBV+OPeO1SbVTwekDoH27s8TETPdUMgmimr437P9XozJxqbR7AAwqUSdnW8l0H4v4csCt26oVMZtXCOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=a10Exl+t; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="a10Exl+t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=c53S+pbiTHmrP9RTo7GY1zF1sPNtykP7X8lXQBRCBLs=; t=1789587350;
	x=1790192150; b=a10Exl+tjd3nGOyZQs4ptP8Tc3USll2CP19nk5esS2JXsR83/1VsFC07MsrQb
	YgJ+DZfl+9PK64HMBZ9M3Xrdj0t9U3NA/V92KZp5ju+qugPI9ox90P4NS0EbN7aYiRDdVWUuz37OY
	oATtxte9DccWWEMZYmQzbFpPMB21UKx7hTNKi7alb1azdQhOF9Eu4VV3E4/usaIttv4CfKKto4nIw
	bwNV13s3KMBAawviSbHBIf6ZOhjYFgIkl+35+KQqxY7cMdHigbeCLDahaPu7835gLvHGkWV9FV6aD
	9ogXA/j0M+hWPnLgv6sNrhPmfc0W6bjh9WVVdzG4AMUzQXlA2g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x6vPz-00000001HHH-0BXx; Wed, 16 Sep 2026 21:35:43 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x6vPy-000000036ws-3LeZ; Wed, 16 Sep 2026 21:35:42 +0200
Message-ID: <39b2e329b1db35a1171833deb497f7e1a0850918.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: lib: Restore r4 in shift helpers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato
	 <yoshinori.sato@nifty.com>, linux-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 21:35:42 +0200
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

Hi Florian,

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
> =20
>  	.align	2
>  ashlsi3_table:
> diff --git a/arch/sh/lib/ashrsi3.S b/arch/sh/lib/ashrsi3.S
> index bf3c4e03e6ff..9962d7c587df 100644
> --- a/arch/sh/lib/ashrsi3.S
> +++ b/arch/sh/lib/ashrsi3.S
> @@ -62,8 +62,9 @@ __ashrsi3_r0:
>  	mova	ashrsi3_table,r0
>  	mov.b	@(r0,r4),r4
>  	add	r4,r0
> +	mov.l	@r15+,r4
>  	jmp	@r0
> -	mov.l	@r15+,r0
> +	mov	r4,r0
> =20
>  	.align	2
>  ashrsi3_table:
> diff --git a/arch/sh/lib/lshrsi3.S b/arch/sh/lib/lshrsi3.S
> index b79b8170061f..9218f0bad1cc 100644
> --- a/arch/sh/lib/lshrsi3.S
> +++ b/arch/sh/lib/lshrsi3.S
> @@ -62,8 +62,9 @@ __lshrsi3_r0:
>  	mova	lshrsi3_table,r0
>  	mov.b	@(r0,r4),r4
>  	add	r4,r0
> +	mov.l	@r15+,r4
>  	jmp	@r0
> -	mov.l	@r15+,r0
> +	mov	r4,r0
> =20
>  	.align	2
>  lshrsi3_table:

The change looks reasonable to me, but I'm not 100% sure I understand the
code in detail at the moment, so I'll have to take another look tomorrow
when I'm more awake and had a coffee.

Given the fact that this unbreaks J2, we should pick it up for v7.4 once
I have fully understood the changes.

@Geert: Could you have another look at this and let me know what you think?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
