From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Nov 2009 01:49:55 +0000
Subject: Re: [PATCH] sh: Account for cache aliases in flush_icache_range()
Message-Id: <20091109014955.GA22932@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1257462879-16865-1-git-send-email-matt@console-pimps.org>
In-Reply-To: <1257462879-16865-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 05, 2009 at 11:14:39PM +0000, Matt Fleming wrote:
> The icache may also contain aliases so we must account for them just
> like we do when manipulating the dcache. We usually get away with
> aliases in the icache because the instructions that are read from memory
> are read-only, i.e. they never change. However, the place where this
> bites us is when the code has been modified.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Looks reasonable to me, I've applied it.
