Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E34CA78B;
	Fri, 16 Oct 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158648; cv=none; b=ljj4qzFqhOTZkIVWVTrgw8IkNEmG3T7C6kUk/FEH9bsieA03+VKBe9Vk1mOKjaymYlW9a7HmHqjtT2GFkI4l8mNYhRk8C5hauIem0IQxqD4qI06gIdiGVbzLtaL/rwJW4Bcblz7d9KdnKDoqzcY4NWtgq9B9QObNFNtmXmLlFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158648; c=relaxed/simple;
	bh=n4/VRt6W4WN2nnymbTJWd/zO+oyjr+nQVB8vwqngF/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDwnrfvifoaWjHZEHOE3yIMPj+EBLBgbeMiD44hYZVTgIwyAKTqDjL0abevKaoBWFHMS1GLHVlDNgR5Z6wrtMLpkV4FZXx6Iz764A3oI2Ss2QYboWWky4VsdKZN5z3jbMbP5X5Hks3s6l86397THcKwIH2l+y+pbc1AiV862itU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Mbr1Wsx/; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Mbr1Wsx/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Q4UsDgRYaanQzQK3Wt/yZkiQ+b6Z8NemUZLB73f4xbU=; t=1792158644;
	x=1792763444; b=Mbr1Wsx/mkjPj3hIcufZhig5q+yesxLDTZs79XXltKU2HXkthSHUGjQXCC3bf
	0FlE/n7ay9wocb385gU3F//AsLztJVXd4AAOU8ICpWaGj5AJWG1do4QWOYrZQKBSV1Qri6BV6p9M5
	88yjgWOp1bdJ3eQSD/upOwynnjetRWp2rCL3INhJLHG31FVep0thXCQE/qUdIWHCzQcozBBuTOG9h
	Rd4UsMooR6OzmVnFCsAWrctT8081/VH1qSv9QUZ4qB0uvfkyEvTBxXuWMdnhiTlYsPw4mcmoC/xXC
	2Q5CgDFfekaBGQtXjcv7qgCpQfhxcqiW3IXbm4cfr3IiKm1gGg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xHiKR-00000001YOp-1y6g; Fri, 16 Oct 2026 15:50:35 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xHiKR-00000003zsT-0zJB; Fri, 16 Oct 2026 15:50:35 +0200
Message-ID: <f46a2ef98217b3cb6bd374b9bdf0bcb2e3227940.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: mm: fix double mmap_lock release on SIGBUS and
 SIGSEGV faults
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato
	 <yoshinori.sato@nifty.com>, Rich Felker <dalias@libc.org>
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 16 Oct 2026 15:50:34 +0200
In-Reply-To: <atHwnaEUDihOsGUQ@gmail.com>
References: <20260928001937.12793-1-kmehltretter@gmail.com>
	 <atHwnaEUDihOsGUQ@gmail.com>
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

Hi Karl,

On Fri, 2026-10-16 at 11:46 +0200, Karl Mehltretter wrote:
> On Mon, Sep 28, 2026 at 02:19:37AM +0100, Karl Mehltretter wrote:
> > A process that survives the signal keeps an mm with a corrupted
> > mmap_lock. With CONFIG_DEBUG_RWSEMS and lockdep, stress-ng --msync
> > (which catches SIGBUS) reports within a minute:
> >=20
> >   WARNING: bad unlock balance detected!
> >   stress-ng-msync/54 is trying to release lock (&mm->mmap_lock) at:
> >   mm_fault_error+0xd0/0x16c
> >   ...
> >   DEBUG_RWSEMS_WARN_ON(tmp < 0): count =3D 0xffffff00, ...
> >=20
> > and without them, find_vma() warns that mmap_lock is not held right
> > after it was taken. Seen on a custom QEMU model of the SH7785LCR, in
> > both 29-bit and 32-bit mode.
> >=20
> > Drop the release from do_sigbus(), whose only caller is
> > mm_fault_error(), and use bad_area_nosemaphore() for VM_FAULT_SIGSEGV.
> > bad_area() has no users left and goes away.
> >=20
> > Fixes: fb027ada051a ("sh/mm: use helper fault_signal_pending()")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> > ---
> >=20
> > Notes:
> >     Tested in QEMU on a custom SH7785LCR model, not on hardware.
> >     Reproducer: Debian sh4 stress-ng 0.22.01 --msync
> >=20
>=20
> A friendly ping on this fix.
>=20
> I have now also reproduced it with stock QEMU 11.0.2 on the upstream
> r2d machine (SH7751R): the unpatched kernel warns after a caught SIGBUS,
> while the patched kernel does not.
>=20
> Also, the stress-ng command in the review notes is incorrect. Use:
>=20
>   stress-ng --msync 1 --timeout 60s

I'm trying to get this reviewed in the weekend. I'm not forgetting about
patches as I'll always check what's on patchwork and pick everything up
that I haven't taken yet [1].

Adrian

> [1] https://patchwork.kernel.org/project/linux-sh/list/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
