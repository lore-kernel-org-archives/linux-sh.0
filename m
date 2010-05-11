From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 11 May 2010 02:51:00 +0000
Subject: Re: [PATCH 1/1] sh: clkfwk: Use debugfs_remove_recursive() for rewinding
Message-Id: <20100511025100.GA18036@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1273492255-5158-1-git-send-email-Hiroshi.DOYU@nokia.com>
In-Reply-To: <1273492255-5158-1-git-send-email-Hiroshi.DOYU@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 10, 2010 at 02:50:55PM +0300, Hiroshi DOYU wrote:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> Rewinding each debugfs entries to unregister if an error happens.
> 
> Based on the commit ca4caa4e1d45f9542fa54263974d0ef637157b4a
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Applied, thanks.
