From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Tue, 30 Sep 2008 09:31:23 +0000
Subject: Re: [PATCH] sh: Rework sh7720 GPIO header usage
Message-Id: <aec7e5c30809300231v511494csffe1a8ccaeb92b6@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080929104626.5354.80315.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080929104626.5354.80315.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 30, 2008 at 3:40 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Sep 30, 2008 at 08:27:24AM +0200, Mark Jonas wrote:
>> > --- 0001/arch/sh/include/asm/gpio.h
>> > +++ work/arch/sh/include/asm/gpio.h     2008-09-29 15:31:10.000000000 +0900
>> This is most likely a stupid question but still:
>> Now that arch/sh/include/asm/gpio.h is completely empty from the
>> compiler's POV, why wasn't simply deleted?
>>
> It was just in this patch, the subsequent patches added back to it.
> Anyways, I've dropped that, and simply merged the subsequent patches
> around the ifdef. There isn't any breakage for your platform, but you may
> wish to look in to what it would take to get magicpanelr2 converted to
> the generic framework.

I've got the sh7720 specific cpu bits mostly done. Mark, do you have
time to convert the board code?

/ magnus
