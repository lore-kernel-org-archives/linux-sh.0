From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 29 Apr 2010 14:30:18 +0000
Subject: Re: [PATCH] arch/sh: Fix wrong function prototype for native_cpu_disable
Message-Id: <20100429143018.GC9621@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201004290256.10506.PeterHuewe@gmx.de>
In-Reply-To: <201004290256.10506.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Huewe <PeterHuewe@gmx.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Matt Fleming <matt@console-pimps.org>, Mike Travis <travis@sgi.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, Apr 29, 2010 at 02:56:10AM +0200, Peter Huewe wrote:
> From: Peter Huewe <peterhuewe@gmx.de>
> 
> This patch fixes the prototype of native_cpu_disable if
> CONFIG_HOTPLUG_CPU is not set, and thus fixes a build failure[1]
> 
> References:
> [1] http://kisskb.ellerman.id.au/kisskb/buildresult/2536296/
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

I've already applied Matt's patch for the same issue, thanks anyways!
