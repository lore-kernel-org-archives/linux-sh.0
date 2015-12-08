From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 08 Dec 2015 12:53:07 +0000
Subject: Re: [PATCH v2 2/9] i2c: add generic routine to parse DT for timing information
Message-Id: <20151208125307.GA3359@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
List-Id: <linux-sh.vger.kernel.org>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
 <1449567473-2084-3-git-send-email-wsa@the-dreams.de>
 <20151208110944.GH1766@lahna.fi.intel.com>
In-Reply-To: <20151208110944.GH1766@lahna.fi.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I wonder if it makes sense to add "i2c-sda-hold-time-ns" (taken from the
> designware driver DT binding) to the timings structure? It is tHD;DAT
> parameter in the I2C bus specification.

It totally makes sense. I just didn't need it for the RCar driver and
didn't want to implement something which isn't actually used. So feel
free to add it, or ask me to do it, if you promise to use it in the
designware driver :)

Thanks for the review!


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZtKyAAoJEBQN5MwUoCm2dqQP/34nxInrnYQSTVxE+dBiUae2
qnqUJhDn6r9S4RB3QeOMVmSACBg7rY5XfYkjJS9f40GTgr3Bf2LJW9wuLxXY3Pal
Y5dTIWDBQGaVq/DUlixw9KMEO0fsw8i4bKWwYqV3+wbd50ANmsBT91aTc9WksRQV
mBwHBv8YgDAgBzlPlVFOFfGTvoHkHxX11uJedegOELWO5X5mID9wpILp0ix3v2mW
tqFq4SiPGxJqiIi5l+HREbJpqCGvW+up8AUsRAig68hhlLXmdH/xsf5Yl1tpSMCF
nvpdLK21jv1VvJPon1jgCLaunr4KIokaOBT57I7NDDpPTlLAicPxOOm50TUcLrMi
ErRhnNeerFmR9nMlG/1oygwVZEjKVGv6NMntQXQ+/rnNrOVXp31OulqjMeVWW0HX
t861X56RRPRFhHlh3sbFqiZUw+hGQQjsAf30WGkcgllm39cueB+tZ3SDXOLTgdG3
th5D+9Ox4Dw8mKSmNud+lJESncptk7cJBqZQIV2WgGH+hqNljvHRvLc14vikD6XK
XAXk47uXTL+nq8EB81lASxyo7gOmtmDp9ozkfYO0u3f5hSUghxQdE0VfU7ZNSM3c
I4JeRubpF912nFkvJXeOPyKjN9rXhQUyDLOxRQ+rWVH+tGPR5bbFzRiBv7HQIoZA
SXFpDHXsrnsHnKFjXHI2
=/Rha
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
