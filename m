Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF5851DB04;
	Tue, 13 Oct 2026 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912323; cv=none; b=N22GxZjcUySHKVYnVAtfmYRuZc3OgstLQjaz8sfEadzo/wPR0nfnsLhbAUI6BTdw2SFEBYjfWXJ76fvqfGzTl7yxeOAtWoIdznZ0lo8NrGU0vtBOHf13Ppo+fcuQPz0m0yshdWaqSnA2yAGtqBgkw1fatbxFjuovXaXd/hDYpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912323; c=relaxed/simple;
	bh=SnX5zrdwCvBeWn0h8qP+neLTuwMRqnICPGFtHdv9et4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVdh36tIDj6hvaRf0/ykMJc1dQpUiq49CuBz7yInu6izOCZoZMHgbmjlfN/wQeqBeX+9NmxHejOz5N89pDecioX1eCq+Ba5Cji5K8UsQIqX1Brv5wW1ImJL9iUUJyDWwKTHyL1JL/7QRbsQPJKr6DTcvXKbCSNYtaJs7p6oTgxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=AAXeOyg1; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="AAXeOyg1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=akkOVpdsqrpm+L9u5j/grPKDcy1oC8Dgmqfbm0sZuBc=; t=1791912321;
	x=1792517121; b=AAXeOyg1PRXwEs5GnQx35+gHi5q39PfziuqiS9DoUFkzjLlEIb4wcEtj8sOlr
	/07Pvjf3ioHnYatdlQHrk8XFWE9BDPqPG+8TtqR69bbbfofBjZBRKLQTJMVxhNSWIhdAIMmn5ZBDh
	ISmc75793bUVWs/+q1m3sjxqCs9x0zbNF9MqCbAT1yJe9AKkElVW5PA6Y9Crp8SbsAKDXNvrJqjO/
	+HcBQWRRNoCeDky7lqwQjXGZTNz8WJ506y58j+BQlaXjNugjmwr9I/U90nMCFiS99/+VQ0BJvOPc3
	4jbvwBUNiLXrP+GWnUkSYoV/17UTK9Z5noJvz2TMr1m/p9SWRA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xGgFa-00000000umb-03De; Tue, 13 Oct 2026 19:25:18 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xGgFZ-00000000Kw4-3EE9; Tue, 13 Oct 2026 19:25:17 +0200
Message-ID: <6163133fc58a067860627efc768819d242e583d1.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: sh7785lcr: register the PCA9564 as I2C bus 0
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato
	 <yoshinori.sato@nifty.com>, Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 13 Oct 2026 19:25:17 +0200
In-Reply-To: <20261004184644.90750-1-kmehltretter@gmail.com>
References: <20261004184644.90750-1-kmehltretter@gmail.com>
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

On Sun, 2026-10-04 at 20:46 +0200, Karl Mehltretter wrote:
> Before commit 44454baa7ca7 ("i2c: Dynamically assign adapter id if it
> wasn't explictly specified"), a negative ID was replaced by zero, and
> I2C bus zero was instantiated. Since that commit, a negative ID is passed
> verbatim, instantiating an I2C bus with a dynamic number. As SH boards
> still use i2c_register_board_info(0, ...) to register I2C devices, they
> rely on the I2C bus being bus zero.
>=20
> The SH7785LCR is the only SH board whose I2C adapter has a negative ID.
> Its PCA9564 becomes i2c-1, causing registration of the R2025S/D RTC to
> fail, and hwclock finds no /dev/rtc0.
>=20
> Set the platform device ID to 0, so that the adapter is registered as
> bus zero again.
>=20
> Fixes: 44454baa7ca7 ("i2c: Dynamically assign adapter id if it wasn't exp=
lictly specified")
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>=20
> v2:
> - Rewrite the commit message based on Geert's suggested wording.
> - Add the tags from Adrian and Geert.
> - No code change.
>=20
> v1: https://lore.kernel.org/r/20261003082833.21511-1-kmehltretter@gmail.c=
om/
>=20
>  arch/sh/boards/board-sh7785lcr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh77=
85lcr.c
> index 25c4968f0d8b..b93423df582f 100644
> --- a/arch/sh/boards/board-sh7785lcr.c
> +++ b/arch/sh/boards/board-sh7785lcr.c
> @@ -256,7 +256,7 @@ static struct i2c_pca9564_pf_platform_data i2c_platfo=
rm_data =3D {
> =20
>  static struct platform_device i2c_device =3D {
>  	.name		=3D "i2c-pca-platform",
> -	.id		=3D -1,
> +	.id		=3D 0,
>  	.dev		=3D {
>  		.platform_data	=3D &i2c_platform_data,
>  	},

Merged into for-next for v7.4.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
