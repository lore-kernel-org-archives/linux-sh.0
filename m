From: Rich Felker <dalias@libc.org>
Date: Mon, 08 Aug 2016 14:31:39 +0000
Subject: Re: Build regressions/improvements in v4.8-rc1
Message-Id: <20160808143139.GW15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.10.1608081032130.9359@ayla.of.borg>
 <CAMuHMdW_fPP5dyOtRC98gh1kG-zuW_KxV7vAME_7b8Z-U10N_g@mail.gmail.com>
In-Reply-To: <CAMuHMdW_fPP5dyOtRC98gh1kG-zuW_KxV7vAME_7b8Z-U10N_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Aug 08, 2016 at 10:38:07AM +0200, Geert Uytterhoeven wrote:
> On Mon, Aug 8, 2016 at 10:32 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v4.8-rc1[1] compared to v4.7[2].
> >
> > Summarized:
> >   - build errors: +8/-12
> 
> >   + /home/kisskb/slave/src/arch/arm/kernel/setup.c: error: 'SECTION_SIZE' undeclared (first use in this function):  => 1003:25
> 
> arm-randconfig
> 
> >   + error: "__ucmpdi2" [drivers/scsi/sd_mod.ko] undefined!:  => N/A
> 
> bfin/CM-BF548_defconfig
> 
> >   + error: /home/kisskb/slave/src/drivers/block/loop.c: undefined reference to `__ucmpdi2':  => .text+0x3aaee), .text+0x2ee10), .text+0x2ee1c)
> >   + error: /home/kisskb/slave/src/drivers/scsi/sd.c: undefined reference to `__ucmpdi2':  => .text+0x36cb8), .text+0x3865c)
> 
> Various blackfin
> 
> >   + error: No rule to make target arch/sh/boot/dts/.dtb.o:  => N/A
> 
> sh-allyesconfig, sh-allmodconfig

I saw this. Is there any canonical way I should fix this? The problem
is that there's no default for the DTS name, but I'm not sure there
should be a default. Getting a hard-coded DTB for a particular board
when you do allyesconfig seems like a worse UX than getting a build
failure.

Rich
