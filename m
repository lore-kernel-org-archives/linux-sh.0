From: Rich Felker <dalias@libc.org>
Date: Fri, 05 Jan 2018 21:28:57 +0000
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to device tree
Message-Id: <20180105212857.GR1627@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <c1ec211d-cbe2-1139-edb0-8baa0e7364e8@physik.fu-berlin.de>
 <8c75b447-fc14-871e-1a04-733132527b65@landley.net>
 <E7B2D113-C30D-4A32-AFB6-DC91DDADE0E8@physik.fu-berlin.de>
 <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
In-Reply-To: <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Rob Landley <rob@landley.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 17, 2017 at 08:54:47PM +0100, John Paul Adrian Glaubitz wrote:
> On 11/17/2017 08:17 PM, Rich Felker wrote:
> > There were significant problems that I don't think were ever
> > addressed, including incompatible changes in how boot command line was
> > handled and possibly ambiguity about what a physical address means
> > (zero based vs based in the zone SH3/4 excludes from MMU mapping) in
> > the contract for how the bootloader passes a DTB pointer in to the
> > kernel, or something similar.
> 
> I see, thanks for the heads-up.
> 
> > This is a large part of why I want to get to the point where I can
> > build and boot a kernel on the LANDISK -- not being able to test any
> > of this is a blocker for moving everything to device tree.
> 
> I can actually help you with that. I know what to do to get the kernel
> to boot on the LANDISK device. I've got everything working except
> being unable to detect the IDE controller. The attached config builds
> a kernel which boots with the attached output.
> 
> Furthermore, in order to install the kernel, you need to use the
> cross-LILO version from [1] which allows to install the bootloader
> on an x86 machine into the SuperH LANDISK image.
> 
> Instructions can be found in [2]. A base filesystem can be found in [3].
> 
> And I could also send you an USL-5P which is also a LANDISK device,
> just in a different form-factor.
> 
> Adrian
> 
> > [1]http://iohack.osdn.jp/kogiidena/debian26/base/landisk-tools-20070612.tgz
> > [2] https://www.with.de/fw/pub/Computing/PlextorPX-EH/LANDISKdebian.pdf
> > [3] http://iohack.osdn.jp/kogiidena/debian26/base/

I'm trying to reproduce this but can't find any documentation for
cross-LILO in [2], much less any code except possibly the binary
"lilo.x86" in [1]. Googling cross-lilo isn't finding anything
meaningful except this thread. Is there anywhere to find source and
information on what it's doing, or is this going to be something I
have to reverse-engineer?

Rich
