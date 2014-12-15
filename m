From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 15 Dec 2014 09:06:28 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141215090628.GB1031@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0ntfKIWw70PvrIHh"
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <2462101.Er8OZg9N24@avalon>
 <20141211214732.GC21482@katana>
 <1729516.HWbfnj3Cpn@avalon>
 <20141215064306.GN16827@intel.com>
 <CAMuHMdWsUkQN-+h07Zf2snbD9bEw49_+rasY4zS8QcvqA+aXUQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWsUkQN-+h07Zf2snbD9bEw49_+rasY4zS8QcvqA+aXUQ@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, dmaengine@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Please let me summarize...

Thanks for the summary, Geert!

> Solutions under consideration:
>   1. Wolfram posted a patch to make i2c-sh_mobile fall back to PIO,
>   and retry DMA initialization in every request, so it will switch to
>   DMA when it becomes available. But this is suboptimal, as it adds
>   overhead to every request (and DMA may never become available in
>   case 2).

Still, I'd think I should repost my patches with your comments
addressed. It does add a bit of overhead IF the dmaengine core is
compiled in AND the driver for the DMA hardware is not. Well, yeah. On
the other hand, it fixes the regression that the driver is not even
loaded in that case (because it currently will be deferred endlessly).

What do you think?

All the best,

   Wolfram


--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUjqSTAAoJEBQN5MwUoCm2xNoP/iCI34P9DZZazNsKw88i8e5n
r2XgUeNF7xqFtk+Poh9MkEQ8IazZvWm7LCdukrII+pjoeU9Iwa8TZfKf9MrWeEQu
vmCzvRlH3LMTWk0PnVG31Zp6ARw3dH+HXl/v+7ygxLqOvCkcNN8G2+SM6oPnE7xa
TzGVnRffk3wOUpr+pJ1+0erAdXuQtjD2/RRNdJ2B5TTIqPJWxfF1lNXB90kmYyCc
2A7BUygqlKuaXtTFKDOd4BMthmHB7ds6RxZYAGvTqeyRz0uo+bK9naM3uvawlgrE
HJNPAeSH1x2dGpODJa8FBRBOnoJt4vYhMwIRlbQxYiMiuatxj8d7h702AGfwuxCO
/9alGafNTXzRYAjEXAx8OqqHGDTN0G4dfC3FH7KRIveXnslhjJiutrLtFVPwcUrd
BThbTfmmcGppQx2+ZJbRf4OeRRcfH2nODQ5UE2/yphZmb1EgsLCSDhzOvX30odz8
ffDcbyT1RmYIOxh3zixmA3WD6FciqOlpONhJUw/oCZrfHPQmEhCiXfA9YFj7HqQ5
+aUGaEoj0GatTTNa1PRNbcaMT7Uot52sCxau+t9Hq+FQ4uBpuQrX1RcOTQsuSgel
eyjrZdqHFuUIJfwswURsJB/52Cy0Ny84RFGdzCVOCkVgyOpwel0S/++JlROM2Wla
sDEwYo4lHrekwQLI95Ef
=INy4
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
