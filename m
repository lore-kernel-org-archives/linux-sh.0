From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 12 Nov 2008 04:58:14 +0000
Subject: Re: Qemu SH4 status #2
Message-Id: <20081112045814.GB16332@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081110233926.3d8c7fd1.kristoffer.ericson@gmail.com>
	<20081111141335.3c869c26.yoshii.takashi@gmail.com>
	<20081111122700.79906a33.kristoffer.ericson@gmail.com>
	<20081112133313.967c82e2.yoshii.takashi@gmail.com>
In-Reply-To: <20081112133313.967c82e2.yoshii.takashi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshii.takashi@gmail.com
Cc: qemu-devel@nongnu.org, Kristoffer Ericson <kristoffer.ericson@gmail.com>, takasi-y@ops.dti.ne.jp, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, Nov 12, 2008 at 01:33:13PM +0900, yoshii.takashi@gmail.com wrote:
> Hi,
> 
> > I'm still getting segmentation fault at exact same
> > location. Have you made additional patches?
> Please find attached file "qemu081111.diff".
> Basically, this is an aggregate of patches found on qemu-devel ML,
>  with some conflicts against current svn source being resolved,
>  and some small fix are added, which are scheduled to be posted after
>  I finished with my pending patches.
> 
> I post this to share information between qemu and linux/sh people,
>  and hopefully accelerate debugging with linux people's help.
> 
> Another file "linuxconfig_r2d_qemu.diff" is diff for linux kernel
>  configuretion. It changes following parameters from r2d+'s defconfig.
> - Cache -> off (qemu has no cache)
> - commandline change (for debugging)
> - 8139too -> 8139cp (qemu's default is c+, still thinking how to switch)
> - SH SPI -> off (sci emulation is not mature enough to handle it)
> 
This is precisely what rts7751r2dplus_qemu_defconfig is for. Please patch
that instead, as new features are added.
