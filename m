Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A118E20;
	Fri, 21 Jun 2024 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959732; cv=none; b=e5iyJERz2V/64gDmWp/k744CP343h+ENy+5cO0Uj47uR+bqFBR4jZqR4CicKU8olsqHG6bxQGcSHUDtsPK/6+4t6vPPViuVdDeSgcmo6+Vgbn7g0PN+qqTk0WQH9ByVMzvBeDVw5NuPCuw051Ui6wQF1w/XVWBxpej7U7IeaBsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959732; c=relaxed/simple;
	bh=E8CCwaNxTOtcgV/FCnCW/+NV+DJ2IGbkxo3fNLla1NQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wno4Dv1ZoxcYQifZXZ3pLAK9zlpKKag1GBjyJYZVw1hMxzAAMISDABXLz36vUP5lYGpiWigGolXdN1VLh9yPKyg1ZQQAiQNZN31llFEiQqNXsrcpyUer7+5HlpTgmBnKjYVbK/sIW3wFO/Nh2kduAFaUBvXZ9+wvtiTsnNOtXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=K4OGeB1S; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="K4OGeB1S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ix+NkQr4REwpET3Ad0FPePtCiykRvKA7YhCWjna0BtM=; t=1718959729; x=1719564529; 
	b=K4OGeB1SeImIDsvwtlYNCGuUjOuePBtA1sjqaj3ov7ONsX1XEhByUvvL1wcjrom1sah5a6BQlDu
	L34LuGT0vu70UfCNa7GQwN7r2SDSW7Abl9e+6AeQXLAXKUKnQdanlMHaJzg9mDcQDdiKZlzeaZ/So
	0sLCfYqSlJya0WUMDWe9zibMSkfYbNWrnhr/4+9AlLidKKFSZSxoNJiwwEp6ccxblNgQsu1LYUc+R
	fk+lu9E/046IsdoTBLVfJcYY14IojvXBPlmKo1+K4t2GNScudg+Y8bA6J+7OFuJSr0/Gi747/ePol
	CJx0NzdGvPWyqkhqf1QjJrOkjFRcY7w/9o/Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sKZwr-00000001vJq-19HR; Fri, 21 Jun 2024 10:48:45 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sKZwr-00000001dOn-2Cnm; Fri, 21 Jun 2024 10:48:45 +0200
Message-ID: <4bd2e538d70d8acbdc8da7b0fdb05b93e0614e43.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4 33/40] sh: mach-x3proto: optimize ilsel_enable()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>, Bart Van Assche
 <bvanassche@acm.org>, Jan Kara <jack@suse.cz>, Linus Torvalds
 <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Date: Fri, 21 Jun 2024 10:48:44 +0200
In-Reply-To: <20240620175703.605111-34-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
	 <20240620175703.605111-34-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Yury,

thanks for your patch!

On Thu, 2024-06-20 at 10:56 -0700, Yury Norov wrote:
> Simplify ilsel_enable() by using find_and_set_bit().
>=20
> Geert also pointed the bug in the old implementation:
>=20
> 	I don't think the old code worked as intended: the first time
> 	no free bit is found, bit would have been ILSEL_LEVELS, and
> 	test_and_set_bit() would have returned false, thus terminating
> 	the loop, and continuing with an out-of-range bit value? Hence
> 	to work correctly, bit ILSEL_LEVELS of ilsel_level_map should
> 	have been initialized to one?  Or am I missing something?
>=20
> The new code does not have that issue.
>=20
> CC: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/sh/boards/mach-x3proto/ilsel.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/sh/boards/mach-x3proto/ilsel.c b/arch/sh/boards/mach-x3=
proto/ilsel.c
> index f0d5eb41521a..35b585e154f0 100644
> --- a/arch/sh/boards/mach-x3proto/ilsel.c
> +++ b/arch/sh/boards/mach-x3proto/ilsel.c
> @@ -8,6 +8,7 @@
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> =20
> +#include <linux/find_atomic.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -99,8 +100,8 @@ int ilsel_enable(ilsel_source_t set)
>  	}
> =20
>  	do {
> -		bit =3D find_first_zero_bit(&ilsel_level_map, ILSEL_LEVELS);
> -	} while (test_and_set_bit(bit, &ilsel_level_map));
> +		bit =3D find_and_set_bit(&ilsel_level_map, ILSEL_LEVELS);
> +	} while (bit >=3D ILSEL_LEVELS);
> =20
>  	__ilsel_enable(set, bit);

I will need to take a closer look at the whole code in ilsel_enable() to un=
derstand what's
happening here. If Geert's explanation is correct, it sounds more like you'=
re fixing a bug
and saying you're optimizing the function in the patch subject would sound =
more like an
euphemism.

Also, I think we should add a Fixes tag if possible in case your patch fixe=
s an actual bug.

I will have a closer look over the weekend.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
