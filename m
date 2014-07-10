From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 10 Jul 2014 15:21:29 +0000
Subject: Re: [PATCH] dma: sh: inherit debug options from the subsystem for sh
Message-Id: <20140710150929.GF2296@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LZFKeWUZP29EKQNE"
List-Id: <linux-sh.vger.kernel.org>
References: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2014 at 02:25:58PM +0200, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> On Thursday 03 July 2014 10:48:34 Wolfram Sang wrote:
> > Hi,
> >=20
> > > With dynamic debug, these flags dont make much sense unless you want
> > > something to be printed *always* during boot.
> >=20
> > Yes, this was exactly what I wanted.
>=20
> Why is that ? My understanding is that the purpose of the=20
> CONFIG_DMADEVICES_DEBUG option is to enable debug messages for debugging.=
 As=20
> it requires recompiling the kernel, wouldn't dynamic printk be a better=
=20
> alternative ?
No it wont. Pls see the discussion.

Lots of dmanegine device gets used at boot, so for testing those scenarios =
it
will help to enable debug!

--=20
~Vinod


--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTvqypAAoJEHwUBw8lI4NHbekP/j6tvBNQTgP93VQI8hsBZ/0c
Tdl3VfSQgZkHr1LVJojrePHacci+In2JgiufrYBwAN5FV9nXTdCeqtJD44uUuTsT
ZMWCRckuQbnvSpT64IXua7qFVAdA8/OA/7ZiGPlakdRvVXbxrMsr23KjOVSGGJO1
A2DDWSbahc3QTCBXPpYL/IUE1YAziOpwVtOSSe/iFgr54Q/b2zzIUz/oshYhRytq
nJQGcm/dnVccSkjJA0Tzfjjih9rky5AsOs2HEt5MsyQicd62LsjY5A12kMROd3pz
ZsuS35QPVu0ldowWfPAVb31cq31DocBa3VY1KzJ/CPkzikWoEY8LA41CsenOdVdY
yXigi/LDWupl9sOwBB3ZrG5GNbkS8R1QeVd0fRg+Fl4yNqroMNqzvWc8+p8Ozkwp
GyCl7Rv4kdpHsSVJYRhp51faYVwSlIKUBvE39mc/Au7Wjn9KBYCMzYIu1hKw0Vt/
Rl98MRaG2nfQc3jlNwuIJL4cITl8fP4SFmH2jeCEjn5UG7+QVOK4P6Duc1MC5O+X
Qc/R0jjG3aEi42w98LyuQB0EdOTlJqLfp+1Ff8rr2h+sPn6lEaHcsW3VUWA8rhuc
H7FdIHpK6cV+fbjHjWC0acOT067kLZjr2Bcxc6o/UbpWR84Moyvb5dZdXZuGUGxM
dU/P/H/yXQFQjJyGxc3F
=RsQc
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--
