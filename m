Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530937;
	b=AuvkyGnw/y37VttgtGeM8eSGwvMMcsaNrzJpk/w1g07NCude04Zh5K8+XvvhT0k5rHUQ
	 NnLozzd4s4nDLy/h5k6TJh1ERN9aVlgojpYONucikvJQpPRFyIg5LRyss3/zKQyz+AG/d
	 +eWMjal4D4U84+AmL+nN9F6Gzgw0YB5wkFJxVEQoJi/mzAn+psUYMcqBvU5/q5qjGrepU
	 swsr+K9rw+lsPQjrlmBNLIaRXgo8SvXcIZE38oF0K8AXvvo9clI+aHcURLU2LruPQtqpo
	 HHBOyR5ZhJ9zxH8cAGqlss9vMEAsXVVpVmXhuSuWfmcjkrc7sLj3s9V4D74QeH6kxuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530937;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=dNyqQp4+EY1DvLKJ8Yd7RXdgwCWd6Qj6VpLP/YgQ/G4=;
	b=IkxzUea9wkAbiTFrQjpDtT1xnsdho5vYV36rWUf+MdbNZ4JSdVtpCybOYQMk4xQzcnTX
	 W1EgENyJKdBOhERlyN8g4VO8c30y4JKoY77RhXxebolVX4Rze6cFuMq/QJXnwHcVbQJzh
	 nX6SdEoKesiNSRpvVN2pvU8aIu5NCTwBseb+nPkAzp8XK4RBmUhnrmmQglb+3yZCmcZE6
	 kYLTsUrH8YYX17tHKqxoNrRWyLfuI8i6lM/anNErXKVih/WWMwJQ8hfP1AwGd6k5jAN+V
	 SaBGLWMPCmfv2P+zLSEcd7Hhhq1ib5rZjkC0mnW7qKafFkgP4NLGe/gcMkrPwCO/lxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=KHH2cwK5;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D9606A32D
	for <linux-sh@vger.kernel.org>; Tue, 24 Nov 2026 14:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 315D9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=KHH2cwK5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=dNyqQp4+EY1DvLKJ8Yd7RXdgwCWd6Qj6VpLP/YgQ/G4=; t=1795530936;
	x=1796135736; b=KHH2cwK5LBdwHCpn0Bn+QK4wrk3iEBfrpMdeeNOF97/zLJS2TytByCbbDCWQy
	J5QfpKRNm0HD3Wl0+BqvFlvyU7UtVNVmxo5IcZgCDzl62RCAB9lsUHJuu3NRKSj4cZaBvwH7IxiUs
	fJ+Jsesb1iF+Ti4gCevAW0rIKeebdFDHXfIncrWB/BugnrF6eNOEFzbqgs+sR+vQCf2wCTiQqVtk7
	qwAu2RoQ/KKcNujfJ1bXWA+zcGYc7sIUdE8298HTvAonfgZ1ZNBcdv46ilW9rxUXFd3L8kOj0ocCO
	lyHhuGl+rlYT42lG9GgsbYd8G1U+k87smKOVyHAyC7YTQnCrNQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xVrcK-00000001agw-3COe; Tue, 24 Nov 2026 15:35:32 +0100
Received: from p57bd95b5.dip0.t-ipconnect.de ([87.189.149.181] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xVrcK-00000003x9L-1z8A; Tue, 24 Nov 2026 15:35:32 +0100
Message-ID: <48f0cd1c224b0cfa2ccc39afc75512d5d7a1bd7a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: rsk: stop including linux/gpio.h
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>,  Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski	
 <bartosz.golaszewski@oss.qualcomm.com>, linux-sh@vger.kernel.org
Date: Tue, 24 Nov 2026 15:35:31 +0100
In-Reply-To: <20261124143333.3197625-1-arnd@kernel.org>
References: <20261124143333.3197625-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Arnd,

On Tue, 2026-11-24 at 15:33 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This is one of the last files to include the old header. Drop
> it here so we can remove the file.
>=20
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Ideally this should just get folded into one of the patches
> in Dmitry's series if that makes it into 7.5, otherwise
> please apply just this one.
> ---
>  arch/sh/boards/mach-rsk/devices-rsk7203.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/m=
ach-rsk/devices-rsk7203.c
> index e6b05d4588b7..eb56b57812bd 100644
> --- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
> +++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
> @@ -10,7 +10,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/smsc911x.h>
>  #include <linux/input.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/legacy.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/leds.h>
>  #include <asm/machvec.h>

I will get either of these landed for v7.5.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
