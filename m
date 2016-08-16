From: Rob Landley <rob@landley.net>
Date: Tue, 16 Aug 2016 21:15:22 +0000
Subject: Re: [PATCH] sh: Fix building j2_defconfig
Message-Id: <398e6385-ec40-4493-449d-c8c43fd11d85@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20160816154140.25022-1-jason@lakedaemon.net>
In-Reply-To: <20160816154140.25022-1-jason@lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Cooper <jason@lakedaemon.net>, Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On 08/16/2016 10:41 AM, Jason Cooper wrote:
> When targeting the j2, we need to retain '-m2'.  Previously, the
> Makefile blew out -m2 on the next line via :=.
> 
> Fix this by s/:=/+=/ when building for the J2.
>
> Fixes: 5a846abad07f6 ("sh: add support for J-Core J2 processor")
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>

Speaking of j2, any status on the missing pieces of infratsructure that
went in through other trees, without which booting hangs awaiting the
first interrupt?

  http://lists.j-core.org/pipermail/j-core/2016-August/000326.html

It would be nice if the rest of the board support could make it in this
release. Which trees are they going through?

Rob
