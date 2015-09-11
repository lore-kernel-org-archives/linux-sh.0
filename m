From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Sep 2015 00:40:49 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: lager: add pinmux for iic0
Message-Id: <20150911004049.GA11622@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1441820899-10457-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1441820899-10457-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 09, 2015 at 07:48:19PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> It seems we used to rely on the default pinmux setting of this HW, but
> currently we need to explicitly set the pinmux to access this bus. It is
> better style, too.
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>

Thanks, I have queued this up for v4.4.
