From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Mar 2015 01:59:06 +0000
Subject: Re: Can't mount QSPI-FLASH to userland on Lager
Message-Id: <CAMuHMdVMdFxkv7aLHOOq3fE=XP7JV-tgwyjLrLtnTqogFZw6dA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <550F6E10.8010907@jinso.co.jp>
In-Reply-To: <550F6E10.8010907@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Hiep-san,

On Mon, Mar 23, 2015 at 2:36 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
> Hi Rob Herring-san.
> I'm sorry to bother you!
>
> I'm Hiep from Jinzai Solution (a Japanese Company).
> We are testing Linux kernel v4.0-rc2 on Lager and Koelsch Board ( Renesas=
's
> boards).
> When we tried to test QSPI-FLASH, we can't mount the device file of
> QSPI-FLASH on Lager.
> (Koelsch has no problems)

This is strange: Koelsch and Lager are very similar w.r.t. SPI.
Are you booting the same kernel image?
Do the qspi device nodes in both r8a7790.dtsi and r8a7791.dtsi have dma
properties?
Is there any significant difference in the kernel logs of koelsch and lager?

> The logs is showed as below:
> #mount /dev/mtdblock2 /mnt/
> "EXT3-fs (mtdblock2): error: can't find ext3 filesystem on dev mtdblock2.
> EXT4-fs (mtdblock2): VFS: Can't find ext4 filesystem
> EXT4-fs (mtdblock2): VFS: Can't find ext4 filesystem
> FAT-fs (mtdblock2): bogus number of reserved sectors
> FAT-fs (mtdblock2): Can't find a valid FAT filesystem
> FAT-fs (mtdblock2): bogus number of reserved sectors
> FAT-fs (mtdblock2): Can't find a valid FAT filesystem
> mount: you must specify the filesystem type"
>
> We found that, after removing this patch(as below),
> QSPI-FLASH can mount on Lager very well without any problems.
> "9064bf3=E3=80=80spi: spi-pxa2xx: only include mach/dma.h for legacy DMA"
> I'd like to report it to you and please review it when you have time.

That commit looks like a fairly innocent change to me, but you never know
when mach/*.h is involved...

Which kernel config are you using? shmobile_defconfig?
Do you have CONFIG_SPI_PXA2XX enabled in your .config?
It seems CONFIG_SPI_PXA2XX can be enabled if !ARCH_PXA, while
CONFIG_SPI_PXA2XX_DMA can't. And ARCH_PXA doesn't support
multi-platform.

Which kernel version are you using?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
