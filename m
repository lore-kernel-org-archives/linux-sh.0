From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 07 Nov 2014 13:29:27 +0000
Subject: Re: [PATCH 00/03] ARM: shmobile: sh73a0 and kzm9g Multiplatform support
Message-Id: <CAMuHMdXoFtnksc3Yff5aOfhsC0yhfZvVZEwYwEgFRV56jbYbrA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904022835.26216.90336.sendpatchset@w520>
In-Reply-To: <20140904022835.26216.90336.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thu, Nov 6, 2014 at 8:19 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Sep 4, 2014 at 4:28 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> ARM: shmobile: sh73a0 and kzm9g Multiplatform support
>>
>> [PATCH 01/03] ARM: shmobile: sh73a0: Introduce generic setup callback
>> [PATCH 02/03] ARM: shmobile: sh73a0: Add Multiplatform support
>> [PATCH 03/03] ARM: shmobile: kzm9g: Build DTS for Multiplatform
>>
>> This patch series enables sh73a0 Multiplatform support. At this point
>> the KZM9G board code is left as-is, but future updates will make
>> sure to consolidate the DTS and get rid of C board code.
>
> Did you manage to boot this successfully?
>
> For me, it hangs after:
>
>     On node 0 totalpages: 124928
>     free_area_init_node: node 0, pgdat c04f9a40, node_mem_map df429000
>       Normal zone: 976 pages used for memmap
>       Normal zone: 0 pages reserved
>       Normal zone: 124928 pages, LIFO batch:31

> The kzm9g memory node has "reg = <0x41000000 0x1e800000>;".

... which is incompatible with CONFIG_AUTO_ZRELADDR=y, which requires that
the start address of physical memory is a multiple of 128 MiB, and which is
enabled for multi-platform kernels...

The rationale for stealing the first 16 MiB of RAM is explained in the u-boot
history:

commit 9415cf93bc5ded82c6b915d5ab3b8c8f61a75c46
Author: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date:   Thu Jul 5 01:43:44 2012 +0000

    arm: rmobile: kzm9g: Modify sdram area

    Reserve first 16MB for RT-CPU (as same as kernel config).

    Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
    Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Do you remember what's the reason for stealing the last 8 MiB of RAM?

It works fine with the full 512 MiB of RAM, if enabled.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
