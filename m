From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 23 Apr 2015 08:33:23 +0000
Subject: Re: [PATCH] TESTCASE: of: OOPS when disabling node via OF_DYNAMIC
Message-Id: <20150423083322.GA15071@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
List-Id: <linux-sh.vger.kernel.org>
References: <1427814771-30335-1-git-send-email-wsa@the-dreams.de>
 <AEA6F5CA-D520-4F34-BE6B-EF2839501089@konsulko.com>
 <20150414132709.GA1375@katana>
 <83B5C458-8D49-4EF6-9F4A-6C0E2579AB9F@konsulko.com>
In-Reply-To: <83B5C458-8D49-4EF6-9F4A-6C0E2579AB9F@konsulko.com>
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Sorry for the non-prompt reply; but just for kicks, can you try the attac=
hed patch?
>=20
> I have a hunch this might be the problem.

Yeah, this even makes my more complex driver work \o/ I will post it
once -rc1 is out. Thanks a lot for your help, much appreciated!


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVOK5SAAoJEBQN5MwUoCm2h1YP/RnQwe76BabWg/J5PXCaYz3Y
ZBEswSlb9HElazCdxyRBqONgd56c+/+RiX8Y5+eIMKZSxR+8c9PXJiWHkUFUEvf5
s3dN1B/i+SLDn7hyDhexwtKOhYSPEkVoNJlV24783O/EUAqrk4aIukbSD+/RofU8
dFg94TPYm/OfsT96SXvj7ZoeVO3ixnevW6ak/t6NKofhdWolcb+dkB3it+LI8qDM
VArqhITQNyqiETxO8fwMApyJP6+klvHcV7lBiCFuWr6hPSNgmH9YXpI5Ptzsouu2
jKk5xvrwj5RQ7UOQDFBJoPdXjbC6yqhn+d5BKGoGEG/kGMr4xGNcDBS3jziSkmNK
qkme/fwyY4jr1ntOtiQ0miilrMdJos6Y0G2+6NB89uMx09eIAvnF4wcWjUqhyuKE
yNU++E40xcKLSgrc5oyafK+xMzaHL72LSAD7+tSD3zIXDPK3FM+y3svpfMwOMj9s
IF5sQk6M4mcpKYUZKx8Krsxs1CnUDcnzmRA5AKWgSnOcGpzFELwlfCcGc3N+24+0
tGyZlyrEypFjHE8kWR2HsBqWAI5dSp5dZ1coLKProMGve7Ewizvi8dPzgJgnxupf
6oR7OeCxyBaWsjsnYd5iNHGhhphGU2f1MSVpiem+CPSulpZfrrzlUXOkQD8WN5p+
ktuzg9SAVTa1AXp133iH
=Ri7d
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
