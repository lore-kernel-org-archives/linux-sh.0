From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Dec 2015 13:41:16 +0000
Subject: Re: [PATCH 2/4] PCI: rcar: Support runtime PM link state L1 handling in pcie-rcar
Message-Id: <CAMuHMdWfOo7=g9F_qmhM65yct0P=F3QvkVkHMggBJRLA0gCPYQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
	<1450358557-28376-3-git-send-email-phil.edworthy@renesas.com>
	<20151217133058.GA20372@katana>
In-Reply-To: <20151217133058.GA20372@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Phil Edworthy <phil.edworthy@renesas.com>, Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Dec 17, 2015 at 2:30 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> +             /* Wait until we are in L1 */
>> +             while (!(val & L1FAEG))
>> +                     val = rcar_pci_read_reg(pcie, PMSR);
>
> No timeout?

And no cpu_relax() in each iteration.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
