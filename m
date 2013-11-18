From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Nov 2013 11:35:35 +0000
Subject: Re: [PATCH] gpio: Renesas RZ GPIO driver
Message-Id: <201311181235.35403.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20131106234737.8971.37405.sendpatchset@w520> <CANqRtoQA0dXPs8+sNS-8WBPLpzvbSuwj0J3967He0rm=QwNCMQ@mail.gmail.com> <CACRpkdaMj6jnnVCSdezFH7p=S5zUFrKnjN9dSr7_+2k7dbq9ZA@mail.gmail.com>
In-Reply-To: <CACRpkdaMj6jnnVCSdezFH7p=S5zUFrKnjN9dSr7_+2k7dbq9ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Alexandre Courbot <acourbot@nvidia.com>

On Monday 18 November 2013, Linus Walleij wrote:
> On Wed, Nov 13, 2013 at 7:19 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > On Wed, Nov 13, 2013 at 4:59 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> >> On Thu, Nov 7, 2013 at 12:47 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >>
> >> Is it so that arch/sh is more soft on this for example...?
> >> Can some arch maintainer like SH/Paul ACK this approach?
> >>
> >> Read: SH is not moving to device tree...?
> >
> > From what I can tell this GPIO block is not used with SH, so I don't
> > think SH is related, but regarding DT on SH, do you know when it was
> > decided that other architectures also were supposed to move DT?
> 
> I don't think these is any such decision, I'm just asking. I know
> that we only want to see DT on new archs and old hairy board code
> should be ridded using DT ... So I just want to know what the
> situation is like wrt Super-H.

I think Paul as the arch/sh maintainer has made it very clear in the
past that he is not interested in converting the architecture.

IMHO that makes sense because the current code is working well and
there won't be new SoCs that need to get added to it. While there is
a set of drivers that are shared with arm/shmobile, that set is known
and we can handle each driver individually. In some cases we actually
end up having two completely different drivers for the same peripheral
(e.g. some interrupt controllers), something we normally try very
hard to avoid but that seems appropriate here. Let's just not make it
a common theme for other drivers that are not in this situation.

One thing that makes arch/sh and traditionally mach-shmobile different
from everything else is a very sophisticated way for describing
platforms in an abstract way using C data structures. It's not
necessarily bad, but it's inconsistent with other drivers we have
on ARM, and it's to a large degree incompatible to how we use DT
to describe the same hardware.

	Arnd
