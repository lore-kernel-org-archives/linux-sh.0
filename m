From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Jan 2016 09:31:13 +0000
Subject: Re: [PATCH 1/2] MAINTAINERS: return arch/sh to maintained state, with new maintainers
Message-Id: <CAMuHMdVWtxq+62Uz1xqzrnmjor2aOKnxsirSerXhiwh=UfTKiQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
	<20160108043959.GA7856@brightrain.aerifal.cx>
	<20160111175307.GC6344@twins.programming.kicks-ass.net>
	<20160113014046.GA22101@verge.net.au>
	<20160115005229.GB238@brightrain.aerifal.cx>
In-Reply-To: <20160115005229.GB238@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Peter Zijlstra <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "D. Jeff Dionne" <jeff@uclinux.org>, Rob Landley <rob@landley.net>

Hi Rich, Sato-san,

On Fri, Jan 15, 2016 at 1:52 AM, Rich Felker <dalias@libc.org> wrote:
> On Wed, Jan 13, 2016 at 10:40:46AM +0900, Simon Horman wrote:
>> On Mon, Jan 11, 2016 at 06:53:07PM +0100, Peter Zijlstra wrote:
>> > On Thu, Jan 07, 2016 at 11:39:59PM -0500, Rich Felker wrote:
>> > > From: Rich Felker <dalias@libc.org>
>> > >
>> > > Add Yoshinori Sato and Rich Felker as maintainers for arch/sh
>> > > (SUPERH).
>> > >
>> > > Signed-off-by: Rich Felker <dalias@libc.org>
>> > > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>> > > Acked-by: D. Jeff Dionne <jeff@uClinux.org>
>> > > Acked-by: Rob Landley <rob@landley.net>
>> >
>> > A much appreciated move,
>> >
>> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> Likewise,
>>
>> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> While patch 2/2 still seems to need discussion and resolution, I don't
> think this part (1/2, adding us as maintainers) is controversial. Can
> it be committed now? Geert? Andrew?

I think it should go in either through Andrew, or through yourself, depending
on whether you already have other stuff ready for this merge window, and have
a git repo to pull from.

Do you have a git repository to ask Linus to pull from, and to provide a branch
for linux-next integration testing?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
