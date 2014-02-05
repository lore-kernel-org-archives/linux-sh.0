From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 05 Feb 2014 12:17:23 +0000
Subject: Re: [PATCH 02/11] pci-rcar-gen2: add initial device tree documentation
Message-Id: <52F22BD3.8040107@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1391595554-20640-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1391595554-20640-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 05/02/14 12:04, Magnus Damm wrote:
> On Wed, Feb 5, 2014 at 7:19 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> Add initial documentation for the pci-rcar-gen2 driver device tree bindings.
>> This is not yet complete and needs work on the sub-nodes for the PCI bus.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>> Cc: linux-sh@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: horms+renesas@verge.net.au
>> ---
>>   .../devicetree/bindings/pci/renessas,pci-r8a7790.txt         | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/renessas,pci-r8a7790.txt
>
> Hi Ben,
>
> Thanks for this. Regarding DT bindings, I agree about using the SoC as
> suffix in the compatible string since this is in line with what we do
> for other device drivers. I much prefer that over "gen2" or something
> else that may or may not apply to newer SoCs.

Great, let's get this lot reviewed and hopefully we can get this sorted
before the 3.15-rc1.

> As you probably know, the pci-rcar-gen2.c driver is intended to be
> used both on r8a7790 and r8a7791. Regarding this binding document, is
> it possible to make it one file for the driver instead of r8a7790
> specific? That would match what we do for DT binding documentation for
> other device drivers.

Thanks, should I change this to be renesas,pci-rcar-gen2.txt then?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
