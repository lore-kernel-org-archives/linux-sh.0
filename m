From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 09 Sep 2014 09:42:09 +0000
Subject: RE: Koelsch boot issue with internal PCI and PCIe controllers
Message-Id: <02a71081496a45ea8aee70e054035aa5@HKXPR06MB168.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8252334e1cb8444e9a75e6cd7d788793@HKXPR06MB168.apcprd06.prod.outlook.com>
In-Reply-To: <8252334e1cb8444e9a75e6cd7d788793@HKXPR06MB168.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On: 08 September 2014 13:28, Phil wrote:
> I happened to build Linus' master today (d030671f) for the Koelsch board
> using shmobile_defconfig. It built ok, but fails to boot with no output when a
> PCIe card is plugged in.
> 
> However, if I disable either the internal PCI controller (USB bridge), or the
> PCIe controller, then everything looks ok.
> Has anyone seen this already and started looking into it?
The two PCI controllers are currently on the same PCI domain, when they should be on separate ones. I did a dirty little hack for the domains and this allows the two drivers to work at the same time. However, there doesn't appear to be a standard way to increment the domain.

There are some patches on the pci list that may address this which I'll look into...

Cheers
Phil
