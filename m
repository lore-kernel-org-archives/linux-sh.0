From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 21 May 2013 14:47:04 +0000
Subject: Re: [PATCH v5] V4L2: soc_camera: Renesas R-Car VIN driver
Message-Id: <519B88E8.3040101@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201305180101.11383.sergei.shtylyov@cogentembedded.com> <OFC9B7B505.2CDF0AA3-ON80257B71.00291B65-80257B71.002952EB@eu.necel.com> <519A1FFC.6000304@cogentembedded.com> <OF0ABE628B.1C271A20-ON80257B72.002ED824-80257B72.003627CD@LocalDomain> <OF7D5F7F7E.CF4ED120-ON80257B72.0042ED42-80257B72.004332EB@eu.necel.com>
In-Reply-To: <OF7D5F7F7E.CF4ED120-ON80257B72.0042ED42-80257B72.004332EB@eu.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: phil.edworthy@renesas.com
Cc: vladimir.barinov@cogentembedded.com, g.liakhovetski@gmx.de, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com, matsu@igel.co.jp, mchehab@redhat.com

Hello.

On 21-05-2013 16:13, phil.edworthy@renesas.com wrote:

>>>>> Subject: [PATCH v5] V4L2: soc_camera: Renesas R-Car VIN driver

>>>>> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

>>>>> Add Renesas R-Car VIN (Video In) V4L2 driver.

>>>>> Based on the patch by Phil Edworthy <phil.edworthy@renesas.com>.

>>>> I've seen old patches that add VIN to the Marzen board, do you have an
>>>> updated version?

>>>      The last version of that patchset is 4, here it is archived:

>>> http://marc.info/?l=linux-sh&m6865481429756
>>> http://marc.info/?l=linux-sh&m6865499029807
>>> http://marc.info/?l=linux-sh&m6865509129843
>>> http://marc.info/?l=linux-sh&m6865520029900

>> First of all, thank you for your work on this driver.

>> I have tried your patches on the Marzen board using an Expansion
>> Board with an OmniVision 10635 camera (progressive BT656), using an
>> out-of-tree driver. There appears to be an issue with the interrupt
>> handling compared to my original driver.

>> I realise that you don't have the Marzen Expansion Board & don't
>> have an ov10635 camera. However, unfortunately, I don't have much
>> time that I can spend on this. Do any of the boards you have use a
>> progressive camera?

    No. Is there any way you can send us that expansion board? It seems
the only way we can get some progress on this issue.

> Oops, the comments about the captured image contents are my fault.
> However, the unhandled irq after stopping capture is still an issue.

    Thanks for letting us know.

> Regards
> Phil

WBR, Sergei

