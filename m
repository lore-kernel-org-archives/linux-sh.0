From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Fri, 17 Oct 2014 06:44:34 +0000
Subject: Re: [PATCH 0/2] media: soc_camera: rcar_vin: Add r8a7794, r8a7793 device support
Message-Id: <CAH1o70+s4xTfQKbBRCRdgHibAWG5NTBP-PnhVqotB_HLpSBbGQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1413271224-9792-1-git-send-email-ykaneko0929@gmail.com>
	<Pine.LNX.4.64.1410162222550.16927@axis700.grange>
	<20141017060248.GA7166@verge.net.au>
In-Reply-To: <20141017060248.GA7166@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Linux Media Mailing List <linux-media@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

2014-10-17 15:02 GMT+09:00 Simon Horman <horms@verge.net.au>:
> Hi Guennadi,
>
> On Thu, Oct 16, 2014 at 10:27:13PM +0200, Guennadi Liakhovetski wrote:
>> Hello,
>>
>> Thanks for the patches. Could you please fold these two into one - they
>> really don't deserve to be separated.
>
> Thanks. Kaneko-san could you squash these patches and repost?

Sure, will do.

>
>> As for your other series - patches
>> there look mostly good - from just a formal review. If you don't mind,
>> I'll adjust a couple of cosmetic issues like missing curly braces in
>>
>>       if (a)
>>               x();
>>       else {
>>               y();
>>               z();
>>       }
>>
>> or multiline comments or similar minor things.
>
> Feel free to make any minor updates.
>
>> Thanks
>> Guennadi
>>
>> On Tue, 14 Oct 2014, Yoshihiro Kaneko wrote:
>>
>> > This series is against master branch of linuxtv.org/media_tree.git.
>> >
>> > Koji Matsuoka (2):
>> >   media: soc_camera: rcar_vin: Add r8a7794 device support
>> >   media: soc_camera: rcar_vin: Add r8a7793 device support
>> >
>> >  drivers/media/platform/soc_camera/rcar_vin.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > --
>> > 1.9.1
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
