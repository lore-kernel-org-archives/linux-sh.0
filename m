From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 05 Jul 2010 04:37:59 +0000
Subject: Re: upgrading u-boot from linux for SH7785LCR board
Message-Id: <201007050038.04090.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2835758.EhEp8FbU1u"
List-Id: <linux-sh.vger.kernel.org>
References: <4C30CEC3.1050003@naoi.ca>
In-Reply-To: <4C30CEC3.1050003@naoi.ca>
To: linux-sh@vger.kernel.org

--nextPart2835758.EhEp8FbU1u
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sunday, July 04, 2010 23:29:28 Bill Traynor wrote:
> On 10-07-04 05:24 PM, Mike Frysinger wrote:
> > all i do is:
> > cat u-boot.bin>  /dev/mtdblock0
>=20
> Thanks, that worked perfectly.

for safety sake, you might want to dd it back out and cmp the result.  so=20
something like:
	dd if=3D/dev/mtdblock0 of=3Du-boot.bin.new \
		ibs=3D$(wc -c u-boot.bin | awk '{print $1}') count=3D1
	cmp u-boot.bin u-boot.bin.new
=2Dmike

--nextPart2835758.EhEp8FbU1u
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iQIcBAABAgAGBQJMMWGrAAoJEEFjO5/oN/WBPfoQAIjtUI+VqwLfgvjvuZKiLWz6
H70yNvlmaZxZUYR3FU28/MYggYcjTm8dG0NOpdV4tXT9o5OQ43XR3z+xZuSXrJQB
dTv8Q+oFApDP/sMTL5swzOeohF2w/HK33uknKxeWkEHl43bDbdZ4WuqCAs+D/lOu
TRM0xnihxF2W8eRAohZUsh0b6RvAzPge0NCJV9rGB2TVzhNal3JT/OS+0abPLLXy
xk6/xTnKcQmkiWeRG6FjGJrGXjPtor59pfadpCFT6/z8cTWp6zuW6ZspQTesr+ue
qeOEPeWqCsZlzP76HKPJf59EEMchtoo5egDqaqU8rxb1KXO0+AQ+knC1hS1FZ4Eb
MTLosLPG9D4GnNj2hfPsRe6k84wkF+3JmHesN7wFkqoWPNQgaMw3LPv/FFELKqb7
eYSKfdGNusPplC6EfNaquWM5cWMG+PlPXrlnCh2ZndgoGS3y1ePkhLi0Fao7myMt
IJtxds2knFing4ZezkUqZmQ8GUIW3CWFhvZRDvMe9QA9nG8rKzcramU6Y4uxSvBr
UrPnE1eyTE85cjpZCMOmILHkRvrzUWr3NZjWUM6xQMhdoawbuG6g1W0p75SP9QWI
SXCzt3HeBgvFGhpLXngGdkQqnhYimOCfbQKki/9YFI465xevoIuMdPeSuJswjwod
9fHXLZ9EXZwoF0eHJ53x
=qBd3
-----END PGP SIGNATURE-----

--nextPart2835758.EhEp8FbU1u--
