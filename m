From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Wed, 15 Oct 2008 06:28:51 +0000
Subject: Re: [PATCH] soc-camera: fix compile breakage on SH
Message-Id: <aec7e5c30810142328n1563163bw636b8baf1a47ad8b@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20081014183936.GB4710@cs181140183.pp.htv.fi>
	<Pine.LNX.4.64.0810142335400.10458@axis700.grange>
	<20081015033303.GC4710@cs181140183.pp.htv.fi>
	<20081015052026.GC20183@cs181140183.pp.htv.fi>
In-Reply-To: <20081015052026.GC20183@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: video4linux-list@redhat.com, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, lethal@linux-sh.org, Magnus Damm <damm@igel.co.jp>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Wed, Oct 15, 2008 at 2:20 PM, Adrian Bunk <bunk@kernel.org> wrote:
> On Wed, Oct 15, 2008 at 06:33:03AM +0300, Adrian Bunk wrote:
>> On Tue, Oct 14, 2008 at 11:53:37PM +0200, Guennadi Liakhovetski wrote:
>> > Fix Migo-R compile breakage caused by incomplete merge.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> >
>> > ---
>> >
>> > Hi Adrian,
>>
>> Hi Guennadi,
>>
>> > please see, if the patch below fixes it. Completely untested. Magnus,
>> > could you please verify if it also works (of course, if it at least
>> > compiles:-)) If it doesn't, please fix it along these lines, if it suits
>> > your needs.
>> >...
>>
>> it does compile.
>>...
>
> But it causes compile breakage elsewhere:
>
> <--  snip  -->

Hi guys,

Thanks for working on fixing the breakage. I'd prefer to wait a bit
since there are quite a few pinmux patches queued up that may break if
we merge a fix right now. I can fix it up later on.

Thanks,

/ magnus
