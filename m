From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 29 Jul 2008 06:40:49 +0000
Subject: Re: kill include symlinks for sh?
Message-Id: <20080729064049.GA28656@uranus.ravnborg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080728115735.GA32089@uranus.ravnborg.org> <20080728231922.GB28055@linux-sh.org>
In-Reply-To: <20080728231922.GB28055@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild <linux-kbuild@vger.kernel.org>

Hi Paul

> This didn't end up being _too_ painful, though it did take a bit of time
> to hunt down all of the guilty parties. I've pushed out what I have now,
> which you can see at:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/lethal/sh-2.6.git;a=3Dcommitd=
iff;h=F15cbe6f1a4b4d9df59142fc8e4abb973302cf44
>=20
> It's been holding up to all of the random builds I've thrown at it so
> far, so there shouldn't be any really nasty surprises left over.

I took a quick look at it and the header re-org looks good.
I like that you added the 'mach-' prefix to the directory names.

But I also noticed several changes like this:
-#include <asm/landisk/iodata_landisk.h>
+#include <mach/iodata_landisk.h>

In this case you _know_ that this is a landisk so
the less magic option would have been the longer
include form like this:
+#include <mach-landisk/mach/iodata_landisk.h>

It would be preferable that we use the gcc -I
directive:

    -Iarch/sh/include/mach-$MACH

only to automagically select between identical named
files for the different platforms and not like
the above where we use it simply to cut off the include
path a little.

Another note is that you decided to move the generated
file over to arch/sh/include too.
I really do not know if I think this is the right approach.
What I like is that we some day end up with generated files
in a common place. But I have not really thought it through
and thus I have no final idea how to do it.
So in other words - keep it as is and lets re-visit it should
we one day decide to do this in a common way across architectures.

Thanks for looking into this so quickly!

	Sam
