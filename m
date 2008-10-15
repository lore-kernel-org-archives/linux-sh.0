From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Wed, 15 Oct 2008 08:03:07 +0000
Subject: Re: [PATCH] soc-camera: fix compile breakage on SH
Message-Id: <aec7e5c30810150103p7ed810ccyc815ad578d64feac@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20081014183936.GB4710@cs181140183.pp.htv.fi>
	<Pine.LNX.4.64.0810142335400.10458@axis700.grange>
	<20081015033303.GC4710@cs181140183.pp.htv.fi>
	<20081015052026.GC20183@cs181140183.pp.htv.fi>
	<aec7e5c30810142328n1563163bw636b8baf1a47ad8b@mail.gmail.com>
	<Pine.LNX.4.64.0810150836100.3896@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0810150836100.3896@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: video4linux-list@redhat.com, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, lethal@linux-sh.org, Magnus Damm <damm@igel.co.jp>

Hi Guennadi,

On Wed, Oct 15, 2008 at 3:41 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Hi Magnus
>
> On Wed, 15 Oct 2008, Magnus Damm wrote:
>
>> Thanks for working on fixing the breakage. I'd prefer to wait a bit
>> since there are quite a few pinmux patches queued up that may break if
>> we merge a fix right now. I can fix it up later on.
>
> no, I would not leave the kernel in a non-compilable state even if just
> for one board. Please, test a new version of the patch below. And yes, You
> will have to rebase your patches, sorry. Another thing, could you also,
> please, add a license / copyright header to
> include/media/soc_camera_platform.h?

I'm not asking you to keep the board broken forever. It's just a
question of in which order the trees are getting merged. Again, I'd
rather see that this fix is put _on_top_ of the patches that are
already queued up in the SuperH tree. Merging it before doesn't help
anything in my opinion - especially since the change should go though
the SuperH tree anyway.

Feel free to add any header you like. =)

/ magnus
