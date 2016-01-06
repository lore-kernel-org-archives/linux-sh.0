From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 06 Jan 2016 08:45:46 +0000
Subject: Re: [PATCH v2 3/4] PCI: rcar: Add runtime PM support to pcie-rcar
Message-Id: <CAMuHMdUZq=8j8sTAu4SiDu+HuJkqciCx9uy-L5TQUGVbNc-Yaw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
	<1451998831-27705-4-git-send-email-phil.edworthy@renesas.com>
	<20160106083500.GB1525@katana>
In-Reply-To: <20160106083500.GB1525@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Phil Edworthy <phil.edworthy@renesas.com>, Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Wolfram,

On Wed, Jan 6, 2016 at 9:35 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> +err_pm_put:
>> +     pm_runtime_put(pcie->dev);
>> +
>> +err_pm_disable:
>> +     pm_runtime_disable(pcie->dev);
>
> What about put/disable in the remove part?

Which remove part? (been there, done that ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
