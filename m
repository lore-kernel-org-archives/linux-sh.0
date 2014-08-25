From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 25 Aug 2014 03:40:09 +0000
Subject: Re: [PATCH v2] Revert "i2c: rcar: remove spinlock"
Message-Id: <20140825034009.GA2795@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
List-Id: <linux-sh.vger.kernel.org>
References: <1642788.pEhrsPDp4u@wasted.cogentembedded.com>
 <20140824064520.GA2578@katana>
 <53F9CCE7.3010006@cogentembedded.com>
In-Reply-To: <53F9CCE7.3010006-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>    You told me to do 2 patches, one of them just revert.

No no, I asked for one patch having both, see: "... feel free to send
one patch with the revert and the updates you mentioned."

> for the follow up patch, I need to think a bit more, so all in a good time.

OK, I'll wait for the proper solution from you or do it on my own
somewhen, whatever comes first.

Thanks,

   Wolfram

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT+rAZAAoJEBQN5MwUoCm27psP/0Jmz8V/GcdcCsUGPg1MRLE/
S7e87A+R7MAfgOaD0VeZdnvqY2M+z4SdOfR7XPkLIqEkfoJQdFj77XwBkppnP/Um
AkJ2T6I2BioEMVMj02BK4kh6PTsyGmGPkns7O8gwTeOz3aegx+dVR426ej0pNHp5
vWPYYrxWfRIHHqmGPPulxvp8Kr2XKYWTWYGB7OWCm47XBdUWgYioKr4y0xR+tIZg
dabvLUoG30JV4fNGSL7e883HPDu1+c+8PeJ+OvsF4Lg1G3GLkAHz6yY2V/hCXTZJ
Z72mjHhtIlMTQEp2f4uH1VJKYCnXtyAkqUdhFf2LXS/MHpyEfwNnct0MQaw9EcW2
9ctbfFiFkms0TtRhYWldB+W4bPqDW6jA0pr+0SpHqNYVlndL5wJNiRUg/6qpAmRl
aPPLg65CcS28f5fiusigjBlplMSFZimy70d6d/rK47oMTTrd6ffWmNIHbeGGT4c1
OWQlveFIE4fSpG7TYy/x8p8499Ek+YOVh8WzEP7JocvDT0ZsnYw9pioxhp20DmRQ
vb2vhYPJm9V7miICPC/x59QGtHkw3JQZ73+yT/rga9+kLxB3pSq0jWNOfEXAmt4Z
lIgtyI1KjLFZ52NiYeWf63qZysHGYQcOeExeufoxjLgC/q+BjvVP+a79U9tZ26AX
VfsiFVrBPa0NXVKocEiW
=ywRY
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
