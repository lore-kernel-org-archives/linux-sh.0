From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 05 Mar 2014 13:54:32 +0000
Subject: Re: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
Message-Id: <20140305135431.GA7985@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
List-Id: <linux-sh.vger.kernel.org>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <1722697.3h0GnbWuD3@avalon> <20140303162731.GA3732@katana>
 <2207635.bd10VfTU6U@avalon>
In-Reply-To: <2207635.bd10VfTU6U@avalon>
To: linux-arm-kernel@lists.infradead.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > While the parent is indeed selected at boot time only, and only one p=
arent
> > > is thus needed, parent selection could be performed by a DIP switch
> > > connected to MD_CLK on the board for instance. In that case both pare=
nts
> > > should be available in DT, as selection will be done by the kernel at
> > > boot time, not at DT compile time.
> >=20
> > OK, I understand the case. I still wonder about specifying two parents,
> > though. If a board uses USB_X1, it then has to spefify a dummy EXTAL
> > clock (or an empty one), just because USB_X1 is enumerated as second
> > entry?
>=20
> That's a good question. Mike, would it be possible to support "holes" in =
the=20
> DT clocks lists, like the GPIO DT bindings do ?

I talked to Magnus and we decided to start with hardcoded EXTAL for now,
and leave USB_X1 support for in incremental patch when this is actually
needed. Note that the devkit will most likely be the only board ever
with a selectable root clock.


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTFyyXAAoJEBQN5MwUoCm2cKEQAJmz6ksa7/pHqcyxxhphb7Ir
Ab1Jwadm7KkTEQQxJRbINDaqcQjMkh/ZMZIL8O5wbtbeLpPZdEhQjifw5y40G91B
3rjnAmzLglZ/f6Qid0b7AawPNYVhoTo64EbNPryrfBCu2MQUXbqWSsjUkIO1CYaS
UVAf9fZaFhQN2amsoPRfstQxm6gH8tak876Pdk6AjvfI2NcbCT9f+3e/FduC1Xnm
mPa0sUK6w4yPyQhsAnYP7wjIT7IwEQtAX8KvREDGohgYrkZwZ74OjC0YeGZmMFY5
LL9YKb1g3XHrS50HloeH94PRzUFdNoTgrCYIMi827vkRhzxNYHVKQ+VEdk78KSyw
BfBowC/0Pg6jRnyXIjcdkspclVHs4TYQHduD2FpSYJzHFffwiDOESPZrk1j4fQPf
L4yuUUQJz3K5Ulamb8DhIgiEdRtJzom9PXPVFXIeBto2UPXUo+b17WvPB+aOS5aq
VSB3zaj7E4xFG+oHfibIgCI4dDRAprGOUduCG5KgC21ivVWL2zQvFHgAPYmxInR7
BIrOeDy5zoGQg2u9Yg92lYrXjEoAmY0u93GZnNntJAOVAIpnRY4LhU36W5BAHM27
U/Ljc0A0IoqKku9ohH1fMBYFcuvMfnqhuFn5P06ufepddNz2efEmI9+1ClAkXTfu
/shThgsi/9L2k4GvO4I3
=VtUM
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
