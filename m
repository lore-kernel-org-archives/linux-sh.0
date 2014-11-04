From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 04 Nov 2014 10:19:42 +0000
Subject: Re: [RFC 1/3] i2c: sh_mobile: add DMA support
Message-Id: <20141104101942.GA1298@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
List-Id: <linux-sh.vger.kernel.org>
References: <1414752678-26078-1-git-send-email-wsa@the-dreams.de>
 <1414752678-26078-2-git-send-email-wsa@the-dreams.de>
 <CAMuHMdX1-ANQQhZkfKG67-TSKEUO6sFeiUMkkA323Ww4Cw9JrA@mail.gmail.com>
In-Reply-To: <CAMuHMdX1-ANQQhZkfKG67-TSKEUO6sFeiUMkkA323Ww4Cw9JrA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Given you only support DT DMA configuration (you always pass (void *)0UL
> as the channel ID), I think you can call dma_request_slave_channel(dev,
> dir == DMA_MEM_TO_DEV ? "tx" : "rx") directly instead of using the
> dma_request_slave_channel_compat() wrapper.

Yay, true. Thanks for the review!


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWKg+AAoJEBQN5MwUoCm2yk0P/2OjHDm6guPiG9VoctW41UcG
1ql9SwW8RWguY2Nm/Twp0tXYMUxmnSm4wgxhN0Cyv8O7XU5KYTI63W8VAGtGg0CM
zgDSwHPlTNyvEKFfdYGbBXNQQ/UmhvSpxSQb2xwyF4Ya2Pehbh14znQC1G5BvmPY
q9Fx3iZY/8SfMhLQfRLLfAVVwlEj6b/jK5iPHhai7pF+MbNS11pWHWQoy1WeFmep
bkdIG2Zuhs22vn/nFiYYhcdxr++xFc8puaBeUd4mGOjVIGaj9GYgHyN1EhykDX1Q
EWszF5udJbvNISa1F9uHbCOV1BtUIv6q49mUXhg54UZ1vmHo/BLJ759JIC67Pkib
xXcTqtdsipl1vr0FE7PdZnX7Sb+X2Qrxlt59wh38RUvuhxw+kQ7hIeZlWtBLmHkx
t7xgPMkykx5NZKvAaOScsmsRJ9nbGHpuTW1zWXEelywSOKeQu357LX4/wILi47TK
H9g3N2ddhIUPCJ58Oe278do21d+ljJnVF0TSnvg+YHq30PZfd+tvjNIzHCkTkzte
rmrPzgFs/c0EkjUlbG2G5w4xyIKtzG/ixJfTyRuN11htjLSjH/5MQV088HRWgWK2
+wvO4LNbHAYs4cGCNjAWB3rTlZM0Q/gJD1zr84bSouqfddtRfgLQudMbfVvgJ015
5tZRmrVWgjFN6ZmLL8cf
=S867
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
