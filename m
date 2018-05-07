From: Rich Felker <dalias@libc.org>
Date: Mon, 07 May 2018 14:43:06 +0000
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to device tree
Message-Id: <20180507144306.GG1392@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <E7B2D113-C30D-4A32-AFB6-DC91DDADE0E8@physik.fu-berlin.de>
 <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
 <20180503013708.GC1392@brightrain.aerifal.cx>
 <20180503023320.GD1392@brightrain.aerifal.cx>
 <048ab147-21b8-045d-d21c-e1be2dd0e954@physik.fu-berlin.de>
 <87k1sgtf8t.wl-ysato@users.sourceforge.jp>
 <5f690985-e905-deb9-aa4f-51561463ae22@physik.fu-berlin.de>
 <9051f0a5-bc75-b49e-c8c3-aa877be1979e@landley.net>
In-Reply-To: <9051f0a5-bc75-b49e-c8c3-aa877be1979e@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 08:40:35AM -0500, Rob Landley wrote:
> On 05/07/2018 06:00 AM, John Paul Adrian Glaubitz wrote:
> > I have been able to boot my own kernel on my USL-5P device, but
> > I could never get it to detect the IDE controller. Do I need
> > an additional patch for that?
> 
> On a related note, is there a list of boards anywhere? I'm working on a 7760
> system at $DAYJOB, Rich has a landisk which according to
> https://www.openbsd.org/landisk.html is an SH7751R, and Sato-san says that
> QEMU's -r2d emulates that too? ("RTS7751R2Dplus is QEMU-SH4 target. So easy
> trying.")
> 
> What other boards do we need to covert to device tree? arch/sh/boards has 15 C
> files and 19 subdirectories, but I dunno the status of any of them...

I think asking "what we need to convert" is at least slightly
mis-framed. Once the basics for device tree support are in place
(basically patches 06-09), which boards are supported by device tree
is mostly a matter of (1) whether the hardware drivers you want to use
have bindings and use modern kernel interfaces, and (2) someone
writing the dts files.

Unless there's strong objection, I'd be happy with just doing a survey
of device drivers used on currently supported boards, making sure they
all nominally support device tree, then removing the old board file
framework and waiting to see user response. If we take this path it
should likely happen in a release not planned for LTS so there's time
to add appropriate driver fixes and dts files before the next LTS
release.

I don't mind holding off a little bit on removal of the legacy board
file support if it's hard to get enough hardware working right away
with device tree, but I do want to move towards getting rid of it as
soon as we can, since it's a large volume of code cutting into my
ability to have a good maintainer-level understanding of the arch/sh
tree and has a lot of crufty, unmaintained parallel infrastructure
duplicating stuff that can be done in cleaner and more modern ways
(see the threads on early platform device stuff, rtc drivers, etc.).

Rich
