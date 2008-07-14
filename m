From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 14 Jul 2008 12:31:23 +0000
Subject: Re: [PATCH 01/06] soc_camera: Move spinlocks
Message-Id: <Pine.LNX.4.64.0807141427140.11348@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20080714120204.4806.87287.sendpatchset@rx1.opensource.se>
	<20080714120213.4806.93867.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080714120213.4806.93867.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: video4linux-list@redhat.com, paulius.zaleckas@teltonika.lt, linux-sh@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, lethal@linux-sh.org, akpm@linux-foundation.org

On Mon, 14 Jul 2008, Magnus Damm wrote:

> This patch moves the spinlock handling from soc_camera.c to the actual
> camera host driver. The spinlock alloc/free callbacks are replaced with
> code in init_videobuf().

As merits of this move were not quite obvious to me (you lose the 
possibility to use default lock allocation / freeing in soc_camera.c), I 
extended your comment as follows:

This patch moves the spinlock handling from soc_camera.c to the actual
camera host driver. The spinlock_alloc/free callbacks are replaced with
code in init_videobuf(). So far all camera host drivers implement their
own spinlock_alloc/free methods anyway, and videobuf_queue_core_init()
BUGs on a NULL spinlock argument, so, new camera host drivers will not
forget to provide a spinlock when initialising their videobug queues.

Do you agree with it? This is how I'm going to pull it into my soc-camera 
tree.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
