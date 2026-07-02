Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF5148B375;
	Thu,  2 Jul 2026 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986117; cv=none; b=eltvy5JkjjkHDpTEP5cn724LXuODMAMdjqBhkthN/W2y6Px9TP6gm75tbmB22AI3T4UtnyH7x9v8JCK6+LS4RtC65riXl1BDYsT5gxSZs0JXpn8BnIvg6v/rkn7hQbR6v+/niR9SmP9TfCUhaOnwWcbERzKUTMb6GSbuaD2r50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986117; c=relaxed/simple;
	bh=4AVMWmXTi+MjCb/l62eQrvVosVF0wxvtbxBCNXQ+Xfo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bkEO4VfvMQwTQYQ7gRat+dh9bE06TU0r0wNzimRH0CnExr2TvC2zFl1dBxu6vSEIM9E6ALX1hNAIoSwGCi5keZaru1kr5+PFSdtcXTr9nOjyClZrFZzFAxTziuQK/arLzdSuF0Ap3v0sA4BNZHeE1Z5Voucf+dXAgdhARRMP6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Mebtqo/e; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Mebtqo/e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=r5eEmYadwM0bSXZFbvzMCdkA5vgWVg7Hz8qc7s0Vl9A=; t=1782986113;
	x=1783590913; b=Mebtqo/e4YibaqefvWax60ktgqwkyuZ+Oav+Z7RIBASqgq1f1izh3QeY9iO/J
	HnJXK9aq/b8/Q0kDHgimxeuZCwQaDfu0NonQOSNS6hJMGgZWKlEdLc5sYooiLqaqlA8Fdt/pGVNvK
	V/uuNc9SKbz1RrGSvuqfHaLg2j2m/tdWlg4k/w/pnWsOES/zuzrn4tHEJUAIfJXQoFiKev9J4W4+P
	NRNkRDVJwzJeYtv9bFI9zBqOhEPs/2BxdalJ6qXZmUILScS18VqN7fD02OmuuBspxPmr7BVchNNG5
	nh8QIvwm6b/dSdtjgMvVnVUk4rSeZHpTzAUVXM9inmVfe+d+3w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wfE8L-00000002wMk-0QdJ; Thu, 02 Jul 2026 11:55:01 +0200
Received: from p57bd94c1.dip0.t-ipconnect.de ([87.189.148.193] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wfE8K-00000003dEp-3g29; Thu, 02 Jul 2026 11:55:01 +0200
Message-ID: <fe0e2ca854db64b1bb169ce47aaa2ce1e796b023.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 00/10] sh: remove NUMA and SPARSEMEM support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-mm@kvack.org
Date: Thu, 02 Jul 2026 11:54:59 +0200
In-Reply-To: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
References: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
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

Hi,

On Thu, 2026-07-02 at 12:37 +0300, Mike Rapoport (Microsoft) wrote:
> Hi,
>=20
> NUMA support for SuperH was introduced a long time ago by commit
> b241cb0c885e ("sh: Support for multiple nodes.")
>=20
>         "... for boards with many different memory blocks that are
>          otherwise unused (SH7722/SH7785 URAM and so forth)"
>=20
> In reality, this added 128K of memory on sh7722 and sh7785 and 256K on
> shx3 at the expense of all the NUMA related code in the kernel.
>=20
> For build of v7.0-rc7 with defconfig and the same configuration with
> CONFIG_NUMA disabled, bloat-o-meter reports difference of ~76k. Disabling
> CONFIG_SPARSMEM on top increases the difference to ~94k. And that's only
> overhead in code and static data that does not take into the account data
> structures allocated at run time.
>=20
> And all this overhead has been there for nothing for almost 8 years
> because since commit ac21fc2dcb40 ("sh: switch to NO_BOOTMEM")
> those additional "nodes" could not be used by the core MM because the
> maximal pfn for ZONE_NORMAL was cut out at the end of the normal memory.
>=20
> ---
> It's been another few weeks without updates from Adrian and I don't see
> why it should wait more.
>=20
> @Andrew, please take it to the mm tree.

I feel like this is an attempt to force me to give up as a maintainer.

Otherwise, I can't really understand why you are building up so much
pressure for a niche and hobbyist architecture

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
