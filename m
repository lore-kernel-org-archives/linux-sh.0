From: Randy Dunlap <rdunlap@xenotime.net>
Date: Wed, 24 Oct 2012 20:35:23 +0000
Subject: Re: [Q] CONFIG_INOTIFY_USER doesn't get enabled upon defconfig
Message-Id: <5088510B.7010400@xenotime.net>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1210241057590.31768@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1210241057590.31768@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Love <rlove@rlove.org>, linux-kbuild@vger.kernel.org

On 10/24/2012 03:02 AM, Guennadi Liakhovetski wrote:

> Hi all
> 
> CONFIG_INOTIFY_USER is marked default "y" in fs/notify/inotify/Kconfig, 
> so, I would expect it to be enabled by any make *_defconfig. However, for 
> some reason, this doesn't happen (e.g. with mackerel_defconfig), which 
> leads to non-functional udev, among others. Any idea why this could be 
> happening?

I think it's because arch/arm/configs/mackerel_defconfig says:

# CONFIG_INOTIFY_USER is not set

-- 
~Randy
