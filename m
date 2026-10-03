Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886420FA81;
	Sat,  3 Oct 2026 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791051453; cv=none; b=rRqZlc5LCxaqAD1gKCgMDxXIOSFeyA2NCLNSl/bQfc4OAQQNegHFhQT8Pucp1GYjRMhZjMeU/VNp2iLRyOBgHVZ8XEz01mlQ/mKK3gIl9+XnN689prVV6NqeM6lVQthZd0IiWvmORG0+WIdaGEUJth9guZkLKnBJT2drVGsNHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791051453; c=relaxed/simple;
	bh=wVLU3AMj/52XNwJdr0FqS1tsZO1HgKakszqeiuK1nas=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RuZ7eF/UUcqg8XLlTawoBesw1mkNNTkUVLDBi4CLxbSd+fUt1v8i3/fDPEq5BvwVaQy7Oki8i8FXwuMP5oNCYD5Drk50lMZRecybX0AS5QqHhHydHG75rfhca49dPvoj4fzwvAi2kWupiVlSmzSDk0OA1xgPFZXDx+y+MXcr1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=UVqmkLzE; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="UVqmkLzE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=+JLyKbrPQXvkMICr2Vf1+yu0WU2/d4YUkKxGVfs/pu8=; t=1791051451;
	x=1791656251; b=UVqmkLzEdb5peWPmAuuBqFyQ6j2jADdcJ04uYZ3RAxJ/GeSkdp/e5YjeYe8aE
	1pCaHaOY3B9iozmty75HDfwDDqBms25MqBHtUShgtmaCrPuNiNWEDYM9700Ur9bxLBuCCasRJOxYU
	LRSe0uYT77qeCig8AZhuQIjYMkJLC9uePBxYx2SR+A6r6iARxvC9jJNAhZzjeMkZRy8Qt6FisMl5q
	EKdvdS1bP1GUt2nQsizWJ63FqkJdwI+ymQQ7Jn7KKoQqvV9Eh132LiGS1/OHjqkZW9h47IijRZqe9
	emhD750+Yr1oov+I0t+Uzd/+fDVNi/5IdmAOnyw6gknSFauQsg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xD4IZ-00000000cSY-1f07; Sat, 03 Oct 2026 20:17:27 +0200
Received: from dynamic-093-128-033-137.93.128.pool.telefonica.de ([93.128.33.137] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xD4IZ-00000000ReA-0KRR; Sat, 03 Oct 2026 20:17:27 +0200
Message-ID: <ca36034e23de799203e73ff6cbe2ca2c9f51128a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: sh7785lcr: register the PCA9564 as I2C bus 0
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Karl Mehltretter
	 <kmehltretter@gmail.com>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Rich Felker
 <dalias@libc.org>, 	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 03 Oct 2026 20:17:26 +0200
In-Reply-To: <CAMuHMdU+Z504HZ3N+oRjAKQWSPiNDVEtEX-wShV-FGbMg+kkYA@mail.gmail.com>
References: <20261003082833.21511-1-kmehltretter@gmail.com>
	 <a4dcd9e615dc4e3c98c00e75cdd0c7fdeef02254.camel@physik.fu-berlin.de>
	 <e3c88969f18c493859f7c382db7ed2afeb15b4fa.camel@physik.fu-berlin.de>
	 <asDOl5bvtlbauh9x@gmail.com>
	 <CAMuHMdU+Z504HZ3N+oRjAKQWSPiNDVEtEX-wShV-FGbMg+kkYA@mail.gmail.com>
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

On Sat, 2026-10-03 at 14:52 +0200, Geert Uytterhoeven wrote:
> Hi Karl,
>=20
> On Sat, 3 Oct 2026 at 11:51, Karl Mehltretter <kmehltretter@gmail.com> wr=
ote:
> > On Sat, Oct 03, 2026 at 11:38:43AM +0100, John Paul Adrian Glaubitz wro=
te:
> > > > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.d=
e>
> > >=20
> > > I have to admit though I don't fully understand the description of th=
is
> > > patch. Either I don't have enough coffee or it's not precise enough.
> >=20
> > Thanks for testing and reviewing! I agree the changelog doesn't explain
> > why -1 is wrong and 0 is right for this board very clearly. I'll give i=
t
> > a day or so to step back and submit a v2 with your tags and a better
> > changelog.
>=20
> Perhaps something like:
>=20
> Before commit 44454baa7ca7bb57 ("i2c: Dynamically assign adapter id if
> it wasn't explictly specified"), a negative ID was replaced by zero,
> and I2C bus zero was instantiated.  Since that commit, a negative ID
> is passed verbatim, instantiating an I2C bus with a dynamic number.
> As SH boards still use i2c_register_board_info(0, ...) to register I2C
> devices, they rely on the I2C bus being bus zero, causing registration to=
 fail.

Yeah, that makes a whole lot of more sense to me. Thanks for the clarificat=
ion!

If Karl agrees, we can go with that one and he can send a v2.

Adrian

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
