From: Rich Felker <dalias@libc.org>
Date: Mon, 30 Apr 2018 01:56:35 +0000
Subject: Re: Board support for NextVoD - pdk7105
Message-Id: <20180430015635.GC1392@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <406f18f4-33df-04f8-919b-5f431dd2229b@physik.fu-berlin.de>
In-Reply-To: <406f18f4-33df-04f8-919b-5f431dd2229b@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Apr 29, 2018 at 11:58:28AM -0500, Rob Landley wrote:
> 
> 
> On 04/25/2018 01:30 PM, Rich Felker wrote:
> > On Wed, Aug 03, 2016 at 11:59:27AM +0200, John Paul Adrian Glaubitz wrote:
> >> Hi!
> >>
> >> I'm currently playing around with a NextVoD box from Taiwan which is
> >> a VoD system based on the ST40 SoC by ST Microelectronics:
> >>
> >> root@nextvod01:~# cat /proc/cpuinfo
> >> machine		: pdk7105
> >> processor	: 0
> >> cpu family	: sh4
> >> cpu variant	: st40-300
> >> cpu type	: STx7105
> >> cut		: 3.x
> >> cpu flags	: fpu icbi synco fpchg
> >> cache type	: split (harvard)
> >> icache size	: 32KiB (2-way)
> >> dcache size	: 32KiB (2-way)
> >> address sizes	: 32 bits physical
> >> bogomips	: 448.51
> >> root@nextvod01:~#
> >>
> >> Attaching the output from dmesg and the current kernel config.gz.
> >>
> >> The machine is currently running a rather old kernel which I would like
> >> to update, however I'm not sure whether the necessary patches have been
> >> upstreamed. There is a git repository available which has 2.6.32 kernel
> >> with the necessary patches [1].
> >>
> >> Do you think we could get this merged into the normal SH kernel?
> > 
> > I've got my replacement NextVoD setup more properly now and ready for
> > development work. Is this the source for the kernel you're using and
> > shipped with it? The repo does not seem to be based off upstream
> > kernel git at all, but rather a new repo starting with some
> > already-modified 2.6.32 tree as the initial commit.
> 
> I have the box you sent me sitting on the shelf at home until I can get a power
> supply and serial adapter for it.
> 
> Can we get a web page (wiki page) somewhere with info on this thing? I spent
> half an hour trawling through the emails you guys cc'd me on back in january
> about the first board Rich got, and... let's see:

The linux-sh.org wiki is mysteriously back! It seems like it would be
the obvious place to put this information. We should find out who is
controlling it and whether they're reliable to keep it up.

> > I have pre-installed Debian Wheezy onto your box. Once you power
> > it up and hook it up to the network, it should boot into Debian
> > Wheezy, the boot is finished once the LED has turned from purple
> > to solid blue.
> > 
> > You will be able to login via SSH using root/root.
> > 
> > The box was installed using the image "wheezy-sh4.dd" linked here:
> > 
> >> https://github.com/fuyuanli/nextvod-linux-manual/blob/master/doc/02.01.md
> > 
> > Original firmware can be found here:
> > 
> >> https://code.google.com/p/nexttv-mod/downloads/detail?name=U-boot_sourcecode.zip
> > 
> > And the original stlinux distribution is to be found here:
> > 
> >> http://archive.stlinux.com/stlinux/index.html
> > 
> 
> > 
> > Some stuff can be found here:
> > 
> >> https://github.com/OpenSH4
> >> https://github.com/dlintw/nextvod-tdt
> >> https://github.com/dlintw/sh4twbox-build-env
> >> https://github.com/dlintw/sh4twbox-multiboot
> > 
> > The kernel is here:
> > 
> >> https://github.com/dlintw/kernel-pdk7105
> > 
> > And I just found there is apparently a more modern kernel:
> > 
> >> https://github.com/dlintw/pdk7105-3.4
> 
> Ooh, did you send one to Sato-san too? (Or is he just cc'd?)

The 3.4 one looks incomplete and even more undocumented. It's not even
clear what version of the upstream kernel it's forked off of or how
they got the underlying ST support since STlinux didn't make it to 3.4
AFAIK.

> And there was more about the serial adapter but that boiled down to
> "Rich offered to mail me a cable" so I don't have a window open for
> that.
> 
> Info about where these boards _come_ from and so on would be nice.
> "Ask Adrian to mail you one" seems unlikely to scale.

Yes, I've had several ppl ask, and I couldn't find it on Yahoo
Auctions Taiwan anymore. Is it still possible to obtain them?

> And I already asked if there was an existing community of
> devs banging on these in China (seems like, since so much stuff is
> translated) that we could maybe talk to...
> 
> (It's a fun little board. Bit like the original linksys, only
> smaller and with video outputs. I look forward to powering it on.)
> 
> > This could be a good direction for future of arch/sh -- presumably all
> > the ST SoCs have a lot in common and could probably be a good first
> > target for supporting with device tree rather than legacy-style board
> > files full of platform devices.
> 
> Rich, I'll see if I can get you one of the SH7760 boards I'm working
> on at this contract, but it won't happen this month.

Great!

Rich
