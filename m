From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 May 2020 06:54:53 +0000
Subject: Re: [PATCH] sh: Drop CONFIG_MTD_M25P80 in sh7757lcr_defconfig
Message-Id: <CAMuHMdXhCdCmXMc=JFRsP-HfUwF-RK57A+ftjg0Y9qREKd+3ig@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1588393643-31499-1-git-send-email-bmeng.cn@gmail.com>
 <CAMuHMdVd3s46o5VXZqAHuQt5qYsbDMOonVWjEqd2nu8OON97Xw@mail.gmail.com> <CAEUhbmWjrnRLXUd3Au2f7fnZtRVgdYzMvFn-RrdOodfFq4r=Lg@mail.gmail.com>
In-Reply-To: <CAEUhbmWjrnRLXUd3Au2f7fnZtRVgdYzMvFn-RrdOodfFq4r=Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bin Meng <bin.meng@windriver.com>

Hi Bin,

On Sat, May 2, 2020 at 1:05 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> On Sat, May 2, 2020 at 6:09 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sat, May 2, 2020 at 6:27 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > From: Bin Meng <bin.meng@windriver.com>
> > >
> > > Drop CONFIG_MTD_M25P80 that was removed in
> > > commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
> > >
> > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> >
> > Thanks for your patch!
> >
> > Blindly removing config options from defconfig files that haven't
> > received much love for a while is IMHO not such a good idea, as it makes
> > it harder to see what the affected platform needs, or needed.
> >
> > > --- a/arch/sh/configs/sh7757lcr_defconfig
> > > +++ b/arch/sh/configs/sh7757lcr_defconfig
> > > @@ -36,7 +36,6 @@ CONFIG_IPV6=y
> > >  # CONFIG_FW_LOADER is not set
> > >  CONFIG_MTD=y
> > >  CONFIG_MTD_BLOCK=y
> > > -CONFIG_MTD_M25P80=y
> > >  CONFIG_BLK_DEV_RAM=y
> > >  CONFIG_SCSI=y
> > >  CONFIG_BLK_DEV_SD=y
> >
> > MTD_SPI_NOR became a dependency for MTD_M25P80 since commit
> > 03e296f613affcc2671c1e86d8c25ecad867204e ("mtd: m25p80: use the SPI nor
> > framework") and commit e43b20619bdb6c851dd7b49cbd15e52875a785d4 ("mtd:
> > spi-nor: shorten Kconfig naming").  Hence CONFIG_MTD_SPI_NOR=y should be
> > added to avoid breaking the platform's SPI FLASH support.
> >
> > Just removing CONFIG_MTD_M25P80=y from the defconfig makes this less
> > visible for someone who wants to build a kernel for this platform using
> > "make sh7757lcr_defconfig": it can no longer be seen that
> > CONFIG_MTD_M25P80=y won't be present in the resulting .config file.
> >
>
> Thank you for the review! Sorry I missed that.
>
> > I think the platform would be better served with a proper refresh of the
> > defconfig file.
>
> I am not sure if doing a defconfig refresh should be a separate patch.

OK.

> I felt mixing the refresh with the real changes makes the code review
> a little bit hard. I just sent v2 without the refresh. Please let me
> know if it is okay.

Thank you, that's fine. It turns out sh7757lcr_defconfig has less bitrotted
than I had feared.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
