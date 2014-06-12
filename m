From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 12 Jun 2014 16:42:03 +0000
Subject: Re: [PATCH 8/8] ARM: shmobile: henninger: Add dummy PCIe bus clock
Message-Id: <5399D85B.2090604@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401261843-6964-9-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1401261843-6964-9-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 06/12/2014 12:36 PM, Phil Edworthy wrote:

>>>> Since the CPU's dtsi refers to pcie_bus_clock, we need an entry in
>>>> the board's dts, even if we aren't using PCIe.

>>>      I don't quite understand that last part: there's PCIe slot in the
>>> Henninger's schematics (although it doesn't seem to be soldered in the
>>> early board version).

>>      In fact, we're in process of verifying PCIe on Henninger (soldered the
>> connector); at least the configuration space accesses work OK...

> At the time of writing those patches, I had no idea if the Henninger board had a PCIe slot or not.

    Ah, that explains it...

> Also, please see v2 of the patches. You no longer need to specify the PCIe bus clock if it's always on.

    I know. But we still need to enable PCIe bridge on Henninger.

> Regards
> Phil

WBR, Sergei

