From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Thu, 12 Jun 2014 15:41:36 +0000
Subject: RE: [PATCH 8/8] ARM: shmobile: henninger: Add dummy PCIe bus clock
Message-Id: <2950f8d6e3da42fc8664f9f769aaff36@HKXPR06MB168.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401261843-6964-9-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1401261843-6964-9-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On 12 June 2014 00:25, Sergei wrote:
> On 06/12/2014 01:03 AM, Sergei Shtylyov wrote:
> 
> >> Since the CPU's dtsi refers to pcie_bus_clock, we need an entry in
> >> the board's dts, even if we aren't using PCIe.
> 
> >     I don't quite understand that last part: there's PCIe slot in the
> > Henninger's schematics (although it doesn't seem to be soldered in the
> early
> > board version).
> 
>     In fact, we're in process of verifying PCIe on Henninger (soldered the
> connector); at least the configuration space accesses work OK...

Do you mean the internal Root-Complex config accesses work ok, or card ones?

One thing we noticed on the Koelsch board is that some cards need Aux 3.3V to be supplied before they will work. By default on the Koelsch board, this is not supplied - you have to add link R719.

Regards
Phil
