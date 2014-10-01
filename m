From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Wed, 01 Oct 2014 04:35:16 +0000
Subject: Re: [PATCH 0/2] Add VSP1 devices to DT for r8a7790 and r8a7791
Message-Id: <542B8484.30202@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Laurent,

Thank you for your help!

On 2014年10月01日 07:56, Laurent Pinchart wrote:
> Hi Cao Minh,
>
> On Tuesday 30 September 2014 13:47:32 Cao Minh Hiep wrote:
>> Hi Laurent,
>>
>> We are testing the upstream linux version on Lager.
>> I have tried to test VSP1 driver on r8a7790(Lager).
>> But I don't know how to test it.
>> Could you please tell the method to test it?
> Sure.
>
> I've attached the test script I use to configure the VSP1 pipeline to this e-
> mail.
>
> Syntax: vsp1.sh dev cmd [...]
>
> Supported commands:
>   - m2d | m2d-bru | m2d-crop | m2d-scale | m2m | m2m-crop | m2m-scale infmt
> outfmt
>   - input index infmt
>   - output index outfmt
>
> "dev" should be the media device name without the /dev/ prefix. For the first
> VSP1 that would thus be "media0".
I'll try to do it as you are showing me.
Please let's me ask you again if I have any problem.


Thank you!
Jinso/Cao Minh Hiep

