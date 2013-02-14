From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 Feb 2013 16:18:11 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: Correct TMU clock support again
Message-Id: <20130214161811.GC3882@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1360813381-3416-1-git-send-email-horms+renesas@verge.net.au>
 <87a9r7v8xd.wl%kuninori.morimoto.gx@renesas.com>
 <CANqRtoQtROi1cD3MmykhKLqY+1Y2=f+1Qkmw2bjAaP6yZRPW=Q@mail.gmail.com>
 <20130214041651.GB6036@verge.net.au>
 <20130214091040.GG6088@linux-sh.org>
 <20130214160842.GC26810@verge.net.au>
In-Reply-To: <20130214160842.GC26810@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 15, 2013 at 01:08:42AM +0900, Simon Horman wrote:
> On Thu, Feb 14, 2013 at 06:10:40PM +0900, Paul Mundt wrote:
> > On Thu, Feb 14, 2013 at 01:16:52PM +0900, Simon Horman wrote:
> > > Ok, so in that case the correct value for "sh_tmu.2" might actually
> > > be MSTP016 or MSTP015 depending on the bundle size. I am unsure how to test
> > > sh_tmu.2.

[snip]

> Getting that information correct for sh_tmu.2 on the r8a7779 problem I'm
> not completely sure of the correct answer to. Though I now strongly suspect
> it is MSTP016.

Testing shouldn't be that difficult, just switch your clocksource to it
and make sure all TMU-related MSTP bits are first cleared?
