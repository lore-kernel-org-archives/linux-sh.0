Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15F2BE034;
	Tue,  6 Oct 2026 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276771; cv=none; b=jIFCOV7xApcotT9gMDwQigsV5Kuj1XcnsI9YsdZ73Fs0X1EEEDtJLcRL09VVMmTv2ioaq/1Ve6NzuckEfHUSyjWZG/cpjM7o8KuwqFFZIr87AzhCYi8NZ5CvUWl7dRW1iVRDzD8I91UWNi8LmbIQ8hJtfn01hxIYApGuFxlF7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276771; c=relaxed/simple;
	bh=lgRqwSifgcv/QFIrzGhn5J6mJPzCLE3UAx1akAM+wCk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nqPtH77xOIJhz1qrRqvO0byxz+xxqKBFfUQj1gaPnRaphERZ9drv8S69Mh/x7CWr+YfCXgcEeoKGkbk1Gi+dVMIOXN3zh2AE0sdg1eHfW+l4IOPK3Lpfjw8RGv2a5Xm1I4GTfqXA4xq6mLYmZhBWU96iXtOSfr8riWNGBh2xwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=gRhJwFey; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="gRhJwFey"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9i8glAIn1hdAyAgLaJEf0Eg8BNyEXzM+3RkK/Z2F9Wc=; t=1791276769;
	x=1791881569; b=gRhJwFeyiMhiWNlWp27cZr4zu0kmmB4ca97OI2RTm2BM6dmdDkOK/7tKfa/+3
	RcS30TQcQcGAITulfYMbihbj1J8+JVyTDv/kmnHjL4e/dO6Cc8Be/IxyCd7N6LcwaZ94otQrGEnNK
	SKd0VB8BirIdxBfFJ6+hUbKlhf9mqe+GSPfKQ9UzORObiXoPIcIQJ0E4rK4dk8pXQv0iwKmIIaZdh
	kLeOhl1dWUSqrVMBkvSM1uXhpAm/KtpmeutVrz3bDWWvF+I65PIVLTyQQnkyuwtJuS2u0VlR5kJlL
	tCyTK469x8wQ9w8dFTrlK2gPWJY9xY8t0P75uu1+YvtYDaNECA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xE0uk-00000001L6Z-3Jei; Tue, 06 Oct 2026 10:52:46 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xE0uk-00000003hg6-2OhZ; Tue, 06 Oct 2026 10:52:46 +0200
Message-ID: <44df76d122650e6a95d1fd2e95bc6c66d4001d4b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3] sh: maple: fix empty port handling
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, linux-sh@vger.kernel.org, Rich Felker
	 <dalias@libc.org>, Artur Rojek <contact@artur-rojek.eu>
Cc: linux-kernel@vger.kernel.org, Adrian McMenamin
 <adrianmcmenamin@gmail.com>
Date: Tue, 06 Oct 2026 10:52:45 +0200
In-Reply-To: <20260515181115.3244161-1-fuchsfl@gmail.com>
References: <20260515181115.3244161-1-fuchsfl@gmail.com>
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

Hi Florian,

On Fri, 2026-05-15 at 20:11 +0200, Florian Fuchs wrote:
> Fix empty Maple port handling so the bus works with fewer than four
> populated ports and devices can be hot-plugged at runtime.

The description doesn't really add much information to what the title
says. It would be more helpful if the description briefly described
the actual bug and how it was fixed.

Adrian

> Cast the response code to s8 so 0xff is handled as MAPLE_RESPONSE_NONE,
> continue scanning after empty ports, and process devinfo replies for
> empty unit-0 ports.
>=20
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> Acked-by: Artur Rojek <contact@artur-rojek.eu>
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> ---
> v2->v3: No functional change. Condense commit message and add Tested-by,
>         Acked-by tags.=20
> v1->v2: Don't break hot-plugging of new devices to empty ports.
>         Explicitly cast the response code to s8 to use the existing
>         logic, that relies on signed chars. In the case of 0xff (all 1s,
>         DCs TIMEOUT response) that was interpreted as 255 unknown respons=
e
>         code, which blocked the maple bus, as busy was never reset. Add
>         condition to maple_response_devinfo() to process the devinfo
>         for currently empty ports.
>=20
> v2: https://lore.kernel.org/all/20260426212714.2286437-1-fuchsfl@gmail.co=
m/
> v1: https://lore.kernel.org/all/20251112190444.3631533-1-fuchsfl@gmail.co=
m/
>=20
>  drivers/sh/maple/maple.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> index 5585f220e495..8e7bb42aef07 100644
> --- a/drivers/sh/maple/maple.c
> +++ b/drivers/sh/maple/maple.c
> @@ -445,7 +445,7 @@ static int setup_maple_commands(struct device *device=
, void *ignored)
>  /* VBLANK bottom half - implemented via workqueue */
>  static void maple_vblank_handler(struct work_struct *work)
>  {
> -	int x, locking;
> +	int x;
>  	struct maple_device *mdev;
> =20
>  	if (!maple_dma_done())
> @@ -474,13 +474,10 @@ static void maple_vblank_handler(struct work_struct=
 *work)
>  				if (!mdev)
>  					break;
>  				atomic_set(&mdev->busy, 1);
> -				locking =3D maple_add_packet(mdev, 0,
> +				maple_add_packet(mdev, 0,
>  					MAPLE_COMMAND_DEVINFO, 0, NULL);
> -				if (!locking)
> -					break;
> -				}
>  			}
> -
> +		}
>  		maple_pnp_time =3D jiffies + MAPLE_PNP_INTERVAL;
>  	}
> =20
> @@ -578,7 +575,8 @@ static void maple_response_devinfo(struct maple_devic=
e *mdev,
>  				   char *recvbuf)
>  {
>  	char submask;
> -	if (!started || (scanning =3D=3D 2) || !fullscan) {
> +	if (!started || (scanning =3D=3D 2) || !fullscan ||
> +	    ((mdev->unit =3D=3D 0) && empty[mdev->port])) {
>  		if ((mdev->unit =3D=3D 0) && (checked[mdev->port] =3D=3D false)) {
>  			checked[mdev->port] =3D true;
>  			maple_attach_driver(mdev);
> @@ -644,7 +642,7 @@ static void maple_dma_handler(struct work_struct *wor=
k)
>  			recvbuf =3D mq->recvbuf->buf;
>  			__flush_invalidate_region(sh_cacheop_vaddr(recvbuf),
>  					0x400);
> -			code =3D recvbuf[0];
> +			code =3D (s8)recvbuf[0];
>  			kfree(mq->sendbuf);
>  			list_del_init(&mq->list);
>  			switch (code) {
>=20
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
