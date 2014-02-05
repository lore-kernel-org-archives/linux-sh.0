From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Feb 2014 12:09:43 +0000
Subject: Re: [PATCH 04/11] ARM: shmobile: lager.dts: add pci 0/1/2
Message-Id: <CANqRtoScEdmP5=9xzBOT4HSHrpGah2L4fMPdSAQiVGFAuKh-OQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1391595554-20640-5-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1391595554-20640-5-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 5, 2014 at 7:19 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Enable pci1 and pci2 nodes for USB controllers attached to the AHB<>PCI
> bridge devices. Node pci0 is enabled for the moment as a device, but
> could be switched to usb-gadget mode later.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>

I'd like this to follow board-lager.c, which means using usb0 as
gadget-only due to missing cable detection on the micro-USB connector.
So feel free to keep pci0, pci1, pci2 in r8a7790.dtsi but for
r8a7790-lager.dtsi please omit pci0 to keep in-sync with the legacy
board-lager.c code.

Thanks,

/ magnus
