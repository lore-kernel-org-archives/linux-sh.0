From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 21 Mar 2014 15:42:44 +0000
Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
Message-Id: <532C6BF7.1050404@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
 <532C5ADE.4030708@cogentembedded.com>
 <OF4D80B18E.5A1F55AB-ON80257CA2.0051AADA-80257CA2.0051D412@eu.necel.com>
 <6044873.2S2Xlhp0hC@wuerfel>
In-Reply-To: <6044873.2S2Xlhp0hC@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 03/21/2014 05:57 PM, Arnd Bergmann wrote:

>>>> +      reg = <0 0xfe000000 0 0x80000>;
>>>> +      #address-cells = >;
>>>> +      #size-cells = <2>;
>>>> +      device_type = "pci";

>>>      This legacy property is only meaningful for the true OF firmware and thus
>>> have been phased out (it's only actively used for the memory nodes).

>> Ok, thanks for pointing this out.

> I think the code still relies on it for PCI though.

    OK, I have found where it does that but the recommended value seems to be 
"pciex" for PCI-Express case.

> 	Arnd

WBR, Sergei

