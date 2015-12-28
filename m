From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 28 Dec 2015 10:24:31 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: LPAE memory bank CMA assignment prototype
Message-Id: <3987591.uIcGfaluy4@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20151219014005.6274.87661.sendpatchset@little-apple>
In-Reply-To: <20151219014005.6274.87661.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Monday 28 December 2015 11:21:08 Geert Uytterhoeven wrote:
> On Mon, Dec 28, 2015 at 11:10 AM, Laurent Pinchart wrote:
> >> Regarding this patch, it is just a proof of concept to test allocation
> >> from a high memory address without modifying any hardware description.
> >> 
> >> > I don't want to see board code coming back through the back door.
> >> > What's wrong with just reserving memory in DT with the reserved-memory
> >> > bindings and assigning it to the DU ?
> >> 
> >> Describing device-to-memory bank assignment in DT equals mixing
> >> software policy with hardware description. I prefer to keep the
> >> software policy in C and the hardware description in DT.
> >> 
> >> If you think there are better ways to reserve memory, why don't you
> >> cook up a counter proposal and post it in a public space? =)
> > 
> > Doing it in DT is the better way in my opinion :-) There are established
> > DT bindings for that purpose, and that's what upstream is using.
> 
> I'm a bit sceptical about describing this in DT, too, as this is a software
> policy, not a hardware description, but it's indeed described in
> Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

The idea of a DT-like kernel configuration file has been toyed with in the 
past but as far as I know it got abandoned. It was certainly an interesting 
idea, and could possibly have led to a better solution, but today what we have 
is DT. Board files are not the way to go to implement such a feature.

-- 
Regards,

Laurent Pinchart

