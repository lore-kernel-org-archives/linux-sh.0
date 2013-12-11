From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 11 Dec 2013 11:59:08 +0000
Subject: Re: [PATCH 1/2] I2C: EMMA Mobile I2C master driver
Message-Id: <20131211115908.GA2564@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
List-Id: <linux-sh.vger.kernel.org>
References: <1377688911-10911-1-git-send-email-ian.molton@codethink.co.uk>
 <1378226969-18722-1-git-send-email-ian.molton@codethink.co.uk>
 <1378226969-18722-2-git-send-email-ian.molton@codethink.co.uk>
 <20130905060429.GJ14960@verge.net.au>
 <20130925044503.GA24243@verge.net.au>
 <52A23916.40507@codethink.co.uk>
 <20131211020904.GK19992@verge.net.au>
In-Reply-To: <20131211020904.GK19992@verge.net.au>
To: Simon Horman <horms@verge.net.au>
Cc: Ian Molton <ian.molton@codethink.co.uk>, magnus.damm@gmail.com, grant.likely@linaro.org, rob.herring@calxeda.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, ben.dooks@codethink.co.uk


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2013 at 11:09:04AM +0900, Simon Horman wrote:
> On Fri, Dec 06, 2013 at 08:52:38PM +0000, Ian Molton wrote:
> > On 25/09/13 05:45, Simon Horman wrote:
> >=20
> > >Hi Ian,
> > >
> > >I spoke with Magnus and in turn Ben about this at LinuxCon in New Orle=
ans
> > >last week.
> > >
> > >Basically the position of Magnus and I is that any support for this
> > >hardware is an incremental improvement on the current situation: no
> > >support.
> > >
> > >With this in mind from an shmobile point of view I am happy for this c=
ode.
> > >And there is no need to wait for a review from Magnus.
> >=20
> > Has anyone merged this for upstream yet? If not, where should I send it?
>=20
> I don't believe it has been merged.
>=20
> My suggestion is to re-post it with my Ack with
> Wolfram Sang <wsa@the-dreams.de> CCed.

No need to resend. I have it on my todo-list. Yet, by glimpsing at it I
found some issues which need a proper review for which I didn't have the
time so far. I hope to have it done by this week.


--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSqFOLAAoJEBQN5MwUoCm2g8EQAKLaVHmD70LiNCZc8G72nwOk
bn32/mjbLGT3+XoPgfnyD6BibJKYcqGXx9SAUsvNCUca27b8r668jLrs2XLNx9M+
tqQl9hsrPttszrW9hDwhab3M1dtuURxQ7YDwrBK9gFhR4pGUAlJw4Kq1KgSp9r68
05LAJBHD9ilDS9iLAt6OZMUjX6PBNjgNySpiKtyDLMSnxjhAN2mOfZbwUogfwgxI
NsqKy19d4qDOIkve+M9q+rU5Zi2NNkqkx0e9kDR0rYDoAITHb61z7NNHmvuViqyH
u4p7JVrX6DsfohQqeOfOe9bMi3eZBzCZN7drh0PIk32rLOxnzylTByDFSvcRhpc9
JejNuE+Q9zE3c+pp0uUaJ8eEQ2LW+TlgjMfAac1Il3yqR8UAYVSe1/XODntxSxn0
BxMAsQzJJ2peHH99QyoPmeJGnxgYu4wsEsmcy3oPf7uCIot+LVGXqLOtAa4FLR5F
K8creWTo1BTM4Y67+rOj3P9069aFbAer77FtWl04osZJZJBCWc76YnX+TzdLTALu
bx8lattyXSLTCjkJCGJAO+2aH/FbamfoM5DKyrpYjRMdcG1A6ffT4m3hdGV4fJXG
vwSh4vpToxurjruuYHDRC7v5RhA0FelQ1mrUAexxwlNhDsRJEbiW0PdQ6NtT5NMb
V76QLBoncd6r7nOvXSAF
=iQyL
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
