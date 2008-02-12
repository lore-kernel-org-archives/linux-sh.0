From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 12 Feb 2008 15:23:40 +0000
Subject: Re: [PATCH] SH/Dreamcast - improve detection of attached peripherals
Message-Id: <200802121023.41473.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1318018.jkP6kEZZUg"
List-Id: <linux-sh.vger.kernel.org>
References: <1202689502.6237.23.camel@localhost.localdomain>
In-Reply-To: <1202689502.6237.23.camel@localhost.localdomain>
To: linux-sh@vger.kernel.org

--nextPart1318018.jkP6kEZZUg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

is there a reason you guys dont use git to submit your patches ?  it does t=
ake=20
time to learn if you arent familiar, but the time spent more than pays off =
in=20
the long wrong ... it takes care of all these fun bits for you.  a shortene=
d=20
list for arbitrary developers:
1. < make changes to git repo >
2. git add < files you want to commit >
3. git commit -s
 - first line is the subject (so you have to follow convention yourself)
 - one blank line
 - paragraph for body of changelog
so the example commit log would be (just the stuff between the dashes):
=2D---------------------------
SH/Maple/Dreamcast: improve detection of attached peripherals

Blah blah blah this is the long subject explaining why this is wanted.

Signed-off-line: automatically-added-by-the-s-flag
=2D---------------------------
4. git-format-patch HEAD^
5. git-send-email --to linux-sh@vger.kernel.org <list of patches produced>
6. git reset --hard HEAD^

i'm lazy and dont create branches for the small one-off changes.  so you gu=
ys=20
doing more work would probably want to create a branch before doing the wor=
k. =20
in that case, just replace "HEAD^" with like "master" to generate patches o=
f=20
all the commits made to your branch.
=2Dmike

--nextPart1318018.jkP6kEZZUg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iQIVAwUAR7G5/UFjO5/oN/WBAQIzWA//SfRioyWl64ISsPBCTbSSUNcmq97a7/VS
dXW06C7xZq9oI+ChHw1ujS7qiC/ko4yBeie/M9mXb9qMXIM+RJHpuCIynC00JJsh
sjE+DIv0bG9+CUE7XNLkl0qh4WvcKYtlvgQmjDFpdAeIRde3zIgk3OlTIhtyu5yb
mgETBQic9ndDVSm1eKxvTDhqdWMHD6iKUtGVDUK2oDMwl5NvTGA9FGoY1c2I+UvW
ktmYXDdBL6rQHL1x72EJQGFfPsWT26gomYiR3cJ5NHYOlqcN5K8X8rdr3ZSU/+wx
JJzJ15e6a516iMJ+cCWR45Y8ms85AqxDm0/Wc9um+w/g8EidVYP7E9WcGvKUET4p
OQqvKN8cR9faCAkc+m2z0LbOdqrjPecIywRl4d6VFvzG0Ba3tUCh9upb732oufUk
VRFOwE7vTID2dSjSfU0FGNJCiaruQxqB/OKvhlRYVSlsKt0jNrJL5bAi3VcLliFR
JnW90zrTh/hD32aWYYtXqQEIg0y32WMBWJHkQLMePXUUBugUrhpWKmBx+iR/GEo1
GNRLHIs2bQfbzxR9VRrcOHEkhvtImOAIyqdnhM1PHg4luEglRGUl8wreMLgAPhzK
hyrMIA/TWlb+X//Cz/+qa+AVT4VIazPdMwDik0aBmyOPbPlnUq1IFzmnFvOKFtqt
FzBaNnzrtsI=
=axza
-----END PGP SIGNATURE-----

--nextPart1318018.jkP6kEZZUg--
