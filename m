From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sun, 02 Jun 2019 07:43:14 +0000
Subject: Re: [linux-stable-rc:linux-5.0.y 1434/2350] arch/sh/kernel/cpu/sh2/clock-sh7619.o:undefined referenc
Message-Id: <20190602174314.09f5f337@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/ZHlU6.H.HMslp_9vg8BHKKd"
List-Id: <linux-sh.vger.kernel.org>
References: <201905301509.9Hu4aGF1%lkp@intel.com>
	<92c0e331-9910-82e9-86de-67f593ef4e5d@infradead.org>
	<20190531100004.0b1f4983@canb.auug.org.au>
	<871s0cqx33.wl-ysato@users.sourceforge.jp>
In-Reply-To: <871s0cqx33.wl-ysato@users.sourceforge.jp>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Randy Dunlap <rdunlap@infradead.org>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, "Sasha Levin (Microsoft)" <sashal@kernel.org>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

--Sig_/ZHlU6.H.HMslp_9vg8BHKKd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yoshinori,

On Sun, 02 Jun 2019 16:13:04 +0900 Yoshinori Sato <ysato@users.sourceforge.=
jp> wrote:
>
> Since I created a temporary sh-next, please get it here.
> git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git tags/sh-next

I have added that tree to linux-next from tomorrow.  However, thet is
no sh-next tag in that tree, so I used the sh-next branch.  I don't
think you need the back merge of Linus' tree.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/ZHlU6.H.HMslp_9vg8BHKKd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzzfhIACgkQAVBC80lX
0GwU4wf/aBm9zCZTK4IW6qEhed2uiOXRANwzjz1TKPGrQh1lNJCKSeS1fgWIstla
+4dmvKdPx9K8dvTKI0nkp7KGgdrIVTRgkTejZDRnDDd4M0DIV1EidGnsN1desUEO
/bWJM/DfRaxPEBxhc3LHlpwG2we25+1mGreUAioMQ2DHC+gkWUVoLSxWWUcTW/9R
vWPuBZBjdZ00a0hIxM5/z7fz6kO8LcVf1dq43mDibeC1GLxM9GlxdHxH26VV0gjG
L2nT+xMitj3pihFHMJY54iR5+E8TXBQcMbft/Q/OFY+69yks81eavH+kyCAlmkzO
U8ahAGUUe5wbQjeDwzJk5rLjuJTCGQ==
=0sdq
-----END PGP SIGNATURE-----

--Sig_/ZHlU6.H.HMslp_9vg8BHKKd--
