From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Mar 2014 10:47:56 +0000
Subject: Re: NFS root on Koelsch reference
Message-Id: <CAMuHMdW3YeOUGhy8oL3Tmq5sQhzeSFuXQsUR8AUmi+PH1-rN4w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdUND0D8rj4K3ZPqx1XqS7czK3PeHfBqTu2WRWQw3Ecj1A@mail.gmail.com>
In-Reply-To: <CAMuHMdUND0D8rj4K3ZPqx1XqS7czK3PeHfBqTu2WRWQw3Ecj1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Fri, Mar 7, 2014 at 7:57 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> We also need a fix for the Micrel PHY to set the LED mode on the
>> Lager board. I've sent that but it seems to have stalled.
>
>    While we're not having it, try changing "renesas,ether-link-active-low"
> prop to "renesas,no-ether-link" in the Koelsch device tree file.

Thanks, that decreases the part between nfsroot mount and system ready
from 54 s to 15 s, hence

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
