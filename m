Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05685367B90;
	Sat, 26 Sep 2026 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790448240; cv=none; b=WSUexuMTg/kj38l6W8YoZBnYcCbSrMxJEpc+nWHrunW2/xHs+63is9bcy/umc1wuJdfTp4jQvnx5aC4kRPKywe3SIW7OFDZZugj5uSV3A4bQ//2UHfu9eWjxihgsoLATlfSS0VVXOItCZQHbU4yV+JNialF8uP3ANk54B2Z+Ft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790448240; c=relaxed/simple;
	bh=QIURmYUXBk4CGBkNo+YfBoc/rv9JGk/MEDxiCObHAY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iTGrcv6UvS8n7I8mrmws7Q9Xkic7ZBzjUxIKFnCdSUZx15Pl0ANAIM3lZsNdZ0jlvgLzR2a+1R30xz2XByZRdVqF9NDXeVOgiq76NdSasiIzCvud/i/iF+M4QGe7Xj2cP9uy86qEOXHcWwF5Y6JxXyym3aDurqg8Zhm2WRxTuws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=DMpb17R7; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="DMpb17R7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ZRqdnQVYOWo/r4+FEgARvCAFTE8PSP6/Q+C1nHisg48=; t=1790448237;
	x=1791053037; b=DMpb17R7ahwBf2TPJAWOlB41YYPtIrB2D222YhWIfQgWVVnZ5cg5zJZKAnsXo
	cV2j+q5x3X6zxckT9EXUoU6I3xOXzgISe4Rmd1MDZKJ7echI32Hkjs7jGooPbnHbC8Q4e+F3qTI7B
	78Lr9VRriiOBx2SS6kk/Qe4Af2VGlcWPvztju/HybRuTVrF40Dv9GXCEkchkAwgcyjNrQWxDVHynK
	m6aDmuoUH5dDSs9rvlEo5zJx25FDM/qN7OHatJ2FVsZDIBNTfbXBLkLmJuWV+capb9npOXC0K3/+C
	+3UzaB0algKrjBsNJjRd/PkdhhvtsAiZ1bV+TqlzKlP5owofYA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xAXNC-00000000zck-2x3m; Sat, 26 Sep 2026 20:43:46 +0200
Received: from dynamic-002-245-050-003.2.245.pool.telefonica.de ([2.245.50.3] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xAXNC-000000022yM-1ytU; Sat, 26 Sep 2026 20:43:46 +0200
Message-ID: <9b75aa51e19f9c0f5c97ac02cfc0948ab5bbf279.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] sh: mm: fix hugetlb on SH-4
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, Muchun Song <muchun.song@linux.dev>, Oscar
 Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Andrew
 Morton	 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Date: Sat, 26 Sep 2026 20:43:45 +0200
In-Reply-To: <20260926183904.76186-1-kmehltretter@gmail.com>
References: <20260926183904.76186-1-kmehltretter@gmail.com>
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

On Sat, 2026-09-26 at 20:39 +0200, Karl Mehltretter wrote:
> Muchun Song noted in the review of the Arm hugetlb alignment fix [1]
> that SuperH has the same arch_get_unmapped_area() gap. Reproducing it
> in QEMU turned up a second, older bug that corrupts memory once the
> mappings are aligned.
>=20
> Patch 1 fixes the page size in hugetlb PTEs. pte_mkhuge() ORs the huge
> size into the base page size bits, so 64 KiB huge pages over 4 KiB
> pages are loaded into the TLB as 1 MiB pages. User writes then land in
> unrelated kernel memory. This dates back to the start of git history.
>=20
> Patch 2 aligns hugetlb mappings to the huge page size. Without it
> mmap(MAP_HUGETLB) can return an address that is not aligned to the huge
> page size, and process exit hits the BUG_ON() in
> __unmap_hugepage_range(). This is a 6.13
> regression.
>=20
> Patch 1 goes first because patch 2 alone makes the corruption reachable
> through a plain mmap(). Both are marked for stable.
>=20
> Tested on QEMU r2d (SH7751R, rts7751r2dplus_defconfig plus HUGETLBFS
> with 64 KiB huge pages, gcc 15.2) on top of fddfc3ec3179. A test init
> maps two huge pages with the default and legacy layouts and with
> MAP_FIXED, writes and reads back every 4 KiB, mprotect()s the mapping
> read-only and back, and checks a COW write in a forked child:
>=20
>   kernel          MAP_FIXED       default/legacy mmap
>   base            memory corrupt  misaligned, BUG at mm/hugetlb.c:5215
>   patch 1         pass            misaligned, BUG
>   patches 1+2     pass            pass
>=20
> SH-X2 (X2TLB) is only build tested (r7785rp_defconfig with 64 KiB huge
> pages).
>=20
> QEMU's SH-4 TLB emulation flushes only the first 4 KiB of a 64 KiB or
> 1 MiB entry when the entry is dropped [2]. Keep that in mind when
> testing hugetlb on QEMU.
>=20
> [1] https://lore.kernel.org/r/5AB6FE85-4CB9-41EF-A700-BC5E071F29F5@linux.=
dev
> [2] https://gitlab.com/qemu-project/qemu/-/issues/4598
>=20
> Karl Mehltretter (2):
>   sh: mm: replace the page size bits in pte_mkhuge()
>   sh: mm: align hugetlb mappings to the huge page size
>=20
>  arch/sh/include/asm/pgtable_32.h |  7 +++++--
>  arch/sh/mm/mmap.c                | 11 +++++++++--
>  2 files changed, 14 insertions(+), 4 deletions(-)

Thanks for the patch! This should definitely be tested on real hardware
and I think it's a good reason to test this on my SH7785LCR which wouldn't
boot on anything newer than 6.5.0.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
