From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 17 Nov 2010 08:18:11 +0000
Subject: Re: [PATCH (sh-2.6)] sh: avoid to flush all cache in sys_cacheflush
Message-Id: <20101117081811.GB11447@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1289976668-27728-1-git-send-email-peppe.cavallaro@st.com>
In-Reply-To: <1289976668-27728-1-git-send-email-peppe.cavallaro@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 17, 2010 at 07:51:08AM +0100, Giuseppe CAVALLARO wrote:
> Calling sys_cacheflush with ICACHE we can direclty flush
> the icache without invoking the flush_cache_all function.

On Wed, Nov 17, 2010 at 07:51:52AM +0100, Giuseppe CAVALLARO wrote:
> This patch fixes the following error obtained when
> compile the Kernel with the VSYSCALL support enabled:

These both look good, I'll add them to the .37 queue, thanks!
