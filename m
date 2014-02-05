From: Simon Horman <horms@verge.net.au>
Date: Wed, 05 Feb 2014 01:19:19 +0000
Subject: Re: [PATCH 0/4] Rebased pending Koelsch patches on v3.14-rc1
Message-Id: <20140205011919.GA13630@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1391539703-5787-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1391539703-5787-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 04, 2014 at 10:48:19PM +0400, Valentine Barshak wrote:
> This is a rebase of I2C and VIN1 support for Koelsch
> as requested by Simon here:
> http://marc.info/?l=linux-sh&m8898894707395&w=2
> http://marc.info/?l=linux-sh&m8899483408459&w=2
> 
> Also I2C and VIN SoC camera support have been added
> to koelsch_defconfig.
> 
> I've decided to combine them in a single series
> since VIN depends on I2C support.

There is no need to re-post these patches to address this,
but for future reference.

In this series I see v1, v3 and v4 patches.

While I can make sense of this it makes it cumbersome to refer to the
series as a whole.

Jane, can you take a look at '"[PATCH 0/4] Rebased pending Koelsch patches
on v3.14-rc1", posted on Tuesday the 4th, which includes v1, v3,
v4 patches'?

What would make my life easier would be if the entire series was v4 and
all the patches contained in it were v4. Then I could just ask Jane to look
at "[PATCH v4 0/4] Rebased pending Koelsch patches on v3.14-rc1".

There is no Jane but I do ask people these kind of questions :)
