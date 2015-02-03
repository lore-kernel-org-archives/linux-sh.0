From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 03 Feb 2015 19:04:42 +0000
Subject: Re: [RFC 0/5] r8a7790: lager: add support for RCLK watchdog
Message-Id: <20150203190442.GA32699@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 12:50:24PM +0100, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Mon, Feb 2, 2015 at 12:24 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> I've just tried your series on Koelsch, and it suffers from the same p=
roblem.
> >> Does it work on Lager for both CONFIG_SMP=3Dy and CONFIG_SMP=3Dn?
> >
> > I didn't. And what a surprise, it fails with SMP=3Dy :( I'll having a
> > look...
>=20
> Good luck!

Weelllll....

I think there are multiple issues and they mostly come from the fact
that a watchdog reset does not initialize the RST module. Rebooting even
fails when I only use CPU0 with SMP=3Dy. I could fix this very hackish by
resetting the A15 boot address (CA15BAR) to the default value in the
watchdog probe function. That alone sadly doesn't help. Once I activate
the other CPUs, it will still lock up.

Pity, but before I get too side-tracked from what I originally wanted to
do, it seems that I simply have to run my tests with SMP=3Dn. I guess this
also renders the watchdog driver pretty useless for upstream now :(


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU0RvKAAoJEBQN5MwUoCm2KPcP/iahFNYW0NqetHL4CXKUs9O2
MU3ad6KK8aRbucXf+IfOAjYC6cGjV3m7Xw53LgbN80qApIoDlFBhujcE45m1UL6S
cDEMcQc+zedXlyo5yuaPw41cyXA7Xpxa8NajUvYmsBTbPlCc9p6/4SGDEhjtwtdJ
WolkM7rUSOxEc/j9PRZsk796+2iTTGDBROIboDh58xdDvW8uJ4UoDRtXz/Hz/tRA
/qYPjjYiOb7uIvGYd5Wpam1q39zOCbCixpwlVySz3HTEaSyIX4Pld9cBQHyHaH16
boQwNqLLN8pZrRNMO3FyeIsUE3/bMR5GdwTP9ZWnqegMF0xtgcjCkrDZPfalR/g9
fI/SkUNU8aPL4bp3Yeelj5AIJVmf3AzePhMnmn7d9hZPim2CtYgWMDRtO+wZ+uVa
eu3zTuQ465OSPwzpdAC3DKbhx3LB5sigxF9UWnoXh6XrWn0XY4bNBYaIWrJn/bXW
vQy8UE7GR1ZbW6I6e8orL62Dynw6mAx31QDwu0LuYR/zyDAE2qTXfPo9PSBV70vn
4KX3u+cXN8ELo7KmhRVxo2qEPKNwowWXVrqUxjLQmWhCZFJyuiap61B4DdPmH+3j
3DuupCOdLrrfvJv+8yejotbckfOxTf/6IbrRYM6btPATg5hJv8po/UNi8uLzUvAK
9oESTuudLUPSUwPZGDuP
=vIVq
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
