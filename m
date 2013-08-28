From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 28 Aug 2013 07:53:13 +0000
Subject: Re: [PATCH 10/14] ARM: shmobile: Rename to emev2_init_early(), use smp_set_ops()
Message-Id: <1559583.u8rKlUOvi3@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20130809094748.6530.16511.sendpatchset@w520>
 <10195347.M6JWNyZrex@avalon>
 <CANqRtoQSEdam-_VYuo2ECHk4f9JzJ69xdc==U+JZF-7AOcQJQA@mail.gmail.com>
In-Reply-To: <CANqRtoQSEdam-_VYuo2ECHk4f9JzJ69xdc==U+JZF-7AOcQJQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Magnus,

On Wednesday 28 August 2013 16:03:23 Magnus Damm wrote:
> On Fri, Aug 9, 2013 at 7:41 PM, Laurent Pinchart wrote:
> > On Friday 09 August 2013 18:49:36 Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >> 
> >> Rename emev2_init_delay() into emev2_init_early()
> >> to make the function name show that more than just
> >> delay setup will happen.
> >> 
> >> Also, instead of specifying the smp ops in DT_MACHINE
> >> convert the EMEV2 SoC code to install the smp ops
> >> from emev2_init_early().
> > 
> > Could you please explain in the commit message why this is needed ? Same
> > comment for the other patches in this series.
> 
> I personally think it is neat to use as few callbacks as possible in
> the DT_MACHINE. Hooking in SMP ops in ->init_early() means that the
> boards now are unaware if SMP is used or not - and it makes sense to
> me to write board code that is independent of SMP.

That's a good enough explanation, I'd just like it to be included in the 
commit message.

> Anyway, I suspect that Olof prefers to use smp_ops() instead, so I think
> these patches just should be dropped.

I suppose that's for you to sort out with him :-)

-- 
Regards,

Laurent Pinchart

