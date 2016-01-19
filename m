From: Dirk Behme <dirk.behme@gmail.com>
Date: Tue, 19 Jan 2016 16:56:45 +0000
Subject: Re: [RFC 0/6] mmc: sdhi: add basic r8a7795 support
Message-Id: <569E6ACD.2060303@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfgang,

On 19.01.2016 17:20, Wolfram Sang wrote:
> So, I started working on the SDHI part. Since Dirk seems to be working on the
> clocks already (thanks!), I evaluated the patches for the mmc-subsystem and
> refactored the subset which gets the basic functionality run. A few cleanups
> were applied, too. The patches are RFC because I want to check one more issue
> (restore clock settings after software reset) and also I need to do Gen2
> regression testing. However, release early, I wanted to show you what I am
> hacking on here. A branch for testing (with Dirk's clock patches and DTS
> additions can be found here):
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/v8-sdhi-nodma
>
> Further testing much appreciated. It works fine on my Salvator using SD cards
> on both, SDHI0 and SDHI3. Simple testing, though, no stress testing yet.


Many thanks for working on this! I'll have a look to it, maybe next week.

Just fyi, some general remarks, what's my recent status:

First, regarding the clocks, if anybody from the experts could advise 
me how we'd like to interface dynamic clocks to the existing Gen3 
clock code, that would be really welcome:

http://marc.info/?l=linux-sh&m5302405811953


Second, I'm mainly interested in eMMC support for the Salvator-X. 
Therefore I picked (hopefully) all patches from the Renesas BSP to 
renesas-drivers-2016-01-13-v4.4

https://github.com/dirkbehme/linux-renesas-rcar-gen3/commits/dirk/gen3-latest-update

I compared the Renesas BSP code in drivers/mmc with that version, it's 
the same. However, this branch crashes more or less immediately after 
successfully detecting the eMMC in various core kernel parts. This 
happens as soon as I enable the eMMC in the device tree. It looks to 
me like a DMA issue, because I'd think the errors are in core kernel 
code which is fine, so I'd suspect some memory overwriting. But what 
confuses me is that the same code works fine on the the 4.2 based 
Renesas BSP. I have no idea regarding this, yet.

And third, from reading the r8a7795 manual I think the manual talks about

https://github.com/dirkbehme/linux-renesas-rcar-gen3/commit/f2a727c859916d59dca85dbb72c1b61da3fd6da0

But testing this it doesn't work. So either the manual is wrong, or I 
missed anything else.

Best regards

Dirk

