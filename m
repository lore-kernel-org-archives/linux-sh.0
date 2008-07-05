From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Sat, 05 Jul 2008 04:24:41 +0000
Subject: Re: [PATCH 01/04] soc_camera: Move spinlocks
Message-Id: <aec7e5c30807042124y31bf3ce3qf7ef8aa03d92a15@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080705025335.27137.98068.sendpatchset@rx1.opensource.se>
	<20080705025345.27137.74420.sendpatchset@rx1.opensource.se>
	<Pine.LNX.4.64.0807050602370.705@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0807050602370.705@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: video4linux-list@redhat.com, paulius.zaleckas@teltonika.lt, linux-sh@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, lethal@linux-sh.org, akpm@linux-foundation.org

On Sat, Jul 5, 2008 at 1:19 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Sat, 5 Jul 2008, Magnus Damm wrote:
>
>> This patch moves the spinlock handling from soc_camera.c to the actual
>> camera host driver. The spinlock alloc/free callbacks are replaced with
>> code in init_videobuf().
>
> Does this mean, that you have found a possibility to port your
> spinlock-removal patch on the top of the "make videobuf independent" patch
> without any loss of functionality? This looks good on a first glance. I am
> on a holiday now (:-)), so, I unfortunately cannot review your patches
> ATM. I'll try to do this in a week, hope, this still will be in time for
> the 2.6.27 merge window.

Yes, you are correct. It was much easier than I expected. Have a good holiday!

/ magnus
