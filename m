From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Tue, 15 Jul 2008 08:23:14 +0000
Subject: Re: [PATCH 01/06] soc_camera: Move spinlocks
Message-Id: <aec7e5c30807150123x32774aadvfd2685c981c5e8dc@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080714120204.4806.87287.sendpatchset@rx1.opensource.se>
	<20080714120213.4806.93867.sendpatchset@rx1.opensource.se>
	<Pine.LNX.4.64.0807141427140.11348@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0807141427140.11348@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: video4linux-list@redhat.com, paulius.zaleckas@teltonika.lt, linux-sh@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, lethal@linux-sh.org, akpm@linux-foundation.org

On Mon, Jul 14, 2008 at 9:31 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Mon, 14 Jul 2008, Magnus Damm wrote:
>
>> This patch moves the spinlock handling from soc_camera.c to the actual
>> camera host driver. The spinlock alloc/free callbacks are replaced with
>> code in init_videobuf().
>
> As merits of this move were not quite obvious to me (you lose the
> possibility to use default lock allocation / freeing in soc_camera.c), I
> extended your comment as follows:
>
> This patch moves the spinlock handling from soc_camera.c to the actual
> camera host driver. The spinlock_alloc/free callbacks are replaced with
> code in init_videobuf(). So far all camera host drivers implement their
> own spinlock_alloc/free methods anyway, and videobuf_queue_core_init()
> BUGs on a NULL spinlock argument, so, new camera host drivers will not
> forget to provide a spinlock when initialising their videobug queues.
>
> Do you agree with it? This is how I'm going to pull it into my soc-camera
> tree.

Yes, I agree. Thanks for extending the comment.

Speaking about pulling in patches, are all 6 patches ok with you guys?
Or do you expect me to fix up and resend something?

/ magnus
