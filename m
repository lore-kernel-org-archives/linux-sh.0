From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 08 Jul 2010 12:49:44 +0000
Subject: Re: [PATCH v2 6/6] sh: add sh7757lcr board support
Message-Id: <20100708124943.GA29062@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4C32B1D0.5030101@renesas.com>
In-Reply-To: <4C32B1D0.5030101@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 08, 2010 at 09:37:00PM +0900, Simon Horman wrote:
> On Tue, Jul 06, 2010 at 01:32:16PM +0900, Yoshihiro Shimoda wrote:
> > This adds preliminary support for the sh7757lcr board.
> 
> Does the recent fit that Linus had about defconfig abundance (and other
> things) in ARM apply to SH too?
> 
Yes, and I'm working on getting rid of them completely, but it requires a
pretty big rework of the Kconfig layout amongst other things. There's not
enough time to rework all of that for the upcoming merge window, but it's
on my todo list for the next one.
