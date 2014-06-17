From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 17 Jun 2014 07:41:14 +0000
Subject: RE: [PATCH 8/8] ARM: shmobile: henninger: Add dummy PCIe bus clock
Message-Id: <b047028e0ac346f8a49d483f09b22691@HKXPR06MB168.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401261843-6964-9-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1401261843-6964-9-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On 16 June 2014 23:55, Sergei wrote:
> On 06/12/2014 08:47 PM, Sergei Shtylyov wrote:
> 
> >>>>> Since the CPU's dtsi refers to pcie_bus_clock, we need an entry in
> >>>>> the board's dts, even if we aren't using PCIe.
> 
> >>>>      I don't quite understand that last part: there's PCIe slot in the
> >>>> Henninger's schematics (although it doesn't seem to be soldered in the
> >>>> early board version).
> 
> >>>      In fact, we're in process of verifying PCIe on Henninger (soldered the
> >>> connector); at least the configuration space accesses work OK...
> 
> >> Do you mean the internal Root-Complex config accesses work ok, or card
> ones?
> 
> >     We inserted an Intel Wi-Fi card and saw PCI-PCI bridge and network
> > controller in lspci's output. Another (Ethernet) card didn't work though...
> 
>     That PCI-PCI bridge has ID 1912:001f which corresponds to Renesas. I guess
> it's a part of the PCIe controller and then I wonder why this device is not
> seen when no card is inserted...

Simply because the hardware does not support hot plug. So, during probe the driver checks for link up, and if so it will call pci_common_init_dev().

Regards
Phil
