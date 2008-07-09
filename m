From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Wed, 09 Jul 2008 08:33:44 +0000
Subject: Re: [PATCH 03/04] videobuf: Add physically contiguous queue code V2
Message-Id: <aec7e5c30807090133k476c0a48h4b8aec66459ee78d@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080705025335.27137.98068.sendpatchset@rx1.opensource.se>
	<20080705025405.27137.16206.sendpatchset@rx1.opensource.se>
	<48737AA3.3080902@teltonika.lt>
	<200807081642.34261.laurent.pinchart@skynet.be>
In-Reply-To: <200807081642.34261.laurent.pinchart@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@skynet.be>
Cc: video4linux-list@redhat.com, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, linux-sh@vger.kernel.org

On Tue, Jul 8, 2008 at 11:42 PM, Laurent Pinchart
<laurent.pinchart@skynet.be> wrote:
> On Tuesday 08 July 2008, Paulius Zaleckas wrote:
>> Magnus Damm wrote:
>> > This is V2 of the physically contiguous videobuf queues patch.
>> > Useful for hardware such as the SuperH Mobile CEU which doesn't
>> > support scatter gatter bus mastering.
>>
>> spelling gatther :)
>
> gather would be even better :-)

Heh, maybe so, but even better would be if videobuf-dma-sg.c and
videobuf-vmalloc.c used the same spelling... =)

/ magnus
