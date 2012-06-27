From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 27 Jun 2012 00:52:01 +0000
Subject: Re: [PATCH 00/13 v2] sh: add regulators for mmc and smsc911x
Message-Id: <20120627005201.GH24033@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1340751009-18663-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340751009-18663-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 27, 2012 at 12:49:56AM +0200, Guennadi Liakhovetski wrote:
> This is a respin of
> 
> http://thread.gmane.org/gmane.linux.ports.sh.devel/15568
> 
> ported on top of the fixed regulator driver update patches from the
> 
> http://lkml.indiana.edu/hypermail/linux/kernel/1206.2/index.html#01395
> 
> patch-set, which thereby becomes a prerequisite for this series! Basing on 
> top of those patches made the temporary macro redundant, which simplifies 
> the whole work quite a bit. Other changes since v2 are listed in respective 
> patches.
> 
> DEPENDENCY: the above fixed regulator patches can be obtained from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/topic/fixed
> 
Ok, this all looks fine. I'll pull this branch in to a topic branch of my
own (probably sh/regulator due to a lack of originality on my part) and
then layer your patch set on top of it. You can send an incremental patch
for the gpio_request() thing if you like and then that can just be rolled
on top.
