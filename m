From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 30 May 2011 05:02:21 +0000
Subject: Re: [PATCH 3/4] clk: Add fixed-rate clock
Message-Id: <201105300102.23015.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart3187876.XmGpJ4YCpZ"
List-Id: <linux-sh.vger.kernel.org>
References: <1305876469.327290.592839707336.3.gpush@pororo>
In-Reply-To: <1305876469.327290.592839707336.3.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org

--nextPart3187876.XmGpJ4YCpZ
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Friday, May 20, 2011 03:27:49 Jeremy Kerr wrote:
> --- /dev/null
> +++ b/drivers/clk/clk-fixed.c
> +struct clk_hw_ops clk_fixed_ops = {
> +	.recalc_rate = clk_fixed_recalc_rate,
> +};
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> +extern struct clk_hw_ops clk_fixed_ops;

should be const
-mike

--nextPart3187876.XmGpJ4YCpZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJN4yTeAAoJEEFjO5/oN/WBR7cQAM9h0M6yGCXUloYoRXj47peK
TPWH+JJq66U8T1iHjlWaUcF/92tIFKsMBAaG9Eo6PJ34tQ+v/0+p/3wlEKqEBAs8
PN07iVRz8pt2s+J+cEuDNqAXWeUNO8eEQ4gPHHSSGHY/o32YXXIcvHqLTlJICq7w
ILwLQM3bd6/xxL32k2gys/GTWuq/6Zz/x+SAGCZ8T3UTHw2wS210p9dkA0KyDkm9
OwNw/pWrYZF3FfSlzbqpoPHfar8CjCDEpcOKC590geFW6bEidhjAV/H/b1nnyrik
fKXTaxkhImSeymYkX4BLVALJeYxROm4PeZIjpWXtXvC/SRvqQ9jDd1SxXlvqIJXN
2L4MhastNwp2sWDwbapo+cH2KkAXAyxRvAEB15CgozgxmzGcQWxmQdPXQ5818JCr
ny6ARWSp8lsLuwWHQmbnsjOyfy7eDNgsk4bE80u6q5LH248tLZkqlfMnVbvIwN+J
ImYTqD/DeUJDrWuWtJiufTyBkD2tC8b7/O9T+Sx/lA6KGE3aHBpsX9wBPKcxeSt2
rPBnt6/dohmwvaqFTQiaWR4JGZmIELvm5YvnNkjsgNLH5WECt0vwWV4nmubwnQvs
XcMjt3ygUyDgLLWnm07pfSrV7mg8UAUuwyyKZlo0lQaqxGlGv22yhosqE82Xiry2
MjIl4QB6FUZoZhjOn06I
=rbb/
-----END PGP SIGNATURE-----

--nextPart3187876.XmGpJ4YCpZ--
