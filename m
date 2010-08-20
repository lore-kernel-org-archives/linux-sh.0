From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 20 Aug 2010 11:40:52 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb: fix write protect for SDHI1
Message-Id: <20100820114051.GA30659@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1282148653-5000-1-git-send-email-arnd@arndnet.de>
In-Reply-To: <1282148653-5000-1-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 18, 2010 at 06:24:13PM +0200, Arnd Hannemann wrote:
> SDHI1 on AP4EVB has no pin to detect write protection of a card.
> This had the result that a card inserted in this slot was always detected
> as read only. This patch adds the corresponding flag to disable
> write protection detection for SDHI1.
> 
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

Applied, thanks.
