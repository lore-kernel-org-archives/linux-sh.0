From: Olof Johansson <olof@lixom.net>
Date: Wed, 14 Mar 2012 00:02:12 +0000
Subject: Re: [GIT PULL] Renesas SoC updates for v3.4, take 2
Message-Id: <CAOesGMi9uQyS=ATE+wXZY8hP-1+-uZhW2B-Y3zV9fOEBCYUFVw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201203092155.04731.rjw@sisk.pl>
	<201203131939.36186.arnd@arndb.de>
	<201203132117.50390.rjw@sisk.pl>
	<201203132242.07283.rjw@sisk.pl>
In-Reply-To: <201203132242.07283.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Paul Mundt <lethal@linux-sh.org>

On Tue, Mar 13, 2012 at 2:42 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, March 13, 2012, Rafael J. Wysocki wrote:
>> On Tuesday, March 13, 2012, Arnd Bergmann wrote:
>> > On Tuesday 13 March 2012, Rafael J. Wysocki wrote:
>> > > > Note that the __io() issue has turned out to be more urgent than I first
>> > > > thought when we discussed it, so it would be good to apply the patch below
>> > > > on top of your series.
>> > >
>> > > Do you want me to apply it now or will you do that in your tree?
>> >
>> > Doesn't matter to me, as long as one of you applies it ;-)
>>
>> OK, so I will add it to the soc branch in the Renesas tree.
>
> Applied and pushed back the updated tree.

Seems like you applied the patch but without the subject line, so now
git thinks the whole first paragraph is the patch subject. That's a
bit messy and I'd prefer if you could fix it up.

Do you have downstream users of your tree that you'll mess up if you
rebase the last commit though? Alternatively I can take everything on
the branch but the last patch and apply it myself, but that will still
cause trouble for your downstream developers once things go upstream
and come down.


-Olof
