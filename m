From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Aug 2015 10:35:20 +0000
Subject: Re: [PATCH] PCI: PCI_RCAR_GEN2 and PCI_RCAR_GEN2_PCIE should depend on ARM
Message-Id: <CAMuHMdWfpDT_fzGGGuf4GjGdUpRLf7Na=ZSkqyKFXPJbfi7-SQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1439296994-28480-1-git-send-email-geert+renesas@glider.be>
	<SIXPR06MB041595F310174F0654E3BCC4F5790@SIXPR06MB0415.apcprd06.prod.outlook.com>
In-Reply-To: <SIXPR06MB041595F310174F0654E3BCC4F5790@SIXPR06MB0415.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Bjorn Helgaas <bhelgaas@google.com>, Simon Horman <horms@verge.net.au>, Valentine Barshak <valentine.barshak@cogentembedded.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Phil,

On Mon, Aug 17, 2015 at 12:23 PM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> On 11 August 2015 13:43, Geert wrote:
>> On arm64/shmobile:
>>
>>     drivers/pci/host/pci-rcar-gen2.c: In function 'rcar_pci_cfg_base':
>> drivers/pci/host/pci-rcar-gen2.c:112:34: error: dereferencing pointer to
>> incomplete type
>>       struct rcar_pci_priv *priv = sys->private_data;
>>                                     ^
>>
>> and
>>
>>     drivers/pci/host/pcie-rcar.c:138:52: warning: 'struct pci_sys_data' declared
>> inside parameter list
>>      static inline struct rcar_pcie *sys_to_pcie(struct pci_sys_data *sys)
>>                                                       ^
>>
>> pci_sys_data exists on ARM only, hence these drivers should depend on
>> ARM unconditionally.
>
> Since these drivers should also be used for R-Car Gen3, I assume someone will
> have to fix the problem in the same way the designware pci driver is being modified.
> Please see http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/353421.html

Yes, that would be the correct long-term solution.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
