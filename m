From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 02 Feb 2015 11:25:33 +0000
Subject: Re: [RFC 5/5] watchdog: sh_mobile: add driver
Message-Id: <20150202112533.GD3311@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="T7mxYSe680VjQnyC"
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 12:09:59PM +0200, Laurent Pinchart wrote:
> Hi Geert,
>=20
> On Monday 02 February 2015 11:01:54 Geert Uytterhoeven wrote:
> > On Mon, Feb 2, 2015 at 10:54 AM, Laurent Pinchart wrote:
> > > How about PM (system and runtime) support ? How does the watchdog beh=
ave
> > > during system suspend ? You could then replace the clk_prepare_enable=
()
> > > and
> > > clk_disable_unprepare() calls with pm_runtime_get_sync() and
> > > pm_runtime_put().
> >
> > That's a good question.
> >=20
> > If the RWDT MSTP clock is disabled, it can't count, and thus can't trig=
ger.
>=20
> I'd still like to test that. MSTP stands for module stop. While this is=
=20
> probably implemented as clock gates in most cases, there is no guarantee =
that=20
> it will always be the case. All MSTP guarantees is that the module is sto=
pped,=20
> but the definition of "stopped" isn't explained. The watchdog counter mig=
ht=20
> behave in a special way.

I'll have a look at the SMP case today. All the PM stuff, I'd see as an
incremental update however...


--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUz16tAAoJEBQN5MwUoCm2AIIP/0qB+3GsH3eD9nCPnHfo1kKC
FRQ5ljLCCRXbrjyuiB6k0OobwSZs0rUNKFrtYoUj41ff1mvfNznUPCB68nFhjzIL
G4XtHQfJPgsdU90/QRkbxA6oLDrDPSoX5nkgx6ycDjf3PXuzIeZ9jOztAPH81brx
gOjIybSlrsw3Oruzg8F+uJT/y81NATCuHYrQgGRT8doTNMt5RsXQkALDBR26n87g
KTAxoE7HvcbIHHTpuBsSmhC44eaOZJdYpz/xDg/UegPVExEpz91C43qGWZ9ELevh
AYYwbrdll7Oxv8GyHqKThtTCAp3OJeSLDnV7Qo/HsJEbA6jTlfeCEvMfHwLqLCkg
oCt8SMc5u70RaIWV9qS81nZsrB8/WzArLR0YOiZx8WcS5pWEzt4fxRmx/ofNZPLQ
VYqmtHCW1NtKvP1CJJ9+BrbsIARhoA8uQlCwigUnp5qE2q2WY//QWJE9E3h0glr0
/iDLNzWRDioLZDwRgZOr05YLAFyrrRCCjxUqXlXyhtL7TSXgtiNvi6nRHdiwG01L
jIOOwHJEU3BRME6AoT7UiZePhpUc7svrxR/ty+rthF+S1RSgMAHySLWfVMT3jnLy
+rIBoHe1a9I2UfCZQ5xnaQiBY3SHF+rZ1V/Pn7XN+zi2++4dTFiNEQj79Gf/YqVR
IndHuc7yYXDUzsfFbiD/
=noZ9
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
