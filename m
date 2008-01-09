From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 09 Jan 2008 19:21:27 +0000
Subject: Re: Busybox and automatic module loading
Message-Id: <200801091421.28128.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart7384016.kmGQLmjOUW"
List-Id: <linux-sh.vger.kernel.org>
References: <1199495386.12780.3.camel@localhost.localdomain>
In-Reply-To: <1199495386.12780.3.camel@localhost.localdomain>
To: linux-sh@vger.kernel.org

--nextPart7384016.kmGQLmjOUW
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 09 January 2008, Adrian McMenamin wrote:
> On Wed, 2008-01-09 at 12:54 -0500, Mike Frysinger wrote:
> > On Wednesday 09 January 2008, Adrian McMenamin wrote:
> > > On Tue, 2008-01-08 at 19:38 -0500, Mike Frysinger wrote:
> > > > On Tuesday 08 January 2008, Adrian McMenamin wrote:
> > > > > On Tue, 2008-01-08 at 00:57 -0500, Mike Frysinger wrote:
> > > >
> > > > are you generating the device nodes by hand or relying on something
> > > > else ? mdev currently will not place the device nodes in a subdir as
> > > > would be required by alsa-lib.
> > >
> > > No, I'm using udev. The module loading stuff was not the issue I'm su=
re
> > > anyway. And the OSS emulation appears to work perfectly.
> >
> > i'd just build everything into the kernel except for the module you're
> > developing ... a lot simpler that way
>
> Why? I'm not sure I follow what you mean.

because then there is no question of whether you loaded things properly ...=
=20
they're built into the kernel, end of story

> > > > > Maybe something wrong with my driver, (though oss emulation works
> > > > > very well), but nobody is being very communicative. I don't think
> > > > > there is much cross compiling of alsa going on out there!
> > > >
> > > > are you using uClibc or glibc ?  we're cross-compiling alsa-lib for
> > > > Blackfin/uClibc and it seems to be working for us.  our drivers are
> > > > varying degrees of working, but that is a driver problem ;)
> > >
> > > uClibc. I suppose my issue might be driver related, but if so nobody
> > > can point me as to where. And, as I say, the OSS emulation works.
> > >
> > > Maybe you could point me to the configure script you are using?
> >
> > make sure you turn off version stuff: --with-versioned=3Dno
>
> Is this for alsa-lib or something else?

yes, for alsa-lib ... if you try to use symbol versioning with alsa-lib und=
er=20
uClibc (since uClibc does not handle symbol versioning information), it won=
t=20
work properly
=2Dmike

--nextPart7384016.kmGQLmjOUW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iQIcBAABAgAGBQJHhR64AAoJEEFjO5/oN/WBI6IP/1qXzPrTRPE70UApSTeR/1IQ
o5m4g24BTDRL7+xPwwvYMRD76yr110QBub5EdkQqYanHgpTFmZXIMjCJsoViXl6G
lE0npxXp+9Tr9GWnlIs1opTOq5hWvAz76ccyYOs1+dVIKDfJ1gpsQplSpsQZ94mj
MQxQEE3XrIwljc233E08pDbyd9Y38y9QVBoE3MHqrC3rqOcu+RTDC1oWe2kGTuCb
CDS1LUy3nd/sYtfLNnJ29n7PpWBohWigouw0MuXOhJoYnmrYinbkn0NTMxHKbOhn
XjG2P+LMEPBS4n4FymS2+10HnrbfSI6EwsiF7kSJtf65X5S/g0vTYwfT+jkPtuLT
GLZILcopJnXTt37GVfQVr9ZnSW5h7xMO0Rsip61/Oe1hxWawG3coA0vtiHGP0pgg
/ejBG5ScFTq3ZJ8jbxTcLTytgxrYGwGWuBtsUhtbsAoubBdhTLSOM1+A84cZ92ie
RLLpfaJRx/zwBXKD2h5S0M+Y32MjvDDMbA0/OiTfkrNeU8uzlXTXwUx9ecvYze3a
ys+6IKU8HCzBPqm3hpLnsSHBuvRQBU9bd7u6EznVcGazx9g5PWplCKJMM2KYmoJX
xSHYXeDFaXOPZedhK5LGL0lU1BrWFZY8dyzjQg6DxuhWMsK+6wNaBq57ZLrjKqwy
tQynLQ1r4+Y29F8Eptx3
=+HC0
-----END PGP SIGNATURE-----

--nextPart7384016.kmGQLmjOUW--
