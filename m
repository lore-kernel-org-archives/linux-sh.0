From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Aug 2015 09:43:35 +0000
Subject: Re: Warning messages occur when booting kernel on Rcar-Gen2
Message-Id: <CAMuHMdUoTarGeMWBr74y_bnLCdQBNoQicsOK4DrdMjz0bSQPLA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Hiep-San,

On Tue, Jul 21, 2015 at 2:57 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
> I'm sorry for sending a wrong warning messages at previous mail.
> The warning messages on Koelsch and Lager is as below:
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x5c/0x78()
> sysfs: cannot create duplicate filename '/devices/system/cpu/cpu4/cpufreq'
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0-rc2-00002-g3f5cd2e-dirty #1
> Hardware name: Generic R8A7790 (Flattened Device Tree)
> Backtrace:
> [<c0012f90>] (dump_backtrace) from [<c0013138>] (show_stack+0x18/0x1c)
>  r7:c063a9a2 r6:ee8319c0 r5:00000009 r4:00000000
> [<c0013120>] (show_stack) from [<c0512c50>] (dump_stack+0x78/0x94)
> [<c0512bd8>] (dump_stack) from [<c0026284>] (warn_slowpath_common+0x88/0xb4)
> ..."
>
> Please see attached bootlog files.

I cannot reproduce this on koelsch, not with my own config nor with
shmobile_defconfig.

> (Lager)
> Linux version 4.2.0-rc2-00002-g3f5cd2e-dirty (nguyen@ky) (gcc version 4.9.2 2015

This is not plain v4.2-rc2. Furthermore, it has local changes.

> (Koelsch)
> Linux version 4.2.0-rc2-00002-g5255232 (jinso@jinso) (gcc version 4.9.2 20140904 (prereleas5

This is not plain v4.2-rc2.

[...]

> Unable to boot CPU1 when MD21 is set
> CPU1: failed to boot: -524
> Brought up 1 CPUs

Please toggle SW8/4, which controls MD21.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
