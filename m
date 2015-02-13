From: Simon Horman <horms@verge.net.au>
Date: Fri, 13 Feb 2015 23:24:37 +0000
Subject: Re: [PATCH v2] ARM: smp: Only expose /sys/.../cpuX/online if hotpluggable
Message-Id: <20150213232435.GA21924@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1423850799-4028-1-git-send-email-sboyd@codeaurora.org>
 <20150213202002.GB29727@verge.net.au>
 <20150213225704.GF8656@n2100.arm.linux.org.uk>
In-Reply-To: <20150213225704.GF8656@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 13, 2015 at 10:57:04PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 13, 2015 at 03:20:04PM -0500, Simon Horman wrote:
> > > -static int r8a7779_cpu_disable(unsigned int cpu)
> > > -{
> > > -	/* only CPU1->3 have power domains, do not allow hotplug of CPU0 */
> > > -	return cpu = 0 ? -EPERM : 0;
> > > -}
> ...
> > Its not clear to me why r8a7779_cpu_disable() has been
> > removed rather than replaced by r8a7779_cpu_can_disable()
> 
> This is the default if you don't provide a cpu_disable function, so it
> should be removed irrespective of this patch.

Thanks and agreed.

I'd be quite happy to take such a patch through my tree.
