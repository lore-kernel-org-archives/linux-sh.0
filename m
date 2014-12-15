From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 15 Dec 2014 09:45:33 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141215094533.GA3510@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <2462101.Er8OZg9N24@avalon>
 <20141211214732.GC21482@katana>
 <1729516.HWbfnj3Cpn@avalon>
 <20141215064306.GN16827@intel.com>
 <CAMuHMdWsUkQN-+h07Zf2snbD9bEw49_+rasY4zS8QcvqA+aXUQ@mail.gmail.com>
 <20141215091314.GQ16827@intel.com>
In-Reply-To: <20141215091314.GQ16827@intel.com>
To: Vinod Koul <vinod.koul@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, dmaengine@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Quite right, this is a good question. Today we cannot distinguish between the
> two. Should we improve the deferred probe to tell us when the init
> is complete and all the modules have been initialized? If we ever have such
> a mechanism to check then we know no modules are to be inserted then we can
> fall back to PIO mode.

Well, the user can load modules from userspace. And I could imagine
there are people wanting to defer things until they load a module
manually. And surely there will be a case where, for some reason, the
deferred code has to be built-in. I trust Murphy's law here...

> Without that we should use some timeout counter to fall back on, say
> try requesting 5 times and give up and move to PIO after that

Won't work. In my case, the I2C driver gets deferred two times and then
the list becomes static already.

On top of that, arbitrary retry values don't make me happy. Mentioning
Murphy's law again...


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUjq29AAoJEBQN5MwUoCm2YZQP+wYCAuXue/JuALk9fJ/A79Sj
pfDId7XDl3pVGNozw/XNKm0eJwZ9VuQLZoIlXUG5BHPm5mNV8khqmSlr8gvWezmX
YpPMpRZCZEM3XZDIBzy9ASTxRIaZPY7W9radOVKyuw1YifXW0U6Sy0MQwF4C1tzh
DRGQFhQ1U3nYfAXb1Q57rPlZUNanQJ0D5ISvubl4ve3kyxKuRWStbTRQWmC/Ynyz
89AupLeZdXOoQrZRlg2msDpEfVynPC/oGCQl9ZRizOE4CM2Gsxz/zYsFF0Rf7Y3N
f0qknpNk/dg1CcLOPE3B/lB09jSCqtm8+X25U7bSJ+iY3ZA7VMk934XuvkIpJVxD
a3im1duAwtTKGalZl7r2gsKLZ1iL0N659WjZ81JK4EPWL5HEoypsFN6cQYEfxQ6F
AeYW2/XQJWMGK60n/jFOYjXP7/3ilsHgzjnBLwbdfLu+3IEqSMEmGPPqNEUyWtKf
5hQA/grt8+5DDpl8n7dLxCu57lt2I4U/F4AQHnZwx6/IRUn1WDm36TuWBoGv4T8n
SDcpo+peGHwgBJlnbdseEHoafrNV+z2k+UMlRh0xjDVb2orAuA8znc7yaP+FGJ46
TNW9A2hvQE8CbwVgcLzfBmM6IIa+Hzcys1/PY3CveBcb7HtB5jB9usORfOz6pIZ6
z3r9kPQFSa1WrlqcPtHA
=B7Fa
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
