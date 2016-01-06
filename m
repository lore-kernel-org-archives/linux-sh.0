From: Rob Landley <rob@landley.net>
Date: Wed, 06 Jan 2016 20:21:19 +0000
Subject: Re: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
Message-Id: <568D773F.6000408@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-32-git-send-email-mst@redhat.com>
 <20160105232735.GC238@brightrain.aerifal.cx>
 <20160106131321-mutt-send-email-mst@redhat.com>
 <20160106114023.GU6344@twins.programming.kicks-ass.net>
 <20160106134301-mutt-send-email-mst@redhat.com>
 <20160106143218.GV6344@twins.programming.kicks-ass.net>
 <568D35EB.7090108@landley.net>
 <20160106165740.GX6344@twins.programming.kicks-ass.net>
In-Reply-To: <20160106165740.GX6344@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Jeff Dionne <jeff@uclinux.org>, Yoshinori Sato <ysato@users.sourceforge.jp>



On 01/06/2016 10:57 AM, Peter Zijlstra wrote:
> On Wed, Jan 06, 2016 at 09:42:35AM -0600, Rob Landley wrote:
>> (I would have thought the presence of working QEMU support would tide us
>> over providing an easy basic regression testing environment, but people
>> keep insisting that's not real and doesn't count. But if we can keep it
>> 99% working until the sh4 patents expire later this year, we can add mmu
>> and have full sh4 in hardware again with BSD VHDL.)
> 
> I didn't know there was a 'working' qemu for SH.

Yes, for several years now?

  https://lists.gnu.org/archive/html/qemu-devel/2010-03/msg00976.html

I try to build bootable images with each new kernel, although I'm a few
versions behind at the moment (this is 4.1 I think?):

  wget http://landley.net/aboriginal/bin/system-image-sh4.tar.gz
  tar xvzf system-image-sh4.tar.gz
  cd system-image-sh4
  ./run-emulator.sh

There's an sh2eb one in there too, but you need a $50 FPGA board to run
it (Numato Mimas v2, setup walkthrough is at http://nommu.org/jcore).

I keep meaning to poke at qemu and get their r2d board emulation to give
me more than 64 megs of memory so I can do native compiles. (I have a
native toolchain but building much more than "hello world" requires
setting up a swap file because the board emulation only gives me one
virtual disk. None of the other architectures need that...)

I'd _also_ like to get proper sh2 support into qemu (sh2 code runs under
sh4 but still), but the sh4 patents expire later this year and sometime
after that we want to add an MMU to the VHDL, so...

(We still want the nommu version because hard realtime is actually
easier to verify without page faults, and the big product needs
nanosecond accurate timestamps on stuff...)

> My personal 'complaint' with SH is its lack of maintainer feedback. I do
> full arch sweeps on semi-regular basis, and while I know in very board
> terms how a fair number of archs work its impossible to know everything
> about all 25+ we support.

We (the j-core guys) have wanted to take over arch/sh maintainership for
a while, we've just been trying to get the board we're working on in
position to be upstreamed first. The feedback on my craptacular first
effort to chip off a chunk that other people could at least reproduce
against a then-current kernel was "ew" and "redo it all as device tree".
So we went away again to work on that...

Meanwhile all $DAYJOB's in-house resources (at se-instruments.com) have
been tied up making SMP work for a product. (Yes, sh2 SMP. A NOMMU smp
system. There were some teething troubles, but it's working now. Alas,
not on the above $50 FPGA because that's only got an LX9 FPGA which one
SOC instance uses like 2/3 of the gates in. We're doing the SMP stuff in
LX45 boards, which are crazy expensive.)

I note I just sent a Numato board to the buildroot maintainer so I can
walk him through adding jcore support to buildroot. And I got toybox
working nommu, and Rich added sh2 support to musl-libc... There has been
activity on this arch, just not on this list due to the noise from a
bunch of different Renesas arm systems and whatever "arm/shmobile" is.
("Not superh or jcore compatible", that's all I know...)

Rob
