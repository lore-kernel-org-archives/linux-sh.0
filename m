From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 17 Dec 2015 12:01:57 +0000
Subject: Re: [PATCH] i2c: allow building emev2 without slave mode again
Message-Id: <20151217120157.GC3958@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZwgA9U+XZDXt4+m+"
List-Id: <linux-sh.vger.kernel.org>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <15285750.UWXWiNJ6YU@wuerfel> <20151214135206.GA1520@katana>
 <13702087.6o87OAVdIx@wuerfel>
In-Reply-To: <13702087.6o87OAVdIx@wuerfel>
To: linux-arm-kernel@lists.infradead.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 14, 2015 at 11:27:22PM +0100, Arnd Bergmann wrote:
> On Monday 14 December 2015 14:52:06 Wolfram Sang wrote:
> > > > What about not ifdeffing the inline function and keep the build err=
or
> > > > whenever someone uses it without I2C_SLAVE being selected?
> > >=20
> > > The inline function is only added there for the case that I2C_SLAVE is
> > > disabled, so that would be pointless.
> > >=20
> > > However, what we could do is move the extern declaration outside of
> > > the #ifdef to make it always visible. The if(IS_ENABLED(CONFIG_I2C_SL=
AVE))
> > > check should then ensure that it never actually gets called, and we
> > > get a link error if some driver gets it wrong.
> >=20
> > Yes, that's what I meant: move the whole function (as it was before your
> > patch) out of the CONFIG_I2C_SLAVE block. We should get a compiler error
> > even, because for !I2C_SLAVE, the client struct will not have the
> > slave_cb member.
> >=20
>=20
> But we don't want a compile-error for randconfig builds, and we don't
> want unnecessary #ifdef in the driver.=20

My conclusion for now is:

There needs something to be done surely, but currently I don't have the
bandwidth to do it or even play around with it. I am not fully happy
with your patches as well because __maybe_unused has some kind of "last
resort" feeling to me.

So, to get the build failures away immediately I'd simply submit a patch
for the emev driver to select I2C_SLAVE and postpone the proper fix to
later.

That being said, thanks a lot for your input. I will surely come back to it.

All the best,

   Wolfram


--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcqQ1AAoJEBQN5MwUoCm2efkP+wWPKVxLwHCKGuhzadm4RUgU
HNdYnGCp8GEA1P8PEVr+OgNxAfZjHmiDmEb02UzBl+OgqlUk/2qOF7U7SEgWgwC2
uRdCowQjVMb4B74c7B5+9UUCdYYD49YAdzvypMYdTBWg727AYyRUJVmhHfgFjBMd
0oQm7j6L8ucUuUMSfaWxx661EnvQZapj2oDiGNjckI7w3SPC3aXBBGzqY1Udcsgz
8EuphAjSrhuidEnYHk9bhob/xd69OgtT6EFfLIbVZTmC4Kz8a8mXV4+v5S8U/Zdy
yoB5GrE5T+AVOj9dLXxXp736mTAx057S6QTMd4uJSe24EzX8xm5OCPxatJ+GPhVw
12ojjywo+xPjDYRsEkg5hZJRsbEp2ruRS1RJe4N4q+p4wjI8+ACdv+2JCDuB+dKp
z2NmKpGsVkP8eAxVaqO4k3key4l/u4MDOZKTxvm+gJIMfw0NGAOScwU5WoNQcszq
U0jUolkY/opVjXWEbOwgzF6hPJNbWDnKM9iUsQtuUBAK5ECu9Duy0bsICJq5Nz9i
pwYiwTaci805K+AFtTpaq9A2eXJYx20hMBvLoT182ELxMK1jkJmWCcI2Bo6lf/qC
N05LcfQ79dppFJEHrYdsQ86r1SHLHDZ8LaYHDy+dJfdsuk1B/TlPAGI7Lh0Zw+Ks
Isb6IK5SA/EqSoy4nPuC
=dPsv
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
