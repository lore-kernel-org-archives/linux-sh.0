From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 05 Jan 2015 11:50:17 +0000
Subject: Re: [PATCH v2] renesas_usbhs: fix platform init error message
Message-Id: <CAMuHMdXS-N=fmajH9DoraneBs5CXpGXb7VpC6Gu4JWGkOo4pRw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
In-Reply-To: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Shimoda-san,

On Wed, Dec 24, 2014 at 11:02 AM, yoshihiro shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>> > >>>>>     Er, OK. Could you update MAINTAINERS?
>> > >>>>there is no entry for renesas driver in MAINTAINERS.
>> > >>>>Shimoda-san, care to send a patch adding yourself or Morimoto-san as
>> > >>>>maintainers for Renesas driver and pointing to my tree in kernel.org ?

> By the way, about a renesas_usbhs maintainer, I don't know clearly.
> If I do as a renesas_usbhs maintainer:
> - what should I do as the maintainer?
>  - I think I should check patches of renesas_usbhs
>  - And, do I just return  ACK or NACK to the patches?

As a maintainer, you review all patches for renesas_usbhs, and of these patches
will have to go through you.
There are three ways to achieve that:
  1. You collect all accepted patches, and forward them to GregKH with your
     Signed-off-by added,
  2. You collect all accepted ls -lpatches, publish them in a git tree, and
     ask GregKH to pull a branch or tag from your git tree,
  3. You ack all accepted patches, so GregKH knows which patches to apply.

Which way to choose depends on the volume of patches.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
