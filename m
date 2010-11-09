From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 09 Nov 2010 15:09:50 +0000
Subject: Re: [ANNOUNCE] Changes in the SH and Genesis/R-Mobile git trees
Message-Id: <20101110020950.07c84cb4.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Wed__10_Nov_2010_02_09_50_+1100_sT8t_k4afjH7hvhz"
List-Id: <linux-sh.vger.kernel.org>
References: <20101109083518.GA21086@linux-sh.org>
In-Reply-To: <20101109083518.GA21086@linux-sh.org>
To: linux-sh@vger.kernel.org

--Signature=_Wed__10_Nov_2010_02_09_50_+1100_sT8t_k4afjH7hvhz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, 9 Nov 2010 17:35:18 +0900 Paul Mundt <lethal@linux-sh.org> wrote:
>
> rmobile-fixes-for-linus / sh-fixes-for-linus
> 	- These are my pull branches for upstream. They will always
> 	  contain that which is bound for the next -rc, regardless of
> 	  whether we are in a merge window or late in an -rc series. They
> 	  will only be advanced as new things come in that need to be
> 	  merged in to the next -rc, and may very well stay put for
> 	  awhile if I've just completed a merge and all of the new
> 	  patches are aimed at the next kernel.

Should I include these branches among my other "current" trees?  These
trees contain fixes for Linus' current -rc series and are merged very
early in linux-next.  They are in linux-next so that bugs already fixed
are not reported again against linux-next before Linus has merged the
fixes.

> rmobile-latest / sh-latest
> 	- These contain the newest changes and are each an integration of
> 	  their respective namespaces. These are what get pulled (or what
> 	  I would like to have pulled) in to -next, and so will only be
> 	  advanced with next merge window patches once we're in an -rc2
> 	  phase, as per standard -next guidelines. These are basically
> 	  identical to the old master branch behaviour for the previous
> 	  genesis and sh trees.

I will replace the sh and genesis trees in linux-next with the above two
branches starting with next-20101110 (and rename genesis to rmobile).

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
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

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Wed__10_Nov_2010_02_09_50_+1100_sT8t_k4afjH7hvhz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJM2WQ+AAoJEDMEi1NhKgbsESQIAJwtIuxckYfm6TmV80QaPfdo
2Lp4v7WfeCoMfZ+XEZVPKo0mLyTGA23YMgeqI6HnPTbEHxEo/t8LZl6UgdBm2cbx
aw624K67vhDOHrI55lSba0TYagb+De994juQ2dlKzD+F1XmT2g9y1JbkImE3KNiy
GalKzFRPCWo6ElvwfrQw0yTwqp0FTFEyriMPk7LcNSURwhk7q1lkUUXSkvj9et7C
uMH83zfvDcimTWPK0jTjWVWGaZgi+Qcw96ECMQBMiVYBt3R2UcPT9br3EHE6Hkpm
6JJBjeMtL8gWj9RlZ0ttFxsXsJW3FgXC4hS9cZtHjdKXrRBw9GLcUPLR6VS5Pps=
=3Qr7
-----END PGP SIGNATURE-----

--Signature=_Wed__10_Nov_2010_02_09_50_+1100_sT8t_k4afjH7hvhz--
