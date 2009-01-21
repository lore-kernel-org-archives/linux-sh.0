From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 21 Jan 2009 09:04:24 +0000
Subject: Re: [Qemu-devel] [PATCH 1/3] sh: SE7750 board definition
Message-Id: <20090121090424.GC14537@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4969B77E.7050206@juno.dti.ne.jp>
	<20090111130445.GA12080@game.jcrosoft.org>
	<496ABD72.20400@juno.dti.ne.jp>
	<20090112124949.GA14269@linux-sh.org>
	<496BFD30.30306@renesas.com> <496C98EB.5040309@juno.dti.ne.jp>
In-Reply-To: <496C98EB.5040309@juno.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: qemu-devel@nongnu.org
Cc: Takashi Yoshii <yoshii.takashi@renesas.com>, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, Jan 13, 2009 at 10:36:43PM +0900, Shin-ichiro KAWASAKI wrote:
> Nobuhiro Iwamatsu wrote:
> >Paul Mundt wrote:
> >>I haven't seen one of these boards in at least 7 years, so I can't help
> >>you with specifications. Yoshii-san or Iwamatsu-san might know, though?
> >>SE7751 should have the same flash model and layout IIRC.
> >>
> >This board can not get from Hitachi-ULSI now and this is too old.
> >I can send it later by examining the flash memory of this board.
> ># I do not understand the meaning that supports this board ....
> 
> I should have explained it.  To avoid messy many board support,
> board should be selected carefully.
> 
> I wanted a board which can test SCI (not SCIF) console emulation.
> I'm sure that SE7750 supports both SCI and SCIF, and it is suitable
> to check SCI work.  For this purpose, any other board is OK if it
> uses SCI for console.
> 
> # The reason I stick to SCI is r2d+ board's RTC.  The r2d+ board uses
> # SCI not for console but for SPI connection with RTC chip.  Before
> # thinking about RTC emulation, SCI emulation should be done.
> 
SCI is pretty much a relic at this point. No current hardware uses it,
and there isn't much point in spending too much effort supporting legacy
hardware. R2D does use the SCI for SPI bitbang for the RTC, but all other
SH platforms either use the SH-RTC directly or something hanging off of
I2C. SPI bitbang is pretty much a corner case for the SH platforms, it
would be much more useful to see SH-RTC emulation. R2D is basically the
only platform that wants SCI anyways.

> Another reason for SE7750 is support for TOPPERS. TOPPERS is an open
> source realtime OS. I think QEMU will be a strong tool for TOPPERS
> developers.  They already utilizes SkyEye, the ARM dedicated CPU
> simulator for board-less development. Of course SkyEye cannot be
> used for the work for SuperH.
> 
> Here's the list of the CPUs and boards which can run TOPPERS.
>  http://www.toppers.jp/en/jsp-kernel-e.html
> SE7750 is the only one board which has SuperH, can run TOPPERS, and
> has Linux kernel's default config.
> 
> We should focus on completing SH-Linux emulation before thinking about
> other OSes.  But if I have to add new board emulation, I think SE7750
> is a good choice.
> 
Supporting other OSes is good, but standardizing on SE7750 doesn't seem
like it will really help anything, given all of the legacy SH-4 stuff it
drags along with it. If we are going to standardize on a board, it should
be something current, something that is readily available in hardware,
and something that people are actively using. The SE7750 does not meet
any of these requirements, nor does any other SH-4. Something like the
SH7785LCR board on the other hand does.

I also don't see much point in catering to OSes that don't support
hardware manufactured this century. If the TOPPERS and BSD people want to
toy around with legacy support, they are welcome to, but QEMU certainly
doesn't have much to gain by spending time on this.
