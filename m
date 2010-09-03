From: Andreas Gruenbacher <agruen@suse.de>
Date: Fri, 03 Sep 2010 22:58:17 +0000
Subject: Re: [bug-patch] [BUG?] rename patch accepted with --dry-run, rejected without (Re: [PATCH V3] arm &
Message-Id: <201009040058.18028.agruen@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <20100903182323.GA17152@pengutronix.de> <20100903184351.GC2341@burratino>
In-Reply-To: <20100903184351.GC2341@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: bug-patch@gnu.org, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, git@vger.kernel.org

Hi,

On Friday 03 September 2010 20:43:51 Jonathan Nieder wrote:
> Uwe Kleine-K=C3=B6nig wrote:
> > On Fri, Sep 03, 2010 at 07:18:43PM +0900, Magnus Damm wrote:
>=20
> >> Using --dry-run is fine, but omitting dry-run gives me:
> >>=20
> >> ...
> >> patching file arch/arm/common/clkdev.c
> >> patching file arch/sh/include/asm/clkdev.h
> >> Hunk #1 FAILED at 1.
> >> Hunk #2 FAILED at 11.
> >> 2 out of 2 hunks FAILED -- saving rejects to file
> >> arch/sh/include/asm/clkdev.h.rej
> >>=20
> >> I guess this is caused by the last "renaming" hunk, see below.
>=20
> Yep, I can reproduce this.  Patch applies with "git apply",
> "patch --dry-run -p1" accepts it, "patch -p1" fails.
>=20
>  $ patch --version | head -1
>  GNU patch 2.6.1.85-423d
>  $ cd ~/src/linux-2.6
>  $ git checkout 2bfc96a12
>  $ git clean -fd
>  $ wget http://download.gmane.org/gmane.linux.ports.sh.devel/8747/8748
> [...]

something pretty bizarre is going on here.  The wget output modifies the sa=
me=20
file twice, but both patches to this file have the same source sha1 (5645f3=
5):

> diff --git a/arch/sh/include/asm/clkdev.h b/arch/sh/include/asm/clkdev.h
> dissimilarity index 69%
> index 5645f35..6ba9186 100644
> --- a/arch/sh/include/asm/clkdev.h
> +++ b/arch/sh/include/asm/clkdev.h

> diff --git a/arch/sh/include/asm/clkdev.h b/include/linux/clkdev.h
> similarity index 85%
> rename from arch/sh/include/asm/clkdev.h
> rename to include/linux/clkdev.h
> index 5645f35..457bcb0 100644

So "git apply" and "patch --dry-run" seem to work only by accident.

How was this patch generated: with git itself?

The fact that "patch --dry-run" may not work for patches that modify the sa=
me=20
file twice is a known defect.  I don't know how to solve this in a reasonab=
ly=20
elegant way.  Luckily the problem only triggers when people are doing=20
something "strange" such as concatenating patches.

Andreas
