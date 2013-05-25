From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 25 May 2013 15:20:30 +0000
Subject: Re: [PATCH v2] pwm: renesas-tpu: Add missing pwmchip_remove() call in tpu_remove()
Message-Id: <CAFRkauD6jgaETfnFcekJsM1irvCq45bes-Gt7BL1EP36G9+5rg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1369057541.11578.1.camel@phoenix>
	<20130523013933.GI22608@verge.net.au>
	<20130523191217.GB17462@avionic-0098.adnet.avionic-design.de>
	<4528298.O99iVSpig9@avalon>
In-Reply-To: <4528298.O99iVSpig9@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Simon Horman <horms@verge.net.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org

2013/5/25 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi Thierry,
>
> On Thursday 23 May 2013 21:12:17 Thierry Reding wrote:
>> On Thu, May 23, 2013 at 10:39:34AM +0900, Simon Horman wrote:
>> > On Mon, May 20, 2013 at 03:46:59PM +0200, Laurent Pinchart wrote:
>> > > Hi Axel,
>> > >
>> > > Thank you for the patch.
>> > >
>> > > On Monday 20 May 2013 21:45:41 Axel Lin wrote:
>> > > > Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> > >
>> > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> >
>> > Thanks. I have queued this up for v3.11 in the pinmux branch
>> > of my renesas tree on kernel.org.
>>
>> I'd rather take this through the PWM tree along with the original driver
>> patch.
>
> As I will need to submit a new version of the renesas-tpu patches should I
> fold this patch in ?

Hi Laurent,
I think you can fold this patch in if you are going to submit a new version
of the renesas-tpu patches.

Regards,
Axel
