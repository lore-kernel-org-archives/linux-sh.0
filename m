Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB9152E10;
	Mon, 13 May 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607011; cv=none; b=H6rpOCQbEvcr2IBgV+dvJ4Bk9bpZ7EdIuQhhZVdtJXDCk5bM+2rb9BpjBP0ivCMv60g4I4oocyElJczwp90900kFti6aU6mb2VHlYyKWELvotyeRdvScoHNukQTTYYVObd2BgZRfsYL+s4xZUSH7JUOAcIfC19wQLU/5K/J/qtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607011; c=relaxed/simple;
	bh=Ms7j2DWi57/E9cZtgYiwFdsUOxRFwoaHAm9N1+/9Gr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q8I1oCDxBzEJjVaUBoE1fTgGhRSHre4awn7C1mzHUx968xoeUaHFnnI5laVvzR756fb9BNFaEYFgifhX7yJ2XLF2RHL6FwRsWSwp4xQ3zN7x1T5L+REIJc+Tr+2GTojP/RSxMp5FR8APxLHIBgfUd9jtJYUQZMFAoI6ojkJjDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=VKreQDHa; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="VKreQDHa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Pol14G9zW5ipfBE4PDNXixrZtvwDOYvAZwHs2dwHz+k=; t=1715607007; x=1716211807; 
	b=VKreQDHaAB8Rxx+cWbdnIW13+wTm1aJkY2UDvy4x7gmw/IeRM4NWnDDHRMY547+vR7Zp28S2I49
	IZCCrxFghJViCIUD8M4ThV9WBwWR5uqzpKPeq0YkmRblmkKMJukyNy6Hfr4HHl7AxOGJPgbN58iXS
	G/G5v7XDLzYGMyLnfA/ypaUokGoyBlB21j1P1qKBkX3G/DUABbWSdNiohbaF9D+I08t98PJaXaMJl
	+8TpkrUS9k+DZRn8JT4+CRuZEMcthz/4UlKLjfpJ+4an4BLmQFoWv54H20Yrp6KK9MB3E6mBBtHkg
	+qByvuJgwrafNsSG2zSciU0IVZadi0kJN6LQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s6Vkg-00000003Yyp-3y1c; Mon, 13 May 2024 15:30:02 +0200
Received: from p5b13a15c.dip0.t-ipconnect.de ([91.19.161.92] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s6Vkg-000000026ew-35Pc; Mon, 13 May 2024 15:30:02 +0200
Message-ID: <abc8fb59ceb102895320850609c7d6e29aedcf1a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/3] sh: Fix missing prototypes (part three)
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Arnd Bergmann
	 <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 13 May 2024 15:30:02 +0200
In-Reply-To: <cover.1715606232.git.geert+renesas@glider.be>
References: <cover.1715606232.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Geert,

On Mon, 2024-05-13 at 15:20 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
>=20
> This patch series fixes more "no previous prototype for <foo>" warnings
> when building a kernel for SuperH, namely when building j2_defconfig.
>=20
> Thanks for your comments!
>=20
> Geert Uytterhoeven (3):
>   sh: of-generic: Add missing #include <asm/clock.h>
>   sh: smp: Protect setup_profiling_timer() by CONFIG_PROFILING
>   sh: setup: Add missing forward declaration for sh_fdt_init()
>=20
>  arch/sh/boards/of-generic.c | 2 ++
>  arch/sh/include/asm/setup.h | 1 +
>  arch/sh/kernel/smp.c        | 2 ++
>  3 files changed, 5 insertions(+)

Thanks a lot for fixing these. I have run into these as well and except
for patch #2 where you found the proper fix, my proposed fixes looked
exactly the same.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
