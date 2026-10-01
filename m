Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692B277C81;
	Thu,  1 Oct 2026 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838212; cv=none; b=VQ3sEUen51/9xQztdUw+7X8EHxEGhvlnqC+/dxj6rrlIBDrk3gzff2zZ7WdXmFzNYRLgOjZqoH3DykN1rzRBlUyLiJjYujkcVs6ZyDpQCbc/m0TF8mP2CWnmjEAPB+M9JR81709Hea7PNV6sW0K88XYYMKBAdF/fSZnBhjG2z3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838212; c=relaxed/simple;
	bh=1jPaPA1I39BNNWC72wkawqc4ZKBfmoPfNzZIEsAgCMo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CFb+cr/SiQtrEQBbsuOKLN2nXUNa3GjTMqB3RuKSDYBjAklMgWXzpVMLf4gaq3Tg3MXSJm1noYlARXkn7n6KDcgZbtoN6F86N90ZobZjNjiMimsemOnsYf4QLbf8KLFkPcLw9Nf99ClorT+KyPplk/eNLdTmo4KtShi2+crZ01k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=e6u/HsSi; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="e6u/HsSi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=vywd8u74cFsIXvWs9r8Ot7Ks+vUphfCVif9upDz9spE=; t=1790838209;
	x=1791443009; b=e6u/HsSi8T9aVx/zylFXc1HQ36Zxfq99r7oPV7Zpu3cErslzIwS5pyN6kEKBB
	xLmxLdYLZ+DsTPdkwKN+/DyymtgkxCmVMq0o23HJFTqYC6dvz0slfSRnanAgx2s2ezyUO2I3U2wsu
	t7INbYfJq13HRUKhbEv1AFKx+KuZzEQknXIxx+2wM0qM2a9fOV/4tO0oXmg4DDdJeYf/7BogSlpYd
	C9keMJwh9hzL9LdQ8CoDS902QporXzr/rY6jcrc9D7WGNsrVvW6b+BG0TcH5OXGvKcqWZFtVKNapI
	3/CxRR+rcrP9pOF/5R6OpCt3fSzocADBfMNX/dtrhgNiu85sYQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xCAp7-00000001ZFI-3bHD; Thu, 01 Oct 2026 09:03:21 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xCAp7-00000003HyG-2hPR; Thu, 01 Oct 2026 09:03:21 +0200
Message-ID: <4aca8d823a2a276732d439c72b4a8427114206c6.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] sh: add initial SH7305 CPU support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: cacioandpepe <artem122novak@gmail.com>, ysato@users.sourceforge.jp, 
	dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 09:03:21 +0200
In-Reply-To: <20261001065736.753215-1-artem122novak@gmail.com>
References: <20261001065736.753215-1-artem122novak@gmail.com>
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

Hi cacioandpepe,

On Thu, 2026-10-01 at 00:57 -0600, cacioandpepe wrote:
> Add initial SuperH support for the Renesas SH7305 processor.
>=20
> The first patch fixes SH4 compiler flag fallback handling for toolchains
> which support SH4A targets but do not provide the plain -m4-nofpu
> option.
>=20
> The second patch adds the SH7305 CPU subtype, processor name and CPU
> probe.
>=20
> This is the first small architecture level part of ongoing SH7305
> enablement. Platform specific clock, interrupt controller, timer and
> board support are intentionally left for separate patches.
>=20
> The SH7305 support has been compile tested with GCC 14.3.0 targeting
> big endian SH4A.
>=20
> cacioandpepe (2):
>   sh: guard SH4 no-FPU compiler fallback
>   sh: add SH7305 CPU subtype support
>=20
>  arch/sh/Kconfig                 | 9 +++++++++
>  arch/sh/Makefile                | 2 +-
>  arch/sh/include/asm/processor.h | 2 +-
>  arch/sh/kernel/cpu/proc.c       | 3 ++-
>  arch/sh/kernel/cpu/sh4/probe.c  | 3 +++
>  5 files changed, 16 insertions(+), 3 deletions(-)

Thanks for the patch! May I ask what board you are using with this CPU?

FWIW, in the future we want to switch to device trees, so if you add the
board later, it might be an idea to do this using device trees instead.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
