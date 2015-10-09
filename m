From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 09 Oct 2015 21:34:01 +0000
Subject: Re: [PATCH 0/9] i2c: rcar: tackle race conditions in the driver
Message-Id: <20151009213359.GB1481@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5/uDoXvLw7AC5HRs"
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2015 at 10:20:04PM +0200, Wolfram Sang wrote:
> Hello RCar Fans!
>=20
> Two issues people have seen with the i2c-rcar driver was:
>=20
> a) immediately restarted messages after NACK from client
> b) duplicated data bytes in messages
>=20
> Some people already worked on those and had a tough time because it was h=
ard to
> reproduce these issues on non-customer setup. Luckily, I somewhen had a s=
tate
> where the first transfer after boot would always show the above issues on=
 a
> plain Renesas Lager board. When measuring, I found a third issue thanks t=
o my
> new tool 'i2ctransfer' (and thanks to projects like sigrok and OpenLogicS=
niffer,
> of course. Thank you very much!):
>=20
> c) after read message, no repeated start was sent, but stop + start.
>=20
> Due to some unlucky design choices in the IP core, it has some race windo=
ws
> which can cause problems if interrupts get delayed. Also, for every new m=
essage
> in one transfer, context switches between interrupt and process were need=
ed.
>=20
> So I refactored the driver to setup new messages in interrupt context, to=
o.
> This avoids the race for b) because we are now setting up the new message
> before we release the i2c bus clock (before we released the clock and set=
 up
> the message in process context). c) is also fixed, this was not a race bu=
t a
> bug in the state handling. a) however is not fixed 100% :( We have the ra=
ce
> window as small as possible now when utilizing interrupts, so it is an
> improvement and worked for my test cases well. There were experiments by =
me and
> Renesas engineers to use polling to prevent the issue but this caused oth=
er
> side effects, sadly. So, let's improve the situation now and let's see wh=
ere we
> get.
>=20
> I did quite some lab testing here and also verified that slave support do=
es not
> suffer from these changes. However, I'd really appreciate if people could=
 give
> this real-world-testing which is always different.
>=20
> Please have a look, a test, etc...
>=20
> Thanks,
>=20
>    Wolfram
>=20
>=20
> Wolfram Sang (9):
>   i2c: rcar: rework hw init
>   i2c: rcar: remove unused IOERROR state
>   i2c: rcar: remove spinlock
>   i2c: rcar: refactor setup of a msg
>   i2c: rcar: init new messages in irq
>   i2c: rcar: don't issue stop when HW does it automatically
>   i2c: rcar: check master irqs before slave irqs
>   i2c: rcar: revoke START request early
>   i2c: rcar: clean up after refactoring
>=20

Applied to for-next, thanks!


--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWGDLHAAoJEBQN5MwUoCm2rKYQAIHHGHkbu5FFj8p0dr76Jrxd
oz878wXBPLZaQHjjzul4/CnMvtP2jjvswJnr8EL2H7e9yq1h8dP7UTZTii33AAgr
o+A0/J1mpIoMilYwudv7P+NzwVah8jiynhtAxfr2fWgzb5IVTZOzTO6+Hs6i5LCh
Y3DraSLs4oRigTdJvqXY06S/FRRiSO1rNaL0uSRthiLhBishyfPsXP2QVTFCHaYh
xHXgn3DKY8vP+SEYISvYyRzftce46KymREXCBp+CpHG5/m2Wbjdeiz0cYD4O5Wgp
ONR3frr/TOtSpl1bomSPGnqg1zg74agjQWvlkXGMAs2z9c0jt3yRNXEJryFlMNtV
atTZiy0YWSC4Qfv2PCIuvDVL+j8qlr4YCkL3wRIDp+LT0XMm4sy0wiUagf0AhgbU
Fad1jKIe1iYLiV/HlDJYp4brukiK3TrK5qirHyeTarhYuH+WVG8vWEliMvR6XOVN
HwIYc1Q7dcJ7y44eIVDXD+1f4+n5LTTnS+q3KkfNdB9AJtDussA6L5Sw7MEExqAA
05tiF8dtRr7oi5kR+HJhgcKGy1+EcT/z6+2cWhO/jn9qILzEX1Ci+zrc9fgf+sQR
4FzG7Ua+tih5JlJXXSUirwIHEJ9JjSjLtcTJ60/NSRQY5ZZWNPfrCItg131aaEwO
MUhXzpTxLEQ5QPWFjg48
=CC5P
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
