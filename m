From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jul 2008 23:19:22 +0000
Subject: Re: kill include symlinks for sh?
Message-Id: <20080728231922.GB28055@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080728115735.GA32089@uranus.ravnborg.org>
In-Reply-To: <20080728115735.GA32089@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild <linux-kbuild@vger.kernel.org>

Hi Sam,

On Mon, Jul 28, 2008 at 01:57:35PM +0200, Sam Ravnborg wrote:
> Now that kbuild has proper support for
> include/$ARCH/* maybe this is a good time
> to kill the use of symlinks for sh?
>=20
Good idea, I just saw the sparc change go by earlier today and remembered
we had talked about this before.

> I do not have sh toolchina on this box so I have
> not tried to do a full patch myself. And the mach stuff
> obviously worries me with the link to the parent directory.
>=20
This didn't end up being _too_ painful, though it did take a bit of time
to hunt down all of the guilty parties. I've pushed out what I have now,
which you can see at:

http://git.kernel.org/?p=3Dlinux/kernel/git/lethal/sh-2.6.git;a=3Dcommitdif=
f;h=F15cbe6f1a4b4d9df59142fc8e4abb973302cf44

It's been holding up to all of the random builds I've thrown at it so
far, so there shouldn't be any really nasty surprises left over.

I'm glad git supports renames.. :-)
