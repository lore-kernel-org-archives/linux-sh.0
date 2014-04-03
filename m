From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Apr 2014 00:08:46 +0000
Subject: Re: [PATCH] ARM: shmobile: Enable HIGHMEM in shmobile_defconfig
Message-Id: <20140403000843.GA4223@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140402090624.22077.58451.sendpatchset@w520>
In-Reply-To: <20140402090624.22077.58451.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 02, 2014 at 06:06:24PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Many mach-shmobile hardware platforms include support for more
> than 1GiB of RAM. Enable HIGHMEM by default to allow use of
> larger amounts of memory.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up.
