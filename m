Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0563F2E22BE;
	Wed, 12 Nov 2025 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983124; cv=none; b=eIv41x9qZNltxG/0rxnv2peOP5v0WZJi6gYqy8HT2k1lNgVJUCF6/+bByuOP5N7tKM7JALMGzwQ6idIzirFhtMlmLUBXuQVVoC0fRhVBgaDC+eToHlnlF1eg7s468lDw1gidG+AwhyKLT58CL5JbbWqLPk2Gnc+LrWsiFqZxp2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983124; c=relaxed/simple;
	bh=+vuP93t5PqRstpUzx/unvire6CjhHu3kJPYllfPAmj4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qdb0Zd/8TC/P219LsJ7LYhwRwMmOUwwaBAzaDkmWj7nVyDI0CW+f7L4hwjuVhnVxZDGLgr7ByyNrrHXsxBrp0hffpt97rA0EJmJmU3ssNczBrcl+P4tU6SwpxNWQ2B3PhQPBG0De/7L+NsL6xbk5uHckslZkzTZQaJ2z27EOCHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=LL/T3Pss; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="LL/T3Pss"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=M6BtNAxgwcIcbKjexH/J6fKR2lgKJrrBsGy4HhwgdXU=; t=1762983120;
	x=1763587920; b=LL/T3PsshB6XvWZrFLk1wQVki0e6/yaifrwfnXzrPV1Hn9MLUxKdb16n8q/vp
	Bf9SNBjGoHeM42GTjaoq/ztoszUpXX1yS6tfVLzyfj8ROEuoVxEEvZx8rGX5l2TKX4nZXsahSDVSE
	DilOf4x8g2SaLfj/A/YkQefaIrvt2ymyR9Rklqifyf0fsnS17AOYloyIXVWHILH+4rPM/lfr//xuB
	dL4SktNdzDcju92gWadyUxtwtAZ4G43ZCJSEpUFpb6z3CaifKdGY6vhJwFuYxJKnubB4rh216qQRv
	Bw0qVaqsEpLDRpRms6C6Do/j4JrI4bfedEPuq/FqY3V0Z/Yy3w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vJIRC-00000000Kd3-1Bva; Wed, 12 Nov 2025 22:31:34 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vJIRC-00000000All-0CWq; Wed, 12 Nov 2025 22:31:34 +0100
Message-ID: <4f70a38490b12d13858f45f3e7a531bf5dc2162d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: maple: fix empty port handling
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, 	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 Artur Rojek	 <contact@artur-rojek.eu>
Date: Wed, 12 Nov 2025 22:31:33 +0100
In-Reply-To: <20251112190444.3631533-1-fuchsfl@gmail.com>
References: <20251112190444.3631533-1-fuchsfl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Florian.

On Wed, 2025-11-12 at 20:04 +0100, Florian Fuchs wrote:
> Handle timeout response from empty ports of the maple bus to prevent a
> stuck maple_sentq and a blocked maple bus.
>=20
> When only some ports are used, e.g. if only keyboard is connected and the
> other ports are empty, the device tends to timeout and return 0xff for
> the empty port. This needs to be handled, just like the
> MAPLE_RESPONSE_NONE response, to detect empty ports and to have usable
> peripherals, if not all of the ports are utilized. Previously, an empty
> port resulted in a never cleared maple_sentq which totally blocked the
> maple bus to be used.
>=20
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> ---
> Note: This patch was tested on real Sega Dreamcast hardware and resulted
> in a usable keyboard, even when only 1 or 2 ports where populated. The
> hot-plugging of the keyboard does also work fine.
>=20
> The description of the timeout response can be obtained on the bottom of
> of the page: https://mc.pp.se/dc/maplebus.html: "If no response is
> received before the timeout, a word with all bits set (FFFFFFFF) is
> written at the Result address."
>=20
>  drivers/sh/maple/maple.c | 1 +
>  include/linux/maple.h    | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> index 6dc0549f7900..3d6c716cfc98 100644
> --- a/drivers/sh/maple/maple.c
> +++ b/drivers/sh/maple/maple.c
> @@ -649,6 +649,7 @@ static void maple_dma_handler(struct work_struct *wor=
k)
>  			list_del_init(&mq->list);
>  			switch (code) {
>  			case MAPLE_RESPONSE_NONE:
> +			case MAPLE_RESPONSE_TIMEOUT:
>  				maple_response_none(mdev);
>  				break;
> =20
> diff --git a/include/linux/maple.h b/include/linux/maple.h
> index 3be4e567473c..4ae3cc6678a8 100644
> --- a/include/linux/maple.h
> +++ b/include/linux/maple.h
> @@ -27,7 +27,8 @@ enum maple_code {
>  	MAPLE_COMMAND_BWRITE,
>  	MAPLE_COMMAND_BSYNC,
>  	MAPLE_COMMAND_SETCOND,
> -	MAPLE_COMMAND_MICCONTROL
> +	MAPLE_COMMAND_MICCONTROL,
> +	MAPLE_RESPONSE_TIMEOUT =3D 255
>  };
> =20
>  enum maple_file_errors {
>=20
> base-commit: 24172e0d79900908cf5ebf366600616d29c9b417

Thanks for your patch! I'll try to get it reviewed in the weekend.

In the meantime, I'll like to add Artur Rojek who did some work for Linux o=
n the
Dreamcast as well if I remember correctly. Maybe he could test your patch a=
s I
currently don't have my Dreamcast set up for testing.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
