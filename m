From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 13 Feb 2015 22:57:04 +0000
Subject: Re: [PATCH v2] ARM: smp: Only expose /sys/.../cpuX/online if hotpluggable
Message-Id: <20150213225704.GF8656@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1423850799-4028-1-git-send-email-sboyd@codeaurora.org>
 <20150213202002.GB29727@verge.net.au>
In-Reply-To: <20150213202002.GB29727@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 13, 2015 at 03:20:04PM -0500, Simon Horman wrote:
> > -static int r8a7779_cpu_disable(unsigned int cpu)
> > -{
> > -	/* only CPU1->3 have power domains, do not allow hotplug of CPU0 */
> > -	return cpu = 0 ? -EPERM : 0;
> > -}
...
> Its not clear to me why r8a7779_cpu_disable() has been
> removed rather than replaced by r8a7779_cpu_can_disable()

This is the default if you don't provide a cpu_disable function, so it
should be removed irrespective of this patch.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
