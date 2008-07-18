From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 18 Jul 2008 08:07:20 +0000
Subject: Re: [PATCH 05/06] sh_mobile_ceu_camera: Add SuperH Mobile CEU driver V3
Message-Id: <aec7e5c30807180107g6d2f55fdh917da10963f3df20@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080714120204.4806.87287.sendpatchset@rx1.opensource.se>
	<20080714120249.4806.66136.sendpatchset@rx1.opensource.se>
	<Pine.LNX.4.64.0807180918160.13569@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0807180918160.13569@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: video4linux-list@redhat.com, paulius.zaleckas@teltonika.lt, linux-sh@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, lethal@linux-sh.org, akpm@linux-foundation.org

Hi Guennadi!

On Fri, Jul 18, 2008 at 4:39 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Hi Magnus,
>
> the whole this patch-series has been pulled into the v4l tree now, which
> means there hasn't been any critical issues left, at least none are
> known:-)

Excellent! Thank you.

> A couple of general notes, that would be nice to address in an incremental
> patch:
>
> 1. the driver could benefit from a bit more comments:-) At least for
> register configuration.

Yes, I agree with you.

> 2. code like
>
>> +     ceu_write(pcdev, CETCR, ~ceu_read(pcdev, CETCR) & 0x0317f313);
>> +     ceu_write(pcdev, CEIER, ceu_read(pcdev, CEIER) | 1);
>> +
>> +     ceu_write(pcdev, CAPCR, ceu_read(pcdev, CAPCR) & ~0x10000);
>> +
>> +     ceu_write(pcdev, CETCR, 0x0317f313 ^ 0x10);
>
> specifically the 0x0317f313 constants in it might better be coded with
> macros, or at least should be commented.

Yeah, sorry about that. The sequence above is pure magic, but it would
definitely not hurt with a few constants...

> 3. you don't seem to check the interrupt reason nor to handle any error
> conditions like overflow. I guess, there is something like a status
> register on the interface, that you can check on an interrupt to see what
> really was the cause for it.

I've done some stress testing and I've had the camera running over the
weekend on a sh7723 board without problems, so i guess the driver is
at least half-ok.

This doesn't mean you're wrong though, there is definitely a need for
better error handling. There are many bits available for error
conditions - I guess the biggest question is how to trigger them and
what to do about it.

> 4. you really managed it to keep the driver platform-neutral!:-) Still, do
> we need an ack from the SH-maintainer? If you think we do, please, try to
> obtain one asap - the patches should be ready to go upstream by Sunday.

I'm sure Paul would ack if you guys needed it, but i wonder if there
is any point in it. Paul knows about this work and he will sign off on
the platform data part for sure. So I wouldn't worry about it if I
were you.

> 5. the memory you are binding with dma_declare_coherent_memory - is it
> some SoC-local SRAM? Is it usably only by the camera interface or also by
> other devices? You might want to request it first like in
> drivers/scsi/NCR_Q720.c to make sure noone else is using it.

This memory could on-chip SRAM, but right now it's regular external
RAM. It's up to the person fixing up the platform data to decide, and
I think that's a pretty nice and flexible strategy.

I plan on doing something like this for the platform data:
http://git.kernel.org/?p=linux/kernel/git/lethal/sh-2.6.git;a=commitdiff;h;a5b04f107f462ec14994270e15b91c59041ef9

Regarding request_mem_region() - I used to add that here and there,
but I think the platform driver layer should handle that for us
automatically these days. I'm not 100% sure though. =)

Thanks for all the help!

/ magnus
