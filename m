From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 16 Oct 2009 05:39:46 +0000
Subject: Re: [PATCH] sh: disabled cache handling fix for sh4
Message-Id: <20091016053946.GB2952@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091016012006.20892.67821.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091016012006.20892.67821.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 16, 2009 at 10:20:06AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add code to handle the cache disabled case for sh4. Fixes breakage
> introduced by 37443ef3f0406e855e169c87ae3f4ffb4b6ff635. Without
> this patch configuring caches off with CONFIG_CACHE_OFF=y makes
> kfr2r09 and migo-r lock up in fbdev deferred io or early user space.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied after moving it to cache.c and some tidying.
