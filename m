From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Wed, 02 Jul 2008 02:50:28 +0000
Subject: Re: [PATCH 02/07] soc_camera: Let the host select videobuf_queue type
Message-Id: <aec7e5c30807011950u1ae2cf63u9ac03cdcd50fb755@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>
	<20080701124657.30446.28078.sendpatchset@rx1.opensource.se>
	<Pine.LNX.4.64.0807012158510.4203@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0807012158510.4203@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: video4linux-list@redhat.com, linux-sh@vger.kernel.org, lethal@linux-sh.org, mchehab@infradead.org, paulius.zaleckas@teltonika.lt, akpm@linux-foundation.org

[CC Paulius]

On Wed, Jul 2, 2008 at 5:02 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Tue, 1 Jul 2008, Magnus Damm wrote:
>
>> This patch makes it possible for hosts (soc_camera drivers for the soc)
>> to select a different videobuf queue than VIDEOBUF_DMA_SG. This is needed
>> by the SuperH Mobile CEU hardware which requires physically contiguous
>> buffers. While at it, rename the spinlock callbacks to file callbacks.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>
> I'm afraid, this patch conflicts with an earlier one by Paulius Zaleckas:
> http://marc.info/?l=linux-video&m1438688924771&w=2, which I've already
> acked, and which, I think, makes videobuf handling more generic than
> yours. Could you please have a look if you can use it, if yes - rebase
> your patch-set on it (I think, some other your patches will have to be
> changed then too). If there's anything that you cannot use there, we'll
> have to see how we can satisfy all the requirements.

My patches are similar to Paulius change above, but I also clean up
the spinlock handling - since the videobuf queue stuff is moved into
the host driver there is no longer any point to keep the spinlock
callbacks and the icf->lock pointer inside soc_camera.c.

If you're interested in cleaning up the spinlock stuff then it's a tad
difficult to do that on top of Paulius code IMO. I'd say my patches
01-04 does the same as Paulis patch, but also removes redundant
spinlock code.

Let me know what you think. I'm more than happy to build on top of
Paulius patch, but I wonder if we really should keep the redundant
spinlock code...

Thanks!

/ magnus
