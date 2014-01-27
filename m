From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 27 Jan 2014 13:31:01 +0000
Subject: Re: [PATCH 2/8] pci-rcar-gen2: add initial device tree documentation
Message-Id: <52E65F95.9080306@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-1-git-send-email-ben.dooks@codethink.co.uk>	<1390754945-28142-3-git-send-email-ben.dooks@codethink.co.uk> <CAMuHMdVo80pmYG+MC8d4-_Lxod0j2reAEEFM4sC7Z2vCbEioMw@mail.gmail.com>
In-Reply-To: <CAMuHMdVo80pmYG+MC8d4-_Lxod0j2reAEEFM4sC7Z2vCbEioMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, horms+renesas@verge.net.au

Hello.

On 26-01-2014 23:09, Geert Uytterhoeven wrote:

>> + - reg : A list of physical regions to access the device. The first is
>> +         the operational registers for the OHCI/EHCI controller and the
>> +        second region is for the bridge configuration and control registers.

> You may want to add "reg-names" to use named regions, as there
> is more than one region.

    I've already told Ben he can't claim EHCI/OHCI register ranges at the 
bridge node, so there should be only one "reg" specifier.

WBR, Sergei

