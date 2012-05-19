From: Olof Johansson <olof@lixom.net>
Date: Sat, 19 May 2012 01:18:39 +0000
Subject: Re: [PATCH] gpio: Emma Mobile GPIO driver V2
Message-Id: <CAOesGMh1VQ5BAybLEzVLqL2cOQe2CJ8CgbK+5-R4sH4iG0Kvog@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120515154333.6659.66479.sendpatchset@w520>
	<201205162205.09082.rjw@sisk.pl>
	<CAOesGMjgBWxjAvMpcxWsJf7n3q90sGhccUSgfGxJQA+tfDZBHw@mail.gmail.com>
	<201205170037.34305.rjw@sisk.pl>
	<CAOesGMi8LPO=AFSshC8UyCmBB3hG38YKHWnHmcNCnLvgR2xcTw@mail.gmail.com>
	<20120518225625.28C643E07C8@localhost>
In-Reply-To: <20120518225625.28C643E07C8@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linus.walleij@stericsson.com, arnd@arndb.de, linux-sh@vger.kernel.org, horms@verge.net.au, lethal@linux-sh.org

On Fri, May 18, 2012 at 3:56 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Wed, 16 May 2012 15:54:16 -0700, Olof Johansson <olof@lixom.net> wrote:
>> On Wed, May 16, 2012 at 3:37 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Thursday, May 17, 2012, Olof Johansson wrote:
>> >> On Wed, May 16, 2012 at 1:05 PM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
>> >> > On Wednesday, May 16, 2012, Linus Walleij wrote:
>> >> >> On Wed, May 16, 2012 at 12:15 PM, Magnus Damm <magnus.damm@gmail.c=
om> wrote:
>> >> >>
>> >> >> > Do you guys have any preferences how to merge this?
>> >> >> >
>> >> >> > Can I include it together with the EMEV2 SoC bits perhaps? That =
may be
>> >> >> > easy so we can keep track of the platform data header file depen=
dency.
>> >> >>
>> >> >> For ux500 I made a special "gpio and pins" branch and sent through=
 ARM SoC.
>> >> >
>> >> > The problem is we have a patch depending on the $subject one in the=
 EMEV2
>> >> > series and it would be better to keep them both together if that's =
not
>> >> > a big deal.
>> >>
>> >> Dependencies are fine, as long as they are not circular. You can
>> >> either pull in the gpio/pins branch into the EMEV2 branch, or base it
>> >> on it.
>> >
>> > I guess I'll try to merge the gpio/pins into the EMEV2 branch.
>>
>> By the way, I should have mentioned that if the dependencies are only
>> for building and not for context when applying patches, then it's
>> sufficient to let us know in the pull request so we merge the branches
>> in the right order when sending to Linus (so we maintain
>> bisectability).
>
> Really? =A0I don't think that works. The actually commit point will
> always be unbuildable regardless of the merge order in mainline. =A0If
> there is a dependency then the dependency must be merged into the
> working branch before applying the commit.

Not if the prerequisite commit sits in a branch that is merged before
the dependent commit.

A git bisect should never end up in a situation where the second
commit is included but the first is not. Either that, or I have
completely misunderstood how it works.

Of course, this assumes that the dependency is one-way, and not mutual.

-Olof
