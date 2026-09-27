Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7531F98D;
	Sun, 27 Sep 2026 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790539112; cv=none; b=XU7uA3oxJ/6BYS8oi8KiI5vikFOHPlsCDvOq5q1cZk7m2DdVNWeOsLAEgXLZniB04O35oNF16S14QHtFJ62IbAvJNPNmbZrB+cTr5pMJ5fYkHqmtcrK8nX6AlUsgMj9zcafTGyVRGbybAOwT/C0YalaKE6ck6XW+m/BSSvZ07bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790539112; c=relaxed/simple;
	bh=7VCFpXN7cYc8sdLGYAvNE0FP5Hzr0vRjjO5R9rfGcGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MSpTaSlY+2zbFUUC3OpI54c5hytf4kgjoGNozmeFBlA2PoxQsb3UkWvMSJd5Z5lpM1mPdJ4smP04qSm8JDqCwIzhMp6rVzINT2ImbTCqezU1KkiAr/4sonWRj7wvbidAYcbOu72S7QAAgL/xbiTh03XCxkxfWioCO6qyTDMOI5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=c1lkDCFX; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="c1lkDCFX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=VmUTXC2IsZgXuwZJ1u8D9MwDqxE4b1ifYD3+hAizTzI=; t=1790539108;
	x=1791143908; b=c1lkDCFXsffOLI3g7o3FiVdIPSiG4WY6UxEadveeBskXOdT87dTJnDySbvvFW
	v8/b9XIbk3JD7TPxGBwR2+yokt/YiYjdLf4XjxA2P69VXDsk7OittJoncXaPHVcdbP/BphrpVaKjM
	yunIFb1iED69FiMeR0nFHseQSRoSjjd11cwitC0GcaLRaf++F5zJT52sI2QPC+8SwUkBy/SoVrOWA
	hEH+UocAfnMaqT3WZqwVs7AVKJcb0W1axkFHME9flPdSsVwn5v1fMtjK6BmSdETNODbq6fvqb1h2q
	z1RyMig84McOs7I2bypEatNJHcGcVDUYhzZUoIqL7CEGsJFDJA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xAv0s-000000007mQ-0FSZ; Sun, 27 Sep 2026 21:58:18 +0200
Received: from dynamic-077-183-200-086.77.183.pool.telefonica.de ([77.183.200.86] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xAv0r-00000002K6W-3UOQ; Sun, 27 Sep 2026 21:58:17 +0200
Message-ID: <416ab0edeb42d71f78ab5481cb54f8ce0995d3c3.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] sh: mm: fix hugetlb on SH-4
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, 	linux-sh@vger.kernel.org, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador	 <osalvador@suse.de>, David
 Hildenbrand <david@kernel.org>, Andrew Morton	 <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Sun, 27 Sep 2026 21:58:17 +0200
In-Reply-To: <arlhcX870kV0DBO2@gmail.com>
References: <20260926183904.76186-1-kmehltretter@gmail.com>
	 <9b75aa51e19f9c0f5c97ac02cfc0948ab5bbf279.camel@physik.fu-berlin.de>
	 <arlhcX870kV0DBO2@gmail.com>
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

On Sun, 2026-09-27 at 20:35 +0200, Karl Mehltretter wrote:
> On Sat, Sep 26, 2026 at 08:43:45PM +0100, John Paul Adrian Glaubitz wrote=
:
> > Thanks for the patch! This should definitely be tested on real hardware
> > and I think it's a good reason to test this on my SH7785LCR which would=
n't
> > boot on anything newer than 6.5.0.
> >=20
>=20
> Testing with real hardware is very cool! Maybe I will get some SH
> hardware myself one day. For now you've motivated me to do a QEMU SuperH
> fork with more features, with a lot of help from my LLM agent:
>=20
> https://github.com/kmehltretter82/qemu-superh

Thanks, appreciate the patches. I'll try to look at these patches tomorrow.

Since I am reviewing them in detail, it can take me a few hours to properly
review them. Usually, I'm also asking Geert to have a look at them as well
since he is a far more experienced kernel developer than I am.

> I will send some bug fix patches based on it soon, hopefully also fixing
> your 6.5 problem. I believe it is an old heap overflow in the SH intc
> code that only started to crash when sh7785lcr_defconfig switched from
> SLAB to SLUB in 6.5.

Great, I'll give that patch a try tomorrow when I'm back home. Would be
great to unbreak my favorite SH board.

Btw, feel free to join us in #linux-sh on Libera IRC and/or on Discord:

https://discord.gg/WhtqXkYys

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
