From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Thu, 16 Oct 2014 05:18:31 +0000
Subject: Re: [PATCH 3/3] media: soc_camera: rcar_vin: Add NV16 horizontal scaling-up support
Message-Id: <CAH1o70Kk-W1sXG27GgpP+qVpHDo_Pae73jPhOx=Jc9eHvaDpNA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1413268013-8437-1-git-send-email-ykaneko0929@gmail.com>
	<1413268013-8437-4-git-send-email-ykaneko0929@gmail.com>
	<543D1DD1.2060700@cogentembedded.com>
	<20141015045213.GA18646@verge.net.au>
	<543E8746.80809@cogentembedded.com>
	<20141016045548.GA31899@verge.net.au>
In-Reply-To: <20141016045548.GA31899@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

2014-10-16 13:55 GMT+09:00 Simon Horman <horms@verge.net.au>:
> On Wed, Oct 15, 2014 at 06:40:06PM +0400, Sergei Shtylyov wrote:
>> Hello.
>>
>> On 10/15/2014 08:52 AM, Simon Horman wrote:
>>
>> >>>From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>>
>> >>>The scaling function had been forbidden for the capture format of
>> >>>NV16 until now. With this patch, a horizontal scaling-up function
>> >>>is supported to the capture format of NV16. a vertical scaling-up
>> >>>by the capture format of NV16 is forbidden for the H/W specification.
>>
>> >>    s/for/by/?
>>
>> >How about the following text?
>>
>> >Up until now scaling has been forbidden for the NV16 capture format. This
>> >patch adds support for horizontal scaling-up for NV16. Vertical scaling-up
>> >for NV16 is forbidden for by the H/W specification.
>>
>>    "For by", hehe? Were you trying to keep every happy? :-)
>
> Maybe :^)
>
> Kaneko-san, can you change "for by" to "by" ?

I got it.
