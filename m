From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 20 May 2010 03:36:01 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: G3EVM FLCTL platform data
Message-Id: <20100520033601.GG6661@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100219095406.5206.86934.sendpatchset@t400s>
In-Reply-To: <20100219095406.5206.86934.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 23, 2010 at 02:49:46PM +0900, Magnus Damm wrote:
> On Mon, Feb 22, 2010 at 7:31 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> >> + ? ? /* FOE, FCDE, FSC on dedicated pins */
> >> + ? ? __raw_writel(__raw_readl(0xe6158048) & ~(1 << 15), 0xe6158048);
> >> +
> > This looks suspiciously like an obfuscated MSTP toggle that the clock
> > framework needs to be handling. I thought I was already pretty clear when
> > I said I wouldn't be applying any more of these sorts of patches until
> > some basic clock framework support was in place?
> 
> I didn't ask you to apply the patch, just wanted to post it so other
> people can get the code.
> 
I suppose you are going to respin this once the G3 clkdev stuff is
posted?
