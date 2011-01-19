From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 19 Jan 2011 10:00:22 +0000
Subject: Re: [PATCH] sh: update INTC to clear IRQ sense valid flag
Message-Id: <20110119100022.GA13114@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110119081629.13270.23386.sendpatchset@t400s>
In-Reply-To: <20110119081629.13270.23386.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 19, 2011 at 05:16:29PM +0900, Magnus Damm wrote:
> Clear the valid flag is in the INTC code.
> Without this fix bit 7 of the sense register
> is mistakenly set.

Applied, thanks.
