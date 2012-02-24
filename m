From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Feb 2012 04:31:45 +0000
Subject: Re: [PATCH] arch/arm/mach-shmobile/board-ag5evm.c: included linux/dma-mapping.h twice
Message-Id: <20120224043145.GE9994@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1329403598-304-1-git-send-email-danny.kukawka@bisect.de>
In-Reply-To: <1329403598-304-1-git-send-email-danny.kukawka@bisect.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 16, 2012 at 03:46:38PM +0100, Danny Kukawka wrote:
> arch/arm/mach-shmobile/board-ag5evm.c: included 'linux/dma-mapping.h'
> twice, remove the duplicate.
> 
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>

Applied, thanks.
