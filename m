From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 23 Mar 2014 10:13:20 +0000
Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
Message-Id: <CAMuHMdVMCeZwX_67ktCYcYLe_P3+X5EeRbUDT3ZJjcgvU=Hwqg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
 <1395397968-6242-7-git-send-email-phil.edworthy@renesas.com>
 <532C5ADE.4030708@cogentembedded.com>
In-Reply-To: <532C5ADE.4030708@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Mar 21, 2014 at 4:29 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> +
>> +       pcie: pcie@fe000000 {
>> +               compatible = "renesas,r8a7790-pcie";
>
>    The convention adopted on this list is to put the "pcie" first, and SoC
> name the last.

Except for clock bindings ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
