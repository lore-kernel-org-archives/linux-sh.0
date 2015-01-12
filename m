From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Jan 2015 09:25:06 +0000
Subject: Re: [PATCH 13/16] pci/host: rcar-gen2: convert to use generic config accesses
Message-Id: <CAMuHMdX0om4EjS35YKUxo+-W-YLXQ0uJRyr-PLC9VYm=Jcu+TQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420857290-8373-1-git-send-email-robh@kernel.org>
	<1420857290-8373-14-git-send-email-robh@kernel.org>
In-Reply-To: <1420857290-8373-14-git-send-email-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Simon Horman <horms@verge.net.au>, Linux-sh list <linux-sh@vger.kernel.org>, Valentine <valentine.barshak@cogentembedded.com>

On Sat, Jan 10, 2015 at 3:34 AM, Rob Herring <robh@kernel.org> wrote:
> Convert the rcar-gen2 host PCI driver to use the generic config access
> functions.
>
> This changes the i/o accessors from io(read|write)X to readX/writeX
> variants which are equivalent on ARM.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-sh@vger.kernel.org

Thanks, look OK to me.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
