From: Rob Landley <rob@landley.net>
Date: Mon, 07 May 2018 13:40:35 +0000
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to device tree
Message-Id: <9051f0a5-bc75-b49e-c8c3-aa877be1979e@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <c1ec211d-cbe2-1139-edb0-8baa0e7364e8@physik.fu-berlin.de>
 <8c75b447-fc14-871e-1a04-733132527b65@landley.net>
 <E7B2D113-C30D-4A32-AFB6-DC91DDADE0E8@physik.fu-berlin.de>
 <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
 <20180503013708.GC1392@brightrain.aerifal.cx>
 <20180503023320.GD1392@brightrain.aerifal.cx>
 <048ab147-21b8-045d-d21c-e1be2dd0e954@physik.fu-berlin.de>
 <87k1sgtf8t.wl-ysato@users.sourceforge.jp>
 <5f690985-e905-deb9-aa4f-51561463ae22@physik.fu-berlin.de>
In-Reply-To: <5f690985-e905-deb9-aa4f-51561463ae22@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/07/2018 06:00 AM, John Paul Adrian Glaubitz wrote:
> I have been able to boot my own kernel on my USL-5P device, but
> I could never get it to detect the IDE controller. Do I need
> an additional patch for that?

On a related note, is there a list of boards anywhere? I'm working on a 7760
system at $DAYJOB, Rich has a landisk which according to
https://www.openbsd.org/landisk.html is an SH7751R, and Sato-san says that
QEMU's -r2d emulates that too? ("RTS7751R2Dplus is QEMU-SH4 target. So easy
trying.")

What other boards do we need to covert to device tree? arch/sh/boards has 15 C
files and 19 subdirectories, but I dunno the status of any of them...

Rob
