From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Jan 2013 00:38:04 +0000
Subject: Re: [PATCH 0/2] allow unplugging of CPU0
Message-Id: <20130111003804.GG8415@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1357813004-9549-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1357813004-9549-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 10, 2013 at 11:16:42AM +0100, Ulrich Hecht wrote:
> Hi!
> 
> sh73a0 appears to deal fine with having its first core disabled, so we
> should allow that.
> 
> This may not be the case with all platforms, so as per suggestion of
> Magnus, so I have introduced a new method (shmobile_cpu_disable_any())
> that removes the restriction on CPU0.

Thanks.

Both of these changes look good to me.
I will queue them up for 3.9 a little later today.
