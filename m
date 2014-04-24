From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Apr 2014 07:03:25 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Koelsch DT serial integration prototype
Message-Id: <CAMuHMdVCtwU+z68UKn0jzGSJAHdP+vxnUXzmZ7S6ZTK12mj=qA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140421013114.3236.90868.sendpatchset@w520>
In-Reply-To: <20140421013114.3236.90868.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 24, 2014 at 12:18 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> What is the problem? We need to encourage development and also provide
>> a stable base. And from my point of view, you're not even supposed to
>> use the C DT reference code as a developer - you should use DT-only
>> board support for development.
>
>    I wonder how DT-only support (without C reference code) is possible with
> the current devel branch: only board-{lager|koelsch}-reference.c include
> call to of_platform_populate() without which DT probing drivers won't see
> their devices. If we had that call in the setup-r8a779[01].c then I would
> have understood what you mean by DT-only...

Koelsch boots without C board code, up to the point where NFS root is
to be mounted. It seems Ethernet is not working, although I have
DT-friendly support for enabling its MSTP clock.

You need "ARM: shmobile: r8a7790: Add early debugging support"
and boot with "keep_bootcon", or "ARM: shmobile: koelsch: Enable SCIF0
and SCIF1 serial ports in DT" to keep an eye on what the kernel is doing.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
