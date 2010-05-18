From: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Date: Tue, 18 May 2010 09:57:31 +0000
Subject: Re: [GIT PULL] sh updates for 2.6.35-rc1
Message-Id: <AANLkTim6t8oG-vdLKE918Sd2TFKJpSf5Bw2PTtSsD_Fh@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100518092532.GA3050@linux-sh.org>
In-Reply-To: <20100518092532.GA3050@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal@linux-sh.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Paul,

On Tue, May 18, 2010 at 2:55 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> Please pull from:
>
> =A0 =A0 =A0 =A0master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.=
git
>
> Which contains:
>
..
> =A0drivers/dma/shdma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 52 ++-
> =A0drivers/dma/shdma.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A04 +-
> =A0drivers/serial/sh-sci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A01=
89 ++++++---
> =A0drivers/sh/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 24 +
> =A0drivers/sh/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +
> =A0drivers/sh/clk-cpg.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0298 +++++++++++++
> =A0drivers/sh/clk.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0545 ++++++++++++++++++++++
> =A0drivers/sh/intc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0333 +++++++++++++--
> =A0include/linux/device.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A04 +
> =A0include/linux/serial_sci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A04 +-
> =A0include/linux/sh_clk.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0150 +++++++
> =A0include/linux/sh_dma.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0102 +++++
> =A0include/linux/sh_intc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
26 +-
..
> =A0create mode 100644 drivers/sh/Kconfig
> =A0create mode 100644 drivers/sh/clk-cpg.c
> =A0create mode 100644 drivers/sh/clk.c
> =A0create mode 100644 include/linux/sh_clk.h
> =A0create mode 100644 include/linux/sh_dma.h

I have few doubts :

1. Which other architectures are using :
include/linux/sh_clk.h, include/linux/sh_dma.h and include/linux/sh_intc.h

2. If you think, in future some architecture will going to use these
files, then do you think sh_*.h name is appropriate.

3. Can we move :
include/linux/sh_clk.h -> drivers/sh/sh_clk.h
include/linux/sh_dma.h -> drivers/dma/sh_dma.h
include/linux/sh_intc.h -> drivers/sh/sh_intc.h
So that if someone want to use these file they can use it from here.

Thanks,
--
Jaswinder Singh.
