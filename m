From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 02 Sep 2014 10:28:01 +0000
Subject: Re: [PATCH] i2c-rcar: fix MNR interrupt handling
Message-Id: <20140902102800.GB1266@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LpQ9ahxlCli8rRTG"
List-Id: <linux-sh.vger.kernel.org>
References: <1843756.qQiZLxsyqD@wasted.cogentembedded.com>
In-Reply-To: <1843756.qQiZLxsyqD@wasted.cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2014 at 01:15:26AM +0400, Sergei Shtylyov wrote:
> Sometimes the MNR and MST interrupts happen simultaneously  (stop  automa=
tically
> follows NACK, according to the manuals) and in such case the ID_NACK flag=
  isn't
> set since the MST interrupt handling precedes MNR and all interrupts are =
cleared
> and disabled then, so that MNR interrupt is never noticed -- this causes =
NACK'ed
> transfers to be falsely reported as successful. Exchanging MNR and  MST h=
andlers
> fixes this issue, however the MNR bit  somehow  gets set again even after=
  being
> explicitly cleared, so I decided to completely suppress handling of all d=
isabled
> interrupts (which is a good thing anyway)...
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: stable@vger.kernel.org
>=20

Applied to for-current, thanks!


--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUBZuwAAoJEBQN5MwUoCm2cJMQAI3Ku8jvgJh/YW2cYQInPjqB
y8dFYIvD4gZXEaAnl0du7q82ITEBmLEhj8JhKqPGmNBwLFMPMRkEs2fNN3smbxkJ
u4wyaekdiUDsY6PaqdzV6eldML2XRw420xV03Ncyic0yM9ckz7F7CUfkpdZEI0+/
ODNuvSgGeol2FVogaEYi+AP38Ss56oyt2aEvex55yknN12HS42nu4tkB/g3JzUGk
DYptC/G0LkS5cAGDkkan43CGJekzaEEGWMUZzjwqs3dJPqnYP9/1rasJqhCknjeO
DVrCVlktczuh/FTtrd/5c5P8VYTgL0nZt0+MRHasOMQEkl/XtlumPALO1Zq7aHiT
tS+IFwW48u0D2rTwyREqblBCb8XVMqn/qZozJtfppAStZ7qFheQp3fcWxUZy7XCX
USFRCV7zeokLRDA2oW3/UqPiFHpXIWuazYpYZguEinfz0TFkPqBfjtnYm2jCh3QG
tGABPkAYpaBBV3VxYrI71xDCB3CyXNBwIOYq/JDgQjkgi5FnXz1V4QqrFuMOoiOP
hy1gPreaPncn+PCOwUY2DaKX2liyvo2uCTu+rAtFXLg4SrTKxvnTjYDsP8uCbqLB
0+/N6xw+VMg0FIuaWPfZOdUXpXb//CfCfE6o69tqBRdNkEjgdjuPP7I1qk9gnJsZ
MWWpxWTIY2y+9mN+aE0/
=Avhx
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
