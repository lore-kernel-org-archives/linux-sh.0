From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 03 Jul 2015 11:13:58 +0000
Subject: Re: Possible regression due to "tick: broadcast: Prevent livelock from event handler"
Message-Id: <20150703111358.GW7557@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <20150703110249.GV7557@n2100.arm.linux.org.uk>
 <20150703110730.GG1521@katana>
In-Reply-To: <20150703110730.GG1521@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jul 03, 2015 at 01:07:31PM +0200, Wolfram Sang wrote:
> > Please share your .config file for this case.  Thanks.
> 
> Here it goes...

Please try:

sed -i s/IRQSOFF_TRACER/TRACE_IRQFLAGS/ arch/arm/kernel/entry-armv.S

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
