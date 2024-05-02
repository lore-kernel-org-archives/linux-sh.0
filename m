Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8128689
	for <linux-sh@vger.kernel.org>; Thu,  2 May 2024 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714635977; cv=none; b=bBxxjqTlUCP+gABIlttPyJNyIMu9+Rjj6U7mAx9YSK26gfO+aGjmd4okMwYkjzZlhvHiWrxVamER9rnv9SEkkBljmg4ZpdQgOhIbQquQTXGaWmI1CG1OWa8ghhrxSI+eJgguqV1iLfI4xmI6ZF4tDnGIGIFIMEhMEw1rvHyP11w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714635977; c=relaxed/simple;
	bh=opZ6AeI4Y3why+KpLprXRZPnUcV0x4cC8+97DSr+p54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l4Am0LjWoSgiWU9Cehsxphb3gRZ4sq+1PRc8WJc2D71dlZQgvjB80G72az1hNbazYAZthsi4IT9jk5ek1aOUa0eWdYLhqY/Ev1Y7yh2FIrF+TY6yQwBn3pGJRdie8OUw0rYQbgM/dKZxfgyjc3waDzFBSKcd2FvzVjmF46/D3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=fhrR74Is; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="fhrR74Is"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EABbw17QXhxGXGTdUO1v1Osu7F/s/7fKKafpM5ruzfw=; t=1714635974; x=1715240774; 
	b=fhrR74Isjxy+CXCtiFkk0zVE7B5bO2+IcBld0HDeqCJOWr0J1hgKO5J4gMBPBMXFX9lK1Nzb5MQ
	b7e02C6sCqmJKPyvc656wQOI4OAn0Cn6bAJ2PN6GCCQQbwWqNbSC248rU6MV0ix6IRRnoVjFHNIEE
	njNsAJcREZvNMonjAxD68Jux90iDyD92P10wS5li0gxbIlwZDZLlASu/NPsnjRZApibjomgVrlajw
	9iVzxqd0F7cqeZwmfIKFDn/vkySXzQgAXcFLbNkMmFHP0PEkhXVn6WVSOH16Zse2EMX+QK8OoL1qf
	DUzDYK4OR+RbdOfs4ycTwlf8ZIGZEBEpTmJA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2R8t-00000000ZrE-32pf; Thu, 02 May 2024 09:46:11 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2R8t-00000003iwK-2CJx; Thu, 02 May 2024 09:46:11 +0200
Message-ID: <88ba5d091a1591cabf68fe8fd6728255fa5c3526.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: boot: Add proper forward declarations
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Date: Thu, 02 May 2024 09:46:11 +0200
In-Reply-To: <b7ea770a3bf26fb2a5f59f4bb83072b2526f7134.1713959841.git.geert+renesas@glider.be>
References: 
	<b7ea770a3bf26fb2a5f59f4bb83072b2526f7134.1713959841.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Geert,

On Wed, 2024-04-24 at 13:58 +0200, Geert Uytterhoeven wrote:
> arch/sh/boot/compressed/misc.c:110:6: warning: no previous prototype for =
=E2=80=98ftrace_stub=E2=80=99 [-Wmissing-prototypes]
> arch/sh/boot/compressed/misc.c:113:6: warning: no previous prototype for =
=E2=80=98arch_ftrace_ops_list_func=E2=80=99 [-Wmissing-prototypes]
> arch/sh/boot/compressed/misc.c:123:6: warning: no previous prototype for =
=E2=80=98decompress_kernel=E2=80=99 [-Wmissing-prototypes]
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is v2 of "[PATCH 08/20] sh: boot: Add proper forward declarations".
> https://lore.kernel.org/r/2614d991c816ece903ef47c715bcc53881d34f3f.170932=
6528.git.geert+renesas@glider.be
>=20
> v2:
>   - Rebase on top of "sh: boot: Remove sh5 cache handling".
> ---
>  arch/sh/boot/compressed/misc.c | 2 ++
>  arch/sh/boot/compressed/misc.h | 9 +++++++++
>  2 files changed, 11 insertions(+)
>  create mode 100644 arch/sh/boot/compressed/misc.h
>=20
> diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/mis=
c.c
> index 195367d40031f9e9..3690379cc86bd4fe 100644
> --- a/arch/sh/boot/compressed/misc.c
> +++ b/arch/sh/boot/compressed/misc.c
> @@ -16,6 +16,8 @@
>  #include <asm/addrspace.h>
>  #include <asm/page.h>
> =20
> +#include "misc.h"
> +
>  /*
>   * gzip declarations
>   */
> diff --git a/arch/sh/boot/compressed/misc.h b/arch/sh/boot/compressed/mis=
c.h
> new file mode 100644
> index 0000000000000000..2b4534faa3052857
> --- /dev/null
> +++ b/arch/sh/boot/compressed/misc.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef MISC_H
> +#define MISC_H
> +
> +void arch_ftrace_ops_list_func(void);
> +void decompress_kernel(void);
> +void ftrace_stub(void);
> +
> +#endif /* MISC_H */

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
