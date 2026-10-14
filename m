Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925447206C;
	Wed, 14 Oct 2026 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964843; cv=none; b=AE5gmO56iStwp/yJQSddLRmSBKt2ONPMHwgBWVruCAX7K083yycDtp5w7FdaW/sk0IwT9YjSV/L++4TLxXkueZviqukRBhzZMRXvrowofv6zkQIodnIVPq1n0+AzGgfPcdZ9ONGG05lN3575h7SBfRkbELYh6E5QI26VRS43R4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964843; c=relaxed/simple;
	bh=vFkDkhBeMhFRutuDvCdetF0ADDVBdqx4xV+1n4POMYY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u0MLF56/pQ/OcdL5cFOgEs2emyaJb1b8MKcUjp14gz6XuHCDp/ORudorpDdsQ+xrpHiazIwwcsm9JaVEL+PY/+r72E15RPKdWjcsEDZAEjk5r7xJVIXiMk0CDYBjvNbyYgGgNqaBTvz5auIDH17NxAJZ2/KRUNAU6aEb6spdPFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=WbnLHdwA; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="WbnLHdwA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=60tx3zRz4erFrmECiL1J6M/Q1u0CPmk03XyybwSmiQE=; t=1791964840;
	x=1792569640; b=WbnLHdwAbDiyKwttZrPGydki/lcr7RgGI2H43jwq6BVSO8QWwvNkiWdZ9ljqx
	ckv4kX3LxIC0/pvlD2n0ukPsexKLxP1Sh4i0m5iOgK14tRsOHO6l19sRfxGTay94XCh8trbYZkhsh
	ZZ2pj1XbfOY6q/ZW8YQGU986SSCuQXVgEu+CjtRUeaNC+88mEVufpaHPlBoGhWVFD58A8XLTloVB9
	SyxPtbZrZwV7go7O+K9IkN2ZSAV5H18DhYTlYt/l4ul3Hg4WXwzvRPk/zhVzhxjkarIMJ90BHkB0X
	GZgtFH6CEXLBJsANLcF5Rg9oFcDQrnfBHjOzIyXS7WXAmLysyA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xGtue-00000003nJh-0cYc; Wed, 14 Oct 2026 10:00:36 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xGtud-000000031lG-3oYf; Wed, 14 Oct 2026 10:00:36 +0200
Message-ID: <3b5171841776d58f0d19fbe585b356e2a7f7480e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling
 them
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Karl Mehltretter
	 <kmehltretter@gmail.com>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Rich Felker
 <dalias@libc.org>, 	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 10:00:35 +0200
In-Reply-To: <CAMuHMdXfpChkH-Ad5x7p579+4rBQtfF5CKwwRrdZ6CxDPDWMCg@mail.gmail.com>
References: <20260927191359.6144-1-kmehltretter@gmail.com>
	 <CAMuHMdXfpChkH-Ad5x7p579+4rBQtfF5CKwwRrdZ6CxDPDWMCg@mail.gmail.com>
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

Hi Geert,

On Wed, 2026-10-14 at 09:03 +0200, Geert Uytterhoeven wrote:
> Hi Karl,
>=20
> On Sun, 27 Sept 2026 at 21:14, Karl Mehltretter <kmehltretter@gmail.com> =
wrote:
> > register_intc_controller() sorts d->prio and d->sense right after
> > allocating them, with hw->nr_prio_regs and hw->nr_sense_regs as the
> > element count. The lists hold hw->nr_vectors entries and are only
> > filled later, by intc_register_irq().
> >=20
> > On SH7785, sh7785-irq0123 and sh7785-irq4567 have four vectors but the
> > SoC's eleven priority registers, so sort() swaps 88 bytes in a 32 byte
> > kmalloc object at boot. slub_debug=3DFZPU reports "Right Redzone
> > overwritten" in kmalloc-32, and v6.5 and v6.6 panic in
> > __kmem_cache_alloc_node() while registering sh7785-irq0123.
> >=20
> > Found with a custom QEMU model of the SH7785LCR. On it, v6.4
> > sh7785lcr_defconfig boots with SLAB, the defconfig default before v6.5,
> > and hangs before the console is up when built with SLUB.
> >=20
> > Sort the lists once all vectors are registered, with the number of
> > entries that were added.
> >=20
> > Fixes: b59f9f9775e6 ("sh: intc: optimize intc IRQ lookup")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/sh/intc/core.c
> > +++ b/drivers/sh/intc/core.c
> > @@ -275,9 +275,6 @@ int __init register_intc_controller(struct intc_des=
c *desc)
> >                         k +=3D save_reg(d, k, hw->prio_regs[i].set_reg,=
 smp);
> >                         k +=3D save_reg(d, k, hw->prio_regs[i].clr_reg,=
 smp);
> >                 }
> > -
> > -               sort(d->prio, hw->nr_prio_regs, sizeof(*d->prio),
> > -                    intc_handle_int_cmp, NULL);
>=20
> Yeah, if hw->nr_prio_regs > hw->nr_vectors, this overflows d->prio[].
> Furthermore, this sorting is useless, as d->prio[] is still empty
> (all zeroes).
>=20
> >         }
> >=20
> >         if (hw->sense_regs) {
> > @@ -287,9 +284,6 @@ int __init register_intc_controller(struct intc_des=
c *desc)
> >=20
> >                 for (i =3D 0; i < hw->nr_sense_regs; i++)
> >                         k +=3D save_reg(d, k, hw->sense_regs[i].reg, 0)=
;
> > -
> > -               sort(d->sense, hw->nr_sense_regs, sizeof(*d->sense),
> > -                    intc_handle_int_cmp, NULL);
>=20
> Similar.
>=20
> >         }
> >=20
> >         if (hw->subgroups)
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for the additional review. I have already merged this patch in my
tree, but I will add your Reviewed-by with some git foo.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
