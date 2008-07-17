From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 Jul 2008 05:55:00 +0000
Subject: Re: [PATCH] sh2(A) exception handler update
Message-Id: <20080717055500.GD12007@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87vdzfowr0.wl%ysato@users.sourceforge.jp>
In-Reply-To: <87vdzfowr0.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 10, 2008 at 01:20:03AM +0900, Yoshinori Sato wrote:
> This patch is
> 
> By sh2
> - Remove duplicate code
> - Reduce stack usage
> - Cleanup and little optimize 
> 
> By sh2a
> - Add missing handler(256 to 511)
> - Use sh2a instructions handler
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
Applied, thanks.
