From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 29 Jan 2009 00:44:55 +0000
Subject: Re: [PATCH RFC] sh: maple: Add support for SEGA Dreamcast VMU and clean up maple bus driver (2/3)
Message-Id: <200901281944.57894.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart5751798.d1G9QpNVWd"
List-Id: <linux-sh.vger.kernel.org>
References: <1233186456.6734.16.camel@localhost.localdomain> <1233187069.6734.21.camel@localhost.localdomain> <1233187750.6734.27.camel@localhost.localdomain>
In-Reply-To: <1233187750.6734.27.camel@localhost.localdomain>
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>

--nextPart5751798.d1G9QpNVWd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 28 January 2009 19:09:10 Adrian McMenamin wrote:
> +static struct maple_driver vmu_flash_driver = {
> +	.function =	MAPLE_FUNC_MEMCARD,
> +	.drv = {
> +		.name =		"Dreamcast_visual_memory",

i thought there was like a 16byte limit or something on this ?
-mike

--nextPart5751798.d1G9QpNVWd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJgPwJAAoJEEFjO5/oN/WB7WoQAIdrOqh+Lprp/P1q8n5dZmH1
+PxDZu7ZBqiL5qr+BCS3ltAvPYtZt4Ajvn78ypx4fzegH0NVZdXMQ6kvLs5JKRnY
bLR4yXP0tBeaFXF80o4FFHxr7VPrMMXIaQUovgKagN87988km4RRRhBCQCzEfzGv
FeVtilrzxkCYFsg2noCThoEFWdx03QOMlrcx50IQUhtj2hWR/qegh0vIoBDwjCxf
viTYFunr3DqT1SfgzYFBaFFJB/vxAV8fQGLl8GrhRCHgwMcB9E2+WNOLYA5WL+uW
+MvF+T+/MhY5QU3ztKAODAOR9ycl72eX5aMzx39vJhRWTIt62nzftvfy7MHW0pq9
J3MVH9nJSJpPoEvLca9VjlpexOzy8+4EvUIL53bcaGJpGHuA8m0/unQci4GuYMRY
LsjNvGLCbz+XUolNe6oOIwnMMMQb+YYjz7eaRRU4ov9+ZqGCJfUiIgSUoZN9U86v
cIWRBazjow2EXt8iwz+DOHJXdNgbtUZu25dpL1foU79T81f6TpfaVsoCsnfKhpdE
1ewteCXUjAeQR9Cd/CwDTk8/gQabYutJMtjz5Uh/4i48S0wtgSOew/GaTnsaUAXJ
uJtCJJ/Mrq4G8DyULkTQa+b3Zv79Iy7wAbZwZAfXXYJ6sXBf+jD3+mc43nkwt+j5
6RWyfz99uZR4X0RVEEsE
=iCdt
-----END PGP SIGNATURE-----

--nextPart5751798.d1G9QpNVWd--
