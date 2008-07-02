From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Wed, 02 Jul 2008 03:08:46 +0000
Subject: Re: [PATCH 07/07] sh_mobile_ceu_camera: Add SuperH Mobile CEU driver
Message-Id: <aec7e5c30807012008y6d5a16f0h9c634d79f0de37ba@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>
	<20080701124745.30446.27603.sendpatchset@rx1.opensource.se>
	<Pine.LNX.4.64.0807012205511.4203@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0807012205511.4203@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: video4linux-list@redhat.com, lethal@linux-sh.org, akpm@linux-foundation.org, mchehab@infradead.org, linux-sh@vger.kernel.org

On Wed, Jul 2, 2008 at 5:07 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Tue, 1 Jul 2008, Magnus Damm wrote:
>
>> This patch adds support for the SuperH Mobile CEU interface.
>>
>> The hardware is configured in a transparent data fetch mode,
>> and frames are captured from the attached camera and written
>> to physically contiguous memory buffers provided by the
>> videobuf-dma-contig queue.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>
> Great to see new soc-camera host drivers! Just out of curiousity - can you
> tell us, with which camera drivers you tested / used it?

Uh, I knew that question would come up... =)

So far I've mainly tried the SuperH Mobile CEU driver on a MigoR QVGA
board, which means a sh7722 processor (which includes the CEU) and a
ov7725 camera. I also have a sh7723 board with a ncm03j camera (i
think, no docs), but that combination isn't up an running yet.

As for camera drivers, I'm sorry to say that I've been using hacked-up
out-of-tree drivers. I'd like to add upstream support for both camera
types, but I'm not sure if I have enough time before the merge window
closes for 2.6.27. So I've prioritized the CEU driver so far since
it's easy to reuse.

Regarding the ov7725 driver - there seem to be quite a few
half-fitting candidates out there already. I'm thinking about the
ovcamchip/ code and the ov7670.c driver. I need something for the
soc_camera framework though. What to do? Any recommendations?

Thanks,

/ magnus
