From: =?ISO-8859-1?Q?Ra=FAl_Porcel?= <armin76@gentoo.org>
Date: Fri, 18 Jun 2010 12:54:55 +0000
Subject: Re: [sh7785lcr proto] fails to boot since commit 6430a5987f8bb9a7c5187b343956aa8ef404d571
Message-Id: <4C1B6C9F.2040800@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4C14ACDD.6050004@gentoo.org>
In-Reply-To: <4C14ACDD.6050004@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 06/13/2010 12:03 PM, Ra=FAl Porcel wrote:
> Hello list,
>=20
> I tried some weeks to upgrade the sh7785lcr prototype board using 32bits
> to the latest released kernel(2.6.34.something). I've also tried with
> latest git.
>=20
<snip>

By Matt Fleming's request i've tested latest git again, and turns out
that if i run the 'pmb' command on the 32bit uboot, the kernel boots.

So i believe this is 'fixed'.

