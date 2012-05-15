From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 May 2012 19:13:16 +0000
Subject: Re: [PATCH] gpio: Emma Mobile GPIO driver
Message-Id: <201205151913.16372.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20120511094103.16423.51840.sendpatchset@w520> <201205121318.54115.arnd@arndb.de> <CANqRtoQa8Ewd74d+t0iXPXkmUDan6OjcD5VPwCFpQKcg8KvXbg@mail.gmail.com>
In-Reply-To: <CANqRtoQa8Ewd74d+t0iXPXkmUDan6OjcD5VPwCFpQKcg8KvXbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, rjw@sisk.pl, linus.walleij@stericsson.com, linux-sh@vger.kernel.org, horms@verge.net.au, grant.likely@secretlab.ca, lethal@linux-sh.org, olof@lixom.net

On Tuesday 15 May 2012, Magnus Damm wrote:
> >> > Isn't there a new nice inline that will both request and
> >> > remap a piece of memory?
> >>
> >> If so then that would be excellent. Especially together with
> >> ioread/iowrite so the code can work both for IOMEM and PORT
> >> transparently.
> >
> > We have a bunch of helpers, but I think none that does
> > everything yet. io_iomap() locates and remaps the resource.
> > devm_request_and_ioremap() does the request and the map, but
> > doesn't pull it out of the device.
> 
> Let me know if you see any reason for not doing that. I'd be happy to
> try to cook something up and convert my drivers one by one.

I think it would be good to have it, so I don't mind if you give it
a go, but I fear that a lot of people cna have conflicting ideas on
what the perfect interface looks like ;-)

	Arnd
