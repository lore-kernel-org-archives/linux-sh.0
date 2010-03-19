From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Fri, 19 Mar 2010 11:01:23 +0000
Subject: Complining with codesurgery 4.4.-43 sh2a
Message-Id: <201003191201.24090.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi all, why I need to compile my code with -m2a -m2a-nofpu aven if sh2a 762=
03=20
has an fpu?
If I do not use -m2a-nofpu I have error
 undefined reference to `__fpscr_values'
at linking time

Thanks




In data venerd=EC 19 marzo 2010 09:24:04, Magnus Damm ha scritto:
: > Hi Fabio,
>=20
> On Fri, Mar 19, 2010 at 2:27 PM, Fabio Giovagnini
>=20
> <fabio.giovagnini@aurion-tech.com> wrote:
> > Hi, could you tell me please how to find info about using qemu for sh2a
> > if it is possible?
>=20
> QEMU did not support sh2a last time I checked. And I doubt that anyone
> added it recently.
>=20
> It may however be a good idea to use QEMU to learn about initramfs and
> user space programs on a different processor or architecture.
>=20
> If I were you then I'd try to get QEMU working with x86 as target.
> When you have initramfs working on x86 in QEMU then you can easily
> move over to some other target. With sh2a on real hardware with an old
> kernel version there are too many unknowns to make efficient progress.
>=20
> Cheers,
>=20
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
