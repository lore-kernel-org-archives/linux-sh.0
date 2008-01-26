From: "Adrian McMenamin" <lkmladrian@gmail.com>
Date: Sat, 26 Jan 2008 19:55:27 +0000
Subject: Re: kobject oops with maple bus
Message-Id: <8b67d60801261155m36e05f9dx359787b332cb814@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1201377200.6672.10.camel@localhost.localdomain>
In-Reply-To: <1201377200.6672.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On 26/01/2008, Adrian McMenamin <adrian@newgolddream.dyndns.info> wrote:
> Greg,
>
> Just updated my git to the latest sources and get these (seemingly non-fatal) oops with the Dreamcast maple bus. I'll investigate further, but they may mean something to out out of the box.
>
> Adrian
>
>
>
>
> dreamy:~# [    0.000000] Linux version 2.6.24-gf0ea9c3d-dirty (adrian@bossclass) (gcc version 3.4.6) #328 PREEMPT Sat Jan 26 19:45:30 GMT 2008
> [    0.000000] console [sercon0] enabled
> [    0.000000] Booting machvec: Sega Dreamcast
> [    0.000000] Node 0: start_pfn = 0xc000, low = 0xd000
> [    0.000000] Zone PFN ranges:
> [    0.000000]   Normal      49152 ->    53248
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[1] active PFN ranges


Oh, and I've just noticed everythung appears to be timed to 0 too. Very odd.
