From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Aug 2011 02:09:17 +0000
Subject: Re: [PATCH] serial: sh-sci: console Runtime PM support
Message-Id: <CANqRtoTeVzKLRF+nQunQYC8LRZTj-qaFtYoEv2+fg4U-w=knvg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110803034736.3425.87722.sendpatchset@t400s>
In-Reply-To: <20110803034736.3425.87722.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thu, Aug 4, 2011 at 10:04 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Aug 03, 2011 at 12:47:36PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add Runtime PM context save/restore support to
>> the SCIF driver. Tested on the AP4EVB console.
>
> Hi Magnus,
>
> could you explain in a little more detail how this was tested?

This has been tested on AP4EVB with and without power domain support.
For sh7372 the serial ports are located in the A3SP power domain which
has experimental software support through some prototype patches
earlier posted to the linux-sh list. I intend to up-port these
prototype patches to 3.1-rc in the not so distant future.

> Also, is this likely to work on other boards? E.g the AP4 Mackerel?

The Runtime PM support provided by this patch should work with any
SCI/SCIF/SCIFA/SCIFB hardware block regardless of SoC type. So yes,
both AP4EVB and Mackerel should work just fine.

Thanks,

/ magnus
