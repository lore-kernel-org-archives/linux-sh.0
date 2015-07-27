From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Jul 2015 01:09:03 +0000
Subject: Re: [PATCH v2 0/3] bockw SD pull-ups
Message-Id: <20150727010902.GC30052@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1437751317-12235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1437751317-12235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, Jul 24, 2015 at 05:21:54PM +0200, Ulrich Hecht wrote:
> Hi!
> 
> This series implements pull-up configuration in the r8a7778 PFC driver
> and sets the SD0_WP and SD0_CD pull-ups on the Bock-W board correctly,
> replacing the hack that is used in the legacy platforms.
> 
> This revision uses bitfields for the pull-up table, reducing its size to 310
> bytes, and demotes undefined pull-ups from a bug to a warning.

I am wondering if these patches create any forwards/backwards compatibility
issues if the kernel and DT are not upgraded simultaneously.
