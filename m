From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Feb 2008 21:05:26 +0000
Subject: Re: [PATCH] sh: add sh7722 support to EARLY_SCIF_CONSOLE
Message-Id: <20080206210526.GA13945@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080206145423.27046.98635.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080206145423.27046.98635.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 06, 2008 at 11:54:23PM +0900, Magnus Damm wrote:
> This patch adds the base address of SCIF0 in the case of sh7722.

On Wed, Feb 06, 2008 at 11:57:57PM +0900, Magnus Damm wrote:
> This patch adds support for sh7722 devices with prr value 0xa1.

On Thu, Feb 07, 2008 at 12:02:50AM +0900, Magnus Damm wrote:
> Break out the sign extension code since it's used in multiple places.

Applied, thanks.
