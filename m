From: Olof Johansson <olof@lixom.net>
Date: Sat, 19 May 2012 02:27:40 +0000
Subject: Re: [PATCH] gpio: Emma Mobile GPIO driver V2
Message-Id: <CAOesGMizxoEmq948Thax=aY3JmJaMWp5HLmzJtTAJS6pOSbFdQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120515154333.6659.66479.sendpatchset@w520>
	<201205162205.09082.rjw@sisk.pl>
	<CAOesGMjgBWxjAvMpcxWsJf7n3q90sGhccUSgfGxJQA+tfDZBHw@mail.gmail.com>
	<201205170037.34305.rjw@sisk.pl>
	<CAOesGMi8LPO=AFSshC8UyCmBB3hG38YKHWnHmcNCnLvgR2xcTw@mail.gmail.com>
	<20120518225625.28C643E07C8@localhost>
	<CAOesGMh1VQ5BAybLEzVLqL2cOQe2CJ8CgbK+5-R4sH4iG0Kvog@mail.gmail.com>
	<CACxGe6uNgE6Xdx965fSi8ezVts7FFiW6kuBbyEGJXkRD4eoP6Q@mail.gmail.com>
In-Reply-To: <CACxGe6uNgE6Xdx965fSi8ezVts7FFiW6kuBbyEGJXkRD4eoP6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linus.walleij@stericsson.com, arnd@arndb.de, linux-sh@vger.kernel.org, horms@verge.net.au, lethal@linux-sh.org

On Fri, May 18, 2012 at 6:44 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:

> See? =A0Y1 shows up without the X1 parent. =A0With git, there is never a
> straight line history, so every commit must be fully built on top of
> all the commits it needs. =A0(And did I understand what you were trying
> to describe correctly?)

You understood my intentions, but I had a misconception of how bisect
actually works.

"Fighting regressions with git bisect" visualizes pretty well why
you're right and I'm wrong as well. :)


-Olof
