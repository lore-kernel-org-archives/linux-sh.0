From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 03 Jul 2015 15:23:20 +0000
Subject: Re: Possible regression due to "tick: broadcast: Prevent livelock from event handler"
Message-Id: <alpine.DEB.2.11.1507031721390.3916@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana> <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana> <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana> <alpine.DEB.2.11.1507031640060.3916@nanos>
 <20150703150951.GC19284@katana>
In-Reply-To: <20150703150951.GC19284@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 3 Jul 2015, Wolfram Sang wrote:
> > Ok. So it's unrelated to deep idle states. Any chance of poking with
> > JTAG at the frozen box? If not, are there GPIOs which you could use to
> > monitor certain state?
> 
> No JTAGger here at the moment. And no manual/schematics for this board
> :(

Ok. One more check please. Does nohz=off on the command line fix/hide
the issue as well?

Thanks,

	tglx
