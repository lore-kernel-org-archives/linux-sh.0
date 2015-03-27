From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 27 Mar 2015 13:10:45 +0000
Subject: Re: [PATCH/RFC] i2c: rcar: Fix order of restart and clear status
Message-Id: <20150327131044.GB19151@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="eAbsdosE1cNLO4uF"
List-Id: <linux-sh.vger.kernel.org>
References: <1424011396-3492-1-git-send-email-ykaneko0929@gmail.com>
 <b0a6dd2b593f2f891946ef910c876b48@the-dreams.de>
 <20150304040819.GB12776@verge.net.au>
 <20150306220531.GA6572@katana>
 <20150307103349.GA1194@katana>
In-Reply-To: <20150307103349.GA1194@katana>
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 07, 2015 at 11:33:49AM +0100, Wolfram Sang wrote:
> On Fri, Mar 06, 2015 at 11:05:31PM +0100, Wolfram Sang wrote:
> >=20
> > > I asked Kataoka-san about this and his response was as follows:
> >=20
> > Thanks, Simon!
> >=20
> > > If system(CPU) is busy, the driver can't clear the status register so=
on
> > > after kicking start.
> > >=20
> > > If sequence of first start is as follows, there is a problem.
> > > Because H/W starts by 1.
> > > But sequence of re-start is as follows, there is no problem.
> > > Because H/W starts by 2.
> > >=20
> > >   1. Issue START condition by ESG bit of ICMCR register.
> > >                   <--- If there is too much time, H/W finish transmit=
ting
> > >                        and set status in status register.
> > >   2. Clear interrupt status (ICMSR).
> > >   3. Open interrupt mask.
> > >   4. Wait interrupt.
> > >                   <--- If status is cleared, interrupt does not occur.
> >=20
> > I understand. I'll add this explanation to the patch and apply it soon.
>=20
> Sorry, another question came up while applying:
>=20
> How can this interruption happen? The function is called in a
> spin_lock_irqsave protected area. Is this an RT_PREEMPT related issue?
> Am I missing something?

Hi,

any news on this one?

Kind regards,

   Wolfram


--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFVbUAAoJEBQN5MwUoCm2fZYP/i19/y0M21mrDtpivY3RedRV
G+DDFu6fWmbPWqPszjt66V9sE97IV5+kJJ0e3/j7BNbf4Hc6EsulYRv1x9fpK7nw
sTZQUse9AACL+A791vCths362u+yM0eGbMImMo/TTGAykZ0K9WCLZgKnO+6dGV3W
D4uk0ehrlhv1jZiVNtx4Us0IuwLQ0owV1XRmqzE92D9MDn81C/xwDPcU8OQYjyre
DCIc/pKts4+BHez/JQuiIQZGKN4IlzOq6CiEYaODBzZANkmhGyPB1hvD2i2V2nRZ
BAvpfBplgHYznqQxoYJiYNx7yNq/0TYTiYcBFfHFbvO+RnuVldzfB1oacfVNtv5r
ud5biSEbQugXaRIVNoJdIiPBdyPHOOHGODVLAlxyJv45h8fvnbknYUzc+s7/NYgt
ldbeO0bn1smp8uV4ilrSE2mgPuv/+VuF69Qo9P4Cu0lt3bxr0Z5q3h80pXQlZKhJ
YenVHrNxwwq0KOEjZXz8YBa0FC9FF9WmGrfA0FRFisr7HM5ox8sIME1latQKsLcd
ENifLiVNz/oc0No3kKpj/UX64BToc2v1hePpSPjpQZndgaQp1ZxRZCBVv+Mnrmky
GvZlS+11PY1VMi+KiLY0Nz5bIeI6X8MzE9aT2UmrhKBLatn7NijcO+XJc3XgIJ2B
VeIJwGHgY23YRw5Lpt8Z
=GXkF
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
