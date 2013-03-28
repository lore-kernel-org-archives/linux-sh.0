From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Mar 2013 01:11:18 +0000
Subject: Re: [PATCH/RFC 3/3] ARM: shmobile: sh73a0: add a TWD clock
Message-Id: <20130328011118.GN20736@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1303071957230.16065@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1303071957230.16065@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 07, 2013 at 08:00:48PM +0100, Guennadi Liakhovetski wrote:
> Add a TWD clock on sh73a0 for the smp_twd driver to properly update the
> clock's frequency upon cpufreq events.

Thanks, queued up for 3.10 in the soc branch.
