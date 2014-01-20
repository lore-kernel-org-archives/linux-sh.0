From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 20 Jan 2014 10:43:54 +0000
Subject: Re: [PATCH 1/6] pci-rcar-gen2: add initial device tree documentation
Message-Id: <52DCFDEA.4080909@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390057420-13226-1-git-send-email-ben.dooks@codethink.co.uk> <1390057420-13226-2-git-send-email-ben.dooks@codethink.co.uk> <52DAD520.5010807@cogentembedded.com>
In-Reply-To: <52DAD520.5010807@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, horms+renesas@verge.net.au

On 18/01/14 19:25, Sergei Shtylyov wrote:
> Hello.
>
> On 18-01-2014 19:03, Ben Dooks wrote:
>
>> Add initial documentation for the pci-rcar-gen2 driver device tree
>> bindings.
>> This is not yet complete and needs work on the sub-nodes for the PCI bus.

>     Why do you think there's a need to document PCI devices? They're
> auto-dicoverable and not usually described in .dts[i] files.

Because the bridge nodes are not auto-discoverable.

>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>> Cc: linux-sh@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: horms+renesas@verge.net.au
>> ---
>>   Documentation/devicetree/bindings/pci/renessas,pci-r8a7790 | 12
>> ++++++++++++
>
>     Just "renesas", not "renessas". Also, .txt file extension is always
> used for bindings as much as I could observe.

Thanks, will fix.

>>   1 file changed, 12 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/pci/renessas,pci-r8a7790
>
>> diff --git
>> a/Documentation/devicetree/bindings/pci/renessas,pci-r8a7790
>> b/Documentation/devicetree/bindings/pci/renessas,pci-r8a7790
>> new file mode 100644
>> index 0000000..65268d9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/renessas,pci-r8a7790
>> @@ -0,0 +1,12 @@
>> +Renesas internal AHB to PCI bridge
>> +
>> +This is the bridge used internally to connect the USB controllers to the
>> +AHB.
>> +
>> +Required properties:
>> + - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC
>> + - reg : A list of physical regions to access the device. The first is
>> +         the operational registers for the OHCI/EHCI controller and the
>
>     What?! This resource doesn't belong to the bridge itself. Perhaps
> it's a candidate for the "ranges" property.

Will look into that one.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
