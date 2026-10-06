Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3EF3914FF;
	Tue,  6 Oct 2026 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791265321; cv=none; b=e84C1oGhIx9x2/DRN8ZMq5tPfInVUlZUhYW1USDLa0M0N3EMr0wn9QzUqhtQGBilw92hHF0E0GzvV6x0Q/jflVQsmh1OP1KJXz0U3auHabrVog9jq/FaYwi2qN/WzT737mN5Vl/oymsD8C7/2qpeBOoS/7tzSX6j+u8B80W/r5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791265321; c=relaxed/simple;
	bh=nstkmpmHL6bOYtuVnjDIMpLQnmmlABn+5Rf3v962yYU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lay9q+bPAErH/+j3Bg+71hYhcFOMHvct7qhpGMMfjajnMxTm1OCtviWbWA+5hpkPo11Jhjwc8X120hsGU765mn9oDNYUNAg9hA0JsZP69tZGyyDVq+M7fKvSXPdseo9aJriYqffHymIabTNogKWdH0e+uUzEYzosFw2f23IMGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=YulTShn1; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="YulTShn1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=3Isc+1hoF0Wm6EgexowntuLCVU7EvtTDCPNKTqd9XDQ=; t=1791265319;
	x=1791870119; b=YulTShn1GjC1kaw5m8y2cndHQIithhqd62OdMqSHQ59dsazuOHzhGSWFrOx88
	NjbjFlk1lydB2lJIGftcy9aVeWsF2nrR/k3B99fcXC33vN8PYSEachHSHIO+npV71jvLsOVkFqca2
	21qp3fllWVKuL+t22M5P0eLsqXSV/Qn+G6WDfRSajNiJqaitE+8VBW9IxgQEukUROt0cWNmLlg8Rt
	PmF0ArRj14SHRhiS1lGB3G7xZ+ztSQkwxtlFyhnrOM5Ehyh1hqU0FPJodsKcHfb5r8lLjxg9ubqBH
	2taVTMI0ojVEb/l7ureB0h5thKnUx+xnWLAzrOQp7xXo9MA0yA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xDxw3-000000005zS-487Y; Tue, 06 Oct 2026 07:41:56 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xDxw3-00000002vqK-2fjb; Tue, 06 Oct 2026 07:41:55 +0200
Message-ID: <e2d4c042a53eddc1ea8d800e171e6c59c9d3f7e1.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: lib: Restore r4 in shift helpers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato
	 <yoshinori.sato@nifty.com>, linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 07:41:54 +0200
In-Reply-To: <85c4e0b40ec4b52b73c1525c2340cdaf31fd7d6a.camel@physik.fu-berlin.de>
References: <20260714104147.2016549-1-fuchsfl@gmail.com>
	 <85c4e0b40ec4b52b73c1525c2340cdaf31fd7d6a.camel@physik.fu-berlin.de>
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

On Thu, 2026-09-17 at 09:17 +0200, John Paul Adrian Glaubitz wrote:
> Hi Florian.
>=20
> On Tue, 2026-07-14 at 12:41 +0200, Florian Fuchs wrote:
> > Commit 940d4113f330 ("sh: New gcc support") added new shift helpers
> > that use r4 as a scratch register while dispatching to the selected shi=
ft
> > sequence. But, the helpers return without restoring r4. With GCC 17, th=
e
> > register allocator can keep a live value in r4 across the helper call.
> > Clobbering it results in runtime data corruption. Restore r4 before
> > jumping to the selected shift sequence.
> >=20
> > Fixes: 940d4113f330 ("sh: New gcc support")
> > Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> > ---
> > Without the patch, the early boot on e.g J2 gets a kernel BUG at
> > mm/percpu.c:2604 / "can't handle more than one group."
> >         PCPU_SETUP_BUG_ON(pcpu_verify_alloc_info(ai) < 0);
> > As the static condition in mm/percpu-km.c wasn't true:
> >         ai->nr_groups !=3D 1
> > nr_groups contained 60 - the clobbered value from the shift helper.
> >=20
> > This change was tested on the J2 core on the Mimas v2 board. It can
> > theoretically also target other SH2 devices, but I don't have any other
> > than J2 sadly.
> >=20
> > The flow of operations matches now the state in the libgcc, see also
> > in gcc: libgcc/config/sh/lib1funcs.S
> > ---
> >  arch/sh/lib/ashlsi3.S | 3 ++-
> >  arch/sh/lib/ashrsi3.S | 3 ++-
> >  arch/sh/lib/lshrsi3.S | 3 ++-
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/sh/lib/ashlsi3.S b/arch/sh/lib/ashlsi3.S
> > index 4df4401cdf31..73a9d709b169 100644
> > --- a/arch/sh/lib/ashlsi3.S
> > +++ b/arch/sh/lib/ashlsi3.S
> > @@ -63,8 +63,9 @@ __ashlsi3_r0:
> >  	mova	ashlsi3_table,r0
> >  	mov.b	@(r0,r4),r4
> >  	add	r4,r0
> > +	mov.l	@r15+,r4
> >  	jmp	@r0
> > -	mov.l	@r15+,r0
> > +	mov	r4,r0
> >=20
>=20
> Please correct me if I'm wrong, but after reading the code in [1], it loo=
ks
> to me as your patch doesn't preserve r4 but it's actually storing it into
> r0 to be used by the selected shift sequence.
>=20
> With the previous code, r4 is pushed onto the stack first but not restore=
d
> before the shift sequence is jumped to, so what your patch does not make =
sure
> that r4 is restored across the complete call of the shift helper but rath=
er
> restore the input value in r4 from the stack before calling the jump sequ=
ence.
>=20
> What am I missing?
>=20
> Adrian
>=20
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/arch/sh/lib/ashlsi3.S

Could you comment on this and maybe rephrase your commit message if you agr=
ee
with my analysis? The patch itself is fine, but I think the description is
somewhat inaccurate.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
