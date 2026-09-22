Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EF753D0B8;
	Tue, 22 Sep 2026 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084469; cv=none; b=CfSCwUCzSGjY7nmkBFPgD19ZVDPZYWpkl/pAtCGHWWLzdYwrxGqObHct8PufE5pAyIIm1csg5hOt56Ruy24Kut2Djn2jfjdRDzil5ZtdfeB1G3x1eFTFfJ2IhQTGEvUHeZhq36+F53rXzQiulp4V80Ep9EezYXUUzDyKXw7tnQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084469; c=relaxed/simple;
	bh=BweRxChOb1YJ+v1k+q0APDIQLDMitADy+y81pzhDgxk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uzFGzop+f2JXEYvH1YLEUxXzcyRGfXc8L7sBPjRnkxBltKJWJyUOym1GHLLHpL7NMEvHTGImGLN8iPqCX6ouDQ7B1hoQ4qS419I8XbOMg3w1nv6NaCVA1yFos0Q1KAPhYbvYXzapAA4FctSnUGWUuNU6zRsjZgpeEDNIFY3QmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Y88+0lDB; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Y88+0lDB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=A1BmD7uV+jx9BE3ZuI47mj1H51SirUH7E2mLXR8RXfg=; t=1790084465;
	x=1790689265; b=Y88+0lDByM2CzEq8pWsXk/paebTbX8g7JHjKTZh1d61JErtbdVahdCO+Jo3Zo
	YPrkoyR5UNaEBenIO5WIyId2OU4K7wp3BYHBqJnd/sAlNGg2aQAT2rU4b4ITRKXKhZgrgCxK6bdnL
	C4cKOVlDXLIvSq2ItVeVQkVIQH3azcd6OU1o37s4QmP5QSZd0cUZ0r0ZpW2ynTvzJpcqFDYvR8edk
	BGWg9bSyAi3GdWlbNkokEh0bQDZEzEzEn8o0/hNT8+34wg6oWYYfuEcgMdffgQo72GjAxB2n0vmqa
	gUfQjGn0xrDuu098Rb0px7TZvoo6AuZSdQHbLKOMo/CxciDE5g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x90jw-00000001GNN-0tV1; Tue, 22 Sep 2026 15:40:56 +0200
Received: from ip-091-065-133-205.vkd74.pools.vodafone-ip.de ([91.65.133.205] helo=[192.168.178.21])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x90jw-00000003g9X-013A; Tue, 22 Sep 2026 15:40:56 +0200
Message-ID: <66b9707696392e324cd28277caab46506e7422e4.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: lib: Restore r4 in shift helpers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: yoshinori.sato@nifty.com
Cc: Florian Fuchs <fuchsfl@gmail.com>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 15:40:55 +0200
In-Reply-To: <87ld8t77aq.wl-yoshinori.sato@nifty.com>
References: <20260714104147.2016549-1-fuchsfl@gmail.com>
		<85c4e0b40ec4b52b73c1525c2340cdaf31fd7d6a.camel@physik.fu-berlin.de>
	 <87ld8t77aq.wl-yoshinori.sato@nifty.com>
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

Hi Yoshinori,

On Tue, 2026-09-22 at 22:19 +0900, yoshinori.sato@nifty.com wrote:
> On Thu, 17 Sep 2026 16:17:00 +0900,
> John Paul Adrian Glaubitz wrote:
> >=20
> > Hi Florian.
> >=20
> > On Tue, 2026-07-14 at 12:41 +0200, Florian Fuchs wrote:
> > > Commit 940d4113f330 ("sh: New gcc support") added new shift helpers
> > > that use r4 as a scratch register while dispatching to the selected s=
hift
> > > sequence. But, the helpers return without restoring r4. With GCC 17, =
the
> > > register allocator can keep a live value in r4 across the helper call=
.
> > > Clobbering it results in runtime data corruption. Restore r4 before
> > > jumping to the selected shift sequence.
> > >=20
> > > Fixes: 940d4113f330 ("sh: New gcc support")
> > > Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> > > ---
> > > Without the patch, the early boot on e.g J2 gets a kernel BUG at
> > > mm/percpu.c:2604 / "can't handle more than one group."
> > >         PCPU_SETUP_BUG_ON(pcpu_verify_alloc_info(ai) < 0);
> > > As the static condition in mm/percpu-km.c wasn't true:
> > >         ai->nr_groups !=3D 1
> > > nr_groups contained 60 - the clobbered value from the shift helper.
> > >=20
> > > This change was tested on the J2 core on the Mimas v2 board. It can
> > > theoretically also target other SH2 devices, but I don't have any oth=
er
> > > than J2 sadly.
> > >=20
> > > The flow of operations matches now the state in the libgcc, see also
> > > in gcc: libgcc/config/sh/lib1funcs.S
> > > ---
> > >  arch/sh/lib/ashlsi3.S | 3 ++-
> > >  arch/sh/lib/ashrsi3.S | 3 ++-
> > >  arch/sh/lib/lshrsi3.S | 3 ++-
> > >  3 files changed, 6 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/arch/sh/lib/ashlsi3.S b/arch/sh/lib/ashlsi3.S
> > > index 4df4401cdf31..73a9d709b169 100644
> > > --- a/arch/sh/lib/ashlsi3.S
> > > +++ b/arch/sh/lib/ashlsi3.S
> > > @@ -63,8 +63,9 @@ __ashlsi3_r0:
> > >  	mova	ashlsi3_table,r0
> > >  	mov.b	@(r0,r4),r4
> > >  	add	r4,r0
> > > +	mov.l	@r15+,r4
> > >  	jmp	@r0
> > > -	mov.l	@r15+,r0
> > > +	mov	r4,r0
> > >=20
> >=20
> > Please correct me if I'm wrong, but after reading the code in [1], it l=
ooks
> > to me as your patch doesn't preserve r4 but it's actually storing it in=
to
> > r0 to be used by the selected shift sequence.
> >=20
> > With the previous code, r4 is pushed onto the stack first but not resto=
red
> > before the shift sequence is jumped to, so what your patch does not mak=
e sure
> > that r4 is restored across the complete call of the shift helper but ra=
ther
> > restore the input value in r4 from the stack before calling the jump se=
quence.
> >=20
> > What am I missing?
> >=20
> > Adrian
> >=20
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/arch/sh/lib/ashlsi3.S
> >=20
> > --=20
> >  .''`.  John Paul Adrian Glaubitz
> > : :' :  Debian Developer
> > `. `'   Physicist
> >   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
>=20
> Here is the modified code snippet.
>=20
> 	and	#31,r0
> 	mov.l	r4,@-r15
> 	mov	r0,r4
> 	mova	ashlsi3_table,r0
> 	mov.b	@(r0,r4),r4
> 	add	r4,r0
> 	mov.l	@r15+,r4
> 	jmp	@r0
> 	mov	r4,r0
>=20
> I understand that r4 no longer changes as a result of this modification.
> While the sh function-calling convention permits the `r4` register to be
> clobbered, the `libgcc` included with GCC does not actually clobber `r4`,
> and GCC's own rules appear to rely on `r4` remaining intact during such c=
alls.
>=20
> This change won't break builds with older versions of GCC, so I think it'=
s
> fine to go ahead and apply it.

Can you please add your Reviewed-by?

Also, could you please update your mail address in MAINTAINERS?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
