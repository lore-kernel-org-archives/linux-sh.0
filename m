From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 17 Mar 2011 06:56:36 +0000
Subject: Re: SH Core Linux 20110317
Message-Id: <201103170256.37388.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1519436.EQbe3p9HOE"
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTikhuHy8iZO+K6OOARG7fAt90hXbcEFE91dirMOX@mail.gmail.com>
In-Reply-To: <AANLkTikhuHy8iZO+K6OOARG7fAt90hXbcEFE91dirMOX@mail.gmail.com>
To: linux-sh@vger.kernel.org

--nextPart1519436.EQbe3p9HOE
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, March 17, 2011 02:40:01 Magnus Damm wrote:
> This is the first public release of SH Core Linux, version 20110317.
>=20
> SH Core Linux brings the Linux to the SH core included in sh7372 -
> running in parallel with the ARM core.
>=20
> Many modern SoCs contain multiple CPU cores in asymmetric
> multiprocessing configurations. These asymmetric CPU configurations
> often run multiple operating system instances; sometimes multiple
> instances of Linux and sometimes Linux on the main CPU and some
> customized software on the other CPU cores. Asymmetric CPU
> configurations are different from symmetric multiprocessing
> configurations which make use of a single Linux kernel together with
> SMP to support multiple processor cores. To make things even more
> complicated, come SoCs are configured to have some CPU cores operating
> in SMP mode, and others in AMP.

interesting.  we've been banging on similar issues with multiple Blackfins.=
 =20
we've got an ICC (inter core communication) driver going atm.  but the=20
protocol isnt limited to Blackfins ... we've made sure to design it so that=
=20
any other processor type can work, as well as any operating system.

> This SH Core Linux prototype is written for the sh7372 SoC from
> Renesas. The sh7372 contains one ARM Cortex-A8 and one SH4AL-DSP core.
> This release includes all that is needed to run two instances of
> Linux; one on the ARM core and one on the SH core. The ARM core is the
> main SoC processor which runs a user space program to control the SH
> core. The SH core does not make use of any special hardware except a
> mailbox interface where Virtio serves as a communication link.

so this implementation isnt limited to Linux right ?

i think TI has been doing their own thing too ?  but they dont usually try=
=20
hard to push back to mainline ...

and then there's MCAPI ...

i wonder if there's some way we can centralize/focus efforts on the Linux s=
ide=20
so each SoC vendor doesnt keep coming up with its own magic sauce to glue=20
worlds together.  i really dont see this as being a useful area for everyon=
e=20
to "innovate" on their own.  the advantage to being the first one into=20
mainline is that everyone else will have to migrate to it :).

perhaps start a list on vger.kernel.org and a wiki on wiki.kernel.org ?
=2Dmike

--nextPart1519436.EQbe3p9HOE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJNgbClAAoJEEFjO5/oN/WBzTYQAIYQZEd0Ry7pTIUHmGgU2H/4
YsAVuSNVjn48z4/kF4F1u277jwI2ofy1sIVQCXWMIZvH8cFGiQWOt35tnU/Knmg3
6C6tyUO3kcuWXm9pHb6xfq8qI+i3E/r1vhj5pPMgygyKbazmfatbhGzTwYLgIUly
Xu1gDEHDgDP76YjJBX9qnId5tmEb8I9Kd1PXitCqnkeKeib/I6nQhcZYEbXcx3Hh
mD3EI5nNVwdenB6/KIaPPSEqqmXvOYe4c91GFHaiKr/f9sGGz2N3TTwxvWOTeZ7y
m8firw7/CrkPNbqeDBKKFomoH6m/Az9SDgycwKFeVwanq/OD+HSI1TSkE8yY5EvU
BmTCytdAevdJoueY4mtwegfEk/c8T/hlbxxa8SS1QIiY9MALMJkNDnDD5Hzj9rCI
BT+3LtSwMjPJ9TaaWvW7pIdnODvg1VVvC0bxkVxX5aduQEzo5NVBoxCEipiIb8me
YyjaoZsHoLsbYMvEPu9aEBbxtXRX23c/NISbkei3hg0Dsfhvt8x3qR1BLmcu9Zzp
4HMH+7PUKs8OM83ZvjbA1RKE0ApBwn0MA6wwf5VmqWtOGqP7Bu/801VYzaaO4091
/R/a7vMcfy4O/aDafF3VMoAs4Lz8mVhzxATQJvL6KkZ7JmMW8NA3JKeZcaOnx0z8
ASZuvGqJsCh99w02jd4n
=1vv1
-----END PGP SIGNATURE-----

--nextPart1519436.EQbe3p9HOE--
