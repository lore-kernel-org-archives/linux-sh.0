From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 15 Aug 2011 17:45:41 +0000
Subject: Re: [PATCH] shmobile/sh7372: Add missing CONFIG_PM guards to fix build failure
Message-Id: <201108151945.42155.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1313274841-8322-1-git-send-email-peterhuewe@gmx.de>
	<201108140155.05625.rjw@sisk.pl>
	<201108151630.12120.PeterHuewe@gmx.de>
In-Reply-To: <201108151630.12120.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Monday, August 15, 2011, Peter H=FCwe wrote:
> Am Sonntag 14 August 2011, 01:55:05 schrieb Rafael J. Wysocki:
> > On Sunday, August 14, 2011, Peter Huewe wrote:
> > > This patch fixes a build failure with the ap4evb_defconfig by adding =
the
> > > missing #ifdef CONFIG_PM.
> >=20
> > This is not the right fix.  Besides, you seem to be testing linux-next
> > and the build problem is in the linux-pm tree.
> >=20
> > Please check if the appended patch fixes the problem for you.
> >=20
> > Rafael
> Works for me - compiles ;)
>=20
> Reviewed-by: Peter Huewe <peterhuewe@gmx.de>

Good, thanks for testing!

I have folded the fix into the patch that caused the problem, so this
should be fixed in linux-next now.

Thanks,
Rafael
