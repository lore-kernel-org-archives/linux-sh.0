From: Simon Horman <horms@verge.net.au>
Date: Wed, 29 Jan 2014 06:12:01 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: Enable modules for Lager and Koelsch
Message-Id: <20140129061201.GA24451@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1390566231-18928-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390566231-18928-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Jan 25, 2014 at 02:35:36AM +0400, Valentine wrote:
> On 01/24/2014 04:23 PM, Valentine Barshak wrote:
> >This enables modules and module versioning support
> >in lager_defconfig and koelsch_defconfig
> 
> Module unloading should also be enabled.
> I'll add it and re-spin in a bit.

Hi Valentine,

I think it would be better to wait until we need modules before
turning them on.
