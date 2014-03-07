From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 07 Mar 2014 16:32:22 +0000
Subject: Re: Renesas RCar device-tree USB series
Message-Id: <5319F496.5060508@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 07/03/14 17:30, Sergei Shtylyov wrote:
> Hello.
>
> On 03/07/2014 05:30 PM, Ben Dooks wrote:
>
>>>> This is a new series covering enabling the RCar series of SoCs USB
>>>> with device-tree based booting. It has been tested on the R8A7790
>>>> Lager board.
>
>>>> Improvements from the previous series include:
>
>>>>          - mapping usb to the relevant phy by dt
>>>>          - better use of existing pci of functions
>
>>>> Note, there is still an issue with the second gigabyte of memory on
>>>> the Lager, which with current kernels causes the system to abort on
>>>> startup. This series will only work if the top memory area is disabled.
>
>>> Thanks for these patches. I think they start looking really good.
>
>>> In my mind there are two outstanding issues:
>
> [...]
>
>>> 2) Per-port USB PHY driver configuration via DT
>>> Right now each USB host controller points to the same PHY device.
>>> Thanks for working on describing the topology! As you know, the PHY
>>> driver itself handles several USB ports, and I'd like to use DT to
>>> represent the mapping between which PHY port that maps to what USB
>>> Host controller to allow proper run time configuration. Right now in
>>> this version of the series there is no such mapping. Of course, that
>>> depends on proper USB PHY DT bindings...
>
>> Hmm, given the shared phy is shared and referenced counted then
>> I don't /think/ there is much more to be done for this. If we add
>> more PHYs then I would assume that each one of them would
>
>     It seems you didn't finish the sentence...

I deleted the last bit by accident.

"have their own phy driver instance"

>
> WBR, Sergei
>


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
